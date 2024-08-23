//
//  MainViewController.swift
//  Weather
//
//  Created by Trần Đức on 6/8/24.
//

import UIKit
import Combine

class MainViewController: UIViewController, MainCallBack {
        
    static let identifier = "MainViewController"

    static func nib() -> UINib {
      return UINib(nibName: "MainViewController", bundle: nil)
    }
    
    enum Section {
        case weatherCard(items: WeatherModel)
        case byTime(items: WeatherModel)
        case forecast(items: WeatherModel)
            
        var title: String {
            switch self {
                case .weatherCard : return ""
                case .byTime : return ""
                case .forecast : return ""
            }
        }
    }
    
    struct CellIdentifier {
        static var weatherCard = "WeatherCardTableViewCell"
        static var byTime = "ByTimeTableCell"
        static var forecast = "ForecastCell"
    }
    
    @IBOutlet weak var contentTableView: UITableView!
    private var dataSource = [Section]()
    private var mainViewModel = MainViewModel(current: GetCurrentWeather(getCurrentWeather: GetCurrentWeatherDataStore()),
                                              hourly: GetForecastHourly(getHourly: GetForecastHourlyDataStore()),
                                              daily: GetDailyWeather(getDailyWeather: GetDailyWeatherDataStore()))
    private var cancellables = Set<AnyCancellable>()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentTableView.register(WeatherCardTableViewCell.nib(), forCellReuseIdentifier: WeatherCardTableViewCell.identifier)
        contentTableView.register(ByTimeTableCell.nib(), forCellReuseIdentifier: ByTimeTableCell.identifier)
        contentTableView.register(ForecastCell.nib(), forCellReuseIdentifier: ForecastCell.identifier)
        
        contentTableView.dataSource = self
        contentTableView.delegate = self
        
        contentTableView.estimatedRowHeight = 55
        contentTableView.rowHeight = UITableView.automaticDimension
        contentTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        contentTableView.showsVerticalScrollIndicator = false
        if (!WeatherProvider.getWeathers().isEmpty){
            dataSource = createDataSource(WeatherProvider.getWeathers()[0])
        }
        moveToAddLocation()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: .unitChangeNoti, object: nil)
    }
    
    @objc func handleNotification() {
        mainViewModel.fetchWeatherData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    func onAddNewClick() {
        let searchViewController = SearchViewController()
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func onSettingClick() {
        let settingViewController = SettingViewController()
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
            
    override func viewDidAppear(_ animated: Bool) {
        mainViewModel.$state.receive(on: DispatchQueue.main).sink { _ in
            self.contentTableView.reloadData()
        }.store(in: &cancellables)
    }
    
    func moveToAddLocation (){
        if (WeatherProvider.getWeathers().isEmpty){
            onAddNewClick()
        }
    }
    
    func onLocationChange(_ data: WeatherModel) {
        dataSource = createDataSource(data)
        contentTableView.reloadSections([1,2], with: UITableView.RowAnimation.fade)
    }
}

protocol MainCallBack : AnyObject {
    
    func onLocationChange(_ data: WeatherModel)
    
    func onAddNewClick()
    
    func onSettingClick()
}


extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (dataSource.isEmpty){
            return 0
        }
        switch dataSource[section] {
            case .weatherCard(_) : return 1
            case .byTime(_)  : return 1
            case .forecast(_)    : return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = dataSource[indexPath.section]
        switch section {
        case .weatherCard (_):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellIdentifier.weatherCard,
                for: indexPath) as! WeatherCardTableViewCell
            cell.weatherCardView.headerView.mMainCallBack = self
            cell.weatherCardView.mMainCallBack = self
            cell.weatherCardView.createDataSource()
            return cell
            
        case .byTime (let data):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellIdentifier.byTime,
                for: indexPath
            ) as? ByTimeTableCell
            cell?.byTimeView.createDataStore(data)
            return cell ?? UITableViewCell()
            
        case .forecast(let data):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellIdentifier.forecast,
                for: indexPath
            ) as? ForecastCell
            cell?.config(weather: data, row: indexPath.row)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 16))
        return footer
    }
    
    func createDataSource(_ data : WeatherModel) -> [Section] {
        let weatherItm = Section.weatherCard(items: data)
        let byTimeItm = Section.byTime(items: data)
        let forecastItm = Section.forecast(items: data)
        return [weatherItm, byTimeItm, forecastItm]
    }
}
