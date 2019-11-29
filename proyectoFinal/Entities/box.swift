//
//  box.swift
//  proyectoFinal
//
//  Created by SSiOS on 11/21/19.
//  Copyright © 2019 unam. All rights reserved.
//

import Foundation

struct Box{
    var id: String
    var title: String
    var items: [String]
    
    init(){
        self.id = String()
        self.title = String()
        self.items = []
    }
    
    init(id: String, title: String){
        self.id = id
        self.title = title
        self.items = []
    }
    
    init(id: String, title: String, items: [String]){
        self.id = id
        self.title = title
        self.items = items
    }
    
    mutating func addItem(item: String){
        self.items.append(item)
    }
}
