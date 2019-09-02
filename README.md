# Screen Recorder With Audio

This is a wrapper for screen recording with audio on iOS with ReplayKit2 using Swift. 
</br>

[![CI Status](https://img.shields.io/travis/Ajaysainisd/ScreenRecorderWithAudio.svg?style=flat)](https://travis-ci.org/Ajaysainisd/ScreenRecorderWithAudio)
[![Version](https://img.shields.io/cocoapods/v/ScreenRecorderWithAudio.svg?style=flat)](https://cocoapods.org/pods/ScreenRecorderWithAudio)
[![License](https://img.shields.io/cocoapods/l/ScreenRecorderWithAudio.svg?style=flat)](https://cocoapods.org/pods/ScreenRecorderWithAudio)
[![Platform](https://img.shields.io/cocoapods/p/ScreenRecorderWithAudio.svg?style=flat)](https://cocoapods.org/pods/ScreenRecorderWithAudio)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ScreenRecorderWithAudio is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ScreenRecorderWithAudio'
```

## Usage

Create a object of screenRecorder Coordinator

```
let screenRecorder = ScreenRecordCoordinator()
```

Set Recording quality

```
screenRecorder.screenRecorder.recordingQua = .high
```

Screen recording is abstracted to a single function 

```
screenRecorder.startRecording(recordingHandler: { (error) in
print("Recording in progress")
}) { (error) in
print("Recording Complete")
}
```

Also a single line stop 

```
screenRecorder.stopRecording()
```

Get path of recorded file

```
ReplayFileUtil.filePath()
```


## Features

* Record Screen with audio from microphone or playing audio from device speaker
* Set output quality as you wish


## Contributions

Please feel free to contribute to the project :) 


## Author

Ajaysainisd, ajaysainisd@gmail.com

## License

ScreenRecorderWithAudio is available under the MIT license. See the LICENSE file for more info.
