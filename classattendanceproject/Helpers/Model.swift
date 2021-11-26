//
//  UserModel.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 20/10/2564 BE.
//

import Foundation

struct UserModel:Codable {
    var id:String?
    var name:String?
    var email:String?
    var usernumber:String?
    var usertype:String?
    var password:String?
}

struct ClassModel:Codable {
    var doccumentID:String?
    var inviteCode:String?
    var classID:String?
    var className:String?
    var classLecID:String?
    var classLecName:String?
    var studentList:[String]?
    var classtime:String?
    var classdate:String?
    var classactive:Bool?
}

