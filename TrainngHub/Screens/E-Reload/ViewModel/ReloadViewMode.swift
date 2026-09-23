//
//  ReloadViewMode.swift
//  TrainngHub
//
//  Created by LP Mackbook on 20/09/2026.
//

import Foundation
class ReloadViewMode {
    let reloads : [Reload] = [
        Reload("E-Voucher","PDF File","document.viewfinder.fill"),
        Reload("E-Voucher","Video","movieclapper"),
        Reload("E-Voucher","Link","link"),
        Reload("Subscription","PDF File","document.viewfinder.fill"),
        Reload("Subscription","Video","movieclapper"),
        Reload("Subscription","Link","link"),
        
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
    
    
    
    private   func cateogryFilter(_ query : String ){
        
        if query.isEmpty || query == "all" {
            filteredReloads = reloads
        } else {
            print(query)
            filteredReloads = filteredReloads.filter { $0.category.lowercased().hasPrefix(query) }
            
        }
    }
    
    private func contentFilter(_ query : String ){
        if query.isEmpty || query == "all" {
            filteredReloads = reloads
        } else {
            print(query)
            filteredReloads = filteredReloads.filter { $0.typeContent.lowercased().hasPrefix(query) }
            
        }
    }
    
    func filter(_ categois : [String] , _ contentTypes : [String]){
        print("From filter funcation")
        print("\(categois)  \(contentTypes)")
        
        let categoryQuery = categois.map{$0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()}
        let contentQuery = contentTypes.map{$0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()}
        
 
        var isCategorisEmtpy = categoryQuery.isEmpty
        var isContentEmtpy = contentQuery.isEmpty
        
        if(isCategorisEmtpy && isContentEmtpy){
            filteredReloads = reloads
        }else if(!isCategorisEmtpy && !isContentEmtpy){
            
            filteredReloads = reloads.filter({
                (                categoryQuery.contains($0.category.lowercased()) &&
                                 contentQuery.contains($0.typeContent.lowercased()))
            })
        } else if(isCategorisEmtpy){
            filteredReloads = reloads.filter({
                contentQuery.contains($0.typeContent.lowercased())
            })
        } else {
            filteredReloads = reloads.filter{
                categoryQuery.contains($0.category.lowercased())}
            
        }

        }
    }

