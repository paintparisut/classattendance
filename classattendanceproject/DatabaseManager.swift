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
                print("authError",authError) 
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
    
    //login
    public func login(email:String,password:String,completion:@escaping (Result<UserModel,Error>) -> Void ) {
        auth.signIn(withEmail: email, password: password) { [weak self] (authresult,error) in
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
                let docRef = strongSelf.db.collection("user").document(userid)
                docRef.getDocument{ (document,err) in
                    if let err = err {
                        print("Error writing document: \(err)")
                        let dbError = err as NSError
                        completion(.failure(dbError))
                    }
                    else {
                        print("Document successfully written!")
                        let data = document?.data()
                        response.id = userid
                        response.email = email
                        response.name = data!["user_name"] as! String
                        response.usernumber = data!["user_number"] as! String
                        response.usertype = data!["user_type"] as! String
                        response.password = password
                        completion(.success(response))
                    }
                }
            }
        }
    }
    
    //userDefault loadtype
    public func saveType(type:String) {
        UserDefaults.standard.set(type, forKey: "Type")
    }
    public func checkType() -> String {
        return UserDefaults.standard.string(forKey: "Type") ?? ""
    }
    public func removeType() {
        UserDefaults.standard.removeObject(forKey: "Type")
    }
    
    //userDefault loaduid
    public func saveUserID(type:String) {
        UserDefaults.standard.set(type, forKey: "ID")
    }
    public func checkUserID() -> String {
        return UserDefaults.standard.string(forKey: "ID") ?? ""
    }
    public func removeUserID() {
        UserDefaults.standard.removeObject(forKey: "ID")
    }
    
    //signed in auto
    var HomePage:EnterSite!
    let storyboard = UIStoryboard(name: "Main", bundle: nil)

    //ให้ return ค่า bool
    func showApp() -> Bool {
        if Auth.auth().currentUser != nil {
            let doc = Auth.auth().currentUser?.uid
            let docRef = db.collection("user").document(doc!)
            
            docRef.getDocument { (document, error) in
                guard let document = document, document.exists else {
                    print("Document does not exist")
                    return
                }
                let dataDescription = document.data()
                self.saveUserID(type: dataDescription?["user_number"] as! String)
                self.saveType(type: dataDescription?["user_type"] as! String)
            }
            return (auth.currentUser != nil)
        }
        else {
            return false
        }
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

    //getdatauserprofile
    func getdata(data:String,get:UITextField) {
        let doc = Auth.auth().currentUser?.uid
        let docRef = db.collection("user").document(doc!)
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
    
    //gencode
    public func randomString() -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((1...6).map{ _ in letters.randomElement()! })
    }
    
    //createClass
    public func createClass(class_id:String,class_name:String,class_lecName:String,class_time:String,class_date:String,completion:@escaping(Result<ClassModel,Error>) -> Void) {
        var ref: DocumentReference? = nil
        var response = ClassModel()
        let invitecode = randomString()
        ref = db.collection("class").addDocument(data: [
            "doc_ID" : "",
            "invite_Code": invitecode,
            "class_ID":  class_id,
            "class_name" : class_name,
            "class_LecName":  class_lecName,
            "class_LecID":  checkUserID(),
            "studentList": [],
            "class_time":  class_time,
            "class_date": class_date,
            "class_Active": false
        ]) { err in
            if let err = err {
                completion(.failure(err))
            } else {
                response.doccumentID = ""
                response.inviteCode = invitecode
                response.classID = class_id
                response.className = class_name
                response.classLecName = class_lecName
                response.classLecID = self.checkUserID()
                response.studentList = []
                response.classtime = class_time
                response.classdate = class_date
                response.classactive = false
                completion(.success(response))
            }
        }
    }
    
    //userDefault loaduid
    public func saveInvite(type:String) {
        UserDefaults.standard.set(type, forKey: "InviteCode")
    }
    public func checkInvite() -> String {
        return UserDefaults.standard.string(forKey: "InviteCode") ?? ""
    }
    public func removeInvite() {
        UserDefaults.standard.removeObject(forKey: "InviteCode")
    }
    
    //insert uid intoClass
    func updateDocIDClass(){
        db.collection("class").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let Ref = self.db.collection("class").document(document.documentID)

                    Ref.updateData([
                        "doc_ID": document.documentID
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                }
            }
        }
    }
    
    //getallclassdata
    func getalldata(completion:@escaping(Result<[ClassModel],Error>) -> Void) {
        var response = [ClassModel]()
        db.collection("class").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var docRef = self.db.collection("class").document(document.documentID)
                    docRef.getDocument { (document, error) in
                        guard let document = document, document.exists else {
                            print("Document does not exist")
                            return
                        }
                        let dataDescription = document.data()
                        response.append(ClassModel(doccumentID: dataDescription?["doc_ID"] as! String, inviteCode: dataDescription!["invite_Code"] as! String, classID: dataDescription!["class_ID"] as! String, className: dataDescription!["class_name"] as! String, classLecID:dataDescription!["class_LecID"] as! String ,classLecName:dataDescription!["class_LecName"] as! String ,studentList:dataDescription!["studentList"] as? [String] ,classtime:dataDescription!["class_time"] as! String ,classdate:dataDescription!["class_date"] as! String ,classactive:dataDescription!["class_Active"] as! Bool))
                        completion(.success(response))
                    }
                }
            }
        }
    }

    //selectedClass Teacher
    func selectedClassTeacher (number:String,classdata:[ClassModel]) -> [ClassModel] {
        var obj = [ClassModel]()
        for i in classdata {
            if i.classLecID == number {
                obj.append(i)
            }
        }
        return(obj)
    }
    
    //selectedClass Student
    func selectedClassStudent(number:String,classdata:[ClassModel]) -> [ClassModel] {
        var obj = [ClassModel]()
        for i in classdata {
            for k in i.studentList! {
                if number == k {
                    obj.append(i)
                }
            }
        }
        return(obj)
    }

    //createClassAttendance
    public func createClassAttendance(invite:String,completion:@escaping(Result<ClassAttendanceModel,Error>) -> Void) {
        var ref: DocumentReference? = nil
        var response = ClassAttendanceModel()
        let invitecode = randomString()
        ref = db.collection("classAttendance").addDocument(data: [
            "doc_ID" : "",
            "invite_code" : invite,
            "studentNumber" : checkUserID(),
            "status_Active": false
        ]) { err in
            if let err = err {
                completion(.failure(err))
            } else {
                response.docID = ""
                response.invite = invite
                response.studentNumber = self.checkUserID()
                response.statusactive = false
                completion(.success(response))
            }
        }
    }
    
    //insert uid ClassAttendance
    func updateDocIDClassAttendance(){
        db.collection("classAttendance").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let Ref = self.db.collection("classAttendance").document(document.documentID)

                    Ref.updateData([
                        "doc_ID": document.documentID
                    ]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            print("Document successfully updated")
                        }
                    }
                }
            }
        }
    }
    
    //checkStudentJoinClass
    func checkJoinClass(invite:String,classdata:[ClassModel]) -> Bool {
        var check = false
        var classselect = ClassModel()
        for i in classdata {
            if invite == i.inviteCode {
                check = true
                print("found")
                classselect = i
            }
        }
        
        if classselect.studentList != nil {
            print("class=",classselect.studentList)
            for k in classselect.studentList! {
                if checkUserID() == k {
                    print("user=",checkUserID())
                    print("k=",k)
                    print("id found")
                    check = false
                }
            }
        }
        return check
    }
    
    //getClassDocID
    func getDocIDClassAttendance(invite:String,classdata:[ClassModel]) -> String {
        var doc:String = ""
        for i in classdata {
            if invite == i.inviteCode{
                doc = i.doccumentID!
            }
        }
        return doc
    }
    
    //addStudentToClass
    func addStudentList(invite:String,classdata:[ClassModel],id:String){
        let Ref = self.db.collection("class").document(getDocIDClassAttendance(invite: invite, classdata: classdata))

        Ref.updateData([
            "studentList": FieldValue.arrayUnion([id]) ,
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    //setActiveClass true
    func setActiveClassOpen(docID:String) {
        let Ref = self.db.collection("class").document(docID)

        Ref.updateData([
            "class_Active": true
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
        //setActiveClass false
    func setActiveClassClose(docID:String) {
        let Ref = self.db.collection("class").document(docID)

        Ref.updateData([
            "class_Active": false
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    //getClassAttenDanceData
    func getallClassAttenDancedata(completion:@escaping(Result<[ClassAttendanceModel],Error>) -> Void) {
        var response = [ClassAttendanceModel]()
        db.collection("classAttendance").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(.failure(err))
            } else {
                for document in querySnapshot!.documents {
                    var docRef = self.db.collection("classAttendance").document(document.documentID)
                    docRef.getDocument { (document, error) in
                        guard let document = document, document.exists else {
                            print("Document does not exist")
                            return
                        }
                        let dataDescription = document.data()
                        response.append(ClassAttendanceModel(studentNumber: dataDescription!["studentNumber"] as! String, invite: dataDescription!["invite_code"] as! String, docID: dataDescription?["doc_ID"] as! String, statusactive: dataDescription!["status_Active"] as! Bool))
                        completion(.success(response))
                    }
                }
            }
        }
    }
    
    //selectedClassAttendance Teacher
    func selectedClassAttendanceTeacher(inviteCode:String,classAttendance:[ClassAttendanceModel]) -> [ClassAttendanceModel] {
        var ClassSelected = [ClassAttendanceModel]()
        for i in classAttendance {
            if i.invite == inviteCode {
                ClassSelected.append(i)
            }
        }
        return ClassSelected
    }
    
    //selectedClassAttendance Student
    func selectedClassAttendanceStudent(inviteCode:String,classAttendance:[ClassAttendanceModel]) -> [ClassAttendanceModel] {
        var ClassSelected = [ClassAttendanceModel]()
        for i in classAttendance {
            if i.invite == inviteCode && i.studentNumber == checkUserID() {
                ClassSelected.append(i)
            }
        }
        return ClassSelected
    }
    
    //StudentCheckClass
    func CheckStundet(classData:[ClassAttendanceModel]) {
        for i in classData {
            let Ref = self.db.collection("classAttendance").document(i.docID ?? "")
            Ref.updateData([
                "status_Active": true
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    }
    
    //setFalseStudentWhenCloseClass
    func setFalseStundet(classData:[ClassAttendanceModel]) {
        for i in classData {
            let Ref = self.db.collection("classAttendance").document(i.docID ?? "")
            Ref.updateData([
                "status_Active": false
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }
        }
    }
    
    //deleteClass
    func deleteClass(classDocID:String) {
        db.collection("class").document(classDocID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    //deleteClassAttendanceData
    func deleteClassAttendance(classInvite:String,classAttendanceData:[ClassAttendanceModel]) {
        for i in classAttendanceData {
            if i.invite == classInvite {
                db.collection("class").document(i.docID ?? "").delete() { err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }
        }
    }
}
