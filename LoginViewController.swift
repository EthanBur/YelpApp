//
//  UIView.swift
//  PokedexApp
//
//  Created by mcs on 2/3/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    var usernameTextField: UITextField = {
       var textField = UITextField()
        textField.accessibilityIdentifier = "username"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        
        return textField
    }()
    
    var passwordTextField: UITextField = {
       var textField = UITextField()
        textField.accessibilityIdentifier = "password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        
        return textField
    }()
    
    var submitButton: UIButton = {
        var button = UIButton()
        button.accessibilityIdentifier = "submit"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.setTitle("submit", for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
//        usernameTextField.text = "admin@test.com"
//        passwordTextField.text = "admin"
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(submitButton)
        
        submitButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.navigationItem.title = "PokéDex"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "Trebuchet MS", size: 35.0)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        navigationController?.navigationBar.barTintColor = UIColor.red
        setupConstraints()
    }
    
        //submit button function
    @objc func buttonTapped() -> Bool{
        //alert
        let alertController = UIAlertController(title: "Warning", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        if usernameTextField.text == ""{
            alertController.message = "Username is Empty"
            self.present(alertController, animated: true)
        }else if passwordTextField.text == ""{
            alertController.message = "Password is Empty"
            self.present(alertController, animated: true)
        }else {
            
            if usernameTextField.text?.lowercased() == "admin@test.com" && passwordTextField.text == "admin" {
                navigationController?.pushViewController(ViewController(), animated: true)
                return true
            } else {
                alertController.message = "Incorrect username or password"
                self.present(alertController, animated: true)
            }
        }
        return false
    }
  
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            //Username Constraints
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            usernameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            usernameTextField.heightAnchor.constraint(equalToConstant: 30),
            
            //Password Constraints
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            
            //Submit Button Constraints
            submitButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
    }
    
}

