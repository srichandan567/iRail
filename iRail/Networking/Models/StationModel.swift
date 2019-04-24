//
//  StationModel.swift
//  iRail
//
//  Created by Sri Anumala on 4/23/19.
//  Copyright © 2019 Sri Anumala. All rights reserved.
//

import Foundation

enum StationType: String{
    case all = "All"
    case mainline = "Mainline"
    case suburban = "Suburban"
    case dart = "Dart"
    
    func getParam() -> String{
        switch self {
        case .mainline:
            return "M"
        case .suburban:
            return "S"
        case .dart:
            return "D"
        default:
            return "A"
        }
    }
}
import Foundation

struct Station: Codable{
    
    var stationDesc: String?
    var stationAlias: String?
    var stationLatitude: String?
    var stationLongitude: String?
    var stationCode: String?
    var stationId: String?
    
    private enum CodingKeys : String, CodingKey {
        case stationDesc = "StationDesc", stationAlias = "StationAlias", stationLatitude = "StationLatitude", stationLongitude = "StationLongitude", stationCode = "StationCode", stationId = "StationId"
    }
}

struct StationResponseModel: Codable{
    var objStation: [Station]?
}

struct StationFilterResponseModel: Codable{
    var objStationFilter: [Station]?
}


struct StationData: Codable{
    var traincode: String?
    var stationfullname: String?
    var stationCode: String?
    var trainDate: String?
    var origin: String?
    var destination: String?
    var originTime: String?
    var destinationTime: String?
    var status: String?
    var lastLocation: String?
    var expArrival: String?
    var expDepart: String?
    var schArrival: String?
    var schDepart: String?
    
    private enum CodingKeys : String, CodingKey {
        case traincode = "Traincode", stationfullname = "Stationfullname", stationCode = "StationCode", trainDate = "TrainDate", origin = "Origin", destination = "Destination", originTime = "Origintime", destinationTime = "Destinationtime", status = "Status", lastLocation = "LastLocation", expArrival = "Exparrival", expDepart = "Expdepart", schArrival = "Scharrival", schDepart = "Schdepart"
    }
}

struct StationDataResponseModel: Codable{
    var objStationData: [StationData]?
}
