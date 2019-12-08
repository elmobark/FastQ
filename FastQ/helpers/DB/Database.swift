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
    private func update(which: DBkeys,id:String,new:Dictionary<String,Any>) -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = AppEntry(which: which.rawValue, Context: context)
        
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        
        let predicate = NSPredicate(format: "(id = %@)", id)
        request.predicate = predicate
        do {
            let results =
                try context.fetch(request)
            let objectUpdate = results[0] as! NSManagedObject
            objectUpdate.setValuesForKeys(new)
            
            do {
                try context.save()
                return true
            }catch _ as NSError {
                return false
            }
        }
        catch _ as NSError {
            return false
        }

    }
  private  func savetoDB(which: DBkeys , values:Dictionary<String,Any>) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = AppEntry(which: which.rawValue, Context: context)
        let table = NSManagedObject(entity: entity, insertInto: context)
    print("FAQ saving")
        for (key,value) in values {
            table.setValue(value, forKey: key)
            print("FAQ saving \(key) to \(value)")
        }
        do{
            print("FAQ saving done")
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
    func genID(_ which:DBkeys) -> Int {
        let db = getfromDB(which:which);
        if db.count == 0 {
            return 0
        }else{
            return (db[db.count-1]["id"] as? Int)! + 1
        }
        
    }
    func saveUser(user:UserModel) -> Bool{
        print("FAQ start saving")
        if checkUser(usermodel: user){
             print("FAQ error saving")
            return false
        }else{
             print("FAQ start saving 2")
            let dic : [String:Any] = ["id":genID(.users),"email":user.email,"password":user.password,"name":user.name]
            print("FAQ data:\(dic)")
            return savetoDB(which: DBkeys.users, values: dic)
        }
        
    }
    func addQueue(queue:QueueModel) -> Bool {
        let insert : [String:Any] = ["id":genID(.queues),"sp":Util().FlipToTicket(id: queue.sp),"time":queue.time,"type":queue.type]
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
       
        let model = QueueModel(id: (lastitem["id"] as? Int)!.description, sp: (lastitem["sp"] as? String)!, time: (lastitem["time"] as? String)!, type: (lastitem["type"] as? String)!,serveTo:(lastitem["serveTo"] as? String)!,servedBy: (lastitem["servedBy"] as? String)!)
        return model
    }
    func checkUser(usermodel:UserModel) -> Bool {
        var isExist = false
        print("FAQ start checking")
        let users = getfromDB(which: DBkeys.users)
        
        check : for user in users {
            if user["email"] as! String == usermodel.email{
                if user["password"] as! String == usermodel.password{
                     isExist = true
                    print("FAQ checking")
                    break check
                }
                
            }
        }
        return isExist
    }
    /////////////////////////////////////////////////////////////////////////////////////admin side
    func saveSP(sp:SPModel)->Bool{
        return savetoDB(which: .sps, values: sp.toDic())
    }
    func getSPs()->[SPModel]{
        let dic = getfromDB(which: .sps)
        var SPs:[SPModel] = []
        for sp in dic {
            SPs.append(SPModel(dic: sp))
        }
        return SPs
    }
    func saveService(service:ServiceModel) -> Bool{
        let dic:[String:Any] = ["id":service.id,"name":service.name,"to":service.to,"isopen":service.isopen]
        return savetoDB(which: .services, values: dic)
    }
    func getService(id:Int) -> [ServiceModel] {
        let dic = getfromDB(which: .services)
        var services:[ServiceModel] = []
        for service in dic{
            if service["to"] as! String == "\(id)"{
                services.append(ServiceModel(id: service["id"] as! Int, name: service["name"] as! String, to: service["to"] as! String, isopen: (service["isopen"] != nil)))
            }
        }
        return services
    }
    func updateService(service:ServiceModel) -> Bool {
        return update(which: .services, id: "\(service.id)", new: service.toDic())
    }
    
    /// save admin and staff to Database
    ///
    /// - Parameter admin: Admin model that we already genrate
    /// - Returns: returns if data inserted or not
    func saveAdmin(admin:AdminModel) -> Bool {
        return savetoDB(which: .admins, values: [
            "email":admin.email, "id":genID(.admins),"cardname":admin.cardname,"cardnumber":admin.cardnumber,"cardtype":admin.cardtype,"password":admin.password,"cvv":admin.cvv,"expirydate":admin.expirydate,"type":admin.type,"name":admin.name])
    }
    func checkAdmin(adminmodel:UserModel)->Bool{
        var isExist = false
        let admins = getfromDB(which: .admins)
        check : for admin in admins {
            if admin["email"] as! String == adminmodel.email{
                if admin["password"] as! String == adminmodel.password{
                    isExist = true
                    break check
                }
                
            }
        }
        return isExist
    }
    func getAdmin(adminmodel:UserModel) ->AdminModel{
        var res = AdminModel()
        let admins = getfromDB(which: .admins)
        check : for admin in admins {
            if admin["email"] as! String == adminmodel.email{
                if admin["password"] as! String == adminmodel.password{
                    res = AdminModel(dic:admin)
                    break check
                }
                
            }
        }
        return res
        
    }
    
}
