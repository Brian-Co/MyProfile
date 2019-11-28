//
//  ViewController.swift
//  Chandago Test
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
        
        hideKeyboardOnTap()
        createGradientView()
    }
    
    @IBAction func createAccount(_ sender: Any) {
        if let email = validateEmail(string: emailTextField.text!) {
            print("Email valid \(email)")
            if let password = validatePassword(string: passwordTextField.text!) {
                print("password is \(password)")
                let confirmPassword = passwordConfirmationTextField.text!
                let confirmPasswordTrimmed = confirmPassword.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                if password == confirmPasswordTrimmed {
                    print("passwords match")
                    createAccount(email: email, password: password)
                } else {
                    let alertController = UIAlertController(title: "Passwords don't match", message: nil, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                print("password invalid")
            }
        } else {
            print("Email invalid")
        }
        
    }
    
    func createAccount(email: String, password: String) {
        let IDManager = ASIdentifierManager.shared()
        let adID = IDManager.advertisingIdentifier.description
        print("adID \(IDManager.isAdvertisingTrackingEnabled) \(adID)")
        
        let account = Account(email: HelperMethods.shared.hashString(string: email), uuid: HelperMethods.shared.getUID(), password: HelperMethods.shared.hashString(string: password), deviceId: adID)
        guard let uploadData = try? JSONEncoder().encode(account) else {
            return
        }
        print("uploadData" + String(data: uploadData, encoding: .utf8)!)
        
        HelperMethods.shared.sendData(uploadData: uploadData, to: "https://lfdjdev.appconsent.io/register") { bool in
            if bool {
                let defaults = UserDefaults.standard
                defaults.set(true, forKey: "isUserRegistered")
                let alertController = UIAlertController(title: "Congratulations!", message: "Account successfully created!", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: {(alert: UIAlertAction!) in self.dismiss(animated: true, completion: nil)})
                alertController.addAction(defaultAction)
                DispatchQueue.main.async {
                    let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
                    notificationFeedbackGenerator.notificationOccurred(.success)
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "Something went wrong...", message: "An error ocurred. Try again.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                DispatchQueue.main.async {
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func validateEmail(string: String) -> String? {
        let email = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email) {
            return email
        } else {
            let alertController = UIAlertController(title: "Invalid email", message: nil, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return nil
        }
    }
    
    func validatePassword(string: String) -> String? {
        let password = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil) || (password.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil) || password.count < 10 {
            let alertController = UIAlertController(title: "Password Error", message: "Password must contain at least 10 characters, one upper case letter, and one number", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            return nil
        } else {
            return password
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

extension UIViewController {

    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

