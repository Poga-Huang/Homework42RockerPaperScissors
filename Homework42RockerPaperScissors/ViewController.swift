//
//  ViewController.swift
//  Homework42RockerPaperScissors
//
//  Created by 黃柏嘉 on 2021/12/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Label
    @IBOutlet weak var playerWinCountLabel: UILabel!
    @IBOutlet weak var CPUWinCountLabel: UILabel!
    //ImageView
    @IBOutlet weak var CPUResultImageView: CPUImageView!
    @IBOutlet weak var playerResultImageView: UIImageView!
    let myRPSArray = ["Scissors","Rock","Paper"]
    let CPUArray = ["RPS0","RPS1","RPS2"]
    //variables
    var playerCount:Int = 0{
        didSet{
            playerWinCountLabel.text = "\(playerCount)"
        }
    }
    var CPUCount:Int = 0{
        didSet{
            CPUWinCountLabel.text = "\(CPUCount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CPUResultImageView.quickSwitch()
    }
    //出拳
    @IBAction func shoot(_ sender: UIButton) {
        speakRPS()
        let randomNumber = Int.random(in: 0...2)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
            self.CPUResultImageView.image = UIImage(named: self.CPUArray[randomNumber])
            self.playerResultImageView.image = UIImage(named: self.myRPSArray[sender.tag])
            self.checkResult(myResult: sender.tag, CPUResult: randomNumber)
        }
    }
    //檢查雙方結果
    func checkResult(myResult:Int,CPUResult:Int){
        if myResult == CPUResult{
            alert(title: "雙方平手", message: "繼續決勝負吧！")
        }else if myResult == 2 && CPUResult == 0{
            CPUCount += 1
            alert(title: "可惡...", message: "輸了下一場再來...")
        }else if myResult == 0 && CPUResult == 2{
            playerCount += 1
            alert(title: "恭喜！", message: "贏了，繼續贏下去！")
        }else if myResult < CPUResult{
            CPUCount += 1
            alert(title: "可惡...", message: "輸了下一場再來...")
        }else if myResult > CPUResult{
            playerCount += 1
            alert(title: "恭喜！", message: "贏了，繼續贏下去！")
        }
            
    }
    //警示器通知使用者
    func alert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default) { closeAction in
            alert.dismiss(animated: true) {
                self.CPUResultImageView.quickSwitch()
                self.playerResultImageView.image = nil
            }
        }
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
    //說剪刀石頭布
    func speakRPS(){
        let speechUtterance = AVSpeechUtterance(string: "剪刀、石頭、布")
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh_TW")
        speechUtterance.rate = 0.8
        speechUtterance.volume = 10
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speechUtterance)
    }
}

