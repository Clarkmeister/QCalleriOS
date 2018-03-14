//
//  FirstLaunch.swift
//  QCaller
//
//  Created by Arthur Clark on 3/1/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import UIKit

class FirstLaunch: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    
    @IBAction func saveDetails(_ sender: UIButton) {
        UserDefaults.standard.set(firstName.text, forKey: "FirstName")
        UserDefaults.standard.set(lastName.text, forKey: "LastName")
        UserDefaults.standard.set(phoneNumber.text, forKey: "PhoneNumber")
        UserDefaults.standard.set(emailAddress.text, forKey: "EmailAddress")

        var urlComp = URLComponents()
        urlComp.scheme = "http"
        urlComp.host = "qcallerservice.azurewebsites.net"
        urlComp.path = "/api/customer"
        
        guard let url = urlComp.url
            else {
            return
        }
        
        var request = URLRequest(url : url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let customer = CustomerModel(customerId: 0, firstName: firstName.text!, lastName: lastName.text!, phoneNumber: phoneNumber.text!, emailAddress: emailAddress.text!)

        let encoder = JSONEncoder()
        do
        {
//            print(customer)
            //let deSJdata = try JSONSerialization.data(withJSONObject: customer, options: [])
            let jsonData = try encoder.encode(customer)
//            let jString = String(describing: deSJdata)
//            let jsonFinal = jString.data(using: .utf8, allowLossyConversion: true)
//            let dcJData = try decoder.decode(CustomerModel(), from: jsonData)
//            print("Decoded Json: ", dcJData)
            request.httpBody = jsonData
        }
        catch
        {
            print("error encoding")
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                return
            }
            if let retData = data
            {
                //print(response)
                print(retData)
                do
                {
                    let createCustRet = try IntegerReturnValue.decodeAllowFragments(data: retData)
                    UserDefaults.standard.set(createCustRet.Result, forKey: "CustomerId")
                }
                catch
                {
                    
                }
            }
        }
        task.resume()
//        let session = URLSession.shared
//        session.dataTask(with: url) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//            if let data = data {
//                do
//                {
//                    let cl = try CustomerModel.decodeAllowFragments(data: data)
//                    print(cl.EmailAddress)
//                }
//                catch
//                {
//                    print(error)
//                }
//            }
//        }.resume()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
//    @IBAction func lostFocus(_ sender: UITextField) {
//        textFieldShouldReturn(sender)
//    }
    
    @IBAction func skipDetails(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
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
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func doneClick()
    {
        self.view.endEditing(true)
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
    }
}

