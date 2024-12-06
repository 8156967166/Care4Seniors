//
//  GameViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 21/02/24.
//

import UIKit

class CardModel {
    var image: String?
    
    init(image: String) {
        self.image = image
    }
}


class GameViewController: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var colltnView: UICollectionView!
    @IBOutlet weak var labelTimer: UILabel!
    
    //MARK: Variables
    
    var points = Int()
    var counter = 60
    var timer = Timer()
    var imageArry = ["book","burger","car","chair","chocolate","dog","guitar","person","phone","school"]
    var shuffleImageArry = [String]()
    var dataArray: [CardModel] = [] // Your data array containing image information
    var firstSelectedIndexPath: IndexPath?
    var secondSelectedIndexPath: IndexPath?
    var alertPopup: AlertPopupView!
    var quitPopup: QuitAlertPopup!
    
    //MARK: Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colltnView.delegate = self
        colltnView.dataSource = self
        
        progressBar.progress = 0.0
        
        points = 0
        lblPoints.text = "\(points)"
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        shuffleImageArry = imageArry.shuffled()
        print("shuffleImageArry ---- \(shuffleImageArry)")
        print("imageArry ---- \(imageArry)")
        imageArry.append(contentsOf: shuffleImageArry)
        
        for index in 0..<imageArry.count {
            dataArray.append(CardModel(image: imageArry[index]))
        }
        
        print("data array --- \(dataArray)")
    }
    
    //MARK: Functions
    
    // called every time interval from the timer
    @objc func timerAction() {
        counter -= 1
        labelTimer.text = "\(counter)"
        if counter == 0 {
            setPopup()
        }
    }
    
    func setPopup() {
        self.alertPopup = AlertPopupView(frame: self.view.frame)
        alertPopup.popupView.layer.cornerRadius = 6
        alertPopup.popupView.layer.borderWidth = 0.5
        alertPopup.popupView.layer.borderColor = UIColor.gray.cgColor
        self.alertPopup.buttonTryAgain.addTarget(self, action: #selector(tappedTryAgain), for: .touchUpInside)
        self.view.addSubview(alertPopup)
    }
    
    @objc func tappedTryAgain() {
        self.alertPopup.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
    
    func setQuitPopup() {
        self.quitPopup = QuitAlertPopup(frame: self.view.frame)
        self.quitPopup.buttonQuit.addTarget(self, action: #selector(tappedQuit), for: .touchUpInside)
        self.quitPopup.buttonNo.addTarget(self, action: #selector(tappedNo), for: .touchUpInside)
        self.view.addSubview(quitPopup)
    }
    
    @objc func tappedQuit() {
        self.quitPopup.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedNo() {
        self.quitPopup.removeFromSuperview()
    }
    
    //MARK: ButtonActions
    
    @IBAction func buttonQuit(_ sender: UIButton) {
        setQuitPopup()
    }
}

//MARK: CollectionView Delegate & Datasource

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        cell.CardView.layer.borderWidth = 1
        cell.CardView.layer.borderColor = UIColor.gray.cgColor
        cell.imageCard.image = UIImage(named: dataArray[indexPath.item].image ?? "")
        cell.imageCard.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            print("Selected IndexPath: \(selectedIndexPath)")
            cell.imageCard.isHidden = false
            cell.imageCard.image = UIImage(named: dataArray[selectedIndexPath.item].image ?? "")
            
            print("selected image ----> \(String(describing: cell.imageCard.image))")
            
            if firstSelectedIndexPath == nil {
                // First cell selected
                firstSelectedIndexPath = selectedIndexPath
            } else if secondSelectedIndexPath == nil {
                // Second cell selected
                secondSelectedIndexPath = selectedIndexPath
                
                // Check if the images are equal
                let firstSelectedImage = dataArray[firstSelectedIndexPath!.item].image
                let secondSelectedImage = dataArray[secondSelectedIndexPath!.item].image
                if let first = firstSelectedImage, let second = secondSelectedImage, first.isEqual(second) || second.isEqual(first) {
                    print("The images are equal.")
                    // Images are equal, remove the selected cells
                    dataArray.remove(at: firstSelectedIndexPath!.item)
                    dataArray.remove(at: secondSelectedIndexPath!.item)
                    points += 5
                    progressBar.progress += 0.1
                    lblPoints.text = "\(points)"
                    // Access Shared Defaults Object
                    let userDefaults = UserDefaults.standard
                    // Write/Set Value
                    userDefaults.set(points, forKey: "TotalPoints")
                    let totalPoints = UserDefaults.standard.value(forKey: "TotalPoints")
                    if points > totalPoints as! Int {
                        print("point is highest scores")
                        userDefaults.set(points, forKey: "TotalPoints")
                    }else {
                        print("point is lowest scores")
                    }
                    // Update the collection view
                    collectionView.deleteItems(at: [firstSelectedIndexPath!, secondSelectedIndexPath!])
                } else {
                    print("The images are not equal.")
                }
                // Reset selected indices for the next comparison
                firstSelectedIndexPath = nil
                secondSelectedIndexPath = nil
            }
        }
    }
    
}

