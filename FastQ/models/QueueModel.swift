//
//  QueueModel.swift
//  FastQ
//
//  Created by Mobark on 11/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//import ObjectMapper
class QueueModel: Codable{
    let qnumber: Int
    let qname, qtarget: String
    
    enum CodingKeys: String, CodingKey {
        case qnumber = "Qnumber"
        case qname = "Qname"
        case qtarget = "Qtarget"
    }
}
