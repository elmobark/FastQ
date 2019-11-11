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
    var dat :String
        Alamofire.request(url, method: .get)
            
            .response {response in
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: response.data!, options : JSONSerialization.ReadingOptions.allowFragments) as JSONDecoder
                        
                    {
                        dat = jsonArray
                    } else {
                        print("bad json")
                    }
                } catch let error as NSError {
                    print(error)
                }
                completion(dat)
        }
    }
    func getCurrentQueue(completion : @escaping (QueueModel)->()){
        JsonDictionary(url: Queues.CurrentQ.rawValue) {it in
            
            let queue = try? newJSONDecoder().decode(Queue.self, from: it)
            completion
        }
    }
}
