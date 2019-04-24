//
//  URLConstants.swift
//  iRail
//
//  Created by Sri Anumala on 4/23/19.
//  Copyright © 2019 Sri Anumala. All rights reserved.
//

import Foundation

struct URLS {
    static let baseurl = "http://api.irishrail.ie/realtime/realtime.asmx"
    static let getStations = "/getAllStationsXML"
    static let getStationsByType = "/getAllStationsXML_WithStationType"
    static let getCurrentTrains = "/getCurrentTrainsXML"
    static let getStationData = "/getStationDataByNameXML"
    static let getStationDataByCode = "/getStationDataByCodeXML"
    static let getStationsFilter = "/getStationsFilterXML"
    static let getTrainMovements = "/getTrainMovementsXML"
    static let mapsurl = "https://maps.apple.com/maps?saddr=%@,%@"
}

struct Params{
    static let stationType = "StationType"
    static let trainType = "TrainType"
    static let stationName = "StationDesc"
    static let numMins = "NumMins"
    static let stationCode = "StationCode"
    static let stationText = "StationText"
    static let trainId = "TrainId"
    static let trainDate = "TrainDate"
}
