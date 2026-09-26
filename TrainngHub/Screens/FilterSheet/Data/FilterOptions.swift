//
//  FilterOptions.swift
//  TrainngHub
//
//  Created by LP Mackbook on 24/09/2026.
//

import Foundation

class SelectedItems{
    
    var text : String!
    var indexpath : IndexPath!
    
    init(_ text:String){
        self.text = text
    }
    
    init(_ text:String , _ indexpath : IndexPath){
        self.text = text
        self.indexpath = indexpath
    }
}
