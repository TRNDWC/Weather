//
//  MainCell.swift
//  Weather
//
//  Created by Trần Đức on 16/8/24.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    static let identifier = "MainCell"
    @IBOutlet weak var contentCard: ContentWeatherCard!
    @IBOutlet weak var bottomCard: BottomWeatherCard!
    
    static func nib() -> UINib {
      return UINib(nibName: "MainCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp( _ status : WeatherModel){
        contentCard.set(status)
        bottomCard.set(status)
    }
}
