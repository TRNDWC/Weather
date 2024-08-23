//
//  ByTimeView.swift
//  Weather
//
//  Created by Trần Đức on 9/8/24.
//

import UIKit

class ByTimeView: UIView {
    
    static let identifier = "ByTimeView"
    
    static func nib() -> UINib {
        return UINib(nibName: "ByTimeView", bundle: nil)
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerLabel: UILabel!
    
    var weatherModel : WeatherModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("ByTimeView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = UIColor(red: 0.17, green: 0.47, blue: 0.76, alpha: 1.00)
        
        let nib = UINib(nibName: ByTimeCell.identifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: ByTimeCell.identifier)
    }
    
    func createDataStore(_ data : WeatherModel){
        weatherModel = data
        collectionView.reloadData()
    }
}


extension ByTimeView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherModel?.hourly.hourly.time.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ByTimeCell.identifier, for: indexPath) as! ByTimeCell
        if (weatherModel != nil){
            cell.config(indexPath.row, weatherModel!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = (UIScreen.main.bounds.width-32)/5
        return CGSize(width: screenWidth, height: screenWidth*104/72)
    }

}
