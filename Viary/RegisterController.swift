//
//  RegisterController.swift
//  Viary
//
//  Created by User on 18/01/22.
//

import UIKit
import SimpleCheckbox
import CoreData

class RegisterController: UIViewController {
    
    var users: [NSManagedObject] = []
    
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
        
        if(isRegisterValid(username: username, email: email, PIN: PIN, confirmPIN: confirmPIN, cbState: cbState)){
            fetchData()
            var newID: NSNumber!
            if(users.isEmpty){
                newID = 0
            }else{
                let prevID = users[users.count-1].value(forKey: "userID")
                newID = prevID as! Int + 1 as NSNumber
            }
            
            saveData(userID: newID, username: username, email: email, PIN: PIN)
            
            //segue straight to Home
            performSegue(withIdentifier: "homeSegue", sender: self)
            
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
    
    func isRegisterValid(username: String, email: String, PIN: String, confirmPIN: String, cbState: Bool) -> Bool{
        if(username.isEmpty){
            showAlert(msg: "Please input your username!")
            return false
        }else if(username.count < 3){
            showAlert(msg: "Username must be at least 3 characters!")
            return false
        }else if(email.isEmpty){
            showAlert(msg: "Please input your email!")
            return false
        }else if(!email.contains("@")){
            showAlert(msg: "Please input valid email!")
            return false
        }else if(PIN.isEmpty){
            showAlert(msg: "Please input your PIN!")
            return false
        }else if(PIN.count < 6){
            showAlert(msg: "PIN must be 6 digits!")
            return false
        }else if(confirmPIN.isEmpty){
            showAlert(msg: "Please confirm your PIN!")
            return false
        }else if(confirmPIN != PIN){
            showAlert(msg: "PIN does not match!")
            return false
        }else if(!cbState){
            showAlert(msg: "You must agree withh Viary's terms and conditions to register your account!")
            return false
        }
        
        return true
    }
    
    func fetchData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "User")
          
          do {
             users = try managedContext.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
    }
    
    func saveData(userID: NSNumber, username: String, email: String, PIN: String){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
          }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "User",
                                       in: managedContext)!
          
        let user = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
        
        user.setValue(userID, forKey: "userID")
        user.setValue(username, forKey: "username")
        user.setValue(email, forKey: "email")
        user.setValue(PIN, forKey: "pin")
        
        do {
            try managedContext.save()
            users.append(user)
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }
    }

    

}
