//
//  DatabaseManager.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 20/10/2564 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit

class DatabaseManager {
    private let db = Firestore.firestore()
    private let auth = Auth.auth()
    static let shared = DatabaseManager()
    
    //register
    public func register(name:String,email:String,password:String,usernumber:String,type:String,completion:@escaping(Result<UserModel,Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { [weak self] (authresult,error) in
            guard let strongSelf = self else {return}
            if let error = error {
                let authError = error as NSError
                print("authError",authError) //รอเพิ่มalertเมื่อสร้างไม่ได้เช่นรหัสไม่ถึง6ตัว หรือ เมลซ้ำ เป็นต้น
                completion(.failure(authError))
            }
            else {
                var response = UserModel()
                print("authresult",authresult?.user.uid)
                let userid = authresult?.user.uid ?? ""
                strongSelf.db.collection("user").document(userid).setData([
                    "user_name": name,
                    "user_number": usernumber,
                    "user_email": email,
                    "user_type": type,
                    "user_password" : password
                ]){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                        let dbError = err as NSError
                        completion(.failure(dbError))
                    }
                    else {
                        print("Document successfully written!")
                        response.id = userid
                        response.email = email
                        response.name = name
                        response.usernumber = usernumber
                        response.usertype = type
                        response.password = password
                        completion(.success(response))
                    }
                }
            }
        }
    }
        
    //signed in auto
    var HomePage:EnterSite!
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    func showApp() {
        var viewController: UIViewController
        if FirebaseAuth.Auth.auth().currentUser != nil {
            // User is signed in.
            viewController = storyboard.instantiateViewController(withIdentifier: "home")
            HomePage.present(viewController,animated: false , completion: nil)
            print("User is signed in")
            }
            else {
            // No user is signed in.
            // viewController = storyboard.instantiateViewController(withIdentifier: "entersite")
            print("User is not signed in")
        }
        //HomePage.present(viewController,animated: true , completion: nil)
    }
    
    //logout
    func logout() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            print("Log Out Success")
        }
        catch {
            print("An error occurred")
        }
    }

    func getdataCon() {
        
    }
    
    func getdata(data:String,get:UITextField) {
        let doc = Auth.auth().currentUser?.uid
        let docRef = db.collection("user").document(doc!)
       
        //Documents
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
               // print("Document data: \(dataDescription)") //ใช้test
            } else {
                print("Document does not exist")
            }
        }
        
        //Data
       // var showdata = String()
        docRef.getDocument { (document, error) in
            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }
            let dataDescription = document.data()
           // print(dataDescription?[data] ?? "")
            get.text! = dataDescription?[data] as! String
        }
        
        
    }

    
    
    
}
