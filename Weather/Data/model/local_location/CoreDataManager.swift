//
//  CoreDataManager.swift
//  Weather
//
//  Created by Trần Đức on 20/8/24.
//

import Foundation
import CoreData
import Combine

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    func saveLocation(_ model: LocationModel, context: NSManagedObjectContext) throws {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "CoreDataLocation", into: context) as! CoreDataLocation
        entity.name = model.name
        entity.latitude = model.latitude
        entity.longitude = model.longitude
        entity.createTime = Date()
        try context.save()
    }
    
    func fetchLocationsPublisher(context: NSManagedObjectContext) -> AnyPublisher<[LocationModel], Error> {
        Future<[LocationModel], Error> { promise in
            let fetchRequest: NSFetchRequest<CoreDataLocation> = CoreDataLocation.fetchRequest()
            
            context.perform {
                do {
                    var entities = try context.fetch(fetchRequest)
                    entities.sort{ $0.createTime! < $1.createTime! }
                    let models = entities.map { LocationModel(fromCore: $0) }
                    promise(.success(models))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func updateUnit(_ unit: UnitModel, context: NSManagedObjectContext) throws {
        let fetchRequest: NSFetchRequest<CoreDataUnit> = CoreDataUnit.fetchRequest()
        
        let entities = try context.fetch(fetchRequest)
        
        let entity: CoreDataUnit
        if let existingEntity = entities.first {
            entity = existingEntity
            print ("existingEntity")
        } else {
            entity = NSEntityDescription.insertNewObject(forEntityName: "CoreDataUnit", into: context) as! CoreDataUnit
            print ("insertNewObject")
        }
        
        entity.temperature = unit.tempUnit.title
        entity.wind = unit.windUnit.title
        entity.pressure = unit.pressureUnit.title
        
        try context.save()
    }
    
    func fetchUnit (context : NSManagedObjectContext) -> AnyPublisher<UnitModel, Error> {
        Future<UnitModel, Error> { promise in
            let fetchRequest: NSFetchRequest<CoreDataUnit> = CoreDataUnit.fetchRequest()
            
            context.perform {
                do {
                    let entities = try context.fetch(fetchRequest)
                    
                    guard let entity = entities.first else {
                        promise(.failure(CoreDataError.noData))
                        return
                    }
                    
                    let unit = UnitModel(fromCore: entity)
                    promise(.success(unit))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}


enum CoreDataError: Error {
    case noData
}
