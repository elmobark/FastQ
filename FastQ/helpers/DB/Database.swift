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
    func savetoDB(which: DBkeys , values:Dictionary<String,Any>) -> Bool {
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
}
