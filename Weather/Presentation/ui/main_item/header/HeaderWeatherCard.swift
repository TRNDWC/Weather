//
//  HeaderWeatherCard.swift
//  Weather
//
//  Created by Trần Đức on 5/8/24.
//

import UIKit

class HeaderWeatherCard: UIView {
    
    static let identifier = "HeaderWeatherCard"
    weak var mMainCallBack : MainCallBack?
    
    static func nib() -> UINib {
        return UINib(nibName: "HeaderWeatherCard", bundle: nil)
    }
    @IBOutlet var contentView: UIView!
    @IBAction func addNewButton(_ sender: Any) {
        mMainCallBack?.onAddNewClick()
    }
    
    @IBAction func settingButton(_ sender: Any) {
        mMainCallBack?.onSettingClick()
    }
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("HeaderWeatherCard", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
    }
}
