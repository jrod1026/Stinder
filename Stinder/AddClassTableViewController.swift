//
//  AddClassTableViewController.swift
//  Stinder
//
//  Created by Josue Rodriguez on 4/30/18.
//  Copyright © 2018 Josue Rodriguez. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth



class courseTableCell: UITableViewCell {
    @IBOutlet weak var courseName: UILabel!
    
    
}

var dbRef = Database.database().reference()
var currentUser = dbRef.child("users").child((Auth.auth().currentUser?.uid)!)
var mySchool = ""
var yourSchool = dbRef.child("schools").child(mySchool)
class AddClassTableViewController: UITableViewController {
    
    
    
    
    
    var courses = [String]()
    var newClass = ""
    @IBAction func cancel(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        let AddClassVC = segue.source as! AddClassViewController
        newClass = AddClassVC.course
        
        courses.append(newClass)
        currentUser.updateChildValues(["myCourses": courses])
            yourSchool.observeSingleEvent(of: .value) { (snapshot) in
                print("im here")
                if let value = snapshot.value as? NSDictionary {
                    var arrayToBeUpdated = value[self.newClass] as? [String]
                    if arrayToBeUpdated == nil{
                        arrayToBeUpdated = [String]()
                    }
                    arrayToBeUpdated!.append((Auth.auth().currentUser?.uid)!)
                    yourSchool.updateChildValues([self.newClass: arrayToBeUpdated as Any])
                }
                    else {
                        yourSchool.child(self.newClass).setValue([ Auth.auth().currentUser?.uid])
                }
            
            }
            
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        currentUser.child("myCourses").observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                for (_, val) in value {
                    self.courses.append(val as! String)
                }
            }
            
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentUser.observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                mySchool = (value["school"] as? String)!
                yourSchool = dbRef.child("schools").child(mySchool)
                
                
                if let myCourseArray = value["myCourses"] as? [String] {
                    print(myCourseArray)
                    self.courses = myCourseArray
                    print(self.courses)
                }
//                for (_, val) in value {
//                    self.courses.append(val as! String)
//                }
            }
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
        print(courses)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath) as! courseTableCell
        cell.courseName.text = courses[indexPath.row]
        // Configure the cell...

        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            print("before deleting: ", courses)
            let removedCourse = courses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            yourSchool.child(removedCourse).observeSingleEvent(of: .value) { (snapshot) in
                if let value = snapshot.value as? [String] {
                    let newValue = value.filter {$0 != Auth.auth().currentUser?.uid }
                    yourSchool.updateChildValues([removedCourse: newValue])
                }
            }
            currentUser.child("myCourses").observeSingleEvent(of: .value) { (snapshot) in
                if let value = snapshot.value as? [String] {
                    let newValue = value.filter {$0 != removedCourse}
                    currentUser.updateChildValues(["myCourses": newValue])
                }
            }
            print(courses)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
