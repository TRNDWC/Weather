//
//  UnitProvider.swift
//  Weather
//
//  Created by Trần Đức on 21/8/24.
//

import Foundation

class UnitProvider {
    static let shared = UnitProvider()

    var unitModel: UnitModel
    
    private init() {
        self.unitModel = UnitModel(tempUnit: TempUnit.c, windUnit: WindUnit.km , pressureUnit: AtmosUnit.hPa)
    }
    
    func updateUnitModel(_ newModel: UnitModel) {
        self.unitModel = newModel
    }
}
