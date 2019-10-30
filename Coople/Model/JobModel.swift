//
//  JobModel.swift
//  Coople
//
//  Created by Akib Quraishi on 10/10/2019.
//  Copyright © 2019 AkibMakesApps. All rights reserved.
//

import Foundation

struct JobModel:Decodable {
    
    struct data:Decodable {
        var items:[items]
    }
    
    var error:Bool
    var status:Int
    var data:data
}



struct items:Decodable {
    
    struct jobLocation:Decodable {
        var addressStreet:String
        var zip:String
        var city:String
    }
    
    var workAssignmentName:String
    var jobLocation:jobLocation
}
