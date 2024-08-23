//
//  SearchViewController.swift
//  Weather
//
//  Created by Trần Đức on 11/8/24.
//

import UIKit

protocol SearchCallBack : AnyObject {
    func onStartSearch()
    func onFinishSearch(weatherModel : WeatherModel)
    func onCancelSearch()
}

class SearchViewController: UIViewController, SearchCallBack {
    
    func onStartSearch() {
        let searchTableViewController = SearchTableViewController()
        searchTableViewController.mSearchCallback = self
        present(searchTableViewController, animated: true, completion: nil)
    }
    
    func onFinishSearch(weatherModel : WeatherModel) {
        WeatherProvider.addWeather(weatherModel)
        loadWeatherModel()
    }
    
    func onCancelSearch() {
        print ("cancel")
    }
    
    
    let gradientBackGround = CAGradientLayer()
    @IBOutlet weak var mToolBar: Toolbar!
    @IBOutlet weak var mSearchView: SearchView!
    
    func setUpLayout() {
        gradientBackGround.colors = [UIColor(named: "firstColor")!.cgColor, UIColor(named: "secondColor")!.cgColor]
        gradientBackGround.frame = searchStackView.bounds
        
        searchStackView.layer.insertSublayer(gradientBackGround, at: 0)
        let cornerRadius: CGFloat = 20.0
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: searchStackView.bounds, cornerRadius: cornerRadius).cgPath
        gradientBackGround.mask = maskLayer
    }
    
    func settingBackAction() {
        mToolBar.onBackButtonTap = {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBOutlet weak var searchStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mSearchView.mSearchCallBack = self
        settingBackAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadWeatherModel()
    }
        
    private func loadWeatherModel(){
        self.mSearchView.createDataSource(WeatherProvider.getWeathers())
        self.mSearchView.resultTableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpLayout()
    }
}


