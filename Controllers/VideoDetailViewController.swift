//
//  VideoDetailViewController.swift
//  Care4Senior
//
//  Created by Aneesha on 20/02/24.
//

import UIKit
import AVKit
import AVFoundation
import youtube_ios_player_helper_swift

class VideoDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var buttonPlayPause: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewheight: NSLayoutConstraint!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var videoPlayer: UIView!
    @IBOutlet weak var lblremainingTime: UILabel!
    @IBOutlet weak var lblcurrentTime: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var imgdropArrow: UIImageView!
    
    //MARK: - Variables
    
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var index = Int()
    var videoArry = [Video]()
    var isFullScreen = false
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgdropArrow.image = UIImage(named: "downarrow")
        dropDownView.isHidden = true
        stackViewheight.constant = stackView.frame.size.height / 2
        print("videourl --- \(videoArry[index].videourl)")
        lblTitle.text = videoArry[index].title
        lblSubTitle.text = videoArry[index].videoDate
        let image = UIImage(systemName: "pause.fill")
        buttonPlayPause.setImage(image, for: .normal)
        // Load the local video file
        guard let videoURL = Bundle.main.url(forResource: videoArry[index].videourl, withExtension: videoArry[index].extensions) else {
            fatalError("Video file not found")
        }
        
        // Create AVPlayer with the video URL
        player = AVPlayer(url: videoURL)
        
        // Create AVPlayerLayer to display the video
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoPlayer.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        videoPlayer.layer.addSublayer(playerLayer)
        
        // Start playing the video
        player.play()
        // Add observer for time updates
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { [weak self] time in
            guard let self = self else { return }
            let duration = CMTimeGetSeconds(self.player.currentItem?.duration ?? CMTime.zero)
            let currentTime = CMTimeGetSeconds(time)
            
            self.updateTimeLabels(currentTime: currentTime, duration: duration)
            self.updateSliderValue(currentTime: currentTime, duration: duration)
        }
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UINib(nibName: "VideoListTableViewCell", bundle: .main), forCellReuseIdentifier: "VideoListTableViewCell")
    }
    
    func reloadPage() {
        
        lblTitle.text = videoArry[index].title
        lblSubTitle.text = videoArry[index].videoDate
        
        // Load the local video file
            guard let videoURL = Bundle.main.url(forResource: videoArry[index].videourl, withExtension: videoArry[index].extensions) else {
                fatalError("Video file not found")
            }
            
            // Replace the current player item with the new video URL
            let playerItem = AVPlayerItem(url: videoURL)
            player.replaceCurrentItem(with: playerItem)
            
            // Start playing the new video
            player.play()
        
        
    }
    
    func updateTimeLabels(currentTime: Double, duration: Double) {
        lblcurrentTime.text = formatTime(time: currentTime)
        
        let remainingTime = duration - currentTime
        lblremainingTime.text = "\(formatTime(time: remainingTime))"
    }
    
    func formatTime(time: Double) -> String {
        guard !time.isNaN && !time.isInfinite else {
            return "00:00"
        }
        
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    
    func updateSliderValue(currentTime: Double, duration: Double) {
        guard duration != 0 else { return }
        let sliderValue = Float(currentTime / duration)
        timeSlider.value = sliderValue
    }
    
   
    //MARK: - ButtonAction
    
    @IBAction func playClicked(_ sender: Any) {
        if self.player?.timeControlStatus == .playing {
            let image = UIImage(systemName: "play.fill")
            buttonPlayPause.setImage(image, for: .normal)
            self.player?.pause()
        }else {
            let image = UIImage(systemName: "pause.fill")
            buttonPlayPause.setImage(image, for: .normal)
            self.player?.play()
        }
    }
    
    @IBAction func buttonDropUpDown(_ sender: UIButton) {
        if imgdropArrow.image == UIImage(named: "downarrow") {
            imgdropArrow.image = UIImage(named: "uparrow")
            stackViewheight.constant = 100
            dropDownView.isHidden = false
        }else {
            imgdropArrow.image = UIImage(named: "downarrow")
            stackViewheight.constant = 50
            dropDownView.isHidden = true
        }
    }
    
    @IBAction func sliderMove(_ sender: UISlider) {
        let duration = CMTimeGetSeconds(player.currentItem?.duration ?? CMTime.zero)
        let seekTime = duration * Double(sender.value)
        let seekTarget = CMTimeMakeWithSeconds(seekTime, preferredTimescale: 1)
        
        player.seek(to: seekTarget)
    }
    
    @IBAction func fullscreenClicked(_ sender: Any) {
        DispatchQueue.main.async {
            OrientationManager.landscapeSupported = !OrientationManager.landscapeSupported
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            if #available(iOS 16.0, *) {
                windowScene?.requestGeometryUpdate(.iOS(interfaceOrientations: OrientationManager.landscapeSupported ? .landscape : .portrait))
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 16.0, *) {
                self.setNeedsUpdateOfSupportedInterfaceOrientations()
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    @IBAction func buttonBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension VideoDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! VideoListTableViewCell
        cell.lblDateOfVideo.text = videoArry[indexPath.row].videoDate
        cell.titleOfVideo.text = videoArry[indexPath.row].title
        cell.imgOfVideo.image = UIImage(named: videoArry[indexPath.row].videoImg)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if imgdropArrow.image == UIImage(named: "uparrow") {
            stackViewheight.constant = 50
        }
        imgdropArrow.image = UIImage(named: "downarrow")
        dropDownView.isHidden = true
        let image = UIImage(systemName: "pause.fill")
        buttonPlayPause.setImage(image, for: .normal)
        index = indexPath.row
        reloadPage()
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

class OrientationManager {
    static var landscapeSupported: Bool = false
}
