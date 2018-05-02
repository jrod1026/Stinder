//
//  StackViewController.swift
//  Stinder
//
//  Created by Josue Rodriguez on 5/1/18.
//  Copyright © 2018 Josue Rodriguez. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class theirCourseCell: UITableViewCell {
    @IBOutlet weak var courseName: UILabel!
    
}




class StackViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dbRef = Database.database().reference()
    var currentUserID = (Auth.auth().currentUser?.uid)!
    
    var potentialMatches = [String]()
    var interestedIn = [String]()
    var matches = [String]()
    var myCourses = [String]()
    var theirCourseList = [String]()
    var mySchool = ""
    var alreadySeen = [String]()
    var theirID = ""
    var theirMatches = [String]()
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theirCourseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "theirCourseCell", for: indexPath) as! theirCourseCell
        cell.courseName.text = theirCourseList[indexPath.row]
        return cell
    }
    
    
    @IBOutlet weak var theirProfilePic: UIImageView!
    @IBOutlet weak var theirName: UILabel!
    @IBOutlet weak var theirCourses: UITableView!
    
    
    
    
    @IBAction func notInterestedButton(_ sender: Any) {
        updateAlreadySeen(); prepareData()
    print("in the button")
    
    
    
    
    }
    
    
    @IBAction func interestedButton(_ sender: Any) {
        updateAlreadySeen(); rightButtonFunctionality(); prepareData()
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        theirCourses.delegate = self
        theirCourses.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareData()
//        dbRef.child("users").child(currentUserID).observeSingleEvent(of: .value) { (snapshot) in
//            if let value = snapshot.value as? NSDictionary{
//                self.myCourses = value["myCourses"] as! [String]
//                self.mySchool = (value["school"] as? String)!
//                if let potalreadySeen = value["alreadySeen"] as? [String] {
//                    self.alreadySeen = potalreadySeen
//                }
//                print("my school is ", self.mySchool)
//                print("my courses are ", self.myCourses)
//            }
//            self.dbRef.child("schools").child(self.mySchool).observeSingleEvent(of: .value) { (snapshot) in
//                if let value = snapshot.value as? NSDictionary {
//                    for course in self.myCourses {
//                        if let peopleInCourse = value[course] as? [String] {
//                            for people in peopleInCourse {
//                                if  !self.potentialMatches.contains(people) {
//                                    self.potentialMatches.append(people)
//                                }
//                            }
//                        }
//                    }
//                }
//                self.updateScreen()
//            }
//        }
//
//        potentialMatches = potentialMatches.filter {
//            $0 != currentUserID
//        }
//        if alreadySeen != [] {
//            for seen in alreadySeen {
//                potentialMatches = potentialMatches.filter {
//                    $0 != seen
//                }
//            }
//        }
        
    }
    
    func prepareData() {
        dbRef.child("users").child(currentUserID).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? NSDictionary{
                self.myCourses = value["myCourses"] as! [String]
                self.mySchool = (value["school"] as? String)!
                if let potalreadySeen = value["alreadySeen"] as? [String] {
                    self.alreadySeen = potalreadySeen
                }
                print("my school is ", self.mySchool)
                print("my courses are ", self.myCourses)
            }
            self.dbRef.child("schools").child(self.mySchool).observeSingleEvent(of: .value) { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    for course in self.myCourses {
                        if let peopleInCourse = value[course] as? [String] {
                            for people in peopleInCourse {
                                if  !self.potentialMatches.contains(people) {
                                    self.potentialMatches.append(people)
                                    
                                    
                                    
                                
                                
                                }
                            }
                        }
                    }
                    self.potentialMatches = self.potentialMatches.filter {
                        $0 != self.currentUserID
                    }
                    if self.alreadySeen != [] {
                        for seen in self.alreadySeen {
                            self.potentialMatches = self.potentialMatches.filter {
                                $0 != seen
                            }
                        }
                    }
                    print(self.alreadySeen)
                    print(self.potentialMatches)
                    
                }
//                self.potentialMatches = self.potentialMatches.filter {
//                    $0 != self.currentUserID
//                }
//                if self.alreadySeen != [] {
//                    for seen in self.alreadySeen {
//                        self.potentialMatches = self.potentialMatches.filter {
//                            $0 != seen
//                        }
//                    }
//                }
                self.updateScreen()
            }
        }
        
        
    }
    
    func updateScreen() {
        print("updating screen")
        if potentialMatches != [] {
            dbRef.child("users").child(potentialMatches[0]).observeSingleEvent(of: .value) { (snapshot) in
                if let value = snapshot.value as? NSDictionary{
                    self.theirName.text = (value["name"] as! String)
                    self.theirCourseList = value["myCourses"] as! [String]
                    let imagePathVal = value["imagePath"] as? String
                    if imagePathVal == "noPath" {
                        self.theirProfilePic.image = #imageLiteral(resourceName: "profile-placeholder")
                    }
                    else {
                        getDataFromPath(path: imagePathVal!) { (data) in
                            if let data = data {
                                let image = UIImage(data: data)
                                self.theirProfilePic.image = image
                            }
                        }
                    }
                    self.theirCourses.reloadData()
                    
                }
            }
        }
    }
    func updateAlreadySeen() {
        dbRef.child("users").child(currentUserID).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                if let potalreadySeen = value["alreadySeen"] as? [String] {
                    self.alreadySeen = potalreadySeen
                    if self.potentialMatches == [] {
                    }
                    else {
                        self.alreadySeen.append(self.potentialMatches[0])
                    }
                }
                else {
                    self.alreadySeen.append(self.potentialMatches[0])
                }
                self.dbRef.child("users").child(self.currentUserID).updateChildValues(["alreadySeen" :self.alreadySeen])
            }
        }
        
        
    }
    func rightButtonFunctionality() {
        
        dbRef.child("users").child(currentUserID).observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                if let potinterestedList = value["interestedIn"] as? [String] {
                    self.interestedIn = potinterestedList
                }
                self.interestedIn.append(self.potentialMatches[0])
                self.dbRef.child("users").child(self.currentUserID).updateChildValues(["interestedIn" :self.interestedIn])
                
                //getting my match array
                if let potMatchArray = value["matches"] as? [String] {
                    self.matches = potMatchArray
                }
            }
            
            self.dbRef.child("users").child(self.potentialMatches[0]).observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? NSDictionary {
                    if let potTheirMatchArray = value["matches"] as? [String] {
                        self.theirMatches = potTheirMatchArray
                    }
                    //check to see if you are in their interestedIn list
                    if let potTheirInterestedList = value["interestedIn"] as? [String] {
                        if potTheirInterestedList.contains(self.currentUserID) {
                            //append to match
                            self.matches.append(self.potentialMatches[0])
                            self.theirMatches.append(self.currentUserID)
                            self.dbRef.child("users").child(self.currentUserID).updateChildValues(["matches" : self.matches])
                            self.dbRef.child("users").child(self.potentialMatches[0]).updateChildValues(["matches" : self.theirMatches])
                        }
                    }
                }
            })
            
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
