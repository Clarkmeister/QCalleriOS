//
//  ReservationStatus.swift
//  QCaller
//
//  Created by Arthur Clark on 3/1/18.
//  Copyright © 2018 Arthur Clark. All rights reserved.
//

import Foundation

public enum ReservationStatus
{
    case Waiting, Ready, Seated, Complete, Cancelled, Unknown
}

public func ConvertReservationStatusToEnum(status : Int) -> ReservationStatus
{
    switch status
    {
    case 0:
        return ReservationStatus.Waiting
    case 1:
        return ReservationStatus.Ready
    case 2:
        return ReservationStatus.Seated
    case 3:
        return ReservationStatus.Complete
    case 4:
        return ReservationStatus.Cancelled
    case 5:
        return ReservationStatus.Unknown
    default:
        return ReservationStatus.Unknown
    }
}

public func ConvertReservationStatusToInt(status : ReservationStatus) -> Int
{
    switch status
    {
    case ReservationStatus.Waiting:
        return 0
    case ReservationStatus.Ready:
        return 1
    case ReservationStatus.Seated:
        return 2
    case ReservationStatus.Complete:
        return 3
    case ReservationStatus.Cancelled:
        return 4
    case ReservationStatus.Unknown:
        return 5
    }
}
