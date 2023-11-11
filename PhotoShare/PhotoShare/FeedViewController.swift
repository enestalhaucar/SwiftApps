//
//  FeedViewController.swift
//  PhotoShare
//
//  Created by Enes Talha Uçar  on 2.11.2023.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var emailArray = [String]()
    var noteArray = [String]()
    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        retrieveDataFromFirebase()
    }
    
    func retrieveDataFromFirebase() {
        let firebaseDB = Firestore.firestore()
        firebaseDB.collection("Post").order(by: "date", descending: true)
            .addSnapshotListener { (snapshot, error) in
            if error != nil {
                self.wrongAlert(title: "Failed", message: error?.localizedDescription ?? "Try again")
            }
            else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.emailArray.removeAll(keepingCapacity: false)
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.noteArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        if let email = document.get("email") as? String {
                            self.emailArray.append(email)
                        }
                        if let note = document.get("note") as? String {
                            self.noteArray.append(note)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.imageArray.append(imageUrl)
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    func wrongAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.emailTextField.text = self.emailArray[indexPath.row]
        cell.noteTextField.text = self.noteArray[indexPath.row]
        cell.postImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))

        
        return cell
    }
    
}
