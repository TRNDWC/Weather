//
//  SettingViewController.swift
//  Weather
//
//  Created by Trần Đức on 12/8/24.
//

import UIKit

enum Section {
    case setting(items: [Unit])
    case extra(items: [String])
    
    var title: String {
        switch self {
            case .setting : return "UNIT"
            case .extra : return "EXTRA"
        }
    }
}

struct CellIdentifier {
    static var setting = SettingCell.identifier
    static var extra = SettingCell.identifier
}

class SettingViewController: UIViewController {
    
    private var dataSource = [Section]()
    private var unit = [Unit]()

    @IBOutlet weak var mTable: UITableView!
    @IBOutlet weak var mStackView: UIStackView!
    @IBOutlet weak var mToolBar: Toolbar!
    private let oldUnit : UnitModel = UnitProvider.shared.unitModel.copy() as! UnitModel

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = createDataSource()
        unit = createSetting()
        mTable.register(SettingCell.nib(), forCellReuseIdentifier: SettingCell.identifier)
        mTable.dataSource = self
        mTable.delegate = self
        settingBackAction()
    }
    
    func setUpLayout() {
        let gradientBackGround = CAGradientLayer()
        gradientBackGround.colors = [UIColor(named: "firstColor")!.cgColor, UIColor(named: "secondColor")!.cgColor]
        gradientBackGround.frame = mStackView.bounds
        mStackView.layer.insertSublayer(gradientBackGround, at: 0)
        
        let cornerRadius: CGFloat = 20.0
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: mStackView.bounds, cornerRadius: cornerRadius).cgPath
        gradientBackGround.mask = maskLayer
        mTable.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func settingBackAction(){
        mToolBar.onBackButtonTap = {
            self.navigationController?.popViewController(animated: true)
            do {
                try CoreDataManager.shared.updateUnit(UnitProvider.shared.unitModel, context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
                let newUnit = UnitProvider.shared.unitModel
//                if (self.oldUnit.tempUnit.title != newUnit.tempUnit.title ||
//                    self.oldUnit.windUnit.title != newUnit.windUnit.title ||
//                    self.oldUnit.pressureUnit.title != newUnit.pressureUnit.title ) {
//                    NotificationManager.shared.unitChangePostNotification()
//                }
                if (self.oldUnit != newUnit){
                    NotificationManager.shared.unitChangePostNotification()
                }
            } catch {
                print("Failed to save location: \(error)")
            }

        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpLayout()
    }
    
}




extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSource[section] {
            case .setting(let items) : return items.count
            case .extra(let items)  : return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = dataSource[indexPath.section]
        switch section {
        case .setting(let items):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellIdentifier.setting,
                for: indexPath) as! SettingCell
            let row = items[indexPath.row]
            var unit = ""
            if (indexPath.row == 0) {
                unit = UnitProvider.shared.unitModel.tempUnit.title
            } else if (indexPath.row == 1) {
                unit = UnitProvider.shared.unitModel.windUnit.title
            } else {
                unit = UnitProvider.shared.unitModel.pressureUnit.title
            }
            cell.settingUnit(unit: row)
            cell.initData(unit: unit)
            return cell
            
        case .extra(let items):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellIdentifier.extra,
                for: indexPath
            ) as? SettingCell
            let row = items[indexPath.row]
            cell?.settingExtra(title: row)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return HEADER_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 16))
        if (section<dataSource.count-1) {
            let lineView = UIView(
                frame: CGRect(x: 16, y: footer.frame.size.height - 1, width: tableView.frame.size.width - 32, height: 1)
            )
            lineView.backgroundColor = .white
            footer.addSubview(lineView)
        }
        return footer
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let mSection = dataSource[section]
        return mSection.title
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.font = headerView.textLabel?.font.withSize(12)
        }
    }
    
    func createDataSource() -> [Section] {
        let setting = Section.setting(items: createSetting())
        let extra = Section.extra(items: ["About","Privacy policy"])
        return [setting, extra]
    }
    
    func createSetting() -> [Unit] {
        let temp = Unit.temp(items: [TempUnit.c, TempUnit.f])
        let wind = Unit.wind(items: [WindUnit.km, WindUnit.mil, WindUnit.m, WindUnit.kn])
        let atmos = Unit.atmos(items: [AtmosUnit.mbar, AtmosUnit.atm, AtmosUnit.mmHg, AtmosUnit.inHg, AtmosUnit.hPa])
        return [temp,wind,atmos]
    }
}

