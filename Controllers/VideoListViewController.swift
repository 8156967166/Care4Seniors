//
//  VideoListViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 20/02/24.
//

import UIKit
import youtube_ios_player_helper_swift

class VideoListViewController: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    //MARK: Variables
    
    var titleStr = String()
    var videoArry = [Video]()
    
    //MARK: LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = titleStr
        tblView.delegate = self
        tblView.dataSource = self
        setVideoModel()
        tblView.register(UINib(nibName: "VideoListTableViewCell", bundle: .main), forCellReuseIdentifier: "VideoListTableViewCell")
    }
    
    //MARK: - Functions
    
    func setVideoModel() {
        let first = Video(videoId: 1, title: "Introduction to Exercise", videoImg: "img1", videourl: "firstVideo", videoDate: "10 Jan 2021", extensions: ".mp4")
        let second = Video(videoId: 2, title: "Get started", videoImg: "img2", videourl: "secondVideo", videoDate: "21 Mar 2021", extensions: ".mp4")
        let third = Video(videoId: 3, title: "Types of Exercise", videoImg: "img3", videourl: "thirdVideo", videoDate: "30 Dec 2021", extensions: ".mp4")
        let fourth = Video(videoId: 4, title: "Beginner Cardio Workout", videoImg: "img4", videourl: "fourthVideo", videoDate: "22 Feb 2022", extensions: ".mp4")
        let fifth = Video(videoId: 5, title: "Full Body HIIT Workout", videoImg: "img5", videourl: "fifthVideo", videoDate: "05 Jun 2021", extensions: ".mp4")
        let sixth = Video(videoId: 6, title: "Yoga for Flexibility", videoImg: "img6", videourl: "sixthVideo", videoDate: "20 Jan 2023", extensions: ".mp4")
        let videoDetails = [first, second, third, fourth, fifth, sixth]
        videoArry.append(contentsOf: videoDetails)
    }
    
    //MARK: - ButtonActions

    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Tableview Delegate & Datasource

extension VideoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! VideoListTableViewCell
        cell.titleOfVideo.text = videoArry[indexPath.row].title
        cell.imgOfVideo.image = UIImage(named: videoArry[indexPath.row].videoImg)
        cell.lblDateOfVideo.text = videoArry[indexPath.row].videoDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VideoDetailViewController") as! VideoDetailViewController
        print("Selected Index -- \(indexPath.row)")
        vc.index = indexPath.row
        vc.videoArry = videoArry
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
