//
//  JsonSerializerExtensions.swift
//  QCaller
//
//  Created by Arthur Clark on 3/7/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import Foundation

extension Decodable {
    static func decodeAllowFragments(data: Data) throws -> Self
    {
        let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
        let jsonString = String(describing: json)
        let jsonData = jsonString.data(using: .utf8, allowLossyConversion: true)
        let decoder = JSONDecoder()
        let myStruct = try! decoder.decode(self, from: jsonData!)
        return myStruct
    }
}
