//
//  SMMessageView.swift
//  Learning
//
//  Created by Erik Bean on 7/1/16.
//  Copyright © 2016 Red Man Apps. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

internal enum SMMessageType {
    case text, textUpdate
    case photo, photoUpdate
    case video, videoUpdate
    case gif, gifUpdate     // Support Coming Soon
    case textOld, photoOld, videoOld, gifOld
}

private enum CheckType {
    case avatar     // Updates views bounds baised on avatar visibility
    case message    // Checks bounds of views and alters where needed
    case label      // Checks text and truncates if needed
}

internal class SMCell: UITableViewCell { // UITableViewCell programaticly drawn
    internal var sender = true
    internal var message = SMMessage()
    internal var labelText = String()
    
    private let dispatch = SMDispatch.sharedInstance
    private var tail: Bool { return dispatch.tail }
    private var avatar: Bool { return dispatch.avatar }
    private var label: Bool { return dispatch.label }
    private var bubbleWidth: CGFloat {
        if avatar {
            return self.frame.width - 92
        } else {
            return self.frame.width - 46
        }
    }
    private var bubbleHeight: CGFloat {
        var height: CGFloat = self.frame.height - 16
        if label {
            height -= 29
        }
        if tail {
            height -= 34
        }
        return height
    }
    private var bubbleX: CGFloat {
        var x: CGFloat = 0
        if sender {
            if avatar {
                x = self.frame.maxX - 46
            } else {
                x = self.frame.maxX - 8
            }
        } else {
            if avatar {
                x = self.frame.minX + 46
            } else {
                x = self.frame.minX + 8
            }
        }
        return x
    }
    private var bubbleY: CGFloat {
        var y: CGFloat = 0
        if label {
            y = self.frame.minY + 37
        } else {
            y = self.frame.minY + 8
        }
        return y
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let bubble = drawBubble()
        if label {
            let lab = drawLabel()
            bubble.addSubview(lab)
        }
        if avatar {
            let ava = drawAvatar()
            bubble.addSubview(ava)
        }
        if tail {
            let til = drawTail()
            bubble.addSubview(til)
        }
        
        self.addSubview(bubble)
    }
    
    private func drawBubble() -> UIImageView {
        let view = UIImageView(frame: CGRect(x: bubbleX, y: bubbleY, width: bubbleWidth, height: bubbleHeight))
        view.image = UIImage(named: "bbubble", in: Bundle(for: self.classForCoder), compatibleWith: nil)
        view.image = view.image!.withRenderingMode(.alwaysTemplate)
        return view
    }
    
    private func drawLabel() -> UILabel {
        return UILabel()
    }
    
    private func drawAvatar() -> UIImageView {
        return UIImageView()
    }
    
    private func drawTail() -> UIImageView {
        return UIImageView()
    }
    
    private func messageCheck(for message: SMMessage) {
        if message.type == .text {
            send(text: message, update: false)
        } else if message.type == .textUpdate {
            send(text: message, update: true)
        } else if message.type == .photo {
            send(photo: message, update: false)
        } else if message.type == .photoUpdate {
            send(photo: message, update: true)
        } else if message.type == .video {
            send(video: message, update: false)
        } else if message.type == .videoUpdate {
            send(video: message, update: true)
        } else if message.type == .gif {
            send(gif: message, update: false)
        } else if message.type == .gifUpdate {
            send(gif: message, update: true)
        } else {
            dispatch.logError(error: "Invalid Message Type", file: "SMMessageView", type: .fatal, options: dispatch.loggingOptions)
            dispatch.logError(error: "Message: \(message)", file: "SMMessageview", type: .fatal, options: dispatch.loggingOptions)
            dispatch.logTip(tip: "Check the message is non-nil and the data is not corrupt!", file: "SMMessageView", options: dispatch.loggingOptions)
            fatalError()
        }
    }
    
    private func send(text message: SMMessage, update: Bool) {
        if !update {
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: insideView.frame.width, height: insideView.frame.height))
//            label.text = message.text
//            label.textColor = dispatch.textColor
//            label.sizeToFit()
            
//            insideView.addSubview(label)
//            insideView.frame = CGRect(x: insideView.frame.minX, y: insideView.frame.minY, width: label.frame.width, height: label.frame.height)
            
//            boundCheck(type: .message)
        }
    }
    
    private func send(photo message: SMMessage, update: Bool) {
        if !update {
            let image = message.photo!.asUIImage()
//            let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: insideView.frame.width, height: 300))
//            imageView?.contentMode = .scaleAspectFit
//            imageview.image = image
            
//            insideView.addSubview(imageview)
//            insideView.frame = CGRect(x: insideView.frame.minX, y: insideView.frame.minY, width: insideView.frame.width, height: 300)
            
//            boundCheck(type: .message)
        }
    }
    
    private func send(video message: SMMessage, update: Bool) {
        if !update {
            let player = AVPlayer(url: message.video!.video)
            let controller = AVPlayerViewController()
            controller.player = player
//            controller.view.frame = CGRect(x: 0, y: 0, width: insideView.frame.width, height: 300)
//            insideView.addSubview(controller.view)
//            insideView.frame = CGRect(x: insideView.frame.minX, y: insideView.frame.minY, width: insideView.frame.width, height: 300)
            
//            boundCheck(type: .message)
        }
    }
    
    private func send(gif message: SMMessage, update: Bool) {
        if !update {
            dispatch.log(message: "GIF messages are not yet fully ready. Please come back later!", file: "SMMessageView", options: dispatch.loggingOptions)
        }
    }
    
    private func avatarCheck(for message: SMMessage?) {
        if dispatch.avatar {
//            avatarView.layer.cornerRadius = 15
            if message?.avatar != nil {
//                let av = avatarView as! UIImageView
//                av.image = message?.avatar
            } else {
//                avatarView.backgroundColor = dispatch.avatarNilColor
            }
        } else {
//            avatarView.isHidden = true
//            boundCheck(type: .avatar)
        }
    }
}

internal class SMMessageView: UITableViewCell { // soon to no longer be needed
    
    internal var type: SMMessageType!
    internal var message = SMMessage()
    internal var height = CGFloat()
    private let dispatch = SMDispatch.sharedInstance
    
    @IBOutlet internal weak var outsideView: UIImageView!
    @IBOutlet internal weak var insideView: UIView!
    @IBOutlet internal weak var avatarView: UIView!
    @IBOutlet internal weak var userLabel: UILabel!
    @IBOutlet internal weak var tailView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tailView.image = UIImage(named: "rTail", in: Bundle(for: self.classForCoder), compatibleWith: nil)
        tailView.image = tailView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        outsideView.image = UIImage(named: "bbubble", in: Bundle(for: self.classForCoder), compatibleWith: nil)
        outsideView.image = outsideView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        tailView.tintColor = dispatch.bubbleColor
        outsideView.tintColor = dispatch.bubbleColor
        insideView.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        messageCheck(for: message, draw: true)
    }
    
    internal func present(for message: SMMessage) {
        avatarCheck(for: message)
        messageCheck(for: message, draw: false)
    }
    
    private func messageCheck(for message: SMMessage, draw: Bool) {
        if message.type == .text {
            if draw {
                send(text: message, update: false)
            } else {
                type = .text
                self.message = message
            }
        } else if message.type == .textUpdate {
            if draw {
                send(text: message, update: true)
            } else {
                type = .textUpdate
                self.message = message
            }
        } else if message.type == .photo {
            if draw {
                send(photo: message, update: false)
            } else {
                type = .photo
                self.message = message
            }
        } else if message.type == .photoUpdate {
            if draw {
                send(photo: message, update: true)
            } else {
                type = .photoUpdate
                self.message = message
            }
        } else if message.type == .video {
            if draw {
                send(video: message, update: false)
            } else {
                type = .video
                self.message = message
            }
        } else if message.type == .videoUpdate {
            if draw {
                send(video: message, update: true)
            } else {
                type = .videoUpdate
                self.message = message
            }
        } else if message.type == .gif {
            if draw {
                send(gif: message, update: false)
            } else {
                type = .gif
                self.message = message
            }
        } else if message.type == .gifUpdate {
            if draw {
                send(gif: message, update: true)
            } else {
                type = .gifUpdate
                self.message = message
            }
        } else {
            dispatch.logError(error: "Invalid Message Type", file: "SMMessageView", type: .fatal, options: dispatch.loggingOptions)
            dispatch.logError(error: "Message: \(message)", file: "SMMessageview", type: .fatal, options: dispatch.loggingOptions)
            dispatch.logTip(tip: "Check the message is non-nil and the data is not corrupt!", file: "SMMessageView", options: dispatch.loggingOptions)
            fatalError()
        }
    }
    
    private func send(text message: SMMessage, update: Bool) {
        if !update {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: insideView.frame.width, height: insideView.frame.height))
            label.text = message.text
            label.textColor = dispatch.textColor
            label.sizeToFit()
            
            insideView.addSubview(label)
            insideView.frame = CGRect(x: insideView.frame.minX, y: insideView.frame.minY, width: label.frame.width, height: label.frame.height)
            
            boundCheck(type: .message)
        }
    }
    
    private func send(photo message: SMMessage, update: Bool) {
        if !update {
            let image = message.photo!.asUIImage()
            let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: insideView.frame.width, height: 300))
            imageView?.contentMode = .scaleAspectFit
            imageview.image = image
            
            insideView.addSubview(imageview)
            insideView.frame = CGRect(x: insideView.frame.minX, y: insideView.frame.minY, width: insideView.frame.width, height: 300)
            
            boundCheck(type: .message)
        }
    }
    
    private func send(video message: SMMessage, update: Bool) {
        if !update {
            let player = AVPlayer(url: message.video!.video)
            let controller = AVPlayerViewController()
            controller.player = player
            controller.view.frame = CGRect(x: 0, y: 0, width: insideView.frame.width, height: 300)
            
            insideView.addSubview(controller.view)
            insideView.frame = CGRect(x: insideView.frame.minX, y: insideView.frame.minY, width: insideView.frame.width, height: 300)
            
            boundCheck(type: .message)
        }
    }
    
    private func send(gif message: SMMessage, update: Bool) {
        if !update {
            dispatch.log(message: "GIF messages are not yet fully ready. Please come back later!", file: "SMMessageView", options: dispatch.loggingOptions)
        }
    }
    
    private func avatarCheck(for message: SMMessage?) {
        if dispatch.avatar {
            avatarView.layer.cornerRadius = 15
            if message?.avatar != nil {
                let av = avatarView as! UIImageView
                av.image = message?.avatar
            } else {
                avatarView.backgroundColor = dispatch.avatarNilColor
            }
        } else {
            avatarView.isHidden = true
            boundCheck(type: .avatar)
        }
    }
    
    private func boundCheck(type: CheckType) {
        if type == .avatar {
            dispatch.logError(error: "Bound Check called, but no bounds updated!", file: "SMMesssageView", type: .warning, options: dispatch.loggingOptions)
        } else if type == .message {
            let height = insideView.frame.height + 28
            let width = insideView.frame.width + 28
            let x = tailView.frame.maxX - width
            let y = outsideView.frame.minY // 5.5 tailview
            let newFrame = CGRect(x: x, y: y, width: width, height: height)
            if newFrame == outsideView.frame {
                dispatch.logError(error: "Bound Check called, but no bounds updated!", file: "SMMesssageView", type: .warning, options: dispatch.loggingOptions)
            } else {
                if newFrame.width != userLabel.frame.width {
                    let x = newFrame.minX
                    let y = userLabel.frame.minY
                    userLabel.frame = CGRect(x: x, y: y, width: newFrame.width, height: userLabel.frame.height)
                    boundCheck(type: .label)
                }
                
                outsideView.frame = newFrame
                let height = newFrame.height - 28
                let width = newFrame.width - 28
                let x = newFrame.minX + 14
                let y = newFrame.minY + 14
                insideView.frame = CGRect(x: x, y: y, width: width, height: height)
                
                let tailFrame = CGRect(x: tailView.frame.minX, y: outsideView.frame.maxY - 5.5, width: tailView.frame.width, height: tailView.frame.height)
                tailView.frame = tailFrame
                
                let avaFrame = CGRect(x: tailFrame.maxX + 8, y: tailFrame.maxY - avatarView.frame.height, width: avatarView.frame.width, height: avatarView.frame.height)
                avatarView.frame = avaFrame
                
                self.height = (tailView.frame.height - 5.5) + outsideView.frame.height + userLabel.frame.height
                let vc = SMMessageViewController()
                vc.heights.append(self.height)
                dispatch.log(message: "Height registared as \(self.height)", file: "SMMessageView", options: dispatch.loggingOptions)
            }
        } else if type == .label {
            dispatch.logError(error: "Bound Check called, but no bounds updated!", file: "SMMesssageView", type: .warning, options: dispatch.loggingOptions)
        }
    }
}

internal class SMMessage {
    var uid: String!
    var time: Date!
    var avatar: UIImage?
    var type: SMMessageType!
    var text: String?
    var photo: SMPhoto?
    var video: SMVideo?
    var gif: SMGif?
    private let dispatch = SMDispatch.sharedInstance
    
    internal init() { }
    
    internal init(withText text: SMTextMessage) {
        self.uid = text.uid
        self.time = text.time
        if dispatch.avatar {
            self.avatar = text.avatar
        }
        if text.update {
            self.type = .textUpdate
        } else {
            self.type = .text
        }
        self.text = text.text
    }
    
    internal init(withPhoto photo: SMPhotoMessage) {
        self.uid = photo.uid
        self.time = photo.time
        if dispatch.avatar {
            self.avatar = photo.avatar
        }
        if photo.update {
            self.type = .photoUpdate
        } else {
            self.type = .photo
        }
        self.photo = photo.photo
    }
    
    internal init(withVideo video: SMVideoMessage) {
        self.uid = video.uid
        self.time = video.time
        if dispatch.avatar {
            self.avatar = video.avatar
        }
        if video.update {
            self.type = .videoUpdate
        } else {
            self.type = .video
        }
        self.video = video.video
    }
    
    internal init(withGIF gif: SMGifMessage) {
        self.uid = gif.uid
        self.time = gif.time
        if dispatch.avatar {
            self.avatar = gif.avatar
        }
        if gif.update {
            self.type = .gifUpdate
        } else {
            self.type = .gif
        }
        self.gif = gif.gif
    }
}

public class SMTextMessage {
    public var uid: String!
    public var time: Date!
    public var text: String { return privText }
    public var avatar: UIImage?
    public var updateTime: Date { return newTime }
    public var update: Bool { return privUpdate }
    private var privText: String!
    private var privUpdate = false
    private var newTime: Date!
    
    public init(withMessage message: String, user: SMDispatch.user) {
        self.time = Date()
        self.privText = message
        self.uid = user.uid
        self.avatar = user.avatar
    }
    
    public init(withMessage message: String, uid: String, avatar: UIImage?) {
        self.time = Date()
        self.privText = message
        self.uid = uid
        self.avatar = avatar
    }
    
    public func update(_ text: String) {
        self.privText = text
        self.newTime = Date()
        self.privUpdate = true
    }
}

public class SMPhotoMessage {
    public var uid: String!
    public var time: Date!
    public var photo: SMPhoto { return privPhoto }
    public var avatar: UIImage?
    public var updateTime: Date { return newTime }
    public var update: Bool { return privUpdate }
    private var privPhoto: SMPhoto!
    private var privUpdate = false
    private var newTime: Date!
    
    public init(withPhoto photo: SMPhoto, user: SMDispatch.user) {
        self.time = Date()
        self.privPhoto = photo
        self.uid = user.uid
        self.avatar = user.avatar
    }
    
    public init(withPhoto photo: SMPhoto, uid: String, avatar: UIImage?) {
        self.time = Date()
        self.privPhoto = photo
        self.uid = uid
        self.avatar = avatar
    }
    
    public func update(_ photo: SMPhoto) {
        self.privPhoto = photo
        self.newTime = Date()
        self.privUpdate = true
    }
}

public class SMVideoMessage {
    public var uid: String!
    public var time: Date!
    public var video: SMVideo { return privVideo }
    public var avatar: UIImage?
    public var updateTime: Date { return newTime }
    public var update: Bool { return privUpdate }
    private var privVideo: SMVideo!
    private var privUpdate = false
    private var newTime: Date!
    
    public init(withVideo video: SMVideo, user: SMDispatch.user) {
        self.time = Date()
        self.privVideo = video
        self.uid = user.uid
        self.avatar = user.avatar
    }
    
    public init(withVideo video: SMVideo, uid: String, avatar: UIImage?) {
        self.time = Date()
        self.privVideo = video
        self.uid = uid
        self.avatar = avatar
    }
    
    public func update(_ video: SMVideo) {
        self.privVideo = video
        self.newTime = Date()
        self.privUpdate = true
    }
}

public class SMGifMessage {
    public var uid: String!
    public var time: Date!
    public var gif: SMGif { return privGIF }
    public var avatar: UIImage?
    public var updateTime: Date { return newTime }
    public var update: Bool { return privUpdate }
    private var privGIF: SMGif!
    private var privUpdate = false
    private var newTime: Date!
    
    public init(withGIF gif: SMGif, user: SMDispatch.user) {
        self.time = Date()
        self.privGIF = gif
        self.uid = user.uid
        self.avatar = user.avatar
    }
    
    public init(withGIF gif: SMGif, uid: String, avatar: UIImage?) {
        self.time = Date()
        self.privGIF = gif
        self.uid = uid
        self.avatar = avatar
    }
    
    public func update(_ gif: SMGif) {
        self.privGIF = gif
        self.newTime = Date()
        self.privUpdate = true
    }
}

public class SMPhoto {
    internal var photo: UIImage!
    
    public init(fromUIImage image: UIImage) {
        self.photo = image
    }
    
    public init(fromData data: Data) {
        self.photo = UIImage(data: data)
    }
    
    public init(fromCIImage image: CIImage) {
        self.photo = UIImage(ciImage: image)
    }
    
    public init(fromCGImage image: CGImage) {
        self.photo = UIImage(cgImage: image)
    }
    
    public func asUIImage() -> UIImage {
        return photo
    }
    
    public func asCIImage() -> CIImage {
        return photo.ciImage!
    }
    
    public func asCGImage() -> CGImage {
        return photo.cgImage!
    }
}

public class SMVideo {
    internal var video: URL!
    
    internal init() { }
    
    public init(fromURL url: URL) {
        video = url
    }
    
    @available(iOS 9.0, *)
    public init(fromData data: Data) {
        video = URL(dataRepresentation: data, relativeTo: nil)
    }
}

public class SMGif {
    public init() {
        let dispatch = SMDispatch.sharedInstance
        dispatch.logTip(tip: "SMGif is not yet ready, try a custom SMImage?", file: "SMGif", options: dispatch.loggingOptions)
    }
    // Keep?
}


