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
    }
}

extension FollowersViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension FollowersViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:FollowerCell = tableView.dequeueReusableCell(withIdentifier: "followerCell") as! FollowerCell
        return cell
    }
    
    
}


class FollowerCell:UITableViewCell{
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
}
