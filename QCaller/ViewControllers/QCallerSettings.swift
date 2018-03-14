//
//  QCallerSettings.swift
//  QCaller
//
//  Created by Arthur Clark on 3/1/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import UIKit

class QCallerSettings: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var customerID: UILabel!
    
    @IBAction func saveDetails(_ sender: UIButton) {
        UserDefaults.standard.set(firstName.text, forKey: "FirstName")
        UserDefaults.standard.set(lastName.text, forKey: "LastName")
        UserDefaults.standard.set(phoneNumber.text, forKey: "PhoneNumber")
        UserDefaults.standard.set(emailAddress.text, forKey: "EmailAddress")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.phoneNumber.delegate = self
        self.emailAddress.delegate = self
        loadSettings()
        
        //Number KeyBoard
        let kb = UIToolbar()
        kb.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneClick))
        kb.items = [doneButton]
        phoneNumber.inputAccessoryView = kb
        // Do any additional setup after loading the view.
    }
    
    @objc func doneClick()
    {
        self.view.endEditing(true)
    }

    @IBAction func saveSettings(_ sender: UIButton) {
        UserDefaults.standard.set(firstName.text, forKey: "FirstName")
        UserDefaults.standard.set(lastName.text, forKey: "LastName")
        UserDefaults.standard.set(phoneNumber.text, forKey: "PhoneNumber")
        UserDefaults.standard.set(emailAddress.text, forKey: "EmailAddress")
        
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSettings()
    {
        firstName.text = UserDefaults.standard.string(forKey: "FirstName")
        lastName.text = UserDefaults.standard.string(forKey: "LastName")
        phoneNumber.text = UserDefaults.standard.string(forKey: "PhoneNumber")
        emailAddress.text = UserDefaults.standard.string(forKey: "EmailAddress")
        customerID.text = UserDefaults.standard.string(forKey: "CustomerId")
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
