//
//  MainCellViewModel.swift
//  TrainngHub
//
//  Created by LP Mackbook on 21/09/2026.
//

import Foundation

class MainViewModel{
    let data : [MainData] =
    [
        MainData("E-reload"),
        MainData("E-reload"),
        MainData("E-reload"),
        MainData("B2B"),
        MainData("B2B"),
        MainData("C2B"),
        MainData("C2B"),
   
        
    ]
    
    lazy var filteredData = data
    
    func materialFilter(_ queris : [SelectedItems] ){
        if(queris.isEmpty || queris[0].text.lowercased() == "all" ){
            filteredData = data
            return
        }
        
        let cleanQuris = queris.map {item in item.text.lowercased()}
        print("cleanQuris \(cleanQuris)")
        

           
        filteredData = data.filter { item in
            cleanQuris.contains { q in
                item.MaterialType.lowercased().hasPrefix(q.lowercased())
            }
        

           
        }

    }
}
