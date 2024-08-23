//
//  BottomWeatherCard.swift
//  Weather
//
//  Created by Trần Đức on 5/8/24.
//

import UIKit

class BottomWeatherCard: UIView {
    static let identifier = "BottomWeatherCard"
    
    static func nib() -> UINib {
        return UINib(nibName: "BottomWeatherCard", bundle: nil)
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var windView: BottomWeatherCardItem!
    @IBOutlet weak var rainView: BottomWeatherCardItem!
    @IBOutlet weak var pressureView: BottomWeatherCardItem!
    @IBOutlet weak var humudityView: BottomWeatherCardItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("BottomWeatherCard", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
    }
    
    func set (_ weather: WeatherModel){
        windView.set(String(weather.current.currentWeather.windSpeed10m), "Wind", "ic_wind")
        rainView.set(String(weather.current.currentWeather.rain), "Chance of rain", "ic_rain")
        pressureView.set(String(weather.current.currentWeather.surfacePressure), "Pressure", "ic_pressure")
        humudityView.set(String(weather.current.currentWeather.relativeHumidity2m), "Humidity", "ic_humidity")
    }
}

    

    
