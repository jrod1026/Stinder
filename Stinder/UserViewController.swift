//
//  UserViewController.swift
//  Stinder
//
//  Created by Josue Rodriguez on 4/17/18.
//  Copyright © 2018 Josue Rodriguez. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


func addImage(postImage: UIImage) {
    let dbRef = Database.database().reference()
    let data = UIImageJPEGRepresentation(postImage, 1.0)
    let path = "Images/\(UUID().uuidString)"
    dbRef.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["imagePath": path])
    store(data: data, toPath: path)
}
func store(data: Data?, toPath path: String) {
    let storageRef = Storage.storage().reference()
    storageRef.child(path).putData(data!, metadata: nil) { (metadata, error) in
        if let error = error {
            print(error)
        }
    }
}
func getDataFromPath(path: String, completion: @escaping (Data?) -> Void) {
    let storageRef = Storage.storage().reference()
    storageRef.child(path).getData(maxSize: 10 * 1024 * 1024) { (data, error) in
        if let error = error {
            print(error)
        }
        if let data = data {
            completion(data)
        } else {
            completion(nil)
        }
    }
}

var userRef = Storage.storage().reference().child("users")
class UserViewController: UIViewController {
    let dbRef = Database.database().reference()

    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBAction func changePhoto(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.userProfilePicture.image = image
            addImage(postImage: image)
            
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        displayName.text = Auth.auth().currentUser?.displayName
        userProfilePicture.layer.cornerRadius = 10.0
        Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let imagePathVal = value?["imagePath"] as? String
            if imagePathVal == "noPath" {
                self.userProfilePicture.image = #imageLiteral(resourceName: "profile-placeholder")
            }
            else {
                getDataFromPath(path: imagePathVal!) { (data) in
                    if let data = data {
                        let image = UIImage(data: data)
                        self.userProfilePicture.image = image
                    }
                }
            }
            
        })

        
//        print(val)
//        if val as! NSString == "noPath" as NSString {
//            print("hi")
//            self.userProfilePicture.image = #imageLiteral(resourceName: "profile-placeholder")
//        }
//        else {
//            getDataFromPath(path: self.dbRef.child("users").child((Auth.auth().currentUser?.uid)!).value(forKey: "imagePath") as! String) { (data) in
//                let image = UIImage(data: data!)
//                self.userProfilePicture.image = image
//            }
//
//        }
        //var imageURL =
        //userProfilePicture.image =
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
