//
//  SettingsViewController.swift
//  PhotoShare
//
//  Created by Enes Talha Uçar  on 2.11.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("There is mistake while log out")
        }
        
        performSegue(withIdentifier: "toVC", sender: nil)
    }
    
    
    
    

}
