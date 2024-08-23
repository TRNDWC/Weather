//
//  BottomWeatherCard.swift
//  Weather
//
//  Created by Trần Đức on 5/8/24.
//

import UIKit

class BottomWeatherCardItem : UIView {
    static let identifier = "BottomWeatherCardItem"
    
    static func nib() -> UINib {
        return UINib(nibName: "BottomWeatherCardItem", bundle: nil)
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("BottomWeatherCardItem", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
    }
    
    func set (_ data: String, _ title: String, _ image: String){
        dataLabel.text = data
        descriptionLabel.text = title
        iconImage.image = UIImage(named: image)
    }
}

    
