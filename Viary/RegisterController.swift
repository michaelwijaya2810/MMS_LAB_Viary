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
    
    @IBOutlet weak var onRegister: UIButton!
    @IBOutlet weak var toLogin: UIButton!
    
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
