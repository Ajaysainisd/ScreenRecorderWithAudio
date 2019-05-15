//
//  ViewController.swift
//  ScreenRecordingWithAudio
//
//  Created by Ajay Saini on 14/05/19.
//  Copyright © 2019 Ajay Saini. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import ScreenRecorderWithAudio

class ViewController: UIViewController{
    
    @IBOutlet weak var btnStartRecording : UIButton!
    @IBOutlet weak var btnStopRecording : UIButton!
    @IBOutlet weak var btnViewRecording : UIButton!
    
    @IBOutlet weak var viewAnimate : UIView!
    // Recorder Vars
    
    private var isRecording = false
    let screenRecord = ScreenRecordCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func initialSetup(){
        screenRecord.screenRecorder.onRecordingError = {
            ReplayFileUtil.deleteFile()
            self.isRecording = false
        }
        screenRecord.screenRecorder.recordingQua = .high
        self.btnStopRecording.isHidden = true
        self.btnViewRecording.isHidden = true
    }
    
    func addAnimation(){
        let fantasticView = FantasticView(frame: self.viewAnimate.bounds)
        self.viewAnimate.addSubview(fantasticView)
    }
    
    func removeAnimation(){
        self.viewAnimate.subviews.forEach { (animView) in
            animView.removeFromSuperview()
        }
    }
    
    
    
    @IBAction func btnActionStartRecording(_ vsender: UIButton){
        screenRecord.startRecording(recordingHandler: { (error) in
            print("Recording in progress")
        }) { (error) in
            print("Recording Complete")
        }
        self.isRecording = true
        self.addAnimation()
        self.btnStartRecording.isHidden = true
        self.btnStopRecording.isHidden = false
    }
    
    @IBAction func btnActionStopRecording(_ sender: UIButton){
        screenRecord.stopRecording()
        self.removeAnimation()
        self.isRecording = false
        if ReplayFileUtil.isRecordingAvailible(){
            self.btnStopRecording.isHidden = true
            self.btnStartRecording.isHidden = false
            self.btnViewRecording.isHidden = false
        }
    }
    
    @IBAction func btnActionViewRecording(_ sender: UIButton){
        let player = AVPlayer(url: ReplayFileUtil.filePath() )
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    
    
}

extension AVAssetWriter {
    
    
    /*!
     @enum AVAssetWriterStatus
     @abstract
     These constants are returned by the AVAssetWriter status property to indicate whether it can successfully write samples to its output file.
     
     @constant     AVAssetWriterStatusUnknown
     Indicates that the status of the asset writer is not currently known.
     @constant     AVAssetWriterStatusWriting
     Indicates that the asset writer is successfully writing samples to its output file.
     @constant     AVAssetWriterStatusCompleted
     Indicates that the asset writer has successfully written all samples following a call to finishWriting.
     @constant     AVAssetWriterStatusFailed
     Indicates that the asset writer can no longer write samples to its output file because of an error. The error is described by the value of the asset writer's error property.
     @constant     AVAssetWriterStatusCancelled
     Indicates that the asset writer can no longer write samples because writing was canceled with the cancelWriting method.
     */
    public enum status : Int {
        
        
        case unknown
        
        case writing
        
        case completed
        
        case failed
        
        case cancelled
    }
}
