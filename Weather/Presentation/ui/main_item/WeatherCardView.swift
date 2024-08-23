//
//  WeatherCardView.swift
//  Weather
//
//  Created by Trần Đức on 6/8/24.
//

import UIKit

class WeatherCardView: UIView, ContentCardCallBack {
    
    static let identifier = "WeatherCardView"

    static func nib() -> UINib {
      return UINib(nibName: "WeatherCardView", bundle: nil)
    }

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mCollectionView: UICollectionView!
    private var dataSource = [WeatherModel]()
    
    @IBOutlet weak var headerView: HeaderWeatherCard!
    let gradientBackGround = CAGradientLayer()
    weak var mMainCallBack : MainCallBack?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed(WeatherCardView.identifier, owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mCollectionView.register(MainCell.nib(), forCellWithReuseIdentifier: MainCell.identifier)
        setUpLayout()
        addGradientBackground()
    }
    
    func setUpLayout() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        mCollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
    }
    
    func addGradientBackground() {
        gradientBackGround.frame = contentView.bounds
        gradientBackGround.colors = [UIColor(named: "firstColor")!.cgColor, UIColor(named: "secondColor")!.cgColor]
        gradientBackGround.startPoint = CGPoint(x: 0, y: 0)
        gradientBackGround.endPoint = CGPoint(x: 1, y: 1)
        contentView.layer.insertSublayer(gradientBackGround, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientBackGround.frame = contentView.bounds
    }
    
    override var intrinsicContentSize: CGSize {
        let headerHeight = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let collectionHeight = mCollectionView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let totalHeight = headerHeight + collectionHeight
        return CGSize(width: UIView.noIntrinsicMetric, height: totalHeight)
    }
    
    func createDataSource(){
        dataSource = WeatherProvider.getWeathers()
        headerView.pageController.numberOfPages = dataSource.count
        if (!dataSource.isEmpty){
            headerView.locationLabel.text = dataSource.first?.location.name
            headerView.pageController.currentPage = 0
            mCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
        }
        mCollectionView.reloadData()
    }
    
    func onScollPage(_ index: Int) {
        headerView.locationLabel.text = dataSource[index].location.name
        headerView.pageController.currentPage = index
    }
}

protocol ContentCardCallBack{
    func onScollPage(_ index : Int)
}


extension WeatherCardView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / contentView.frame.width
        self.headerView.pageController.currentPage = Int(scrollPos)
        self.headerView.locationLabel.text = dataSource[Int(scrollPos)].location.name
        self.mMainCallBack?.onLocationChange(dataSource[Int(scrollPos)])
    }
}

extension WeatherCardView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.identifier, for: indexPath) as! MainCell
        cell.setUp(dataSource[indexPath.row])
        return cell
    }
}

extension WeatherCardView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width - 32
        return CGSize(width: screenWidth, height: 500)
    }
}
