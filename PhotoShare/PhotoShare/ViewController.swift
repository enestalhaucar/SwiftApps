//
//  ViewController.swift
//  PhotoShare
//
//  Created by Enes Talha Uçar  on 2.11.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInButton(_ sender: Any) {
        if usernameTextField.text != nil && passwordTextField.text != nil {
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { AuthDataResult, Error in
                if Error != nil {
                    self.wrongAlert(alertTitle: "Failed", alertMassage: Error?.localizedDescription ?? "There is a mistake")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else {
            wrongAlert(alertTitle: "Failed", alertMassage: "Enter Email and Password !")
        }
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        if usernameTextField.text != nil && passwordTextField.text != nil {
            Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.wrongAlert(alertTitle: "Failed", alertMassage: error?.localizedDescription ?? "Hata var")
                    
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else {
            wrongAlert(alertTitle: "Failed", alertMassage: "Enter Email and Password !")
        }
    }
    
    func wrongAlert(alertTitle : String, alertMassage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMassage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

