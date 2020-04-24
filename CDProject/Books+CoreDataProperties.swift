//
//  Books+CoreDataProperties.swift
//  CDProject
//
//  Created by Nathan on 4/24/20.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation
import CoreData

extension Books {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Books> { //returns the container of CoreData
        return NSFetchRequest<Books>(entityName: "Books")
    }
    
    @NSManaged public var title: String
    @NSManaged public var author: String

}
