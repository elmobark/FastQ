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
    func saveUser(user:UserModel) -> Bool{
        let dic : [String:Any] = ["id":0,"email":user.email,"password":user.password]
        return savetoDB(which: DBkeys.users, values: dic)
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
}
