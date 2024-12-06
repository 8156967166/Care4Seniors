//
//  ExerciseViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 20/02/24.
//

import UIKit

class VideoList {
    var img: String
    let title: String
    var dateOfVideo: String
   
    init(title: String, dateOfVideo: String, image: String) {
        self.title = title
        self.dateOfVideo = dateOfVideo
        self.img = image
    }
}

class ArticleList {
    var img: String
    let title: String
    var dateOfVideo: String
   
    init(title: String, dateOfVideo: String, image: String) {
        self.title = title
        self.dateOfVideo = dateOfVideo
        self.img = image
    }
}

class ExerciseViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var lblArticle: UILabel!
    @IBOutlet weak var lblVideo: UILabel!
    @IBOutlet weak var viewVideo: UIView!
    @IBOutlet weak var viewArticle: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: - Variables
    
    var videoArray = [VideoList]()
    var articleArray = [ArticleList]()
    var isSelectVideoArticle = Bool()
    
    //MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()
        isSelectVideoArticle = true
        viewVideo.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.4039215686, blue: 0.8470588235, alpha: 1)
        lblVideo.textColor = .white
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: "VideoListTableViewCell", bundle: .main), forCellReuseIdentifier: "VideoListTableViewCell")
        setVideoModel()
        setArticleModel()
    }
    
    //MARK: - Functions
    
    func setDissable() {
        viewVideo.backgroundColor = .clear
        viewArticle.backgroundColor = .clear
        lblArticle.textColor = .lightGray
        lblVideo.textColor = .lightGray
    }
    
    func setVideoModel() {
        let firstModel = VideoList(title: "Introduction to Exercises", dateOfVideo: "14 Jan 2021", image: "exercisee")
        let secondModel = VideoList(title: "Introduction to Physical Activities", dateOfVideo: "24 June 2022", image: "backgrdloctzn")
        let thirdModel = VideoList(title: "Introduction to Health care", dateOfVideo: "01 March 2023", image: "articles")
        let videoList = [firstModel, secondModel, thirdModel]
        videoArray.append(contentsOf: videoList)
    }
    
    func setArticleModel() {
        let firstModel = ArticleList(title: "Introduction to Article videos", dateOfVideo: "10 July 2020", image: "articles")
        let secondModel = ArticleList(title: "Introduction to Article videos1", dateOfVideo: "12 July 2021", image: "HealthFit")
        let thirdModel = ArticleList(title: "Introduction to Article videos1", dateOfVideo: "30 March 2023", image: "healthLibrary")
        let articleList = [firstModel, secondModel, thirdModel]
        articleArray.append(contentsOf: articleList)
    }
    
    //MARK: - ButtonActions
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonSelectSegmnt(_ sender: UIButton) {
        if sender.tag == 1 {
            isSelectVideoArticle = true
            setDissable()
            viewVideo.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.4039215686, blue: 0.8470588235, alpha: 1)
            lblVideo.textColor = .white
        }else if sender.tag == 2 {
            isSelectVideoArticle = false
            setDissable()
            viewArticle.backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.4039215686, blue: 0.8470588235, alpha: 1)
            lblArticle.textColor = .white
        }
        tblView.reloadData()
    }
}

//MARK: - TableViewDelegate, TableViewDataSource

extension ExerciseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSelectVideoArticle == true {
            return videoArray.count
        }else {
            return articleArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! VideoListTableViewCell
        if isSelectVideoArticle == true {
            let videoModel = videoArray[indexPath.row]
            cell.lblDateOfVideo.text = videoModel.dateOfVideo
            cell.titleOfVideo.text = videoModel.title
            cell.imgOfVideo.image = UIImage(named: videoModel.img)
        }else if isSelectVideoArticle == false {
            let articleModel = articleArray[indexPath.row]
            cell.lblDateOfVideo.text = articleModel.dateOfVideo
            cell.titleOfVideo.text = articleModel.title
            cell.imgOfVideo.image = UIImage(named: articleModel.img)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VideoListViewController") as! VideoListViewController
        if isSelectVideoArticle == true {
            vc.titleStr = "Video List"
        }else if isSelectVideoArticle == false {
            vc.titleStr = "Article List"
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
