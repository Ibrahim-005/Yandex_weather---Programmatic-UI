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
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityConditionName: UILabel = {
        let label = UILabel()
         label.text = "Cloudy"
        label.textColor = .gray
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

    required init?(coder Adecoder: NSCoder) {
        super.init(coder: Adecoder)
        self.configure()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    func configure(){
        setupView()
        setConstraints()
    }
    
    
//    required init(coder: NSCoder){
//        super.init(coder: coder)!
//        setupView()
//        setConstraints()
//        cityName.text = "fdsgdffg"
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        setupView()
//        setConstraints()
//        cityName.text = "fdsgdffg"
//    }
    
    private func setupView(){
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        tempStack = UIStackView(arrangedSubviews: [cityConditionName, tempCity], axis: .horizontal, spacing: 20, distribution: .fillEqually)
        stackview = UIStackView(arrangedSubviews: [cityName, tempStack], axis: .horizontal, spacing: 25, distribution: .fillEqually)
        
        self.addSubview(stackview)
        //print(stackview)
    }
    
    
    
    func configure(weather: Weather){
        self.cityName.text = weather.name
        self.cityConditionName.text = weather.condition
        self.tempCity.text = weather.tempString
        
//        print(weather.name)
//        print(weather.tempString)
    }
    
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            stackview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            stackview.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            
            
        ])
        
        NSLayoutConstraint.activate([
        
//            cityName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
//            
        ])
    }
}

