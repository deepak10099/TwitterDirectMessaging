//
//  MessageViewController.swift
//  DirectMessaging
//
//  Created by Deepak on 16/06/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import Foundation
import UIKit

class FollowersViewController: UIViewController {
    var followersViewModel:FollowersViewModel?
    @IBOutlet weak var followersTableView: UITableView!

    override func viewDidLoad() {
        followersViewModel = FollowersViewModel()
        followersViewModel?.fetchFollowers()
        followersViewModel?.followersViewModelUpdated = {
            self.followersTableView.reloadData()
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension FollowersViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "Add Message", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Message"
            let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
            textField.addConstraint(heightConstraint)

        }
        let backView = alertController.view.subviews.last?.subviews.last
        backView?.layer.cornerRadius = 10.0
        backView?.backgroundColor = UIColor.yellow
        let sendAction = UIAlertAction(title: "Send", style: UIAlertActionStyle.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            self.followersViewModel?.sendMessage(message: firstTextField.text!, indexPath: indexPath, completion: { (response, data, error) in
                if error == nil{
                    let resultAlertController = UIAlertController(title: "Message delivered successfully", message: "", preferredStyle: UIAlertControllerStyle.alert)
                    let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                        (action : UIAlertAction!) -> Void in })
                    resultAlertController.addAction(cancelAction)
                    self.present(resultAlertController, animated: true, completion: nil)
                }
            })
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(cancelAction)
        alertController.addAction(sendAction)

        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.40)
        alertController.view.addConstraint(height);

        self.present(alertController, animated: true, completion: nil)
    }
}

extension FollowersViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = followersViewModel?.followersViewModel{
            return (viewModel.count)
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FollowerCell = tableView.dequeueReusableCell(withIdentifier: "followerCell") as! FollowerCell
        if let viewModel = followersViewModel?.followersViewModel{
        cell.id.text = viewModel[indexPath.row].id
        cell.name.text = viewModel[indexPath.row].name
        cell.location.text = viewModel[indexPath.row].location
        return cell
    }
    return UITableViewCell()
    }
}


class FollowerCell:UITableViewCell{
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
}
