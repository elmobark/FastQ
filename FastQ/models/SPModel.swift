//
//  SPModel.swift
//  FastQ
//
//  Created by Mobark on 12/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit
import MapKit
struct SPModel{
    var name:String = ""
    var logo :UIImage = UIImage()
    var service:[String] = []
    var about:String = ""
    var workTime:String = ""
    var phone:String = ""
    var website:String = ""
    var Location:String = ""
    var id : Int = 0
    var lat:Double = 0.0
    var lng : Double = 0.0
    
    init() {
        
    }
   init(dic : [String:Any]){
        name = dic["name"] as! String
        logo = UIImage(data: dic["logo"] as! Data)!
        service = dic["service"] as! [String]
        about = dic["about"] as! String
        workTime = dic["worktime"] as! String
        phone = dic["phone"] as! String
        website = dic["website"] as! String
        Location = dic["location"] as! String
        id = Int(dic["id"] as! Int32)
    
    }
    init(name:String , logo:UIImage , service:[String],about:String,workTime:String,phone:String,website:String,Location:String,id:Int,lat:Double , lng:Double) {
        self.name = name
        self.logo = logo
        self.service = service
        self.about = about
        self.workTime = workTime
        self.phone = phone
        self.website = website
        self.Location = Location
        self.id = id
        self.lat = lat
        self.lng = lng
    }
}
