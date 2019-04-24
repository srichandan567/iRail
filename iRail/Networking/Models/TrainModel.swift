//
//  TrainModel.swift
//  iRail
//
//  Created by Sri Anumala on 4/23/19.
//  Copyright © 2019 Sri Anumala. All rights reserved.
//

import Foundation

struct CurrentTrain: Codable{
    var trainStatus: String?
    var trainLatitude: String?
    var trainLongitude: String?
    var trainCode: String?
    var trainDate: String?
    var publicMessage: String?
    var direction: String?
    
    private enum CodingKeys : String, CodingKey {
        case trainStatus = "TrainStatus", trainLatitude = "TrainLatitude", trainLongitude = "TrainLongitude", trainCode = "TrainCode", trainDate = "TrainDate", publicMessage = "PublicMessage", direction = "Direction"
    }
}

struct TrainResponseModel: Codable{
    var objTrainPositions: [CurrentTrain]?
}

struct TrainMovements: Codable{
    var trainCode: String?
    var trainDate: String?
    var locationCode: String?
    var locationFullName: String?
    var locationType: String?
    var scheduledArrival: String?
    var scheduledDeparture: String?
    var expectedArrival: String?
    var expectedDeparture: String?
    var arrival: String?
    var departure: String?
    var trainOrigin: String?
    var trainDestination: String?
    
    private enum CodingKeys : String, CodingKey {
        case trainCode = "TrainCode", trainDate = "traindate", locationCode = "LocationCode", locationFullName = "LocationFullName", locationType = "LocationType", scheduledArrival = "ScheduledArrival", scheduledDeparture = "ScheduledDeparture", expectedArrival = "ExpectedArrival", expectedDeparture = "ExpectedDeparture", arrival = "Arrival", departure = "Departure", trainOrigin = "TrainOrigin", trainDestination = "TrainDestination"
    }
}

struct TrainMovementsResponseModel: Codable{
    var objTrainMovements: [TrainMovements]?
}
