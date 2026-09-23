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
    
    func materialFilter(_ queris : [String] ){
        
        let cleanQuris = queris.map {item in item.lowercased()}
        print("cleanQuris \(cleanQuris)")
        
        if(queris.count<=0){
            filteredData = data
        }else
        if(queris[0] == "all" || queris[0].isEmpty ){
            filteredData = data
            return
        }else if(queris.count==1){ // Search bar
            filteredData = data.filter{
                $0.MaterialType.lowercased().hasPrefix(queris[0])
            }
        }
        else  {
           
            filteredData = data.filter{// filter Sheet more Than one type
                cleanQuris.contains($0.MaterialType.lowercased())
            }
           
        }

    }
}
