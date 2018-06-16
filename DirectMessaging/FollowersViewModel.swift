//
//  FollowersViewModel.swift
//  DirectMessaging
//
//  Created by Deepak on 16/06/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import Foundation
import TwitterKit

class FollowersViewModel{
    
    var followersViewModel:[Follower]?{
        didSet{
            
        }
    }

    func fetchFollowers(){
        let directMessaging = DirectMessaging()
        directMessaging.fetchStatus { (response, data, error) in
            var myDict = self.convertToDictionary(data: data!)
            print(myDict!["users"]!)
            let followersArray:Array = myDict!["users"]! as! Array<Any>
            print(followersArray)
            self.followersViewModel = self.makeFollowersArray(array: followersArray)
        }
    }
    
    func makeFollowersArray(array: Array<Any>) -> [Follower]{
        var followers:[Follower] = [Follower]()
        for follower:Any in array {
            let newFollower = Follower()
            newFollower.id = (follower as! [String:Any])["id_str"] as? String
            newFollower.name = (follower as! [String:Any])["name"] as? String
            newFollower.location = (follower as! [String:Any])["location"] as? String
            followers.append(newFollower)
        }
        return followers
    }
    
    func convertToDictionary(data: Data) -> [String: Any]? {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            } catch {
                print(error.localizedDescription)
            }
        return nil
    }

    
}
