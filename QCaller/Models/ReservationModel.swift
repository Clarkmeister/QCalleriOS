//
//  ReservationModel.swift
//  QCaller
//
//  Created by Arthur Clark on 3/1/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import Foundation

public struct ReservationModel : Codable
{
    public let ReservationId: Int
    public let CustomerId: Int
    public let RestaurantId: Int
    public let ReservationTime: Date
    public let GuestCount :Int
    public let Status: Int
}

public struct ReservationStringTimeModel : Codable
{
    public let ReservationId: Int
    public let CustomerId: Int
    public let RestaurantId: Int
    public let ReservationTime: String
    public let GuestCount :Int
    public let Status: Int
}
