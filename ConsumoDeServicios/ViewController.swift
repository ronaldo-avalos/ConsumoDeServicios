//
//  ViewController.swift
//  ConsumoDeServicios
//
//  Created by Ronaldo Avalos on 25/11/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameLabel : UILabel!
    @IBOutlet weak var stateLabel : UILabel!
    @IBOutlet weak var loadig : UIActivityIndicatorView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchService()
    }
    
    
    // Endpoint: https://run.mocky.io/v3/0a1b574e-0ccb-4996-863c-b042023975e5
       // 1. Crear expeción de seguridad - ✅
       // 2. Crear URL con el endpoint. - OK
       // 3. Hacer request con la ayuda de URLSession
       // 4. Transformar respuesta a diccionario
       // 5. Ejecutar Request
    private func fetchService() {
           let endpointString = "https://run.mocky.io/v3/0a1b574e-0ccb-4996-863c-b042023975e5"
           
           guard let endpoint = URL(string: endpointString) else {
               return
           }
           
        loadig.startAnimating()
           URLSession.shared.dataTask(with: endpoint) { (data: Data?, _, error: Error?) in
               
               DispatchQueue.main.async {
                   self.loadig.stopAnimating()
               }
               
               if error != nil {
                   print("Hubo un error!")
                   
                   return
               }
               
               guard 
                let dataFromService = data,
                let model = try? JSONDecoder().decode(UserModel.self, from: dataFromService) else {
                   return
               }
                    
                    
               DispatchQueue.main.async {
                   self.usernameLabel.text = model.user
                   self.stateLabel.text = model.isHappy ? "Es feliz 😁" : "Es triste 😔"
               }
           }.resume()
       }

}

