//
//  FilterSheetViewController.swift
//  TrainngHub
//
//  Created by LP Mackbook on 15/09/2026.
//

import UIKit


 class FilterSheetViewController: UIViewController {
    @IBOutlet var topCollection: UICollectionView!
    @IBOutlet var bottomCollection: UICollectionView!
    @IBOutlet var firstFilterLabel: UILabel!
    @IBOutlet var ContentTypeStack: UIStackView!
    @IBOutlet var secondFilterLabel: UILabel!
    @IBAction func ApplayingFilters(_ sender: Any) {
        delegate?.didSelectFilters(firstFilterOptions, secondFilterOptions)
        self.dismiss(animated: true)
    }
     let viewModel : FilterSheetViewModel!
     let mode : SheetMode!
     
     let materialTypes = ["All","B2B","E-Reload"]
     let categories = ["All","E-Voucher","Subscription"]
     let contentTypes = ["All","PDF File","Link", "Video"]
     
     var firstFilterOptions  : [SelectedItems] = []{
        didSet{
            if(firstFilterOptions.isEmpty){
                topDefaultSelction()

            }
            switch(mode){
                
            case .main:
                MainFilterViewModel.firstFilterIndex = firstFilterOptions
            case .reload:
                ReloadFilterViewModel.firstFilterIndex = firstFilterOptions
            case .none:
                print("none")
            }
         
        }
    }
    var secondFilterOptions :[SelectedItems] = [] {
        didSet{
            if(secondFilterOptions.isEmpty){
                bottomDefualSelection()
            }
                ReloadFilterViewModel.secondFilterIndex = secondFilterOptions
       
        }
    }

     let defaultSelectionindex = IndexPath(item: 0, section: 0)
     init (mode :SheetMode){
         self.mode = mode
         
         
         switch(mode){
         case .main: viewModel = MainFilterViewModel()
             self.firstFilterOptions = MainFilterViewModel.firstFilterIndex
         case .reload: viewModel = ReloadFilterViewModel()
             self.firstFilterOptions = ReloadFilterViewModel.firstFilterIndex
             self.secondFilterOptions = ReloadFilterViewModel.secondFilterIndex
         }
         super.init(nibName: nil, bundle: nil)
         
         
         
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func configerSelectedCell(){
         

         switch(self.mode){
         case  .main :  setSelectedCell(firstFilterOptions  ,topCollection)
         case  .reload :
                        setSelectedCell(firstFilterOptions ,topCollection)
                        setSelectedCell(secondFilterOptions ,bottomCollection)
                        
         case .none:
             print("none")
         }
     }
      
     func setSelectedCell(_ items : [SelectedItems] , _ collection : UICollectionView){
         
         for i in items  {
             collection.selectItem(at: i.indexpath, animated: true, scrollPosition:[])
         }
         
     }
     
     

     
     override func viewDidLoad() {
         super.viewDidLoad()

         topCollection.allowsMultipleSelection = true;
         bottomCollection.allowsMultipleSelection = true
         CellResjstration()
         topCollection.reloadData()
         bottomCollection.reloadData()
         topDefaultSelction()
         bottomDefualSelection()
         configerSelectedCell()
     }
     

     

    
    

    func bottomDefualSelection(){
        
        if ( self.mode == .reload && secondFilterOptions.isEmpty){
            bottomCollection?.selectItem(at: defaultSelectionindex, animated: false, scrollPosition: [])
        }}
    
    func topDefaultSelction(){
        
        if(firstFilterOptions.isEmpty){
        topCollection.selectItem(at: defaultSelectionindex, animated: false, scrollPosition: [])}
        else {
            
        }
    }
    func CellResjstration(){
        let nib = UINib(nibName: "FilterCell", bundle: nil)
        
        topCollection.register(nib, forCellWithReuseIdentifier: FilterCell.identifier)
        bottomCollection.register(nib, forCellWithReuseIdentifier: FilterCell.identifier)
        
        if self.mode == .main {
            firstFilterLabel.text = "Material Type"
           ContentTypeStack.isHidden = true
        }
    }

    weak var delegate : OnSheetDismisedDelegate?
    

}

extension FilterSheetViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(mode){
        case .main : if collectionView === topCollection {
                            return materialTypes.count
                        } else {
                            return 0
                        }
            
        case .reload : if collectionView === topCollection {
            return categories.count
        } else  {
            return contentTypes.count
        }
        case .none:
            return 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCell.identifier, for: indexPath) as! FilterCell
        switch(mode){
        case .main : if collectionView === topCollection {
            cell.configer(materialTypes[indexPath.row])
                        } else {
                            cell.configer(materialTypes[indexPath.row])
                        }
            
        case .reload : if collectionView === topCollection {
            cell.configer(categories[indexPath.row])
        } else  {
            cell.configer(contentTypes[indexPath.row])
        }
        case .none:
           print("none")
        }
            return cell
    }
}

func settopCollectionDefultSelection(){
    
}

extension FilterSheetViewController : UICollectionViewDelegate{
    

    
     func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        switch(mode){
           
        case .main : firstFilterOptions = firstFilterOptions.filter{$0.indexpath != indexPath}
            
        case .reload : if collectionView === topCollection  {
            firstFilterOptions = firstFilterOptions.filter{$0.indexpath != indexPath}
        } else { secondFilterOptions = secondFilterOptions.filter{$0.indexpath != indexPath}}
       
        case .none:
            print("none")
        }

         
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(mode){
           
        case .main :  if(materialTypes[indexPath.item] == "All") {firstFilterOptions=[]} else { firstFilterOptions.append( SelectedItems(materialTypes[indexPath.item] , indexPath)) }
            
        case .reload : if collectionView === topCollection  {
            if(categories[indexPath.item] == "All"){
                firstFilterOptions = []
            }
            else {firstFilterOptions.append(
                SelectedItems(categories[indexPath.item] , indexPath)
                )}
        } else if(contentTypes[indexPath.item] == "All"){
            secondFilterOptions = []
        }
                    
                    else  {
                       
            secondFilterOptions.append( SelectedItems(contentTypes[indexPath.item] , indexPath))
        }
        case .none:
            print("none")
        }
        
        
        let selectedIndex :Int = indexPath.item

            if selectedIndex == 0 {

                // Deselect other cells
                for indexPath in collectionView.indexPathsForSelectedItems ?? [] {
                    if indexPath.item != 0 {
                        collectionView.deselectItem(
                            at: indexPath,
                            animated: true
                        )
                    }
                }

            } else {

                collectionView.deselectItem(
                    at: IndexPath(item: 0, section: 0),
                    animated: true
                )
            }
        
 
    }
        

        
    }
    
    extension FilterSheetViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
            return CGSize(width: 120, height: 50)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 0
            }
        
        
        
    }

protocol  OnSheetDismisedDelegate : AnyObject {
    
    func didSelectFilters( _ firstQueris:[SelectedItems],_ secondQueris:[SelectedItems])
}
