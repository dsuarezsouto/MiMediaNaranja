//
//  DateViewController.swift
//  MiMediaNaranja
//
//  Created by Daniel Suárez Souto on 24/10/17.
//  Copyright © 2017 Alberto Jimenez. All rights reserved.
//

import UIKit
class DateViewController: UIViewController {
    
    @IBOutlet weak var dateBorn : UIDatePicker!
    
    @IBOutlet weak var dateLove: UIDatePicker!
    
    let preferencias = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateBorn.maximumDate = Date()
        dateLove.maximumDate = Date()
        if let dateAmor = preferencias.object(forKey: "dateAmor") as? Date {
            dateLove.date = dateAmor
        }
        if let dateNacimiento = preferencias.object(forKey: "dateNacimiento") as? Date {
            dateBorn.date = dateNacimiento
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
