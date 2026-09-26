//
//  MainViewController.swift
//  TrainngHub
//
//  Created by LP Mackbook on 15/09/2026.
//

import UIKit

class MainViewController: UIViewController {

    

    @IBOutlet var tableView: UITableView!
    @IBOutlet var texFeaildStack: CustemStack!
    @IBOutlet var imageContaner: CustemView!
    @IBAction func OnTap(_ sender: Any) {
        showTheSheet()
    }
    @IBOutlet var searchFeaild: UITextField!
    @IBAction func onStartSearch(_ sender: Any) {
        let query : SelectedItems =  SelectedItems(searchFeaild?.text ?? "")
        viewModel.materialFilter([query])
        tableView.reloadData()
    }
    let viewModel = MainViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageContaner.layer.cornerRadius =  imageContaner.bounds.height / 2
        texFeaildStack.layer.cornerRadius =  texFeaildStack.bounds.height / 2
        cellRegestration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        sheetVC.firstFilterOptions = []
//        sheetVC.secondFilterOptions = []
    }
    
    let sheetVC = FilterSheetViewController( mode: .main)
    func showTheSheet(){

        sheetVC.modalPresentationStyle = .pageSheet
        sheetVC.modalPresentationStyle = .pageSheet

        if let sheet = sheetVC.sheetPresentationController {

            sheet.detents = [
                .custom(identifier: .init("custom300")) { context in
                    300
                }
            ]

            sheet.prefersPageSizing = false

            sheet.preferredCornerRadius = 24
            sheet.prefersGrabberVisible = true
        }

        sheetVC.delegate = self

        present(sheetVC, animated: true)

    }
    
    func cellRegestration(){
        let nib = UINib(nibName: "MainCell", bundle: nil)

        tableView.register(
            nib,
            forCellReuseIdentifier: "MainCell")

    }

}


extension MainViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.filteredData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
                withIdentifier: "MainCell",
                for: indexPath
            ) as! MainCell

        cell.configer( self.viewModel.filteredData[indexPath.section])
            return cell
    }
    
    
}

extension MainViewController:UITableViewDelegate{
   
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EreloadViewController()

        navigationController?.pushViewController(vc, animated: true)
    }
    
   
}

extension MainViewController :OnSheetDismisedDelegate{
    func didSelectFilters(_ firstQueris: [SelectedItems], _ typeContent: [SelectedItems]) {
        viewModel.materialFilter(firstQueris)
        tableView.reloadData()
    }
}
