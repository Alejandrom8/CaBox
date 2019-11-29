//
//  SignUpViewController.swift
//  proyectoFinal
//
//  Created by SSiOS on 11/4/19.
//  Copyright © 2019 unam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var nombreField: UITextField!
    @IBOutlet weak var apellidosField: UITextField!
    @IBOutlet weak var correoElectronicoField: UITextField!
    @IBOutlet weak var contraseña: UITextField!
    @IBOutlet weak var contraseñaRepetida: UITextField!
    
    var userUID = String()
    
    let ref = Database.database().reference(fromURL: "https://proyectofina-ef899.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registrarUsusario(_ sender: UIButton) {
        if(contraseña.text == contraseñaRepetida.text){
            guard let nameUser = nombreField.text, let lastNameUser = apellidosField.text, let emailUser = correoElectronicoField.text, let passUser = contraseña.text else{
                self.present(makeAlert(title: "Error", message: "No se lograron capturar correctamente los datos"), animated: true, completion: nil)
                return
            }
            
            createUser(name: nameUser, lastName: lastNameUser, email: emailUser, password: passUser)
        }else{
            self.present(makeAlert(title: "Las contraseñas no coinciden", message: "vuelve a escribir tu contraseña en ambos campos"), animated: true, completion: nil)
        }
    }
    
    func createUser(name: String, lastName: String, email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error{
                print(error)
            }else{
                
                self.userUID = result!.user.uid
                self.ref.child("user").child(self.userUID).updateChildValues(["name":name, "lastName":lastName, "email":email, "uid": result!.user.uid, "boxes" : []])
            
            }
            
            self.performSegue(withIdentifier: "goToSuccessViewFromRegist", sender: self)
        }
    }
}


