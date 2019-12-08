//
//  QueueModel.swift
//  FastQ
//
//  Created by Mobark on 11/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//import ObjectMapper
import UIKit
struct QueueModel: Codable{
    var id: String  = ""
    var sp: String  = ""
    var time: String = ""
    var type: String  = ""
    var servedBy:String = ""
    var serveTo:String = ""
    init(id:String , sp:String , time:String , type:String,serveTo:String,servedBy:String) {
        self.id = id
        self.sp = sp
        self.time = time
        self.type = type
        self.serveTo = serveTo
        self.servedBy = servedBy
    }
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sp = "sp"
        case time = "time"
        case type = "type"
    }
}
