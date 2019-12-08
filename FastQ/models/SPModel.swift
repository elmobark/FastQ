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
    var about:String = ""
    var workTime:String = ""
    var phone:String = ""
    var website:String = ""
    var admin:Int = 0
    var id : Int = 0
    var lat:Double = 0.0
    var lng : Double = 0.0
    
    init() {
        
    }
    func toDic() -> [String:Any] {
        let dic:[String:Any] = ["name":name, "logo":UIImagePNGRepresentation(logo)!,"about":about,"worktime":workTime,"phone":phone,"website":website,"lat":lat,"long":lng,"id":id,"admin":admin]
        return dic
    }
   init(dic : [String:Any]){
        name = dic["name"] as! String
        logo = UIImage(data: dic["logo"] as! Data)!
        about = dic["about"] as! String
        workTime = dic["worktime"] as! String
        phone = dic["phone"] as! String
        website = dic["website"] as! String
        lat = dic["lat"] as! Double
        lng = dic["long"] as! Double
        id = Int(dic["id"] as! Int32)
        admin = Int(dic["admin"] as! Int32)
    }
    init(name:String , logo:UIImage ,about:String,workTime:String,phone:String,website:String,lat:Double,lng:Double,id:Int,admin:Int) {
        self.name = name
        self.logo = logo
        
        self.about = about
        self.workTime = workTime
        self.phone = phone
        self.website = website
        
        self.id = id
        self.lat = lat
        self.lng = lng
        self.admin = admin
    }
}
