
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var barProgressView: UIProgressView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var player: AVAudioPlayer?
    
    var totalTime = 0
    var secondpassed = 0
    var secondsLeft = 60
    var secondsToMinutes = 0
    var minutesLeft = 0
    var timer = Timer()
    
    let eggTime = ["Soft": 180, "Medium" : 420, "Hard" : 720]

    @IBAction func hardnessSelected(_ sender: UIButton) {
         
        let hardness = sender.currentTitle!
        let result = eggTime[hardness]!
        secondsLeft = 60
        secondpassed = 0
        barProgressView.progress = 0.0
        titleLabel.text = hardness
  
        totalTime = result
        secondsToMinutes = totalTime / 60
        minutesLeft = secondsToMinutes - 1
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // called every time interval from the timer
    @objc func updateTimer() {
            if (secondpassed < totalTime){
                secondpassed += 1
                barProgressView.progress = Float (secondpassed) / Float(totalTime)
                
                secondsLeft -= 1
                
                print(secondpassed)
                timerLabel.text = "Time until the eggs is ready: \(minutesLeft):\(secondsLeft)"
                
                timerCountDown()
                
            }
        else {
                timer.invalidate()
                titleLabel.text = "Yea, the eggs is ready to be eated! :)"
                barProgressView.progress = 1.0
                playSound()
            
        }
    }
    
    func timerCountDown() {
        if (secondpassed == 60 || secondpassed == 120 || secondpassed == 180 || secondpassed == 240 || secondpassed == 300 || secondpassed == 360 || secondpassed == 420 || secondpassed == 480 || secondpassed == 540 || secondpassed == 600 || secondpassed == 660 || secondpassed == 720){
          
            minutesLeft -= 1
            secondsLeft = 60
        }
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

    
            guard let player = player else {
                return
                
            }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
