//
//  ProfileViewController.swift
//  Gestor_Usuarios
//
//  Created by Javier Piñas on 24/04/2020.
//  Copyright © 2020 Javier Piñas. All rights reserved.
//

import UIKit
import Alamofire
class ProfileViewController: UIViewController {
    
    @IBOutlet weak var passField1: UITextField!
    
    @IBOutlet weak var passField2: UITextField!
    
    @IBOutlet weak var deleteField: UITextField!
    
    @IBOutlet weak var passChanged: UILabel!
    
    @IBOutlet weak var passError: UILabel!
    
    @IBOutlet weak var passNotCoincidence: UILabel!
    
    @IBOutlet weak var pass8Characters: UILabel!
    
    @IBOutlet weak var passValid: UILabel!
    
    @IBAction func updatePass(_ sender: Any) {
        if checkInputs() && passwordLength()
        {
            user.password = passField1.text!
            postUpdate(user: user)
            passChanged.isHidden = false
        }
        
       
    }
    
    func checkInputs() -> Bool {
        let texto1 = passField1.text!
        let texto2 = passField2.text!
        
        if passField1.text!.isEmpty || passField2.text!.isEmpty {
            passError.isHidden = false
            return false
        }else if !texto1.elementsEqual(texto2){
            passNotCoincidence.isHidden = false
            return false
        }
        return true
    }
    
    func passwordLength() -> Bool {
        if passField2.text!.count < 8 {
            pass8Characters.isHidden = false
            return false
        }else{
            passValid.isHidden = false
        }
        return true
    }
    
    @IBAction func deleteUser(_ sender: Any) {
        if deleteField.text!.isEmpty {
            passError.isHidden = false
        } else {
            let deleted = deleteField.text!
            postDelete(email: deleted)
        }
    }
    
    func postUpdate(user: User) {
        let url = URL(string: "http://127.0.0.1/gestor-usuarios/public/index.php/api/changePassword")
        let json = ["password": user.password,
                    "email": user.email]
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
        print(response)
     }
    
   }
    
    func postDelete(email:String) {
        let url = URL(string: "http://127.0.0.1/gestor-usuarios/public/index.php/api/deleteUser")
        let json = ["email": email]
        print(user.email)
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
        print(response)
            
        if response.response!.statusCode == 401 {
            let alert1 = UIAlertAction(title: "Cerrar", style: UIAlertAction.Style.default) {
                (error) in
            }
                let alert = UIAlertController(title: "Error", message:
                    "No puedes borrarte a ti mismo", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(alert1)
                self.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "OK", message: "Usuario eliminado correctamente", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
    }

}

}
