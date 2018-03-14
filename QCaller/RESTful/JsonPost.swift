//
//  JsonPost.swift
//  QCaller
//
//  Created by Arthur Clark on 3/7/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import Foundation

public class JsonPost
{
    //"qcallerservice.azurewebsites.net"
    static func PostJson(scheme : String, host : String, path : String, body : Data) -> Data
    {
        var urlCompnts = URLComponents()
        urlCompnts.scheme = "http"
        urlCompnts.host = host
        urlCompnts.path = path
        
        guard let url = urlCompnts.url
            else{
                print("Failed to Create URL")
                return Data()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        var responseData = Data()
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.dataTask(with: request)
        { (data, response, error) in
            responseData = data!
            if let response = response
            {
                print(response)
            }
            else
            {
                print("No Response")
            }
            if let data = data
            {
                responseData = data
                print(data)
            }
            else
            {
                print("No Data")
            }
            if let error = error
            {
                print(error)
            }
        }.resume()
        return responseData
    }
}
