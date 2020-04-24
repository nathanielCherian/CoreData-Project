//
//  User+CoreDataProperties.swift
//  CDProject
//
//  Created by Nathan on 4/21/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> { //returns the container of CoreData
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged public var username: String
    @NSManaged public var password: String
    @NSManaged public var bio: String
    @NSManaged public var profpic: NSData

}
