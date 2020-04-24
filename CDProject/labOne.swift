//
//  labOne.swift
//  CDProject
//
//  Created by Nathan on 4/20/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import UIKit
import CoreData

class labOne: UIViewController{

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    var imagePicker = UIImagePickerController()
    
    var user = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("made it")
        
        imagePicker.delegate = self
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do{
            let user = try persistenceService.context.fetch(fetchRequest)
            self.user = user
            print(String(self.user.count))
            //self.user = user
            
        }catch{}
        
        
    }
    
    
    @IBAction func selectPic(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func countUp(_ sender: Any) {
        let alert = UIAlertController(title: "Add User", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "username"
            }
            alert.addTextField { (textField) in
                textField.placeholder = "password"
            }
            alert.addTextField { (textField) in
            textField.placeholder = "bio"
            }
        let action = UIAlertAction(title:"New User", style: .default) { (_) in
            let username = alert.textFields![0].text!
            let password = alert.textFields![1].text!
            let bio      = alert.textFields![2].text!
            let user = User(context: persistenceService.context)
            user.username = username
            user.password = password
            user.bio = bio
            persistenceService.saveContext()
            self.user.append(user)
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
            

        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        

        
    }
    
    @IBAction func deleteAll(_ sender: Any) {
        //self.user.removeAll()
        print(String(self.user.count))
        print("hi")
        
        for usr in user{
            print(usr.username + "  " + usr.password)
            print("bio: " + usr.bio)
            persistenceService.context.delete(usr)
        }
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
            for usr in self.user{
                if usr.username == username && usr.password == password{
                    print("Welcome back " + usr.username)
                    x = true
                    break
                }
            }
            if x != true{
                print("unsuccesful login")
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

extension labOne: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            let data = image.pngData()
            (user.last)!.profpic = data! as NSData
            persistenceService.saveContext()
            imageV.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
}
