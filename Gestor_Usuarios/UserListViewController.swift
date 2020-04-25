//
//  UserListViewController.swift
//  Gestor_Usuarios
//
//  Created by Javier Piñas on 24/04/2020.
//  Copyright © 2020 Javier Piñas. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var profiles = ["Carlos", "Josep", "Ana", "Iratxe"]
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaList", for: indexPath) as? UserListCell
        cell?.nameCell.text = profiles[indexPath.row]
        return cell!
    }
    
    
    
    
    
    
    
}
