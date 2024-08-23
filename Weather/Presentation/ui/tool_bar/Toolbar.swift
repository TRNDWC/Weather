//
//  Toolbar.swift
//  Weather
//
//  Created by Trần Đức on 11/8/24.
//

import UIKit

class Toolbar: UIView {
    static let identifier = "Toolbar"
    
    static func nib() -> UINib {
        return UINib(nibName: "Toolbar", bundle: nil)
    }
    
    @IBOutlet var contentView: UIView!
    var onBackButtonTap: (() -> Void)?
    
    @IBAction func mBackButton(_ sender: Any) {
        onBackButtonTap?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("Toolbar", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
    }
}
