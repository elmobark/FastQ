//
//  ServiceModel.swift
//  FastQ
//
//  Created by Mobark on 07/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import Foundation
struct ServiceModel {
    var id = 0
    var name = ""
    var to = ""
    var isopen :Bool = false
    init() {
        
    }
    init(id:Int,name:String,to:String,isopen:Bool) {
        self.id = id
        self.name = name
        self.to = to
        self.isopen = isopen
    }
    func toDic() -> [String:Any] {
        return ["id":id,"name":name,"to":to,"isopen":isopen]
    }
}
