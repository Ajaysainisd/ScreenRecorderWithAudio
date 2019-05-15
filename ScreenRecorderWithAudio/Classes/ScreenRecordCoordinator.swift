//
//  ScreenRecordCoordinator.swift
//
//  Created by Giridhar on 21/06/17.
//  Copyright © 2017 Giridhar. All rights reserved.
//
//  ScreenRecordingWithAudio
//
//  Modified by Ajay Saini on 14/05/19.
//  Copyright © 2019 Ajay Saini. All rights reserved.
//

import Foundation

public class ScreenRecordCoordinator: NSObject
{
    
    
    public let screenRecorder = ScreenRecorder()
    public var recordCompleted:((Error?) ->Void)?
    
    
    public override init()
    {
        super.init()
    }
    
    public func startRecording( recordingHandler: @escaping (Error?) -> Void,onCompletion: @escaping (Error?)->Void)
    {
        
        screenRecorder.startRecording() { (error) in
            recordingHandler(error)
            self.recordCompleted = onCompletion
        }
    }
    
    public func stopRecording()
    {
        screenRecorder.stopRecording { (error) in
            self.recordCompleted?(error)
        }
    }
    
}
