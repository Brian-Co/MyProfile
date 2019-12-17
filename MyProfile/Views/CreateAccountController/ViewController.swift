//
//  ViewController.swift
//  MyProfile
//
//  Created by Brian Corrieri on 30/10/2019.
//  Copyright © 2019 FairTrip. All rights reserved.
//

import UIKit
import CryptoKit
import AdSupport

class ViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    private var viewModel: CreateAccountViewModel!
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient = 0
    
    let colorOne = UIColor.blue.cgColor
    let colorTwo = UIColor.red.cgColor
    let colorThree = UIColor.yellow.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        createAccountButton.layer.cornerRadius = 20
        createAccountButton.setTitleColor(.darkGray, for: .disabled)
        createAccountButton.backgroundColor = .lightGray
        createAccountButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmationTextField.delegate = self
        
        viewModel = CreateAccountViewModel(delegate: self)
        
        hideKeyboardOnTap()
        createGradientView()
    }
    
    @IBAction func createAccount(_ sender: Any) {
        
        viewModel.createAccount(email: emailTextField.text!, password: passwordTextField.text!, passwordConfirmation: passwordConfirmationTextField.text!)
        
    }

}

extension ViewController: CreateAccountViewModelDelegate {
        
    func showPopup(_ popup: Popups) {
        
        var alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        var defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        switch popup {
            
        case .error:
            alertController.title = "Something went wrong..."
            alertController.message = "An error ocurred. Try again."
            self.present(alertController, animated: true, completion: nil)
            
        case .invalidEmail:
            alertController.title = "Invalid email"
            self.present(alertController, animated: true, completion: nil)
            
        case .invalidPassword:
            alertController.title = "Password Error"
            alertController.message = "Password must contain at least 10 characters, one upper case letter, and one number"
            self.present(alertController, animated: true, completion: nil)
            
        case .passwordsDoNotMatch:
            alertController.title = "Passwords don't match"
            self.present(alertController, animated: true, completion: nil)
            
        case .accountCreated:
            alertController = UIAlertController(title: "Congratulations!", message: "Account successfully created!", preferredStyle: .alert)
            defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: {(alert: UIAlertAction!) in self.dismiss(animated: true, completion: nil)})
            alertController.addAction(defaultAction)
            let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
            notificationFeedbackGenerator.notificationOccurred(.success)
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
        
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty && !passwordConfirmationTextField.text!.isEmpty {
            createAccountButton.isEnabled = true
            createAccountButton.backgroundColor = UIColor(red: 120/255, green: 75/255, blue: 224/255, alpha: 1)
        } else {
            createAccountButton.backgroundColor = .lightGray
            createAccountButton.isEnabled = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    
}

extension ViewController: CAAnimationDelegate {

        func createGradientView() {
            
            gradientSet.append([colorOne, colorTwo])
            gradientSet.append([colorTwo, colorThree])
            gradientSet.append([colorThree, colorOne])
            
            gradient.frame = self.view.bounds
            gradient.colors = gradientSet[currentGradient]
            gradient.startPoint = CGPoint(x:0, y:0)
            gradient.endPoint = CGPoint(x:1, y:1)
            gradient.drawsAsynchronously = true
            
            self.view.layer.insertSublayer(gradient, at: 0)
            
            animateGradient()
        }
        
        func animateGradient() {
            if currentGradient < gradientSet.count - 1 {
                currentGradient += 1
            } else {
                currentGradient = 0
            }
            
            let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
            gradientChangeAnimation.duration = 3.0
            gradientChangeAnimation.toValue = gradientSet[currentGradient]
            gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
            gradientChangeAnimation.isRemovedOnCompletion = false
            gradientChangeAnimation.delegate = self
            gradient.add(gradientChangeAnimation, forKey: "gradientChangeAnimation")
        }
        
        func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {            
                gradient.colors = gradientSet[currentGradient]
                animateGradient()
        }
    
}



