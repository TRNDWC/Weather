//
//  GetLocation.swift
//  Weather
//
//  Created by Trần Đức on 20/8/24.
//

import Foundation
import CoreData

extension CoreDataLocation {
    convenience init(from model: LocationModel, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = model.name
        self.latitude = model.latitude
        self.longitude = model.longitude
    }
}
