//
//  RegisterViewController.swift
//  Gestor_Usuarios
//
//  Created by Javier Piñas on 24/04/2020.
//  Copyright © 2020 Javier Piñas. All rights reserved.
//

import UIKit
import Alamofire
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passField: UITextField!
    
    @IBOutlet weak var repeatField: UITextField!
    
    @IBOutlet weak var errorEmail: UILabel!
    
    @IBOutlet weak var errorPass: UILabel!
    
    @IBOutlet weak var errorName: UILabel!
    
    @IBOutlet weak var errorNumberName: UILabel!
    
    @IBOutlet weak var passnotCoincidence: UILabel!
    
    @IBAction func registerButton(_ sender: Any) {
        
        var errores = false
        if(nameField.text!.isEmpty){
            errores = true
            errorEmail.isHidden = false
        }else{
            user.name = nameField.text!
            errorEmail.isHidden = true
        }
        
        if(emailField.text!.isEmpty){
            errores = true
            errorEmail.isHidden = false
        }else{
            user.email = emailField.text!
            errorEmail.isHidden = true
        }
        
        if(passField.text!.isEmpty){
            errores = true
            errorEmail.isHidden = false
        }else{
            user.password = passField.text!
            errorEmail.isHidden = true
        }
        
        if(repeatField.text!.isEmpty){
            errores = true
            errorEmail.isHidden = false
        }else{
            user.password = repeatField.text!
            errorEmail.isHidden = true
        }
        
        checkUserName()
        
        checkPasswords()
        
        passwordLength()
        
        
        if(!errores) {
        print("Nombre: ", user.name
                     + " Email: ", user.email + " Password: ", user.password)
            user.name = nameField.text!
             registerUser(user: user)
        
             }else{
                 print("Error")
             }
        
        
    }
    
    func registerUser(user: User){
        let url = URL(string: "http://127.0.0.1/gestor-usuarios/public/index.php/api/register")
        let json:[String:String] = ["name": user.name,
                                    "email": user.email,
                                    "password": user.password]
        NSLog(user.email)
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: nil).responseJSON
            {(response) in
                print(response)
                if response.response!.statusCode == 200 {
                    self.performSegue(withIdentifier: "seguetoUsers2", sender: nil)
                } else {
                    let alert1 = UIAlertAction(title: "Cerrar", style: UIAlertAction.Style.default) {
                        (error) in
                    }
                    let alert = UIAlertController(title: "Error", message:
                    "Parámetros incorrectos: no se permiten nombres repetidos o nombres con números", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(alert1)
                    self.present(alert, animated: true, completion: nil)
                }
        }
        
        
        
    }
        
        func checkPasswords() -> Bool {
            let texto1 = passField.text!
                   let texto2 = repeatField.text!
                   
                   if passField.text!.isEmpty || repeatField.text!.isEmpty {
                       errorPass.isHidden = false
                       return false
                   }else if !texto1.elementsEqual(texto2){
                       passnotCoincidence.isHidden = false
                       return false
                   }
                   return true
        }
        
        func passwordLength() -> Bool {
            if passField.text!.count < 8 {
                errorPass.text! = "La contraseña debe tener al menos 8 caracteres"
                return false
            }else{
                errorPass.text! = "Contraseña válida"
            }
            return true
        }
        
        let characterset = CharacterSet(charactersIn: "0123456789")
        
        func checkUserName() {
            if nameField.text!.rangeOfCharacter(from: characterset.inverted) != nil {
                errorNumberName.isHidden = false
                
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

}
