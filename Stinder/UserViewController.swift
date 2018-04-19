//
//  UserViewController.swift
//  Stinder
//
//  Created by Josue Rodriguez on 4/17/18.
//  Copyright © 2018 Josue Rodriguez. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserViewController: UIViewController {

    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBAction func changePhoto(_ sender: Any) {
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            self.userProfilePicture.image = image
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        displayName.text = Auth.auth().currentUser?.displayName
        userProfilePicture.layer.cornerRadius = 10.0
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
