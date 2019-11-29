//
//  SuccessViewController.swift
//  proyectoFinal
//
//  Created by SSiOS on 11/4/19.
//  Copyright © 2019 unam. All rights reserved.
//

import UIKit
import Firebase
import TensorFlowLite

class SuccessViewController: UIViewController,
                             UIImagePickerControllerDelegate,
                             UINavigationControllerDelegate{
    

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var LeadingConstrain: NSLayoutConstraint!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var imageToAnalize: UIImageView!
    @IBOutlet weak var boxName: UITextField!
    
    var currentUser: User = User()
    
    var menuShowing = false
    
    var userName: Any = ""
    var userLastName: String = String()
    var userEmail: Any = ""
    var currentUserUID: String = String()
    var ref: DatabaseReference! //Firebase reference
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.ref = Database.database().reference()
        let userUID = Auth.auth().currentUser?.uid
        self.currentUserUID = String(userUID!)
        
        ref.child("user").child(userUID!).observeSingleEvent(of: .value) { (snapshot) in
            let user = snapshot.childSnapshot(forPath: "name").value
            let email = snapshot.childSnapshot(forPath: "email").value
            self.currentUser.name = user as! String
            self.currentUser.email = email as! String
            
            self.emailLabel.text = "Email: \(email ?? "email") Usuario: \(user ?? "usuario")"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myView.layer.masksToBounds = false
        LeadingConstrain.constant = -270
    }
    
    @IBAction func openMenu(_ sender: Any) {
        if menuShowing {
            LeadingConstrain.constant = -270
            UIView.animate(withDuration: 0.2,delay:0.0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            })
        }else{
            LeadingConstrain.constant = 0
            UIView.animate(withDuration: 0.2,delay:0.0, options: .curveEaseIn, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        menuShowing = !menuShowing
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let actionSheet = UIAlertController(title: "Seleccióna una imagen", message: "Asegurate de que la imagen contenga texto.", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camara", style: .default){ (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.present(imagePicker, animated: true, completion: nil)
            }else {
                self.present(makeAlert(title: "Error", message: "No tienes una camara"), animated: true, completion: nil)
            }
        })
        
        actionSheet.addAction(UIAlertAction(title: "Galeria", style: .default){ (action: UIAlertAction) in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        })
        
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageToAnalize.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "sendToItemsView"{
            let BID = makeRandomId()
            let finalBoxID: String = "box" + BID as String
            var boxTitle: String = String()
            
            if self.boxName.text == ""{
                self.present(makeAlert(title: "No le has colocado un identificador a tu caja", message: "Ponle un nombre a tu caja, ejemplo: Sala, Comedor, etc."), animated: true, completion: nil)
            } else {
                boxTitle = self.boxName.text!
            }
            
            let newBox = Box(id: finalBoxID, title: boxTitle)
            
            guard let nextView = segue.destination as? ItemsView else { return }
            nextView.box = newBox
        }
    }
}
