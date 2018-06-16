//
//  FirstViewControllerViewModel.swift
//  DirectMessaging
//
//  Created by Deepak on 16/06/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import Foundation
import TwitterKit

class HomeViewModel{
    
    func logoutButtonTapped() {
        for session1 in TWTRTwitter.sharedInstance().sessionStore.existingUserSessions() {
            if let session = session1 as? TWTRSession {
                TWTRTwitter.sharedInstance().sessionStore.logOutUserID(session.userID)
            }
        }
    }
}

