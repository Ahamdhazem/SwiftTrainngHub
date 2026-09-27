//
//  ReloadViewMode.swift
//  TrainngHub
//
//  Created by LP Mackbook on 20/09/2026.
//

import Foundation
class ReloadViewModel {
    
    var selectedCategoris : [SelectedItems]!
    var selectedContentTyps : [SelectedItems]!
    var sheetFilter   : SheetFilters!
    
    init () {
        selectedCategoris = []
        selectedContentTyps = []
         sheetFilter = SheetFilters(selectedCategoris,selectedContentTyps)
    }
    
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
    
    func filter(){
        
        let categoryQuery = sheetFilter.firstFilterQurys.map{$0.text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()}
        
        
        let contentQuery = (sheetFilter.secondFilterQuerys ?? []).map{$0.text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()}
        
 
        let isCategorisEmtpy = categoryQuery.isEmpty
        let isContentEmtpy = contentQuery.isEmpty
        
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

//AI Viersion
//
//func filter() {
//    // 1. Convert queries to Sets for O(1) fast lookup
//    let categorySet = Set(sheetFilter.firstFilterQurys.map {
//        $0.text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
//    })
//    
//    let contentSet = Set((sheetFilter.secondFilterQuerys ?? []).map {
//        $0.text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
//    })
//
//    // 2. Filter in a single, readable pass
//    filteredReloads = reloads.filter { item in
//        let matchesCategory = categorySet.isEmpty || categorySet.contains(item.category.lowercased())
//        let matchesContent = contentSet.isEmpty || contentSet.contains(item.typeContent.lowercased())
//        
//        return matchesCategory && matchesContent
//    }
//}
