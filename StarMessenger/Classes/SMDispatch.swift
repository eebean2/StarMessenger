/*
 SM-GSD
 
 This file is where all functions and commands will be processed.
 All public calls will be represented through this file, then
 redistributed to the proper files as seen fit.
 
 SMDispatch.swift       7.5.16      © 2016 Red Man Apps
 
 Updated Last: 7.5.16
 */

import UIKit

public enum SMMessageOption {
    case sound              // Play sounds?
    case delay              // Send delay
    case numbering          // Numbers options (see SMNumberingOption below)
    case customMID          // Custom Message IDentification string (see below)
}

public enum SMNumberingOption {
    case random64, random32 // A random string of 64 (default) or 32 letters and numbers
    case number             // Numbered starting at 1
    case custom             // Must also include customMID with either your own number
    // to log, or nil (some features will be disabled)
}

public enum SMDisplayOption {
    case time               // Displays the time of the message
    case uid                // Displays the known UID of the user
    case username           // Displays the known username of the user
    case name               // Displays the known name of the user
    case custom             // You choose via Dispatch().display(...)
}

public enum SMNoiseOption { // Internal function for logging.
    case critical           // Only critical errors
    case error              // Displays SOME levels of errors (error & critical)
    case warning            // Displays ALL levels of errors (warning, error, critical)
    case tips               // Displays tips
    case logs               // Displays logs
    case loud               // All Errors, Logs, and Tips (overrides all others)
    case fatal              // Internal
    case spaces             // Internal - See note below
    
    // NOTE: Using warning nullifies error and critical. Using error nullifies critical.
    //       This is because they do the same function. Using loud nullifies all others
    //       as it shows all functions.
    //
    //       spaces is an option created due to increated console logs in Xcode 8. Enabling
    //       puts two lines above and below the console line to be able to find it. You may
    //       use a version of this command at SMDispatch.log(message: String, spaces: true)
    //
    //       Fatal warnings are not ignorable, and will be displayed regardless.
}

internal enum SMErrorType {
    case fatal
    case critical
    case error
    case warning
}

public class SMDispatch {
    
    // MARK: -
    // MARK: Welcome to SM-GSD
    // MARK: Messages
    // MARK: -
    
    public class messages {
        private let dispatch = SMDispatch.sharedInstance
        
        public var wordCount = Int()
        
        /// Opens a new Message Center within the SM-GSD
        public init() { }
        
        /**
         Creates a new message with a text message object to be sent as soon as possible and with send sound played
         
         - warning: If no internet connection, message will not be sent
         - parameter text: The text message object to send to the view
         */
        public func send(_ text: SMTextMessage) {
            dispatch.send(SMMessage(withText: text))
            dispatch.playSendSound()
        }
        
        /**
         Creates a new message with a text message object with options
         
         - warning: If no internet connection, message will not be sent
         - parameter text: The text message object to send to the view
         - parameter options: Options of how to send the message object
         */
        public func send(text message: SMTextMessage, withOptions options: Dictionary<SMMessageOption, AnyObject>?) throws {
            
        }
        
        /**
         Creates a new message with a photo message object to be sent as soon as possible and with send sound played
         
         - warning: If no internet connection, message will not be sent
         - parameter photo: The photo message object to send to the view
         */
        public func send(photo message: SMPhotoMessage) {
            dispatch.send(SMMessage(withPhoto: message))
            dispatch.playSendSound()
        }
        
        /**
         Creates a new message with a photo message object with options
         
         - warning: If no internet connection, message will not be sent
         - parameter photo: The photo message object to send to the view
         - parameter options: Options of how to send the message object
         */
        public func send(photo message: SMPhotoMessage, withOptions options: Dictionary<SMMessageOption, AnyObject>?) throws {
            
        }
        
        /**
         Creates a new message with a video message object to be sent as soon as possible and with send sound played
         
         - warning: If no internet connection, message will not be sent
         - parameter video: The video message object to send to the view
         */
        public func send(video message: SMVideoMessage) {
            dispatch.send(SMMessage(withVideo: message))
            dispatch.playSendSound()
        }
        
        /**
         Creates a new message with a video message object with options
         
         - warning: If no internet connection, message will not be sent
         - parameter video: The video message object to send to the view
         - parameter options: Options of how to send the message object
         */
        public func send(video message: SMVideoMessage, withOptions options: Dictionary<SMMessageOption, AnyObject>?) throws {
            
        }
        
        /// Currently not supported
        public func send(gif message: SMGifMessage) {
            dispatch.send(SMMessage(withGIF: message))
            dispatch.playSendSound()
        }
        
        /// Currently not supported
        public func send(gif message: SMGifMessage, withOptions options: Dictionary<SMMessageOption, AnyObject>?) throws {
            
        }
        
        /**
         Updates the text message opject previously uploaded
         
         - warning: If no internet connection, message will not update
         - parameter text: The text message object to update, must contain the same messageID with new text
         */
        public func update(text message: SMTextMessage) {
            dispatch.update(SMMessage(withText: message))
        }
        
        /**
         Updates the photo message opject previously uploaded
         
         - warning: If no internet connection, message will not update
         - parameter photo: The photo message object to update, must contain the same messageID with a new photo
         */
        public func update(photo message: SMPhotoMessage) {
            dispatch.update(SMMessage(withPhoto: message))
        }
        
        /**
         Updates the video message opject previously uploaded
         
         - warning: If no internet connection, message will not update
         - parameter video: The video message object to update, must contain the same messageID with a new video
         */
        public func update(video message: SMVideoMessage) {
            dispatch.update(SMMessage(withVideo: message))
        }
        
        /// Currently not supported
        func update(gif message: SMGifMessage) {
            dispatch.update(SMMessage(withGIF: message))
        }
        
        /**
         Removes the text message object from the view.
         
         - parameter text: The text object to be removed.
         */
        public func remove(text message: SMTextMessage) {
            dispatch.remove(SMMessage(withText: message))
        }
        
        /**
         Removes the photo message object from the view
         
         - parameter photo: The photo object to be removed
         */
        public func remove(photo message: SMPhotoMessage) {
            dispatch.remove(SMMessage(withPhoto: message))
        }
        
        /**
         Removes the video message object from the view
         
         - parameter photo: The video object to be removed
         */
        public func remove(video message: SMVideoMessage) {
            dispatch.remove(SMMessage(withVideo: message))
        }
        
        /// Currently not supported
        public func remove(gif message: SMGifMessage) {
            dispatch.remove(SMMessage(withGIF: message))
        }
    }
    
    // MARK: -
    // MARK: Notification Center
    // MARK: -
    
    public class notificationCenter {
        public weak var delegate: SMMessageNotificationDelegate?
        private let dispatch = SMDispatch()
        
        public init() { }
        
        internal func didRecieveMessage() {
            dispatch.playReceiveSound()
        }
    }
    
    // MARK: -
    // MARK: User
    // MARK: -
    
    public class user {
        var uid: String!
        var username: String?
        var avatar: UIImage?
        
        public init(uid: String, username: String?, avatar: UIImage?) {
            self.uid = uid
            self.username = username
            self.avatar = avatar
        }
    }
    
    // MARK: -
    // MARK: Disbatch
    // MARK: -
    
    public weak var delegate: SMDispatchDelegate?
    internal var silantMode = false
    
    public static let sharedInstance = SMDispatch()
    
    /**
     The SM-GSD where all functions and commands will be processed.
     Most all public calls will be represented through this file, then
     redistributed to the proper functions as seen fit.
     
     This dispatch is to simplify your files and help you debug faster.
     */
    private init() {
        if delegate != nil {
            self.silantMode = delegate!.silentMode!()
        }
    }
    
    // MARK: -
    // MARK: Options
    // MARK: -
    
    // MARK: Public Variables
    public var tail = true
    public var label = true
    public var avatar = true
    public var loggingOptions = [SMNoiseOption]()
    
    // MARK: Internal Variables
    internal var userMessages = Array<SMMessage>()
    
    internal var bubbleColor = UIColor.lightGray
    internal var avatarNilColor = UIColor.lightGray
    internal var outsideTextColor = UIColor.black
    internal var textColor = UIColor.white
    internal var viewBackgroundColor = UIColor.white
    internal var viewBackgroundImage = UIImage()
    
    // MARK: Public Functions
    public func setBubble(_ color: UIColor) {
        bubbleColor = color
    }
    
    public func setEmptyAvatar(_ color: UIColor) {
        avatarNilColor = color
    }
    
    public func setOutsideText(_ color: UIColor) {
        outsideTextColor = color
    }
    
    public func setText(_ color: UIColor) {
        textColor = color
    }
    
    public func display(_ str: String) {
        // Set text object for SMMessage
        
        // Wrong place to do it?
    }
    
    public func setViewBackground(color: UIColor) {
        viewBackgroundColor = color
    }
    
    public func setViewBackground(image: UIImage) {
        viewBackgroundImage = image
    }
    
    public func setViewBackground(photo: SMPhoto) {
        viewBackgroundImage = photo.asUIImage()
    }
    
    // MARK: Private Functions
    
    private func send(_ message: SMMessage) {
        userMessages.append(message)
    }
    
    /// Not currently supported
    private func remove(_ message: SMMessage) {
        
    }
    
    // Not currently supported
    private func update(_ message: SMMessage) {
        
    }
    
    // MARK: -
    // MARK: Sounds
    // MARK: -
    
    public var sound = true
    
    public func playSendSound() {
        
    }
    
    public func playReceiveSound() {
        
    }
    
    public func playUpdateSuccessSound() {
        
    }
    
    public func playUpdateFailedSound() {
        
    }
    
    public func log(message: String, spaces: Bool) {
        if spaces {
            print("\n \n :: SMDispatch__  (public) :: \(message) \n \n")
        } else {
            print(":: SMDispatch__  (public) :: \(message)")
        }
    }
    
    internal func log(message: String, file: String?, options: [SMNoiseOption]?) {
        let file = file?.lowercased()
        if !options!.isEmpty {
            if options!.contains(.loud) || options!.contains(.logs) {
                if file!.isEmpty {
                    if options!.contains(.spaces) {
                        print("\n \n :: SMDispatch__LOG (generic) :: \(message) \n \n")
                    } else {
                        print(":: SMDispatch__LOG (generic) :: \(message)")
                    }
                } else {
                    if options!.contains(.spaces) {
                        print("\n \n :: SMDispatch__LOG (\(file!)) :: \(message) \n \n")
                    } else {
                        print(":: SMDispatch__LOG (\(file!)) :: \(message)")
                    }
                }
            }
        } else {
            let tip = "Did you know you can set logging options? SMDispatch.loggingOptions = [SMNoiseOptions]"
            logTip(tip: tip, file: "SMDispatch", options: loggingOptions)
            if file!.isEmpty {
                print(":: SMDispatch__LOG (generic) :: \(message)")
            } else {
                print(":: SMDispatch__LOG (\(file!)) :: \(message)")
            }
        }
    }
    
    internal func logError(error: String, file: String?, type: SMErrorType, options: [SMNoiseOption]?) {
        if type == .fatal {
            if !options!.isEmpty {
                if options!.contains(.spaces) {
                    fatalWarning(message: error, file: file, spaces: true)
                } else {
                    fatalWarning(message: error, file: file, spaces: false)
                }
            } else {
                fatalWarning(message: error, file: file, spaces: false)
            }
        }
        let file = file?.lowercased()
        if !options!.isEmpty {
            if options!.contains(.loud) || options!.contains(.warning) {
                if file!.isEmpty {
                    if options!.contains(.spaces) {
                        print("\n \n :: SMDispatch__ERROR (unknown) :: \(error) \n \n")
                    } else {
                        print(":: SMDispatch__ERROR (unknown) :: \(error)")
                    }
                } else {
                    if options!.contains(.spaces) {
                        print("\n \n :: SMDispatch__ERROR (\(file!)) :: \(error) \n \n")
                    } else {
                        print(":: SMDispatch__ERROR (\(file!)) :: \(error)")
                    }
                }
            } else if options!.contains(.error) {
                if type == .error || type == .critical {
                    if file!.isEmpty {
                        if options!.contains(.spaces) {
                            print("\n \n :: SMDispatch__ERROR (unknown) :: \(error) \n \n")
                        } else {
                            print(":: SMDispatch__ERROR (unknown) :: \(error)")
                        }
                    } else {
                        if options!.contains(.spaces) {
                            print("\n \n :: SMDispatch__ERROR (\(file!)) :: \(error) \n \n")
                        } else {
                            print(":: SMDispatch__ERROR (\(file!)) :: \(error)")
                        }
                    }
                }
            } else if options!.contains(.critical) {
                if type == .critical {
                    if file!.isEmpty {
                        if options!.contains(.spaces) {
                            print("\n \n :: SMDispatch__ERROR (unknown) :: \(error) \n \n")
                        } else {
                            print(":: SMDispatch__ERROR (unknown) :: \(error)")
                        }
                    } else {
                        if options!.contains(.spaces) {
                            print("\n \n :: SMDispatch__ERROR (\(file!)) :: \(error) \n \n")
                        } else {
                            print(":: SMDispatch__ERROR (\(file!)) :: \(error)")
                        }
                    }
                }
            }
        } else {
            let tip = "Did you know you can set logging options? SMDispatch.loggingOptions = [SMNoiseOptions]"
            logTip(tip: tip, file: "SMDispatch", options: loggingOptions)
            if file!.isEmpty {
                print(":: SMDispatch__ERROR (unknown) :: \(error)")
            } else {
                print(":: SMDispatch__ERROR (\(file!)) :: \(error)")
            }
        }
    }
    
    internal func logTip(tip: String, file: String?, options: [SMNoiseOption]?) {
        let file = file?.lowercased()
        if !options!.isEmpty {
            if options!.contains(.loud) || options!.contains(.tips) {
                if file!.isEmpty {
                    if options!.contains(.spaces) {
                        print("\n \n :: SMDispatch__TIP (generic tip) :: \(tip) \n \n")
                    } else {
                        print(":: SMDispatch__TIP (generic tip) :: \(tip)")
                    }
                } else {
                    if options!.contains(.spaces) {
                        print("\n \n :: SMDispatch__TIP (\(file!) tip) :: \(tip) \n \n")
                    } else {
                        print(":: SMDispatch__TIP (\(file!) tip) :: \(tip)")
                    }
                }
            }
        } else {
            if file!.isEmpty {
                print(":: SMDispatch__TIP (generic tip) :: \(tip)")
            } else {
                print(":: SMDispatch__TIP (\(file!) tip) :: \(tip)")
            }
        }
    }
    
    private func fatalWarning(message: String, file: String?, spaces: Bool) {
        var file = file?.lowercased()
        if file!.isEmpty {
            if spaces {
                print("\n \n :: SMDispatch__FATAL (warning) :: \(message) \n \n")
            } else {
                print(":: SMDispatch__FATAL (warning) :: \(message)")
            }
        } else {
            if spaces {
                print("\n \n :: SMDispatch__FATAL (\(file!) warning) :: \(message)")
            } else {
                print(":: SMDispatch__FATAL (\(file!) warning) :: \(message)")
            }
        }
    }
}

public protocol SMMessageNotificationDelegate: class {
    func updateNotification() -> Bool
    
}

@objc public protocol SMDispatchDelegate: class {
    @objc optional func silentMode() -> Bool
}
