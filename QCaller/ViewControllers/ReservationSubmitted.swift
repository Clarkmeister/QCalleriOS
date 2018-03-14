//
//  ReservationSubmitted.swift
//  QCaller
//
//  Created by Arthur Clark on 3/8/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import UIKit
import AudioToolbox

class ReservationSubmitted: UIViewController {

    @IBOutlet weak var reservationTimerLabel: UILabel!
    var date = Date()
    var seconds = 0.0
    @IBOutlet weak var countDownTimer: UILabel!
    @IBOutlet weak var qrLabel: UILabel!
    public var stringPassed = Date()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seconds = date.timeIntervalSinceNow
        runTimer()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            reservationTimerLabel.text = "Current Status: "
            countDownTimer.text = "READY"
            //Send alert to indicate "time's up!"
        } else {
            seconds -= 1
            countDownTimer.text = timeString(time: TimeInterval(seconds))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
