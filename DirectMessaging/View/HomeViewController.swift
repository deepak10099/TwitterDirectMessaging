//
//  ViewController.swift
//  DirectMessaging
//
//  Created by Deepak on 16/06/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    var homeViewModel:HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authenticateButtonTapped(_ sender: Any) {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .overCurrentContext
        present(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        homeViewModel?.logoutButtonTapped()
    }
    
}






