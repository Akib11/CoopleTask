//
//  JobCell.swift
//  Coople
//
//  Created by Akib Quraishi on 10/10/2019.
//  Copyright © 2019 AkibMakesApps. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    
    let workAssignmentLabel: UILabel = UILabel(text:"", font:.systemFont(ofSize: 20, weight: .semibold))
    let addressStreetLabel: UILabel = UILabel(text:"", font:.systemFont(ofSize:20))
    let zipLabel: UILabel = UILabel(text:"", font:.systemFont(ofSize:20))
    let cityLabel: UILabel = UILabel(text:"", font:.systemFont(ofSize:20))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
      
        workAssignmentLabel.numberOfLines = 0
        
        
        let zipCitystackView = UIStackView(arrangedSubviews: [
            zipLabel,
            cityLabel])
        zipCitystackView.spacing = 8
        zipCitystackView.axis = .horizontal
        
        
        let stackView = UIStackView(arrangedSubviews: [
            workAssignmentLabel,
            addressStreetLabel,
            zipCitystackView])
        stackView.spacing = 8
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
