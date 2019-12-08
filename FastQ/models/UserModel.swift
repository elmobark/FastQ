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
    init(email:String , password:String,name:String) {
        self.email = email
        self.password = password
        self.name = name
    }
    init() {
        
    }
}
