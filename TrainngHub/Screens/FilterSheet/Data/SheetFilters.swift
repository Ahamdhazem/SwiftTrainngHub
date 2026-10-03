//
//  SheetFilters.swift
//  TrainngHub
//
//  Created by LP Mackbook on 26/09/2026.
//

import Foundation

class SheetFilters{
    
    var firstFilterQurys = SelectedQuery()
    var secondFilterQuerys = SelectedQuery()
    
    init(_ firstFilterQurys: [SelectedItems], _ secondFilterQuerys: [SelectedItems]) {
        self.firstFilterQurys.querys = firstFilterQurys
        self.secondFilterQuerys.querys = secondFilterQuerys
    }
    init() {
        self.firstFilterQurys.querys = []
        self.secondFilterQuerys.querys = []
    }
}
