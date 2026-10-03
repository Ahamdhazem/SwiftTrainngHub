//
//  ReloadFilterViewModel.swift
//  TrainngHub
//
//  Created by LP Mackbook on 02/10/2026.
//

import Foundation
import UIKit

class ReloadFilterViewModel {
    let categories = ["All","E-Voucher","Subscription"]
    let contentTypes = ["All","PDF File","Link", "Video"]
    var tempsheetFilters : SheetFilters!
    var sheetFilters :SheetFilters!
    
    init(_ sheetFilters: SheetFilters) {
        tempsheetFilters = sheetFilters
        self.sheetFilters = sheetFilters
    }
    
    func appendCategory(_ indexPath:IndexPath){
        tempsheetFilters.firstFilterQurys.querys.append(SelectedItems(categories[indexPath.item],indexPath))

    }
    func appendContent(_ indexPath:IndexPath){
        tempsheetFilters.secondFilterQuerys.querys.append(SelectedItems(contentTypes[indexPath.item],indexPath))

    }
    
    func removeCategory(_ indexPath:IndexPath){
        tempsheetFilters.firstFilterQurys.querys =   tempsheetFilters.firstFilterQurys.querys.filter{$0.indexpath != indexPath}
  
    }
    func removeConTent(_ indexPath:IndexPath){
        tempsheetFilters.secondFilterQuerys.querys =   tempsheetFilters.secondFilterQuerys.querys.filter{$0.indexpath != indexPath}
    }
    func clearCategoris(){
        tempsheetFilters.firstFilterQurys.querys = []

    }
    func clearContents(){

        tempsheetFilters.secondFilterQuerys.querys = []
    }
    
    func onApplayTap(){
        sheetFilters = tempsheetFilters
   
    }
    func onClearTap(){
        
        tempsheetFilters.firstFilterQurys.querys = []
        tempsheetFilters.secondFilterQuerys.querys = []
   
    }
}
