//
//  ForcastView.swift
//  Weather
//
//  Created by Trần Đức on 7/8/24.
//

import UIKit

class ForcastView: UIView {
    
    static let identifier = "ForcastView"

    static func nib() -> UINib {
      return UINib(nibName: "ForcastView", bundle: nil)
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var forecastTable: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("ForcastView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = UIColor(red: 0.17, green: 0.47, blue: 0.76, alpha: 1.00)
        
        setUpTable()
    }
    
    private func setUpTable() {
        forecastTable.register(ForcastTableViewCell.nib(), forCellReuseIdentifier: ForcastTableViewCell.identifier)
        forecastTable.delegate = self
        forecastTable.dataSource = self
        
        print("ForcastView",self.bounds.width, self.bounds.height)

    }
}


extension ForcastView : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForcastTableViewCell.identifier, for: indexPath) as! ForcastTableViewCell
        cell.configure()
        return cell
    }
}
