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
     @IBOutlet var clearButton: CustemButton!
     @IBOutlet var filtersStack: UIStackView!
     
     weak var delegate : OnSheetDismisedDelegate?
     let mode : SheetMode!
     let sheetHeight: CGFloat
     let viewModel = FilterViewModel()


     let defaultSelectionindex = IndexPath(item: 0, section: 0)
     
     init (mode :SheetMode , _ sheetFilters : SheetFilters,_ sheetHeight :CGFloat = 1000){
         self.mode = mode
         viewModel.mainFilters = sheetFilters
         viewModel.reloadFilters = sheetFilters
         viewModel.mode = mode
         self.sheetHeight = sheetHeight
         super.init(nibName: nil, bundle: nil)
         
     }
     
     
      var materialView: MaterialView?
      var reloadFilterView: ReloadFilterView?

         override func viewDidLoad() {
             super.viewDidLoad()
             addingTheCustemView()
         }
     
     func addingTheCustemView(){
         switch(mode){
         case .main: addMatiralView()
         case .reload:addReloadFilterView()
         case .none:
             print("none")

         }
     }
     
     func addMatiralView(){
         guard let view = Bundle.main.loadNibNamed(
             "MaterialView",
             owner: nil,
             options: nil
         )?.first as? MaterialView else {
             return
         }

         materialView = view

         materialView?.viewModel =
             MaterialViewModel(self.viewModel.mainFilters)

         if let materialView {
             filtersStack.addArrangedSubview(materialView)
         }
     }

     var sheetFilters = SheetFilters()
     
     func addReloadFilterView(){

         guard let view = Bundle.main.loadNibNamed("ReloadFilterView", owner: nil, options: nil)?.first as? ReloadFilterView else {
             return
         }
         reloadFilterView = view

         reloadFilterView?.viewModel = ReloadFilterViewModel(self.viewModel.reloadFilters)

         if let reloadFilterView {
             filtersStack.addArrangedSubview(reloadFilterView)
         }
     }
     
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()

         view.layer.cornerRadius = view.bounds.height / 9
         view.layer.maskedCorners = [
             .layerMinXMinYCorner,
             .layerMaxXMinYCorner
         ]
         
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     


     @IBAction func ApplayingFilters(_ sender: Any) {
         switch(mode){
         case .main: materialView?.viewModel.onApplayTap()
         case .reload: reloadFilterView?.viewModel.onApplayTap()
         case .none: print("none")
         }
        delegate?.didSelectFilters()
         
         clearButton.style = "clear"
         applyButton.style = "primary"
         self.dismiss(animated: true)
    }

     
     
     @IBAction func closeButton(_ sender: Any) {
         dismiss(animated: true)
     }
     @IBAction func clearFilter(_ sender: Any) {
         clearButton.style = "primary"
         applyButton.style = "clear"
         viewModel.clearMainFilter()
         switch(mode){
         case .main:  materialView?.viewModel.onClearTap()
         case .reload: reloadFilterView?.viewModel.onClearTap()
         case .none: print("none")
         }

        delegate?.didSelectFilters()
         self.dismiss(animated: true)
     }
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
