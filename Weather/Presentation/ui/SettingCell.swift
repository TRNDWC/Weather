//
//  SettingCell.swift
//  Weather
//
//  Created by Trần Đức on 12/8/24.
//

import UIKit

enum Unit {
    case temp(items: [TempUnit])
    case atmos(items: [AtmosUnit])
    case wind(items: [WindUnit])
    
    var title: String {
        switch self {
            case.temp : return "Temperature unit"
            case.atmos : return "Atmospheric pressure unit"
            case.wind : return "Wind speed unit"
        }
    }
    
    var menu: UIMenu {
        switch self {
        case .temp(let items):
            return UIMenu(title: "Temperature", children: items.map { item in
                UIAction(title: item.title, state: item == UnitProvider.shared.unitModel.tempUnit ? .on : .off) { _ in
                    if let selectedUnit = TempUnit(title: item.title) {
                        UnitProvider.shared.unitModel.tempUnit = selectedUnit
                    }
                }
            })
            
        case .wind(let items):
            return UIMenu(title: "Wind", children: items.map { item in
                UIAction(title: item.title, state: item == UnitProvider.shared.unitModel.windUnit ? .on : .off) { _ in
                    if let selectedUnit = WindUnit(title: item.title) {
                        UnitProvider.shared.unitModel.windUnit = selectedUnit
                    }
                }
            })
            
        case .atmos(let items):
            return UIMenu(title: "Atmosphere", children: items.map { item in
                UIAction(title: item.title, state: item == UnitProvider.shared.unitModel.pressureUnit ? .on : .off) { _ in
                    if let selectedUnit = AtmosUnit(title: item.title) {
                        UnitProvider.shared.unitModel.pressureUnit = selectedUnit
                    }
                }
            })
        }
    }
}

class SettingCell: UITableViewCell {
    
    static let identifier = "SettingCell"

    static func nib() -> UINib {
      return UINib(nibName: "SettingCell", bundle: nil)
    }
    
    @IBOutlet weak var mUnitButton: UIButton!
    
    @IBOutlet weak var mUnitLabel: UILabel!
    
    func settingUnit (unit: Unit){
        mUnitLabel.text = unit.title
        mUnitButton.menu = unit.menu
    }

    func settingExtra (title: String){
        mUnitLabel.text = title
        mUnitButton.isHidden = true
    }

    func initData(unit: String){
        mUnitButton.setTitle(unit, for: UIControl.State.normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
