//
//  RegisterController.swift
//  Viary
//
//  Created by User on 18/01/22.
//

import UIKit
import SimpleCheckbox

class RegisterController: UIViewController {
    
    @IBOutlet weak var imgPicker: UIImageView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var pinTxt: UITextField!
    @IBOutlet weak var confirmPinTxt: UITextField!
    
    @IBOutlet weak var cbAgree: Checkbox!
    @IBAction func onRegister(_ sender: Any) {
        let username = usernameTxt.text ?? ""
        let email = emailTxt.text ?? ""
        let PIN = pinTxt.text ?? ""
        let confirmPIN = confirmPinTxt.text ?? ""
        let cbState = cbAgree.isChecked
        
        if(username.isEmpty){
            showAlert(msg: "Please input your username!")
        }else if(username.count < 3){
            showAlert(msg: "Username must be at least 3 characters!")
        }else if(email.isEmpty){
            showAlert(msg: "Please input your email!")
        }else if(!email.contains("@")){
            showAlert(msg: "Please input valid email!")
        }else if(PIN.isEmpty){
            showAlert(msg: "Please input your PIN!")
        }else if(PIN.count < 6){
            showAlert(msg: "PIN must be 6 digits!")
        }else if(confirmPIN.isEmpty){
            showAlert(msg: "Please confirm your PIN!")
        }else if(confirmPIN != PIN){
            showAlert(msg: "PIN does not match!")
        }else if(!cbState){
            showAlert(msg: "You must agree withh Viary's terms and conditions to register your account!")
        }else if(isRegisterValid(username: username)){
            //segue straight to Home
            performSegue(withIdentifier: <#T##String#>, sender: self)
        }else{
            showAlert(msg: "You've registered before with this username!")
        }
    }
                 
    func showAlert(msg: String){
        let alert = UIAlertController(title: "Register Failed", message: msg,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func prepareCheckbox(){
        cbAgree.borderStyle = .square
        cbAgree.checkmarkStyle = .square
        cbAgree.checkmarkColor = .blue
        cbAgree.uncheckedBorderColor = .black
        cbAgree.checkedBorderColor = .blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCheckbox()
        // Do any additional setup after loading the view.
    }
    
    func isRegisterValid(username: String) -> Bool{
        //check if username exist in database or not
        //return true if no duplicate
        
        return false
    }
    
    

    

}
