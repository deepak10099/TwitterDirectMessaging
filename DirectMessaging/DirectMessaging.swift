//
//  DirectMessaging.swift
//  DemoApp
//
//  Created by Deepak on 16/06/18.
//  Copyright © 2018 Twitter. All rights reserved.
//

import Foundation
import TwitterKit

class DirectMessaging {
    func fetchStatus(completion:@escaping ((_ response:URLResponse?, _ data:Data?, _ connectionError:Error?) -> Void)){
        if let session = TWTRTwitter.sharedInstance().sessionStore.session() {
            
            let client = TWTRAPIClient(userID: session.userID)
            print(session.userID)
            
            let statusesShowEndpoint = "https://api.twitter.com/1.1/followers/list.json?cursor=-1&user_id=\(session.userID)&count=5000"
            var clientError : NSError?
            let request = client.urlRequest(withMethod: "GET", urlString: statusesShowEndpoint, parameters: nil, error: &clientError)
            
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                completion(response,data,connectionError)
            }
        }
    }
    
    func sendMessage(message:String, screenName:String, completion:@escaping ((_ response:URLResponse?, _ data:Data?, _ connectionError:Error?) -> Void)) {
        if let session = TWTRTwitter.sharedInstance().sessionStore.session() {
            let client = TWTRAPIClient(userID: session.userID)
            let urlEncodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let urlEncodedScreenName = screenName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let directMessageShowEndpoint = "https://api.twitter.com/1.1/direct_messages/new.json?text=\(urlEncodedMessage!)&screen_name=\(urlEncodedScreenName!)"
            let sendMessageRequest = client.urlRequest(withMethod: "POST", urlString: directMessageShowEndpoint, parameters: nil, error: nil)
            client.sendTwitterRequest(sendMessageRequest, completion: { (response, data, error) in
                completion(response, data, error)
            })
        }
    }
}


