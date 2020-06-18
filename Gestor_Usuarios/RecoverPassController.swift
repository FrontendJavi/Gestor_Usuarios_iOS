//
//  RecoverPassController.swift
//  Gestor_Usuarios
//
//  Created by Javier Piñas on 24/04/2020.
//  Copyright © 2020 Javier Piñas. All rights reserved.
//

import UIKit
import Alamofire
class RecoverPassController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var emailNoExists: UILabel!
    
    @IBOutlet weak var emptyField: UILabel!
    
    @IBAction func backToStart(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func recoverButton(_ sender: Any) {
        
        if(emailText.text!.isEmpty){
            user.email = ""
            emptyField.isHidden = false
        }else{
            user.email = emailText.text!
            postUser(user: user)
        }
        
        
    }
    
    func postUser(user: User) {
        let url = URL(string: "http://127.0.0.1/gestor-usuarios/public/index.php/api/recoverPassword")
        let json = ["email": user.email]
        let header = ["Authentication": token]
        
        Alamofire.request(url!, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
        print(response)
            
            if response.response!.statusCode == 401  {
                self.emailNoExists.isHidden = false
                
            } else {
                self.message.isHidden = false
            }
        
        
        
        
        
        
        
    }
    
    
    
    
}

}
