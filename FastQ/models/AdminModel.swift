//
//  AdminModel.swift
//  FastQ
//
//  Created by Mobark on 11/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//import ObjectMapper
import UIKit
struct AdminModel: Codable{
    var cardname: String  = ""
    var cardnumber: String  = ""
    var cardtype: String = ""
    var admin:Int = 0
    var cvv: String  = ""
    var expirydate = ""
    var id = ""
    var password = ""
    var email = ""
    var type = ""
    var name = ""
    init(cardname:String,cardnumber:String,cardtype:String,cvv:String,expirydate:String,password:String,email:String,type:String,name:String,admin:Int) {
        self.cardname = cardname
        self.cardnumber = cardnumber
        self.cardtype = cardtype
        self.cvv = cvv
        self.expirydate = expirydate
        self.name = name
        self.password = password
        self.email = email
        self.type = type
    }
    init(dic:[String:Any]) {
        self.cardname = dic["cardname"] as! String
        self.cardnumber = dic["cardnumber"] as! String
        self.cardtype = dic["cardtype"] as! String
        self.cvv = dic["cvv"] as! String
        self.expirydate = dic["expirydate"] as! String
        self.name = dic["name"] as! String
        self.password = dic["password"] as! String
        self.email = dic["email"] as! String
        self.type = dic["type"] as! String
        self.admin = dic["admin"] as! Int
    }
    init() {
        
    }
  
}
