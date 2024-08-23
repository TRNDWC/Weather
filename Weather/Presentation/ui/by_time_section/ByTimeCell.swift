//
//  ByTimeCell.swift
//  Weather
//
//  Created by Trần Đức on 9/8/24.
//

import UIKit

class ByTimeCell: UICollectionViewCell {
    
    static let identifier = "ByTimeCell"

    static func nib() -> UINib {
      return UINib(nibName: "ByTimeCell", bundle: nil)
    }

    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var lb3: UILabel!
    
    func config (_ index : Int, _ data: WeatherModel){
        let weatherCode = ItemWeatherStatus(rawValue: (data.hourly.hourly.weatherCode)[index])
        lb1.text = extractTimeFromDateString(String(data.hourly.hourly.time[index]))
        img1.image = UIImage(named: weatherCode?.imageName ?? "")
        lb2.text = String(data.hourly.hourly.temperature2M[index])+"°"
        lb3.text = String(data.hourly.hourly.rain[index])+"% rain"
    }
    
    private func extractTimeFromDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.timeZone = TimeZone.current
        
        if let date = dateFormatter.date(from: dateString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm" // Desired output format
            
            return timeFormatter.string(from: date)
        }
        
        return nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}
