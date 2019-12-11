//
//  ticketmodel.swift
//  FastQ
//
//  Created by Mobark on 11/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import Foundation
struct ticketmodel {
    var name = ""
    var queue = ""
    init(name:String,queue:String) {
        self.name = name
        self.queue = queue
    }
    init() {
        
    }
}
