//
//  profile.swift
//  CDProject
//
//  Created by Nathan on 4/23/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class profile: UIViewController{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioArea: UITextView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var picButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var users = [User]()
    var user = 0
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        
        loadData() // loads in user CoreData into local array
        
        imageView.isHidden = true
        usernameLabel.isHidden = true
        bioArea.isHidden = true
        bioArea.isEditable = false
        logoutButton.isHidden = true
        editButton.isHidden = true
        picButton.isHidden = true
        
    }
    
    
    func loadData(){
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do{
            let user = try persistenceService.context.fetch(fetchRequest)
            self.users = user
            print(String(self.users.count))
                   //self.user = user
                   
            }catch{}
    }
    
    @IBAction func login(_ sender: Any) {
        let alert = UIAlertController(title: "Login", message: "enter your username and password", preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.placeholder = "username"
                }
                alert.addTextField { (textField) in
                    textField.placeholder = "password"
                }
            let action = UIAlertAction(title:"Login", style: .default) { (_) in
                let username = alert.textFields!.first!.text!
                let password = alert.textFields!.last!.text!
                var x = false
                for i in Range(0...self.users.count-1){
                    if self.users[i].username == username && self.users[i].password == password{
                        self.user = i
                        self.start()
                        x = true
                        break
                    }
                }
                if x != true{
                    print("unsuccesful login")
                    let alert = UIAlertController(title: "Incorrect Login", message: "try again or make a new account", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    
    func start(){
        self.imageView.isHidden = false
        self.usernameLabel.isHidden = false
        self.bioArea.isHidden = false
        self.bioArea.isEditable = false
        self.logoutButton.isHidden = false
        self.editButton.isHidden = false
        self.picButton.isHidden = false
        self.loginButton.isHidden = true
        
        imageView.image = UIImage(data: users[user].profpic as Data)
        usernameLabel.text = users[user].username
        bioArea.text = users[user].bio
        
        
    }
    
    @IBAction func editsave(_ sender: Any) {
        if editButton.titleLabel?.text == "Edit Bio"{
            bioArea.isEditable = true
            editButton.setTitle("Save Bio", for: .normal)
        } else if editButton.titleLabel?.text == "Save Bio"{
            bioArea.isEditable = false
            users[user].bio = bioArea.text
            persistenceService.saveContext()
            editButton.setTitle("Edit Bio", for: .normal)
        }
    }
    
    @IBAction func changePic(_ sender: Any) {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        self.present(self.imagePicker, animated: true, completion: nil)

    }
    
    
    }
    
    extension profile: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                let data = image.pngData()
                self.users[user].profpic = data! as NSData
                persistenceService.saveContext()
                imageView.image = image
                

                
            }
            dismiss(animated: true, completion: nil)
        }
        
    }


