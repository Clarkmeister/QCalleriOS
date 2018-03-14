//
//  PostsStruct.swift
//  QCaller
//
//  Created by Arthur Clark on 3/7/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import Foundation

public struct PostsStruct : Codable
{
    public var CustomerId: Int
    public var FirstName: String
    public var LastName: String
    public var PhoneNumber: String
    public var EmailAddress : String
    
    init(customerId : Int, firstName : String, lastName : String, phoneNumber :String, emailAddress : String)
    {
        self.CustomerId = customerId
        self.FirstName = firstName
        self.LastName = lastName
        self.PhoneNumber = phoneNumber
        self.EmailAddress = emailAddress
    }
}
