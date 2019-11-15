//
//  SPModel.swift
//  FastQ
//
//  Created by Mobark on 12/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

struct SPModel{
    var name:String = ""
    var logo :UIImage = UIImage()
    var service:[String] = [String]()
    var about:String = ""
    var workTime:String = ""
    var phone:String = ""
    var website:String = ""
    var Location:String = ""
    var id : Int = 0
    init() {
        
    }
    init(name:String , logo:UIImage , service:[String],about:String,workTime:String,phone:String,website:String,Location:String,id:Int) {
        self.name = name
        self.logo = logo
        self.service = service
        self.about = about
        self.workTime = workTime
        self.phone = phone
        self.website = website
        self.Location = Location
        self.id = id
    }
}
