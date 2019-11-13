//
//  UserModel.swift
//  FastQ
//
//  Created by Mobark on 13/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class UserModel: Codable{
    var email:String = ""
    var password:String = ""
    init(email:String , password:String) {
        self.email = email
        self.password = password
    }
}
