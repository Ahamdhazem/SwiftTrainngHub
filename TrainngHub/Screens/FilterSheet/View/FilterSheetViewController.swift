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
     @IBOutlet var applyButton: CustemButton!
     @IBAction func ApplayingFilters(_ sender: Any) {
        delegate?.didSelectFilters()
         clearButton.style = "clear"
         applyButton.style = "primary"
        self.dismiss(animated: true)
    }

     @IBOutlet var clearButton: CustemButton!
     @IBAction func clearFilter(_ sender: Any) {
         clearButton.style = "primary"
         applyButton.style = "clear"
         sheetFilters.firstFilterQurys = []
         deselectAllItems(topCollection)
         topDefaultSelction()
         if(mode == .reload)
         {
             sheetFilters.secondFilterQuerys = []
             deselectAllItems(bottomCollection)
             bottomDefualSelection()
         }
     }
   
     
     let mode : SheetMode!
     let sheetHeight: CGFloat
     let materialTypes = ["All","B2B","E-Reload"]
     let categories = ["All","E-Voucher","Subscription"]
     let contentTypes = ["All","PDF File","Link", "Video"]
     
     
     var sheetFilters : SheetFilters!
     let defaultSelectionindex = IndexPath(item: 0, section: 0)
     init (mode :SheetMode , _ sheetFilters : SheetFilters,_ sheetHeight :CGFloat = 300){
         self.mode = mode
         self.sheetFilters = sheetFilters
         self.sheetHeight = sheetHeight
         super.init(nibName: nil, bundle: nil)
         
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     func deselectAllItems( _ collectionView: UICollectionView) {
         collectionView.indexPathsForSelectedItems?.forEach { indexPath in
             collectionView.deselectItem(at: indexPath, animated: true)
         }
     }
     func configerSelectedCell(){
         

         switch(self.mode){
         case  .main :  setSelectedCell(sheetFilters.firstFilterQurys  ,topCollection)
         case  .reload :
                        setSelectedCell(sheetFilters.firstFilterQurys  ,topCollection)
                        setSelectedCell(sheetFilters.secondFilterQuerys ?? [] ,bottomCollection)
                        
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

         view.clipsToBounds = true
         topCollection.allowsMultipleSelection = true;
         bottomCollection.allowsMultipleSelection = true
         CellResjstration()
         topCollection.reloadData()
         bottomCollection.reloadData()
         topDefaultSelction()
         bottomDefualSelection()
         configerSelectedCell()

     }
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()

         view.layer.cornerRadius = view.bounds.height / 9
         view.layer.maskedCorners = [
             .layerMinXMinYCorner,
             .layerMaxXMinYCorner
         ]
     }
         override func viewWillAppear(_ animated: Bool){
             super.viewWillAppear(animated)
             topDefaultSelction()
             bottomDefualSelection()

         }

     

    
    

     func topDefaultSelction(){
         
         if(sheetFilters.firstFilterQurys.isEmpty){
             topCollection.selectItem(at: defaultSelectionindex, animated: false, scrollPosition: [])}
         
     }
    func bottomDefualSelection(){
        
        if ( self.mode == .reload && (sheetFilters.secondFilterQuerys ?? []).isEmpty){
            bottomCollection?.selectItem(at: defaultSelectionindex, animated: false, scrollPosition: [])
        }}
    

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
            
        case .reload:
                    if collectionView == topCollection {
                        return categories.count
                    } else {

                      return   contentTypes.count
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
           
        case .main : sheetFilters.firstFilterQurys = sheetFilters.firstFilterQurys.filter{$0.indexpath != indexPath}
            
        case .reload : if collectionView === topCollection  {
            sheetFilters.firstFilterQurys = sheetFilters.firstFilterQurys.filter{$0.indexpath != indexPath}
        } else {sheetFilters.secondFilterQuerys = sheetFilters.secondFilterQuerys!.filter{$0.indexpath != indexPath}}
       
        case .none:
            print("none")
        }

         
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(mode){
           
        case .main :  if(materialTypes[indexPath.item] == "All") {sheetFilters.firstFilterQurys=[]} else { sheetFilters.firstFilterQurys.append( SelectedItems(materialTypes[indexPath.item] , indexPath)) }
            
        case .reload : if collectionView === topCollection  {
            if(categories[indexPath.item] == "All"){
                sheetFilters.firstFilterQurys = []
            }
            else {sheetFilters.firstFilterQurys.append(
                SelectedItems(categories[indexPath.item] , indexPath)
                )}
        } else if(contentTypes[indexPath.item] == "All"){
            sheetFilters.secondFilterQuerys = []
        }
                    else  {
                       
                        sheetFilters.secondFilterQuerys!.append( SelectedItems(contentTypes[indexPath.item] , indexPath))
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
            
            var width : CGFloat!
            switch(mode){
                
            case .main:
                 width = (collectionView.bounds.width - 20) / CGFloat(materialTypes.count)
            case .reload: if(collectionView==topCollection){
                 width = (collectionView.bounds.width - 20) / CGFloat(categories.count)
            }else{
                width = (collectionView.bounds.width - 50) / CGFloat(contentTypes.count)}
            case .none:
                print("")
            }
            return CGSize(width: width, height: 50)}

        
        
        
    }

protocol  OnSheetDismisedDelegate : AnyObject {
    
    func didSelectFilters()
}
extension FilterSheetViewController: UIViewControllerTransitioningDelegate {

    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {

        // Return the presentation controller with the custom height
        return BottomSheetPresentationController(
            presentedViewController: presented,
            presenting: presenting,
            height: sheetHeight
        )
    }
}
