//
//  ViewController+Ext.swift
//  SqliteSample
//
//  Created by Thien Vu on 11/09/2022.
//

import Foundation
import UIKit

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListNameCell", for: indexPath) as! ViewCellCustom
        cell.setDataForCell(self.nameInfo[indexPath.row].name, age: self.nameInfo[indexPath.row].age)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SqliteSample:: didSelectRowAt")
        let cell = tableView.cellForRow(at: indexPath) as! ViewCellCustom
        let storyboard = UIStoryboard.init(name: "DetailView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        
        self.nameInfo.forEach { info in
            if info.name == cell.name.text {
                viewController.getDataFromTable(info, id: indexPath.row)
            }
        }
        
        let navigator = UINavigationController.init(rootViewController: viewController)
        self.navigationController?.present(navigator, animated: true)
    }
    
    @objc func onAddNameList() {
        print("SqliteSample:: Add name list")
        let storyboard = UIStoryboard.init(name: "DetailView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        viewController.getDataFromTable(nil, id: self.nameList.numberOfRows(inSection: 0))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func OnBackAfterPresent() {
        if self.fecthData() {
            nameList.reloadData()
        }
    }
}
