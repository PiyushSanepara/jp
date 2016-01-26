//
//  Contact+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Ratnakala53 on 1/13/16.
//  Copyright © 2016 ratnakala. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var name: String?
    @NSManaged var number: String?
    @NSManaged var city: String?

}
