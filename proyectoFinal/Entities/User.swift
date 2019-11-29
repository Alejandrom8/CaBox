//
//  User.swift
//  proyectoFinal
//
//  Created by SSiOS on 11/21/19.
//  Copyright © 2019 unam. All rights reserved.
//

import Foundation

struct User{
    var name: String
    var lastName: String
    var email: String
    var uid: String
    var boxes: [Box]
    
    init(){
        self.name = String()
        self.lastName = String()
        self.email = String()
        self.uid = String()
        self.boxes = [ Box() ]
    }
    
    init(name: String, lastName: String, email: String, uid: String, boxes: [Box]){
        self.name = name
        self.lastName = lastName
        self.email = email
        self.uid = uid
        self.boxes = boxes
    }
}
