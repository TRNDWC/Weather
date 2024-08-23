//
//  ContentWeatherCard.swift
//  Weather
//
//  Created by Trần Đức on 5/8/24.
//

import UIKit

class ContentWeatherCard: UIView {
    static let identifier = "ContentWeatherCard"
    
    static func nib() -> UINib {
        return UINib(nibName: "ContentWeatherCard", bundle: nil)
    }
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("ContentWeatherCard", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
    }
    
    func set (_ weather : WeatherModel){
        let weatherCode = MainWeatherStatus(rawValue: Int(weather.current.currentWeather.weatherCode))
        let title = weatherCode?.description
        let imageName = weatherCode?.imageName
        statusImage.image = UIImage(named: imageName ?? "")
        statusLabel.text = title
        tempLabel.text = String(weather.current.currentWeather.temperature2m)
    }
}

    
