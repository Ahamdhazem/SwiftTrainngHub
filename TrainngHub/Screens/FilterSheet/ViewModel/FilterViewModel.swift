//
//  FilterViewModel.swift
//  TrainngHub
//
//  Created by LP Mackbook on 28/09/2026.
//

import Foundation
import UIKit
class FilterViewModel{
    
    var mode : SheetMode!
    //let materialTypes = ["All","B2B","E-Reload"]
    
    var  mainFilters : SheetFilters!
    var  reloadFilters : SheetFilters!

    func clearMainFilter(){
         mainFilters.firstFilterQurys.querys = []
    }
    func clearReloadFilter(){
        reloadFilters.firstFilterQurys.querys = []
        reloadFilters.secondFilterQuerys.querys = []
    }
    
    
//
//    func removeFromFirstQuery(_ index : IndexPath){
//        
//        sheetFilters.firstFilterQurys.querys = sheetFilters.firstFilterQurys.querys.filter{$0.indexpath != index}
//    }
//    func removeFromSecondQuery(_ index : IndexPath){
//        sheetFilters.secondFilterQuerys.querys = sheetFilters.secondFilterQuerys.querys.filter{$0.indexpath != index}
//    }
    
    //    func appendOnFilters(_ index : IndexPath,_ queryType:QueryType = QueryType.first){
    //        switch(mode){
    //        case .main:
    //             if materialTypes[index.item] == "All" {
    //                clearFirstFilter()
    //             }
    //             else {
    //                 sheetFilters.firstFilterQurys.querys.append( SelectedItems(materialTypes[index.item] , index))
    //             }
    //
    //        case .reload:
    //            if queryType == QueryType.first  {
    //            if(categories[index.item] == "All"){
    //                clearFirstFilter()
    //            }
    //                else {sheetFilters.firstFilterQurys.querys.append(
    //                SelectedItems(categories[index.item] , index)
    //                )}
    //           } else if(contentTypes[index.item] == "All"){
    //               sheetFilters.secondFilterQuerys.querys = []
    //           }
    //            else  {
    //
    //                sheetFilters.secondFilterQuerys.querys.append( SelectedItems(contentTypes[index.item] , index))
    //            }
    //
    //        case .none: print("none")
    //        }
    //
    //    }
    //}
    
    //case .reload : if collectionView === topCollection  {
    //    if(categories[indexPath.item] == "All"){
    //        sheetFilters.firstFilterQurys = []
    //    }
    //    else {sheetFilters.firstFilterQurys.append(
    //        SelectedItems(categories[indexPath.item] , indexPath)
    //        )}
    //} else if(contentTypes[indexPath.item] == "All"){
    //    sheetFilters.secondFilterQuerys = []
    //}
    //            else  {
    //
    //                sheetFilters.secondFilterQuerys!.append( SelectedItems(contentTypes[indexPath.item] , indexPath))
    //}
}
