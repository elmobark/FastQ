//
//  QueueModel.swift
//  FastQ
//
//  Created by Mobark on 11/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//import ObjectMapper
import UIKit
struct QueueModel: Codable{
    var id: Int  = 0
    var sp: String  = ""
    var time: String = ""
    var type: String  = ""
    var servedBy:Int = 0
    var serveTo:Int = 0
    var service: Int = 0
    init(id:Int , sp:String , time:String , type:String,serveTo:Int,servedBy:Int,service:Int) {
        self.id = id
        self.sp = sp
        self.time = time
        self.type = type
        self.serveTo = serveTo
        self.servedBy = servedBy
        self.service = service
    }
    func toDic()-> [String:Any]{
        return ["id":id,"sp": sp,"time":time,"type":type,"serveTo":serveTo,"servedBy":servedBy,"service":service]
    }
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sp = "sp"
        case time = "time"
        case type = "type"
    }
}
