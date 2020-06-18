//
//  UserListViewController.swift
//  Gestor_Usuarios
//
//  Created by Javier Piñas on 24/04/2020.
//  Copyright © 2020 Javier Piñas. All rights reserved.
//

import UIKit
import Alamofire
class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var users : [[String:Any]]?
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.users == nil){
            return 0
        }
        return (users!.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaList", for: indexPath) as? UserListCell
        
        if(self.users != nil){
            cell?.nameCell.text = (self.users![indexPath.row]["name"] as! String)
        }
        
        return cell!
    }
    
    func getUsers(){
        let url = URL(string: "http://127.0.0.1/gestor-usuarios/public/index.php/api/listUsers")
        print("Sesión iniciada")
        let header = ["Authentication": token]
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            self.users = response.result.value as? [[String:Any]]
            print(response.value)
            print("Hola por aquí", token)
            self.tableView.reloadData()
        }
   }

}
