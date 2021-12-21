//
//  CPUImageView.swift
//  Homework42RockerPaperScissors
//
//  Created by 黃柏嘉 on 2021/12/21.
//

import UIKit

class CPUImageView: UIImageView {

    func quickSwitch(){
        let animatedImage = UIImage.animatedImageNamed("RPS", duration: 0.1)
        image = animatedImage
    }
}
