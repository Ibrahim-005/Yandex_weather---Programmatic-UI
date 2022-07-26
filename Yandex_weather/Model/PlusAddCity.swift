//
//  PlusAddCity.swift
//  Yandex_weather
//
//  Created by cloud_vfx on 19/07/22.
//

import UIKit

extension UIViewController {
    
    func alertCity(name: String, placeHolder: String , completion: @escaping(String) -> Void){
        
        let alertCont = UIAlertController(title: name, message: "", preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default) { action in
            if let tftext = alertCont.textFields?.first {
                let text = tftext.text!
                completion(text)
            }
        }
        
        alertCont.addTextField { tf in
            tf.placeholder = placeHolder
            tf.enablesReturnKeyAutomatically = true
            tf.autocapitalizationType = .sentences
            // tf.autocorrectionType = .yes
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertCont.addAction(alertOk)
        alertCont.addAction(alertCancel)
        
        present(alertCont, animated: true, completion: nil)
    }
}
