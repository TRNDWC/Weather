//
//  ContentWeatherCollectionViewCard.swift
//  Weather
//
//  Created by Trần Đức on 13/8/24.
//

import UIKit

class ContentWeatherCollectionViewCard: UIView {
    static let identifier = "ContentWeatherCollectionViewCard"
    
    static func nib() -> UINib {
        return UINib(nibName: "ContentWeatherCollectionViewCard", bundle: nil)
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("ContentWeatherCollectionViewCard", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.register(ContentCell.nib(), forCellWithReuseIdentifier: ContentCell.identifier)
    }
}

extension ContentWeatherCollectionViewCard : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCell.identifier, for: indexPath) as! ContentCell
//        cell.backgroundColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenWidth = UIScreen.main.bounds.width - 32
        return CGSize(width: screenWidth, height: screenWidth*1.06)
    }
}

