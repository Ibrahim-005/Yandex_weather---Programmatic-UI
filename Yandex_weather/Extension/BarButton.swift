//
//  BarButton.swift
//  Yandex_weather
//
//  Created by cloud_vfx on 25/07/22.
//

import UIKit
import Foundation

extension UIViewController {
    
    func createCustomButton(selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
