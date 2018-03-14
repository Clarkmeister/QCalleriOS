//
//  QCallerEncode.swift
//  QCaller
//
//  Created by Arthur Clark on 3/7/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import Foundation

class QCallerEncode
{
    static func EncodeCustomer (customer : CustomerModel) -> String
    {
        let encoder = JSONEncoder()
        do
        {
            print(customer)
            let jsonData = try encoder.encode(customer)
            print(jsonData)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: [])
            let jsonString = String(describing: json)
            print(jsonString)
            return jsonString
        }
        catch
        {
            return "Failed"
        }
    }
}
