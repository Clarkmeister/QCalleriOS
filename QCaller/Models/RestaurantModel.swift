//
//  RestaurantModel.swift
//  QCaller
//
//  Created by Arthur Clark on 3/1/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import Foundation

public struct RestaurantModel : Codable
{
    public let RestaurantId : Int
    public let Name : String
    public let PhoneNumber : String
    public let Address : String
    public let City : String
    public let State : String
    public let ZipCode : String
    public let EmailAddress : String
    public let Logo : Int?
}
