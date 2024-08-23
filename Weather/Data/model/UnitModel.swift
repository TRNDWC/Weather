//
//  UnitModel.swift
//  Weather
//
//  Created by Trần Đức on 21/8/24.
//

import Foundation

class UnitModel : Equatable{
    var tempUnit : TempUnit
    var windUnit : WindUnit
    var pressureUnit : AtmosUnit

    init(tempUnit: TempUnit, windUnit: WindUnit, pressureUnit: AtmosUnit) {
        self.tempUnit = tempUnit
        self.windUnit = windUnit
        self.pressureUnit = pressureUnit
    }
    
    init (fromCore : CoreDataUnit){
        self.tempUnit = TempUnit(title: fromCore.temperature ?? "") ?? .c
        self.windUnit = WindUnit(title: fromCore.wind ?? "") ?? .km
        self.pressureUnit = AtmosUnit(title: fromCore.pressure ?? "") ?? .hPa
    }
    
    static func ==(lhs: UnitModel, rhs: UnitModel) -> Bool {
            return lhs.tempUnit == rhs.tempUnit &&
                   lhs.windUnit == rhs.windUnit &&
                   lhs.pressureUnit == rhs.pressureUnit
        }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = UnitModel(tempUnit: tempUnit, windUnit: windUnit, pressureUnit: pressureUnit)
        return copy
    }
}
