//
//  CityCell.swift
//  Faire
//
//  Created by Nithin 3 on 09/04/22.
//

import Foundation
import UIKit

class CityCell: UITableViewCell {
    
    var city: City? {
        didSet {
            dataBind()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configureUI()
    }
    
    lazy var cityTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private func configureUI() {
        self.addSubview(cityTitle)
        
        NSLayoutConstraint.activate([
            cityTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cityTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            cityTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            cityTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    /// Data Binding to UI Elements
    private func dataBind() {
        self.cityTitle.text = city?.title
    }
}
