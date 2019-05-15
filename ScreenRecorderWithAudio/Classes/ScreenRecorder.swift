//
//  ScreenRecorder.swift
//
//  Created by Giridhar on 09/06/17.
//  Copyright © 2017 Giridhar. All rights reserved.
//
//  ScreenRecordingWithAudio
//
//  Modified by Ajay Saini on 14/05/19.
//  Copyright © 2019 Ajay Saini. All rights reserved.
//
import Foundation
import ReplayKit
import AVKit


public class ScreenRecorder
{
    public enum recordingQuality : CGFloat {
        
        case lowest = 0.3
        case low = 0.5
        case normal = 0.8
        case good = 1.0
        case better = 1.3
        case high = 1.5
        case best = 2.0
    }
    
    public var recordingQua : recordingQuality = .good
    var assetWriter:AVAssetWriter!
    var videoInput:AVAssetWriterInput!
    var audioInput:AVAssetWriterInput!
    
    var recordCompleted:((Error?) ->Void)?
    
    public var onRecordingError: (() -> Void)?
    
    public init(){}
    
    //MARK: Screen Recording
    func startRecording(recordingHandler:@escaping (Error?)-> Void)
    {
        if #available(iOS 11.0, *)
        {
            ReplayFileUtil.deleteFile()
            RPScreenRecorder.shared().isMicrophoneEnabled = true
            
            let fileURL = ReplayFileUtil.filePath()
            assetWriter = try! AVAssetWriter(outputURL: fileURL, fileType:
                AVFileType.mov)
            let audioSettings = [
                AVFormatIDKey : kAudioFormatFLAC,
                AVNumberOfChannelsKey : 1,
                AVSampleRateKey : 16000.0
                ] as [String : Any]
            
            
            
            let videoSettings = [
                AVVideoCodecKey : AVVideoCodecType.h264,
                AVVideoWidthKey : UIScreen.main.bounds.size.width * recordingQua.rawValue,
                AVVideoHeightKey : UIScreen.main.bounds.size.height * recordingQua.rawValue
                ] as [String : Any]
            
            
            videoInput  = AVAssetWriterInput (mediaType: AVMediaType.video, outputSettings: videoSettings)
            
            videoInput.expectsMediaDataInRealTime = true
            
            audioInput = AVAssetWriterInput (mediaType: AVMediaType.audio, outputSettings: audioSettings)
            
            audioInput.expectsMediaDataInRealTime = true
            
            
            if assetWriter.canAdd(audioInput) {
                assetWriter.add(audioInput)
            }
            
            if assetWriter.canAdd(videoInput) {
                assetWriter.add(videoInput)
            }
            RPScreenRecorder.shared().startCapture(handler: { (sample, bufferType, error) in
                print(bufferType.rawValue)
                
                recordingHandler(error)
                
                DispatchQueue.main.async { [weak self] in
                    if CMSampleBufferDataIsReady(sample)
                    {
                        if self?.assetWriter.status == .unknown
                        {
                            self?.assetWriter.startWriting()
                            self?.assetWriter.startSession(atSourceTime: CMSampleBufferGetPresentationTimeStamp(sample))
                        }
                        
                        if self?.assetWriter.status == .failed {
                            print("Error occured, status = \(String(describing: self?.assetWriter.status.rawValue)), \(String(describing: self?.assetWriter.error!.localizedDescription)) \(String(describing: self?.assetWriter.error))")
                            
                            
                            self?.stopRecording { (error) in
                                self?.recordCompleted?(error)
                                self?.onRecordingError?()
                            }
                            
                            
                            return
                        }
                        if (bufferType == .video)
                        {
                            if self?.videoInput.isReadyForMoreMediaData ?? false
                            {
                                self?.videoInput.append(sample)
                                print("video")
                            }
                        }
                        if (bufferType == .audioMic){
                            if self?.audioInput.isReadyForMoreMediaData ?? false
                            {
                                self?.audioInput.append(sample)
                                print("audio")
                            }
                        }
                        
                    }
                }
                
            }) { (error) in
                recordingHandler(error)
                //                debugPrint(error)
            }
        } else
        {
            // Fallback on earlier versions
        }
    }
    
    func stopRecording(handler: @escaping (Error?) -> Void)
    {
        if #available(iOS 11.0, *)
        {
            RPScreenRecorder.shared().stopCapture
                {    (error) in
                    handler(error)
                    self.assetWriter.finishWriting
                        {
                    }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
}
