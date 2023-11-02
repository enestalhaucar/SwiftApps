//
//  DetailsViewController.swift
//  NoteApp
//
//  Created by Enes Talha Uçar  on 30.10.2023.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var productSizeTextField: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    var selectedProductName = ""
    var selectedProductId : UUID?
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedProductName != "" {
            saveButtonOutlet.isHidden = true
            
            if let uuidString = selectedProductId?.uuidString {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NoteApp")
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
                
                do {
                    let results = try context.fetch(fetchRequest)
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            productNameTextField.text = name
                        }
                        if let price = result.value(forKey: "price") as? Int {
                            productPriceTextField.text = String(price)
                        }
                        if let size = result.value(forKey: "size") as? String {
                            productSizeTextField.text = size
                        }
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            imageView.image = image
                        }
                    }
                } catch {
                    
                }
            }
            
        }else {
            saveButtonOutlet.isHidden = false
            saveButtonOutlet.isEnabled = false
            productNameTextField.text = ""
            productSizeTextField.text = ""
            productPriceTextField.text = ""

        }

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickedImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    }
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    @objc func clickedImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage
        saveButtonOutlet.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let noteApp = NSEntityDescription.insertNewObject(forEntityName: "NoteApp", into: context)
        
        noteApp.setValue(productNameTextField.text, forKey: "name")
        noteApp.setValue(productSizeTextField.text, forKey: "size")
        
        if let price = Int(productPriceTextField.text!){
            noteApp.setValue(price, forKey: "price")
        }
            
        noteApp.setValue(UUID(), forKey: "id")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        noteApp.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("başarılı")
        } catch {
            print("There is a mistake when saving data")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DataEntered"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    

}
