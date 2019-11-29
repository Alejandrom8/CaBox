//
//  ViewController.swift
//  proyectoFinal
//
//  Created by Laboratorio UNAM-Apple 04 on 10/23/19.
//  Copyright © 2019 unam. All rights reserved.
//

import UIKit
import Firebase
import AVKit

class ViewController: UIViewController {

//    @IBOutlet weak var firstButton: UIButton!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
//    var menuShowing = false
    var email = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loginFirebase(_ email: String, _ password: String){
        Auth.auth().signIn(withEmail: email, password: password){ (result, error) in
            
            if let error = error {
                self.present(makeAlert(title: "Error", message: error.localizedDescription), animated: true, completion: nil)
            }
            
//            self.present(makeAlert(title: "Logueo exitoso", message: "Ahora puedes entrar ✌️"), animated: true, completion: nil)
            print("Logueo exitoso")
            self.performSegue(withIdentifier: "goToSuccessView", sender: self)
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        if emailField.text != nil && passwordField.text != nil{
            email = emailField.text!
            password = passwordField.text!
            
            loginFirebase(email, password)
        }else{
            self.present(makeAlert(title: "Error", message: "Llena tdos los campos"), animated: true, completion: nil)
        }
    }

    //    @IBAction func alertaConUITextField(_ sender: Any){
//        let alert = UIAlertController(title: "Añadir", message: nil, preferredStyle: .alert)
//        let confirmAction = UIAlertAction(title: "Agregar", style: .default){ (_) in
//            if let txtField = alert.textFields?.first, let text = txtField.text{
//                print("Texto \(text)")
//            }
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
//        alert.addTextField{ (txtField) in txtField.placeholder = "Agrega un texto" }
//        alert.addAction(confirmAction)
//        alert.addAction(cancelAction)
//
//        self.present(alert, animated: true, completion: nil)
//    }
    
}

