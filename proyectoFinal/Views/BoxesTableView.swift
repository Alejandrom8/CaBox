//
//  BoxesTableView.swift
//  proyectoFinal
//
//  Created by SSiOS on 11/29/19.
//  Copyright © 2019 unam. All rights reserved.
//

import UIKit

class BoxesTableView: UITableViewController {
    
    
    var user: User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.user.boxes.append(Box(id: "box143", title: "Cocina"))
        self.user.boxes.append(Box(id: "box263", title: "Oficina"))
        self.user.boxes.append(Box(id: "box152", title: "Jardin"))
        self.user.boxes.append(Box(id: "box195", title: "Cuarto de los niños"))
        self.user.boxes.append(Box(id: "box953", title: "Cuarto de lavado"))
        self.user.boxes.append(Box(id: "box732", title: "Sala principal"))
        self.user.boxes.append(Box(id: "box243", title: "Cochera"))

//        let boxReference = self.ref.child("user").child(self.currentUserID)
//        var counter = 10
//
//        boxReference.queryOrdered(byChild: "boxes").queryLimited(toLast: UInt(counter)).observe(.childAdded, with: { (snapshot) in
//            let boxes = snapshot.children
//            self.user.boxes.append(Box(id: "box143", title: "Cocina"))
//            counter -= 1
//            if counter <= 0 {
//                print(self.user.boxes)
//            }
//        })
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.user.boxes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "box", for: indexPath)

        let box = self.user.boxes[indexPath.row]
        cell.textLabel?.text = box.title
        cell.detailTextLabel?.text = box.id
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
