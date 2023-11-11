//
//  UploadViewController.swift
//  PhotoShare
//
//  Created by Enes Talha Uçar  on 2.11.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseCore




class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var noteTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedImage))
        imageView.addGestureRecognizer(gestureRecognizer )
        
        
        
    }
    @objc func clickedImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { storageMetaData, error in
                if error != nil {
                    wrongAlert(title: "Failed", message: error?.localizedDescription ?? "Please try again")
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl {
                                
                                let firestoreDatabase = Firestore.firestore()
                                
                                let firestorePost = ["imageUrl" : imageUrl, "note": self.noteTextField.text!, "email" : Auth.auth().currentUser!.email!, "date": FieldValue.serverTimestamp()] as [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { error in
                                    if error != nil {
                                        wrongAlert(title: "Failed", message: error?.localizedDescription ?? "Please try again")
                                    } else {
                                        self.imageView.image = UIImage(named: "Click to choose photo (1)")
                                        self.noteTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                            
                            
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
    }
    
}
