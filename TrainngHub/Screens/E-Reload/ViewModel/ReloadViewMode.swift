//
//  ReloadViewMode.swift
//  TrainngHub
//
//  Created by LP Mackbook on 20/09/2026.
//

import Foundation
class ReloadViewMode {
    let reloads : [Reload] = [
                              Reload("E-Voucher","PDF    File","document.viewfinder.fill"),
                              Reload("E-Voucher","Video","movieclapper"),
                              Reload("E-Voucher","like","link"),
                              Reload("Subscription","PDF File","document.viewfinder.fill"),
                              Reload("Subscription","Video","movieclapper"),
                              Reload("Subscription","like","link"),
    
    ]
    
    lazy var filteredReloads :[Reload] =  self.reloads
    
    func reloadsFilter(_ searchText : String , _ filteringOn : String){
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        switch(filteringOn){
            
        case "category":cateogryFilter(query)
        case "content":contentFilter(query)
        default:print("default")
        }
        
    }
    
    func cateogryFilter(_ query : String ){
        if query.isEmpty {
            filteredReloads = reloads
        } else {
            filteredReloads = reloads.filter { $0.category.lowercased().hasPrefix(query) }
        }
    }
    
    func contentFilter(_ query : String ){
        
    }
}
