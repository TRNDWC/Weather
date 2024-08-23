//
//  SplashViewController.swift
//  Weather
//
//  Created by Trần Đức on 14/8/24.
//

import UIKit

class SplashViewController: UIViewController {
    
    let gradientBackGround = CAGradientLayer()
    let viewmodel : SplashViewModel = SplashViewModel(
        context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, 
        searchLocation: SearchLocation(searchLocation: SearchLocationDataStore()),
        current: GetCurrentWeather(getCurrentWeather: GetCurrentWeatherDataStore()),
        hourly: GetForecastHourly(getHourly: GetForecastHourlyDataStore()),
        daily: GetDailyWeather(getDailyWeather: GetDailyWeatherDataStore())
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBackGround.colors = [UIColor(named: "firstColor")!.cgColor, UIColor(named: "secondColor")!.cgColor]
        gradientBackGround.frame = view.bounds
        view.layer.insertSublayer(gradientBackGround, at: 0)
        bindViewModel()
    }
    
    func bindViewModel(){

        viewmodel.state.bind { [weak self] state in
            guard let self = self, let state = state else {
                return
            }
            if (state == SplashState.Finish){
                let mainViewController = MainViewController()
                self.navigationController?.pushViewController(mainViewController, animated: true)
            }
        }
    }
}
