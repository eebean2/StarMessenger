//
//  ViewController.swift
//  StarMessenger
//
//  Created by Erik on 07/04/2016.
//  Copyright (c) 2016 Erik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let user = SMDispatch.user(uid: "1234", username: "User1", avatar: nil)
        let message = SMPhotoMessage(withPhoto: SMPhoto(fromUIImage: UIImage(named: "cute")!), user: user)
        SMDispatch.messages().send(photo: message)
        let text = SMTextMessage(withMessage: "hi", user: user)
        SMDispatch.messages().send(text)

//      Video not in file
//
//        let path = Bundle.main.path(forResource: "tvid", ofType: "m4v")
//        let url = URL(fileURLWithPath: path!)
//        let video = SMVideo(fromURL: url)
//        let vid = SMVideoMessage(withVideo: video, user: user)
//        SMDispatch.messages().send(video: vid)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

