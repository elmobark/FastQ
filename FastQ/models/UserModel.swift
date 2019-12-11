//
//  UserModel.swift
//  FastQ
//
//  Created by Mobark on 13/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

struct UserModel: Codable{
    var email:String = ""
    var password:String = ""
    var name:String = ""
    var id:Int = 0
    init(id:Int,email:String , password:String,name:String) {
        self.email = email
        self.password = password
        self.name = name
        self.id = id
    }
    func toDic()->[String:Any]{
        return ["id":id,"name":name,"email":email,"password":password]
    }
    init(dic:[String:Any]) {
        self.email = dic["email"] as! String
        self.id = dic["id"] as! Int
        self.name = dic["name"] as! String
        self.password = dic["password"] as! String
    }
    init() {
        
    }
}
