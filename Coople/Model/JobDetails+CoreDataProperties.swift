//
//  JobDetails+CoreDataProperties.swift
//  Coople
//
//  Created by Akib Quraishi on 10/10/2019.
//  Copyright © 2019 AkibMakesApps. All rights reserved.
//
//

import Foundation
import CoreData


extension JobDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JobDetails> {
        return NSFetchRequest<JobDetails>(entityName: "JobDetails")
    }

    @NSManaged public var workAssignmentName: String?
    @NSManaged public var addressStreet: String?
    @NSManaged public var zip: String?
    @NSManaged public var city: String?

}
