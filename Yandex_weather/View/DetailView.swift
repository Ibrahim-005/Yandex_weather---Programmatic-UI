//
//  ViewController.swift
//  Yandex_weather
//
//  Created by cloud_vfx on 19/07/22.
//

import UIKit
import SwiftSVG

class DetailView: UIViewController {

    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = true
        return imageView
    }()
    
    private let cityName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.text = "City name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempCity: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "16"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pressure: UILabel = {
        let label = UILabel()
        label.text = "555"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windSpeed: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "24"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempMin: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempMax: UILabel = {
        let label = UILabel()
        label.text = "17"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pressureLabel: UILabel = {
        let label = UILabel()
        label.text = "Pressure"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Wind_Speed"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempMinLabel: UILabel = {
        let label = UILabel()
        label.text = "Temp_min"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempMaxLabel: UILabel = {
        let label = UILabel()
        label.text = "Temp-max"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var Mainstack = UIStackView()
    var Topstack = UIStackView()
    var Bottomtack = UIStackView()
    var Leftstack = UIStackView()
    var Rightstack = UIStackView()
    var Tempstack = UIStackView()
    
    var weatherM : Weather?
    var tempIcon = "°C"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshLabel()
        setupView()
        setConstraints()
    }
    
    private func setupView(){
        view.backgroundColor = .white
        
        Leftstack = UIStackView(arrangedSubviews: [pressure, windSpeed, tempMin, tempMax], axis: .vertical, spacing: 10, distribution: .fillEqually)
        Rightstack = UIStackView(arrangedSubviews: [pressureLabel, windSpeedLabel, tempMinLabel, tempMaxLabel], axis: .vertical, spacing: 10, distribution: .fillEqually)
        Bottomtack = UIStackView(arrangedSubviews: [Rightstack, Leftstack], axis: .horizontal, spacing: 20, distribution: .fillEqually)
        Tempstack = UIStackView(arrangedSubviews: [tempCity, weatherIcon], axis: .vertical, spacing: 5, distribution: .fillEqually)
        Topstack = UIStackView(arrangedSubviews: [cityName, Tempstack], axis: .horizontal, spacing: 50, distribution: .fill)
        Mainstack = UIStackView(arrangedSubviews: [Topstack, Bottomtack], axis: .vertical, spacing: 200, distribution: .fillProportionally)
       
        view.addSubview(Mainstack)
    }
    
    // Set data to the Properties from model
    func refreshLabel(){
        cityName.text = weatherM?.name
        weatherIcon.image = UIImage(systemName: weatherM?.icon ?? "")
        tempCity.text = (weatherM!.tempString + tempIcon)
        pressure.text = String(format: "%.0f", weatherM!.pressureMm)
        windSpeed.text = String(format: "%.0f", weatherM!.windSpeed)
        tempMin.text = String(format: "%.0f", weatherM!.tempMin)
        tempMax.text = String(format: "%.0f", weatherM!.tempMax)
    }
    
   // Set Constraints
    private func setConstraints(){
        NSLayoutConstraint.activate([
            Mainstack.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            Mainstack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            Mainstack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            weatherIcon.widthAnchor.constraint(equalToConstant: 55),
            weatherIcon.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
