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
    private func update(which: DBkeys,id:Int,new:Dictionary<String,Any>) -> Bool{
        
        
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: which.rawValue)
//        let predicate = NSPredicate(format: "(id = %@)", id)
//        request.returnsObjectsAsFaults = false
//        request.resultType =  .managedObjectResultType
//        request.predicate = predicate
//        do {
//            let dat = try context.fetch(request).last as! NSManagedObject
//            dat.setValuesForKeys(new)
//            do{
//                print("saving done")
//                try context.save()
//                return true
//            }catch{
//                return false
//            }
//        } catch {
//            print("Failed")
//            return false
//        }
//
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = AppEntry(which: which.rawValue, Context: context)

        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        request.predicate = NSPredicate(format: "id == %ld", id)
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
            return 1
        }else{
            return (db[db.count-1]["id"] as? Int)! + 1
        }
        
    }
    func getUser(user usermodel:UserModel) ->UserModel{
        var checkeduser = UserModel()
        print("FAQ start checking")
        let users = getfromDB(which: DBkeys.users)
        
        check : for user in users {
            if user["email"] as! String == usermodel.email{
                if user["password"] as! String == usermodel.password{
                    checkeduser = UserModel(id: user["id"] as! Int, email: user["email"] as! String, password: user["password"] as! String, name: user["name"] as! String)
                    print("FAQ checking")
                    break check
                }
                
            }
        }
        return checkeduser
    }
    func getUserById(id:Int) -> UserModel{
        return UserModel(dic: getfromDB(which: .users).filter({return $0["id"] as! Int == id}).last!)
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
        let insert : [String:Any] = ["id":genID(.queues),"sp": queue.sp,"time":queue.time,"type":queue.type,"serveTo":queue.serveTo,"servedBy":queue.servedBy]
        return savetoDB(which: .queues, values: insert)
    }
    func getTotaleTime(sp:ServiceModel) -> Int {
        let getData = getfromDB(which: .queues)
        var time = 0
        for item in getData {
            if(sp.id.description == item["sp"] as! String){
                if item["servedBy"] as! Int != -1{
                    time += Int(item["time"] as! String)!
                }
                
            }
            
        }
        return time
    }
    func getQueues() -> [QueueModel] {
        let getData = getfromDB(which: .queues)
        var queueslist:[QueueModel] = []
        
        for queue in getData{
            
            queueslist.append(QueueModel(id: (queue["id"] as? Int)!, sp: (queue["sp"] as? String)!, time: (queue["time"] as? String)!, type: (queue["type"] as? String)!,serveTo:(queue["serveTo"] as? Int)!,servedBy: (queue["servedBy"] as? Int)!,service:(queue["service"] as? Int)!))
        }
        
        return queueslist
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
        print("FAQ \(service.toDic())")
        return update(which: .services, id: service.id, new: service.toDic())
    }
    func updateQueue(queue queuemodel:QueueModel) -> Bool {
        print("next s5  \(queuemodel.toDic())")
        return update(which: .queues, id: queuemodel.id, new: queuemodel.toDic())
    }
    func saveAdmin(admin:AdminModel) -> Bool {
        if checkAdmin(adminmodel: UserModel(id:0,email: admin.email, password: admin.password, name: admin.name)) {
            return false
        }else{
            return savetoDB(which: .admins, values: [
                "email":admin.email, "id":genID(.admins),"cardname":admin.cardname,"cardnumber":admin.cardnumber,"cardtype":admin.cardtype,"password":admin.password,"cvv":admin.cvv,"expirydate":admin.expirydate,"type":admin.type,"name":admin.name,"admin":admin.admin])
        }
       
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
    func getStaff(admin adminmodel:AdminModel)->[AdminModel]{
        var staff:[AdminModel] = []
        let dic  = getfromDB(which: .admins).filter({ return $0["admin"] as! Int == adminmodel.admin})
        for item in dic {
            staff.append(AdminModel.init(dic: item))
        }
        return staff
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
