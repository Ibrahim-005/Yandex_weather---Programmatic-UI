//
//  ViewController.swift
//  Yandex_weather
//
//  Created by cloud_vfx on 19/07/22.
//

import UIKit
import SwiftSVG

class DetailView: UIViewController {

    private let cityView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cityName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "City name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let Condition: UILabel = {
        let label = UILabel()
        label.text = "Cloudy"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempCity: UILabel = {
        let label = UILabel()
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
   
    
//
//    @IBOutlet weak var cityName: UILabel!
//    @IBOutlet weak var cityView: UIView!
//    @IBOutlet weak var Condition1: UILabel!
//
//    @IBOutlet weak var Condition: UILabel!
//    @IBOutlet weak var tempCity: UILabel!
//    @IBOutlet weak var pressure: UILabel!
//    @IBOutlet weak var windSpeed: UILabel!
//    @IBOutlet weak var tempMin: UILabel!
//    @IBOutlet weak var tempMax: UILabel!
//
    var Mainstack = UIStackView()
    var Topstack = UIStackView()
    var Bottomtack = UIStackView()
    var Leftstack = UIStackView()
    var Rightstack = UIStackView()
    
    var weatherM : Weather?
    
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
        Topstack = UIStackView(arrangedSubviews: [cityName, cityView, tempCity], axis: .vertical, spacing: 10, distribution: .fill)
        Mainstack = UIStackView(arrangedSubviews: [Topstack, Bottomtack], axis: .vertical, spacing: 20, distribution: .fillProportionally)
        
        view.addSubview(Mainstack)
        
    }
    
    func refreshLabel(){
        cityName.text = weatherM?.name
        let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(String(describing: weatherM!.conditionCode)).svg")!
//        let Wimage = UIView(SVGURL: url!) { (image) in
//            image.resizeToFit(self.cityView.bounds)
//        }
//        guard url != nil else {
//            print("XATTOOOO")
//            return
//        }
        let Wimage = UIView(SVGURL: url) { imagess in
            imagess.resizeToFit(self.cityView.frame)
        }
        Wimage.maximumContentSizeCategory
        self.cityView.addSubview(Wimage)
       
    
        
      //  Condition1.text = weatherM?.condition
        tempCity.text = weatherM?.tempString
        pressure.text = String(format: "%.0f", weatherM!.pressureMm)
        windSpeed.text = String(format: "%.0f", weatherM!.windSpeed)
        tempMin.text = String(format: "%.0f", weatherM!.tempMin)
        tempMax.text = String(format: "%.0f", weatherM!.tempMax)
    }
    
    
    
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            Mainstack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            Mainstack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            Mainstack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            Mainstack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
        
    }
    
}
//var imageView = UIImageView()
//        var image = UIImage(named: "work25")
//        imageView.image = image
//        dropoffLocationField.rightView = imageView
//        dropoffLocationField.rightViewMode = .always
