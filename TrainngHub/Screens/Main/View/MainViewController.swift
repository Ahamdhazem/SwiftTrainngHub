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
    override func viewDidLoad() {
        super.viewDidLoad()
        imageContaner.layer.cornerRadius =  imageContaner.bounds.height / 2
        texFeaildStack.layer.cornerRadius =  texFeaildStack.bounds.height / 2
        cellRegestration()
 
        
       
    }
    func showTheSheet(){
        
        let sheetVC = FilterSheetViewController()
        
        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
         }
        present(sheetVC, animated: true, completion: nil)

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
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
                withIdentifier: "MainCell",
                for: indexPath
            ) as! MainCell

            return cell
    }
    
    
}

extension MainViewController:UITableViewDelegate{
   
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EreloadViewController()
        //vc.modalPresentationStyle = .fullScreen
        //present(vc, animated: true)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
   
}
