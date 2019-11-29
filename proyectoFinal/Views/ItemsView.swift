//
//  ItemsView.swift
//  proyectoFinal
//
//  Created by SSiOS on 11/27/19.
//  Copyright © 2019 unam. All rights reserved.
//

import UIKit
import Firebase

class ItemsView: UIViewController,
                 UITableViewDelegate,
                 UITableViewDataSource{
    
    var box: Box?

    @IBOutlet weak var itemLabel: UITextField!
    @IBOutlet weak var table: UITableView!
    
    let ref = Database.database().reference(fromURL: "https://proyectofina-ef899.firebaseio.com/")
    var currentUserID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            self.currentUserID = String((Auth.auth().currentUser?.uid)!)
            checkBoxPropertie()
        }else{
            self.performSegue(withIdentifier: "redirectToHomeView", sender: self)
        }
        
        //añadir todos los elementos que tiene la propiedad items de la caja en la tabla
    }
    
    func createBoxFireBase(title: String = "", boxId: String = ""){
        self.ref.child("user")
            .child(self.currentUserID!)
            .child("boxes")
            .updateChildValues([boxId: ["title": title]])
        let alerta = makeAlert(title: "Caja añadida", message: "La caja \(title) fue añadida a tu lista")
        self.present(alerta, animated: true, completion: nil)
    }
    
    func checkBoxPropertie(){
        if box != nil{
            createBoxFireBase(title: self.box!.title, boxId: self.box!.id)
        }
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        if self.itemLabel.text == ""{
            self.present(makeAlert(title: "No has escrito ningún elemento", message: "🤨"), animated: true, completion: nil)
        }else{
            
            let id: String = "item\(makeRandomId())"
            let newItem = [id: self.itemLabel.text!]
            self.box!.addItem(item: self.itemLabel.text!)
            
            self.ref.child("user")
                .child(self.currentUserID)
                .child("boxes")
                .child(self.box!.id)
                .child("items")
                .updateChildValues(newItem)
            
            let indexPath = IndexPath(row: self.box!.items.count - 1, section: 0)
            
            self.table.beginUpdates()
            self.table.insertRows(at: [indexPath], with: .fade)
            self.table.endUpdates()
            
            self.itemLabel.text = ""
            view.endEditing(true)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.box!.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        let item = self.box!.items[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            self.box!.items.remove(at: indexPath.row)
            self.table.beginUpdates()
            self.table.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
            self.table.endUpdates()
        }
    }
}
