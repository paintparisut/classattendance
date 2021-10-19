//
//  DatabaseManager.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 20/10/2564 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseManager {
    let db = Firestore.firestore()
    let auth = Auth.auth()
    static let shared = DatabaseManager()
    
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
                    "user_type": type
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
                        completion(.success(response))
                    }
                    
                }
                
            }
            
        }
    }
}
