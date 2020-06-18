//
//  ViewController.swift
//  Gestor_Usuarios
//
//  Created by Javier Piñas on 24/04/2020.
//  Copyright © 2020 Javier Piñas. All rights reserved.
//

import UIKit
import Alamofire
var user = User()
var token:String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImNhbGF0cmF2YUBnbWFpbC5jb20ifQ._xj741q3T2YbGIhlw5F7ODkDDAagvlo28MuzLoiLF00"

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPass: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hola")
        }
    
    @IBAction func loginButton(_ sender: Any) {
        var errores = false
        if(email.text!.isEmpty){
            errores = true
            errorEmail.isHidden = false
        }else{
            user.email = email.text!
            errorEmail.isHidden = true
        }
        
        if(pass.text!.isEmpty){
            errores = true
            errorPass.isHidden = false
        }else{
            user.password = pass.text!
            errorPass.isHidden = true
        }
        
        if(!errores){
            
            print("nombre: ", user.name
            + " Email: ", user.email + " Password: ", user.password)
            postUser(user: user)
        }else{
            print("Error, datos incorrectos")
        }
    
    }
    
    func postUser(user: User){
        let url = URL(string: "http://127.0.0.1/gestor-usuarios/public/index.php/api/login")
        let json:[String:String] = ["email": user.email, "password": user.password]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers:
            nil).responseJSON { (response) in
        print(response)
                if response.response!.statusCode == 401 {
                    print("Fallo")
                  self.errorPass.isHidden = false
                let alert1 = UIAlertAction(title: "Cerrar", style: UIAlertAction.Style.default) {
                    (error) in
                }
                let alert = UIAlertController(title: "Error", message:
                    "Email no encontrado", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(alert1)
                self.present(alert, animated: true, completion: nil)
                    
                }else{
                    
                    var json = response.result.value as! [String: AnyObject]
                    
                    token = json["token"] as! String
                    
                    
                    if response.response!.statusCode == 201 {
                        self.performSegue(withIdentifier: "seguetoUsers", sender: nil)
                    }
                        
                    }
                }
             }
          }
       

