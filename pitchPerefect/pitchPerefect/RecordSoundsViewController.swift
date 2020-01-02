//
//  RecordSoundsViewController.swift
//  pitchPerefect
//
//  Created by Rawdhah alshaqaq on 9/14/19.
//  Copyright © 2019 Rawdhah alshaqaq. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    //Mark
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var RecordButton: UIButton!
    
  
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    @IBOutlet weak var recordLable: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stopRecordingButton.isEnabled = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appeare called")
        
    }
    
    @IBAction func recordAudio(_ sender: Any) {
     
       // recordLable.text = "Tap to finish recording"
       //RecordButton.isEnabled = false
    //    stopRecordingButton.isEnabled = true
        setButtonOnandOff(false)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
     
        let session = AVAudioSession.sharedInstance()

       try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
       try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        
        
    }
    
    @IBAction func stopRecord(_ sender: Any) {
        
       // recordLable.text = "Tap to start recording"
       // RecordButton.isEnabled = true
       // stopRecordingButton.isEnabled = false
        setButtonOnandOff(true)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "StopRecording", sender: audioRecorder.url)
        } else {
            
            print("recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StopRecording" {
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
            
        }
    }
   
    func setButtonOnandOff(_ enabled : Bool){
        stopRecordingButton.isEnabled = !enabled
        RecordButton.isEnabled = enabled
        if enabled {
            recordLable.text = "Tap to start recording"
        } else {
             recordLable.text = "Tap to finish recording"
        }
        
    }
    
    
}

