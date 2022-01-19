//
//  LoginController.swift
//  Viary
//
//  Created by User on 19/01/22.
//

import UIKit

class LoginController: UIViewController {

    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
        
    }
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var pinTxt: UITextField!
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameTxt.text ?? ""
        let PIN = pinTxt.text ?? ""
        if(username.isEmpty){
            showAlert(msg: "Please input your username!")
        }else if(PIN.isEmpty){
            showAlert(msg: "Please input your PIN!")
        }else if(isLoginValid(username: username, PIN: PIN)){
            //goto Home
            performSegue(withIdentifier: <#T##String#>, sender: self)
        }else{
            showAlert(msg: "Username/PIN is wrong, please check again!")
        }
    }
    
    func showAlert(msg: String){
        let alert = UIAlertController(title: "Login Failed", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func isLoginValid(username: String, PIN: String) -> Bool{
        //check if username and PIN is found in the database
        return false
    }
}
