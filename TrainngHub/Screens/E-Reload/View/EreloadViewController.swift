//
//  EreloadViewController.swift
//  TrainngHub
//
//  Created by LP Mackbook on 20/09/2026.
//

import UIKit



class EreloadViewController: UIViewController {
    @IBOutlet var searchStack: UIStackView!
    @IBOutlet var tabelView: UITableView!
    
    @IBOutlet var imageContainter: CustemView!
    @IBOutlet var searchFeaild: UITextField!

    @IBAction func onSearch(_ sender: Any) {
        //print(searchFeaild.text ?? "nil")
        ViewModel.reloadsFilter(searchFeaild.text ?? "","category")
        tabelView.reloadData()
        
        
    }
    
    @IBAction func onFilterTap(_ sender: Any) {
            
        let sheetVC = FilterSheetViewController( mode: .reload)
            if let sheet = sheetVC.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.prefersEdgeAttachedInCompactHeight = true
                    sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 24
             }
            sheetVC.delegate = self
            present(sheetVC, animated: true)

    
    }
    

    
    let ViewModel = ReloadViewMode()
    override func viewDidLoad() {
        super.viewDidLoad()
        cellRejester()
        searchStack.layer.cornerRadius = searchStack.bounds.height / 2
        imageContainter.layer.cornerRadius = imageContainter.bounds.height / 2
    }

    func cellRejester(){
        let nib = UINib(nibName: "EreloadCell", bundle: nil)
        tabelView.register(nib, forCellReuseIdentifier: "EreloadCell")
    }
  

}

extension EreloadViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ViewModel.filteredReloads.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EreloadCell", for: indexPath) as! EreloadCell
        
        cell.configer(ViewModel.filteredReloads[indexPath.row])
        return cell
    }
    
    
}
//func reloadsFilter(_ searchText : String , _ filteringOn : String){
extension EreloadViewController :OnSheetDismisedDelegate{
    func didSelectFilters(_ category: [String], _ typeContent: [String]) {
      print("category: \(category) , content: \(typeContent)")
//        ViewModel.reloadsFilter(typeContent,"content")
//        ViewModel.reloadsFilter(category,"category")
        
        ViewModel.filter(category,typeContent)
        tabelView.reloadData()
        
        
    }
}
