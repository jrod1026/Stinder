//
//  ChatViewController.swift
//  Stinder
//
//  Created by Josue Rodriguez on 4/17/18.
//  Copyright © 2018 Josue Rodriguez. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class matchCell: UITableViewCell {
    @IBOutlet weak var matchPic: UIImageView!
    @IBOutlet weak var matchName: UILabel!
    @IBOutlet weak var matchEmail: UILabel!
}




class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myMatches = [String]()
    
    @IBOutlet weak var matchesTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myMatches.count == 0 {
            return 1
        }
        else {
            return myMatches.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if myMatches.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noMatchCell")!
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "matchCell") as! matchCell
            updateCellInfo(indexPath: indexPath, cell: cell )
            return cell
        }
    }
    
    
    func updateCellInfo(indexPath: IndexPath, cell: matchCell) {
        dbRef.child("users").child(myMatches[indexPath.row]).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                let name = value["name"] as! String
                let email = value["email"] as! String
                let imagePathVal = value["imagePath"] as? String
                if imagePathVal == "noPath" {
                    cell.matchPic.image = #imageLiteral(resourceName: "profile-placeholder")
                }
                else {
                    getDataFromPath(path: imagePathVal!) { (data) in
                        if let data = data {
                            let image = UIImage(data: data)
                            cell.matchPic.image = image
                        }
                    }
                }
                cell.matchName.text = name
                cell.matchEmail.text = email
                self.matchesTableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        matchesTableView.delegate = self
        matchesTableView.dataSource = self
        updateMatchArray()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        updateMatchArray()
        print(myMatches)
        matchesTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateMatchArray() {
        dbRef.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                if let matches = value["matches"] as? [String] {
                    self.myMatches = matches
                }
            }
        }
        
        
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
