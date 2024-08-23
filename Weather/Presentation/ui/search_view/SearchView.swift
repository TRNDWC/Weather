//
//  SearchView.swift
//  Weather
//
//  Created by Trần Đức on 11/8/24.
//

import UIKit

class SearchView: UIView {
    static let identifier = "SearchView"
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchView", bundle: nil)
    }
    
    enum Section {
        case result (items: [WeatherModel])
    }
    
    struct CellIdentifier {
        static var result = SearchItemCell.identifier
    }

    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mSearchView: UIView!
    @IBOutlet weak var resultTableView: UITableView!
    var mSearchCallBack : SearchCallBack?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private var dataSource = [Section]()
    
    private func commonInit(){
        Bundle.main.loadNibNamed("SearchView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
        mSearchView.layer.cornerRadius = 16
        
        resultTableView.register(SearchItemCell.nib(), forCellReuseIdentifier: SearchItemCell.identifier)
        
        resultTableView.estimatedRowHeight = 55
        resultTableView.rowHeight = UITableView.automaticDimension
        resultTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        resultTableView.showsVerticalScrollIndicator = false
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.clickAction(sender:)))
        self.mSearchView.addGestureRecognizer(gesture)
    }
    
    @objc func clickAction(sender : UITapGestureRecognizer) {
        mSearchCallBack?.onStartSearch()
    }
}

extension SearchView : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSource[section] {
            case .result(let items) : return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource[indexPath.section] {
            case .result(let items) :
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.result,for: indexPath) as! SearchItemCell
                cell.setUp(items[indexPath.row])
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 16))
        footer.backgroundColor = .clear
        return footer
    }

    func createDataSource(_ weathers : [WeatherModel]) {
        let weatherItm = Section.result(items: weathers)
        self.dataSource = [weatherItm]
    }
}


    
