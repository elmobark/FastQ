//
//  Util.swift
//  FastQ
//
//  Created by Mobark on 11/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import Foundation
import Alamofire
class Util{
    private func JsonDictionary(url: String,completion : @escaping (String)->())  {
    var _ :String
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                
                if let json = response.result.value as?String{
                    completion(json)
                }
    }
    }
//    func getCurrentQueue(completion : @escaping (QueueModel)->()){
//        JsonDictionary(url: <#T##String#>) { (it) in
//            let jdata = try JSONEncoder().encode(it)
//            let queue = try? JSONDecoder().decode(QueueModel.self, from: jdata)
//        }
//        JsonDictionary(url: Queues.CurrentQ.rawValue) { it in
//
//
//        }
//    }
}
