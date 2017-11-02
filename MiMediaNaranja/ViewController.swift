//
//  ViewController.swift
//  MiMediaNaranja
//
//  Created by Alberto Jimenez on 21/10/17.
//  Copyright © 2017 Alberto Jimenez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var fechaMuerteLabel: UILabel!
    @IBOutlet weak var daysLabelAmor: UILabel!
    @IBOutlet weak var daysLabelNacimiento: UILabel!

    var fechaAmor = Date ()
    var fechaNacimiento = Date()
        
   
   
    var fechaMuerte = Date()
    
    let preferencias = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
       
        
        if let dateNacimiento = preferencias.object(forKey: "dateNacimiento") as? Date {
            fechaNacimiento = dateNacimiento
            daysLabelNacimiento.text = cambioFormato(fechaNacimiento)
            daysLabelNacimiento.isHidden = false
        }else{
            fechaNacimiento = Date()
            daysLabelNacimiento.isHidden = true
        }
        
        if let dateAmor = preferencias.object(forKey: "dateAmor") as? Date {
            fechaAmor = dateAmor
            daysLabelAmor.text = cambioFormato(fechaAmor)
            daysLabelAmor.isHidden = false
        }else{
            fechaAmor = Date()
            daysLabelAmor.isHidden = true
        }
        
        fechaMuerteLabel.isHidden = true
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func botonMuerte(_ sender: Any) {
        if(daysLabelNacimiento.isHidden==true || daysLabelAmor.isHidden == true){
            let alertErrorVacio = UIAlertController(title: "¡Error!", message: "¡Debes introducir las fechas!", preferredStyle: .alert)
            alertErrorVacio.addAction(UIAlertAction(title: "OK", style: .default, handler: {(aa :UIAlertAction) in
                print("Se pulso OK")
            }))
            
            present(alertErrorVacio, animated: true)
            
        }else if (fechaAmor <= fechaNacimiento){
            let alertErrorFechas = UIAlertController(title: "¡Error!", message: "¡No puedes elegir una fecha menor de enamoramiento que de nacimiento o cercana al nacimiento!", preferredStyle: .alert)
            alertErrorFechas.addAction(UIAlertAction(title: "OK", style: .default, handler: {(aa :UIAlertAction) in
                print("Se pulso OK")
            }))
            
            present(alertErrorFechas, animated: true)
            
        }
        else{
            fechaMuerte = fechaNacimiento.addingTimeInterval(2*fechaAmor.timeIntervalSince(fechaNacimiento))
            fechaMuerteLabel.text = cambioFormato(fechaMuerte)
            fechaMuerteLabel.isHidden = false
        }
        
    }
    
    
    
    @IBAction func vuelveOK( _ segue: UIStoryboardSegue){
        guard let vc = segue.source as? DateViewController else {return}
        
        daysLabelNacimiento.isHidden = false
        fechaNacimiento = vc.dateBorn.date
        daysLabelNacimiento.text = cambioFormato(fechaNacimiento)
        
        daysLabelAmor.isHidden = false
        fechaAmor = vc.dateLove.date
        daysLabelAmor.text = cambioFormato(fechaAmor)
        
        fechaMuerteLabel.isHidden = true
        
        upDatePreferences()
       
        
    }
    
    @IBAction func vuelveCancelar( _ segue: UIStoryboardSegue){
        
    }

    private func cambioFormato(_ dateResult : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_EC")
        dateFormatter.dateStyle = .full
        
        return dateFormatter.string(from: dateResult)
        
    }
    
    private func upDatePreferences(){
        preferencias.set(fechaAmor, forKey: "dateAmor")
        print("Cambiada preferencia: dateAmor->"+cambioFormato(fechaAmor))
        preferencias.set(fechaNacimiento, forKey: "dateNacimiento")
        print("Cambiada preferencia: dateNacimiento->"+cambioFormato(fechaNacimiento))

    }
    
    
    

}

