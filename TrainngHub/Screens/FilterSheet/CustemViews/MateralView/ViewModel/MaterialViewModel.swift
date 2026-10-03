//
//  MaterialViewModel.swift
//  TrainngHub
//
//  Created by LP Mackbook on 28/09/2026.
//

import Foundation
import UIKit
class MaterialViewModel{
    let materialType = ["All","B2B","E-Reload"]
    var tempSelection : [SelectedItems]!
    var sheetFilters :SheetFilters!
    
    init(_ filteQuerys: SheetFilters) {
        tempSelection = filteQuerys.firstFilterQurys.querys
        self.sheetFilters = filteQuerys
    }
    
    func appendQuery(_ indexPath:IndexPath){
        tempSelection.append(SelectedItems(materialType[indexPath.item],indexPath))

    }
    func removeQuery(_ indexPath:IndexPath){
     //   filteQuerys.append(SelectedItems(materialType[indexPath.item],indexPath))
        tempSelection = tempSelection.filter{$0.indexpath != indexPath}
        print(tempSelection.count)
    }
    func clearFilter(){
        tempSelection = []
    }
    
    func onApplayTap(){
        sheetFilters.firstFilterQurys.querys = tempSelection
   
    }
    func onClearTap(){
        
        sheetFilters.firstFilterQurys.querys = []
   
    }
}
