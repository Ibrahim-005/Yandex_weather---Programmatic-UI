//
//  ListCell.swift
//  Yandex_weather
//
//  Created by cloud_vfx on 19/07/22.
//

import UIKit

class ListCell: UITableViewCell {

    private let cityName: UILabel = {
       let label = UILabel()
        label.text = "Name"
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityConditionName: UILabel = {
        let label = UILabel()
         label.text = "Cloudy"
         label.font = UIFont.systemFont(ofSize: 13)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private let tempCity: UILabel = {
        let label = UILabel()
         label.text = "25"
         label.font = UIFont.systemFont(ofSize: 14)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    var stackview = UIStackView()
    var tempStack = UIStackView()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setConstraints()
        cityName.text = "fdsgdffg"
    }
    
    private func setupView(){
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        tempStack = UIStackView(arrangedSubviews: [cityConditionName, tempCity], axis: .horizontal, spacing: 10, distribution: .fill)
        stackview = UIStackView(arrangedSubviews: [cityName, tempStack], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        
        self.addSubview(stackview)
        
    }
    
    
    
    func configure(weather: Weather){
        self.cityName.text = "nimadur"
        self.cityConditionName.text = weather.condition
        self.tempCity.text = weather.tempString
    }
    
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            stackview.topAnchor.constraint(equalTo: topAnchor, constant: 2)
            
        ])
    }
}

