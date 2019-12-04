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
    var sec = 60
    var timerLabel:UILabel? = nil
    func FlipToTicket(id:String) -> String {
        switch id {
        case "0":do {
           return "A"
        }
        case "1":do {
            return "B"
            }
        case "2":do {
            return "C"
            }
        case "3":do {
            return "D"
            }
        default:
            return "E"
        }
    }
  
    func timer(controller:UIViewController,label:UILabel,time:Int)  {
        sec = time
        Timer.scheduledTimer(timeInterval: 1, target: controller,   selector: (#selector(Util.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        sec -= 1
        timerLabel?.text = "\(sec)"
    }
    func convertToMilli(timeIntervalSince1970: TimeInterval) -> Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
    func convertMilliToDate(milliseconds: Int64) -> Date {
        return Date(timeIntervalSince1970: (TimeInterval(milliseconds) / 1000))
    }
    private func JsonDictionary(url: String,completion : @escaping (String)->())  {
    var _ :String
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                
                if let json = response.result.value as?String{
                    completion(json)
                }
    }
    }
     static func Alert (contex: UIViewController , title: String , body: String){
        let alert = UIAlertController(title: title, message: body, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action) in
            
        }))
        contex.present(alert, animated: true, completion: nil)
    }
    func AlertWhitAction (contex: UIViewController , title: String , body: String ,actionTitle:String, code: @escaping ((UIAlertAction) ->Void)){
        let alert = UIAlertController(title: title, message: body, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: code))
        contex.present(alert, animated: true, completion: nil)
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
