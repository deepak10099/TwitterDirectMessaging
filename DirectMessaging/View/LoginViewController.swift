//
//  LoginViewController.swift
//  DirectMessaging
//
//  Created by Deepak on 16/06/18.
//  Copyright © 2018 Deepak. All rights reserved.
//

import UIKit
import TwitterKit


class LoginViewController: UIViewController {
    
    var loginViewModel:LoginViewModel?
    
    // MARK: - Private Variables
    private lazy var loginView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundView: UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
        return view
        }()
    
    private lazy var loginButton: TWTRLogInButton = { [unowned self] in
        let button = TWTRLogInButton() { (session, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.actionSheet)
                self.present(alertController, animated: true)
            } else if let session = session {
                self.dismiss(animated: true) {
                    
                }
            }
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        }()
    
    
    
    
    private lazy var cancelButton: UIButton = { [unowned self] in
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(backgroundTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.text = "Select a Login Method"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel = LoginViewModel()
        view.backgroundColor = .clear
        view.addSubview(loginView)
        view.addSubview(backgroundView)
        
        loginView.addSubview(loginButton)
        loginView.addSubview(cancelButton)
        loginView.addSubview(titleLabel)
        
        setupLoginView()
        setupBackgroundView()
        setupLoginButton()
        setupCancelButton()
        setupTitleLabel()
    }
    
    // MARK: - Actions
    
    @objc func backgroundTap() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func setupLoginView() {
        loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loginView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loginView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loginView.heightAnchor.constraint(equalToConstant: 224.0).isActive = true
        
        loginView.layer.shadowRadius = 4.0
        loginView.layer.shadowColor = UIColor.lightGray.cgColor
        loginView.layer.shadowOpacity = 0.2
        loginView.layer.masksToBounds = false
    }
    
    private func setupBackgroundView() {
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: loginView.topAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupLoginButton() {
        loginButton.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10.0).isActive = true
        loginButton.rightAnchor.constraint(equalTo: loginView.rightAnchor, constant: -10.0).isActive = true
        loginButton.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: 10.0).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 48.0).isActive = true
    }
    
    private func setupCancelButton() {
        cancelButton.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: 10.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 10.0).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30.0)
        titleLabel.widthAnchor.constraint(equalToConstant: 100.0)
    }
}

