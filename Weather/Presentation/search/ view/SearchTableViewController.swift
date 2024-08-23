//
//  SearchTableViewController.swift
//  Weather
//
//  Created by Trần Đức on 15/8/24.
//

import UIKit
import Combine

class SearchTableViewController: UIViewController {

    @IBOutlet weak var mSearchBar: UISearchBar!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mLoadingView: UIActivityIndicatorView!
    private var cancellables: Set<AnyCancellable> = []
    private var dataSource : [LocationModel] = []
    private var selectedLocation : LocationModel?
    var mSearchCallback : SearchCallBack?
    private let viewmodel = SearchViewModel (
        searchLocation: SearchLocation(searchLocation: SearchLocationDataStore()),
        current: GetCurrentWeather(getCurrentWeather: GetCurrentWeatherDataStore()),
        hourly: GetForecastHourly(getHourly: GetForecastHourlyDataStore()),
        daily: GetDailyWeather(getDailyWeather: GetDailyWeatherDataStore())
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mLoadingView.stopAnimating()
        bind(to: viewmodel)
    }
    
    private func bind(to viewModel: SearchViewModel) {
        viewModel.$locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                    self?.dataSource = data
                    self?.mTableView.reloadData()
        }.store(in: &cancellables)
        
        viewModel.$currentWeather
            .zip(viewModel.$hourlyWeather, viewModel.$dailyWeather)
            .receive(on: DispatchQueue.main)
            .sink { data in
                if (data.0 != nil && data.1 != nil && data.2 != nil && self.selectedLocation != nil){
                    let weather = WeatherModel(location: self.selectedLocation!, current: data.0!, hourly: data.1!, daily: data.2!)
                    self.mSearchCallback?.onFinishSearch(weatherModel: weather)
                    do {
                        try CoreDataManager.shared.saveLocation(self.selectedLocation!, context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
                    } catch {
                        print("Failed to save location: \(error)")
                    }
                    self.dismiss(animated: true, completion: nil)
                }
                
        }.store(in: &cancellables)
    }
}


extension SearchTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location : LocationModel = dataSource[indexPath.section]
        viewmodel.getCurrent(locationModel: location)
        viewmodel.getHourly(locationModel: location)
        viewmodel.getDaily(locationModel: location)
        selectedLocation = location
        self.mLoadingView.startAnimating()
        print (location.name)
    }
    

}

extension SearchTableViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.section].name
        cell.textLabel?.textColor = .black
        cell.textLabel?.numberOfLines = 1
        cell.selectionStyle = .none
        return cell
    }
}


extension SearchTableViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewmodel.emitKeyword(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search button clicked")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel button clicked")
    }

}
