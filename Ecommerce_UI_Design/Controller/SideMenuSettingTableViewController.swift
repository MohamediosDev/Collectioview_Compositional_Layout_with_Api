//
//  SideMenuSettingTableViewController.swift
//  Ecommerce_UI_Design
//
//  Created by Soda on 6/2/21.
//

import UIKit

class SideMenuSettingTableViewController: UITableViewController {

    
    let item = ["Main","Catogeries","Proudcts","Contnect us","About us"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .darkGray
       
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .darkGray
        return cell
    }

}
