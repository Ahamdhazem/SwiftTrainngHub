

import Foundation
import UIKit
class ReloadFilterView : UIView{
    
    @IBOutlet var categorisCollectin: FilterCollectionView!
    @IBOutlet var contentsCollectin: FilterCollectionView!
    
    var viewModel : ReloadFilterViewModel!{
        didSet{
            categorisCollectin.reloadData()
            contentsCollectin.reloadData()
            restoreSelection()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        cellRegistration()
        restoreSelection()
    }
    private func setupCollectionView() {
        
        categorisCollectin.dataSource = self
        categorisCollectin.delegate = self
        contentsCollectin.dataSource = self
        contentsCollectin.delegate = self

        categorisCollectin.allowsMultipleSelection = true
        contentsCollectin.allowsMultipleSelection = true
    }
   
     func cellRegistration() {

        let nib = UINib(
            nibName: "FilterCell",
            bundle: nil
        )

        categorisCollectin.register(
            nib,
            forCellWithReuseIdentifier: FilterCell.identifier
        )
         
        contentsCollectin.register(
            nib,
            forCellWithReuseIdentifier: FilterCell.identifier
        )
    }

    
    func restoreSelection() {

        guard let viewModel = viewModel else {return }
        let categorisIndexPaths = viewModel.tempsheetFilters.firstFilterQurys.querys.map {
           $0.indexpath
       }
        let contentsIndexPaths = viewModel.tempsheetFilters.secondFilterQuerys.querys.map  {
           $0.indexpath
       }
        categorisCollectin.restoreSelection(categorisIndexPaths as! [IndexPath])
        contentsCollectin.restoreSelection(contentsIndexPaths as! [IndexPath])
    }
}



extension ReloadFilterView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == categorisCollectin){
            viewModel.categories.count
        }else {
            viewModel.contentTypes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FilterCell.identifier,
            for: indexPath
        ) as! FilterCell

        if collectionView == categorisCollectin{ cell.configer(viewModel.categories[indexPath.item])}
        else {
            cell.configer(viewModel.contentTypes[indexPath.item])
        }

        return cell
        
    }
}

extension ReloadFilterView : UICollectionViewDelegate{
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        
        if indexPath.item == 0 {
            if(collectionView == categorisCollectin){
                viewModel.clearCategoris()
            }else{
                viewModel.clearContents()
            }
            
            
        }
        else {
            if collectionView == categorisCollectin{
                viewModel.appendCategory(indexPath)
            }else{
                viewModel.appendContent(indexPath)
            }
        }
        
        
        if(collectionView == categorisCollectin){
            categorisCollectin.handleSelection(at: indexPath)}
        else {
            contentsCollectin.handleSelection(at: indexPath)}
    }
    
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        
        
        if collectionView == categorisCollectin{
            viewModel.removeCategory(indexPath)
            if viewModel.tempsheetFilters.firstFilterQurys.querys.isEmpty{
                categorisCollectin.selectDefault()
            }
        }else{
            viewModel.removeConTent(indexPath)
            if viewModel.tempsheetFilters.secondFilterQuerys.querys.isEmpty{
                contentsCollectin.selectDefault()
            }
        }
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        shouldDeselectItemAt indexPath: IndexPath
    ) -> Bool {
        
        
        
        if indexPath.item == 0 {
            
            return false
        }
        
        return true
    }
}


extension ReloadFilterView : UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
//textWidth + horizontalPadding,
        let text: String
                if collectionView == categorisCollectin {
                    text = viewModel.categories[indexPath.item]
                } else {
                    text = viewModel.contentTypes[indexPath.item]
                }
        let font = UIFont.systemFont(ofSize: 15)
        let textWidth = (text as NSString).size(withAttributes: [.font: font]).width
        return CGSize(width: textWidth + 50, height: 50)
    }
    
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        minimumInteritemSpacingForSectionAt section: Int
//    ) -> CGFloat {
//        return 1
//    }





    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {

        return 2
    }


    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {

        return UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 40
        )
    }
    
    
}
