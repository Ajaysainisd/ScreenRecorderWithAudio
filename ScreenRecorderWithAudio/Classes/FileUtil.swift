//
//  FileManager.swift
//
//  Created by Giridhar on 20/06/17.
//  Copyright © 2017 Giridhar. All rights reserved.
//
//  ScreenRecordingWithAudio
//
//  Modified by Ajay Saini on 14/05/19.
//  Copyright © 2019 Ajay Saini. All rights reserved.
//

import Foundation
import UIKit

public class ReplayFileUtil
{
    
    public class func filePath() -> URL
    {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let soundFileURL = documentsPath.appendingPathComponent("screenRecording.mp4")
        return URL(fileURLWithPath: soundFileURL)
    }
    
    
    public class func deleteFile()
    {
        
        let filemanager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let destinationPath = documentsPath.appendingPathComponent("screenRecording.mp4")
        do {
            try filemanager.removeItem(atPath: destinationPath)
            print("Local path removed successfully")
        } catch let error as NSError {
            print("------Error",error.debugDescription)
        }
    }
    
    
    public class func isRecordingAvailible() -> Bool {
        let manager = FileManager.default
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as NSString
        let destinationPath = documentsPath.appendingPathComponent("screenRecording.mp4")
        if manager.fileExists(atPath: destinationPath) {
            print("The file exists!")
            return true
        } else {
            return false
        }
    }
    
    
    
    
}



