//
//  ReturnValue.swift
//  QCaller
//
//  Created by Arthur Clark on 3/5/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import Foundation

public struct IntegerReturnValue : Codable
{
    public let Result : Int
    public let Description : String
}

public struct StringReturnValue : Codable
{
    public let Result : String
    public let Description : String
}

