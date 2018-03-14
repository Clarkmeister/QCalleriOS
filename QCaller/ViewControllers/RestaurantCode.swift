//
//  RestaurantCode.swift
//  QCaller
//
//  Created by Arthur Clark on 3/1/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import UIKit

class RestaurantCode: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    var presetCode = ""
    @IBOutlet weak var guestCountPicker: UIPickerView!
    @IBOutlet weak var restaurantCodeInput: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var successLabel: UILabel!
    
    let count = [ 1,2,3,4,5,6,7,8,9,10]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let kb = UIToolbar()
        kb.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneClick))
        kb.items = [doneButton]
        restaurantCodeInput.inputAccessoryView = kb
        restaurantCodeInput.text = presetCode
        if presetCode != ""{
            restaurantCodeInput.isUserInteractionEnabled = false
        }
        timePicker.timeZone = TimeZone.current
        timePicker.date = Date()
        timePicker.calendar = Calendar.current
        timePicker.minimumDate = Date()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func doneClick()
    {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return count.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(count[row])
    }
    
    @IBAction func SubmitReservation(_ sender: Any)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = timePicker.date
        let restaurantCode = Int(restaurantCodeInput.text!)
        let guestCount = guestCountPicker.selectedRow(inComponent: 0) + 1
        let customerId = UserDefaults.standard.integer(forKey: "CustomerId")
        
        let stringTime = formatter.string(from: time)
        print("Time: \(timePicker.date)")
        print("String: \(stringTime)")
        
//        let reservation = ReservationModel(ReservationId: 0, CustomerId: customerId, RestaurantId: restaurantCode!, ReservationTime: time, GuestCount: guestCount, Status: 0)
        
        let reservation = ReservationStringTimeModel(ReservationId: 0, CustomerId: customerId, RestaurantId: restaurantCode!, ReservationTime: stringTime, GuestCount: guestCount, Status: 0)
        
        var urlComp = URLComponents()
        urlComp.scheme = "http"
        urlComp.host = "qcallerservice.azurewebsites.net"
        urlComp.path = "/api/reservation"
        
        guard let url = urlComp.url
            else {
                return
        }
        var request = URLRequest(url : url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let encoder = JSONEncoder()
        do
        {
            let jsonData = try encoder.encode(reservation)
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
                print(retData)
                do
                {
                    let createReservationRet = try IntegerReturnValue.decodeAllowFragments(data: retData)
                    print(createReservationRet)
                    
                    if ((createReservationRet.Result > 0) != true)
                    {
                        print("ERROR: Failed to create Reservation")
                        DispatchQueue.main.async {
                            self.successLabel.textColor = .red
                            self.successLabel.text = "Failed"
                        }
                        return
                    }
                    else
                    {
                        DispatchQueue.main.async
                            {
                                self.successLabel.textColor = .green
                            
                                self.successLabel.text = "Success: " + String(createReservationRet.Result)
                            
                                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "reservationSubmitted") as? ReservationSubmitted {
                                if let navigator = self.navigationController {
                                    viewController.date = time
                                    navigator.pushViewController(viewController, animated: true)
                                    }
                            
                            }
                            
                        }
                    }
                }
                catch
                {
                }
            }
        }
        task.resume()
    }
}
