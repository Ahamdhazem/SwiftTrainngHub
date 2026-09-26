//
//  SheetFilters.swift
//  TrainngHub
//
//  Created by LP Mackbook on 26/09/2026.
//

import Foundation

class SheetFilters{
    
    var firstFilterQurys : [SelectedItems]  = []
    var secondFilterQuerys : [SelectedItems]?
    
    init(_ firstFilterQurys: [SelectedItems], _ secondFilterQuerys: [SelectedItems]? = nil) {
        self.firstFilterQurys = firstFilterQurys
        self.secondFilterQuerys = secondFilterQuerys
    }
}
