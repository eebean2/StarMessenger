//
//  SMViewController.swift
//  Pods
//
//  Created by Erik Bean on 7/7/16.
//
//

import UIKit

public class SMMessageViewController: UITableViewController {
    private let dispatch = SMDispatch.sharedInstance
    public weak var delegate: SMMessageViewDelegate?
    private var identifier: String { return tableViewCellIdentifier() }
    private var messages: [SMMessage] { return dispatch.userMessages }
    internal var heights = [CGFloat]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SMRightMessageView", bundle: Bundle(for: SMMessageView.classForCoder()))
        tableView.register(nib, forCellReuseIdentifier: identifier)
//        tableView.register(SMCell.classForCoder(), forCellReuseIdentifier: identifier)
        self.tableView.estimatedRowHeight = 96
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SMMessageView
        cell.selectionStyle = .none
        if delegate != nil {
            let text = delegate!.getTextForLabelIn(row: indexPath.row)
            if text != "" {
                cell.userLabel.text = text
            }
        }
        cell.present(for: messages[indexPath.row])
        
        delegate?.cellWillLoad(cell: cell, indexPath: indexPath)
        
        // Configure the cell...
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(for: messages[indexPath.row])
    }
    
    /**
     The reuse identifier if dynamic cells
     
     Override this function with your own identifier if custom
     - returns: Custom cell identifier (default is "reuseIdentifier")
     */
    public func tableViewCellIdentifier() -> String {
        return "reuseIdentifier"
    }
    
    private func display(_ message: SMMessage, forCell cell: UITableViewCell, at index: IndexPath) {
        
    }
    
    private func getLabel() -> UILabel {
        
        return UILabel()
    }
    
    private func getBubble(for message: SMMessage) -> UIImageView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        return UIImageView()
    }
    
    private func getTail(for message: SMMessage) -> UIImageView {
        
        return UIImageView()
    }
    
    private func getAvatar(for message: SMMessage) -> UIImageView {
        
        
        
        return UIImageView()
    }
    
    private func getHeight(for message: SMMessage) -> CGFloat {
        var height: CGFloat = 0;
        if dispatch.tail {
            height += 26.5
        }
        if dispatch.label {
            height += 29
        }
        if message.type == .text || message.type == .textUpdate {
            let lab = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 21))
            lab.text = message.text
            lab.numberOfLines = -1
            lab.sizeToFit()
            height += 16 + lab.frame.height
        } else if message.type == .photo || message.type == .photoUpdate {
            height += 328
        } else if message.type == .video || message.type == .videoUpdate {
            height += 328
        } else {
            // Gif Support Here
        }
        return height
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

public protocol SMMessageViewDelegate: class {
    func cellWillLoad(cell: UITableViewCell, indexPath: IndexPath)
    func getTextForLabelIn(row: Int) -> String?
}
