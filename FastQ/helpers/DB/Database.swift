//
//  Database.swift
//  FastQ
//
//  Created by Mobark on 13/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit
import CoreData
class Database {
    private func AppEntry(which:String, Context:NSManagedObjectContext) -> NSEntityDescription {
        let entity = NSEntityDescription.entity(forEntityName:  which , in: Context)
        return entity!
    }
  private  func savetoDB(which: DBkeys , values:Dictionary<String,Any>) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = AppEntry(which: which.rawValue, Context: context)
        let table = NSManagedObject(entity: entity, insertInto: context)
        for (key,value) in values {
            table.setValue(value, forKey: key)
        }
        do{
            try context.save()
            return true
        }catch{
            return false
        }
    }
   private func getfromDB(which: DBkeys) -> [Dictionary<String,Any>] {
        var dicPlaceholder = [Dictionary<String,Any>]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: which.rawValue)
        request.returnsObjectsAsFaults = false
        request.resultType =  NSFetchRequestResultType.dictionaryResultType
        do {
            dicPlaceholder = try context.fetch(request) as! [Dictionary<String,Any>]
       
        } catch {
            print("Failed")
        }
        
        
        return dicPlaceholder
    }
    func genID(which:DBkeys) -> Int {
        let db = getfromDB(which:which);
        if db.count == 0 {
            return 0
        }else{
            return (db[db.count-1]["id"] as? Int)! + 1
        }
        
    }
    func saveUser(user:UserModel) -> Bool{
        if checkUser(usermodel: user){
            return false
        }else{
            let dic : [String:Any] = ["id":genID(which: .users),"email":user.email,"password":user.password]
            return savetoDB(which: DBkeys.users, values: dic)
        }
        
    }
    func addQueue(queue:QueueModel) -> Bool {
        let insert : [String:Any] = ["id":genID(which: .queues),"sp":Util().FlipToTicket(id: queue.sp),"time":queue.time,"type":queue.type]
        return savetoDB(which: .queues, values: insert)
    }
    func getTotaleTime() -> Int {
        let getData = getfromDB(which: .queues)
        var time = 0
        for item in getData {
            time += Int(item["time"] as! String)!
        }
        return time
    }
    func getQueue() -> QueueModel {
        let getData = getfromDB(which: .queues)
        let lastitem = getData[getData.count-1]
        print("data is \(lastitem)")
        let model = QueueModel(id: (lastitem["id"] as? Int)!.description, sp: (lastitem["sp"] as? String)!, time: (lastitem["time"] as? String)!, type: (lastitem["type"] as? String)!)
        return model
    }
    func checkUser(usermodel:UserModel) -> Bool {
        var isExist = false
        let users = getfromDB(which: DBkeys.users)
        check : for user in users {
            if user["email"] as! String == usermodel.email{
                if user["password"] as! String == usermodel.password{
                     isExist = true
                    break check
                }
                
            }
        }
        return isExist
    }
    func addQueue(queue:QueueModel){
        
    }
    func saveSP(sp:SPModel)->Bool{
        let imgData = sp.logo.cgImage?.dataProvider?.data! as! Data
        let dic : [String:Any] = ["id":sp.id,"logo":imgData,"name":sp.name,"location":sp.Location,"phone":sp.phone,"about":sp.about,"services":sp.service,"website":sp.website,"worktime":sp.workTime]
        return savetoDB(which: .sps, values: dic)
    }
    func getSPs()->[SPModel]{
        let dic = getfromDB(which: .sps)
        var SPs:[SPModel] = []
        for sp in dic {
            SPs.append(SPModel(dic: sp))
        }
        return SPs
        
    }
}
