//
//  Photo+CoreDataProperties.swift
//  SavingJsonInCoreData
//
//  Created by A on 17/05/19.
//  Copyright © 2019 A. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var author: String?
    @NSManaged public var mediaURL: String?
    @NSManaged public var tags: String?

}
