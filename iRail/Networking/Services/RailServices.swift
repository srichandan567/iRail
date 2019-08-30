//
//  RailServices.swift
//  iRail
//
//  Created by Sri Anumala on 4/23/19.
//  Copyright © 2019 Sri Anumala. All rights reserved.
//

import Foundation
import XMLParsing

class StationService{
    static var sharedInstance = StationService()
}
func getAllStations(success:@escaping ([Station]) -> Void, failure:@escaping (Error) -> Void){
    let url = URLS.baseurl + URLS.getStations
    ApiClient.requestGETURL(url, success:{ data in
        guard let responseData = data else{
            success([]) // FAIL
            return
        }
        let decoder = XMLDecoder()
        do{
            let stationsList = try decoder.decode(StationResponseModel.self, from: responseData)
            success(stationsList.objStation ?? [])
        }catch{
            failure(parsingError)
        }
    }, failure: {error in
        failure(error)
    })
}

func getStationsByType(parameters: [String: String]? = nil, success:@escaping ([Station]) -> Void, failure:@escaping (Error) -> Void){
    let url = URLS.baseurl + URLS.getStationsByType
    ApiClient.requestGETURL(url, parameters: parameters, success:{ data in
        guard let responseData = data else{
            success([])
            return
        }
        let decoder = XMLDecoder()
        do{
            let stationsList = try decoder.decode(StationResponseModel.self, from: responseData)
            success(stationsList.objStation ?? [])
        }catch{
            failure(parsingError)
        }
    }, failure: {error in
        failure(error)
    })
}

func searchStationByText(parameters: [String: String]? = nil, success:@escaping ([Station]) -> Void, failure:@escaping (Error) -> Void){
    let url = URLS.baseurl + URLS.getStationsFilter
    ApiClient.requestGETURL(url, parameters: parameters, success:{ data in
        guard let responseData = data else{
            success([])
            return
        }
        let decoder = XMLDecoder()
        do{
            let stationsList = try decoder.decode(StationFilterResponseModel.self, from: responseData)
            success(stationsList.objStationFilter ?? [])
        }catch{
            failure(parsingError)
        }
    }, failure: {error in
        failure(error)
    })
}

func getStationTrainsData(parameters: [String: String]? = nil, success:@escaping ([StationData]) -> Void, failure:@escaping (Error) -> Void){
    let url = URLS.baseurl + URLS.getStationDataByCode
    ApiClient.requestGETURL(url, parameters: parameters, success:{ data in
        guard let responseData = data else{
            success([])
            return
        }
        let decoder = XMLDecoder()
        do{
            let stationsList = try decoder.decode(StationDataResponseModel.self, from: responseData)
            success(stationsList.objStationData ?? [])
        }catch{
            failure(parsingError)
        }
    }, failure: {error in
        failure(error)
    })
}

func getCurrentTrains(parameters: [String: String]? = nil, success:@escaping ([CurrentTrain]) -> Void, failure:@escaping (Error) -> Void){
    let url = URLS.baseurl + URLS.getCurrentTrains
    ApiClient.requestGETURL(url, parameters: parameters, success:{ data in
        guard let responseData = data else{
            success([])
            return
        }
        let decoder = XMLDecoder()
        do{
            let trainsList = try decoder.decode(TrainResponseModel.self, from: responseData)
            success(trainsList.objTrainPositions ?? [])
        }catch{
            failure(parsingError)
        }
    }, failure: {error in
        failure(error)
    })
}

func getCurrentTrainMovements(parameters: [String: String]? = nil, success:@escaping ([TrainMovements]) -> Void, failure:@escaping (Error) -> Void){
    let url = URLS.baseurl + URLS.getTrainMovements
    ApiClient.requestGETURL(url, parameters: parameters, success:{ data in
        guard let responseData = data else{
            success([])
            return
        }
        let decoder = XMLDecoder()
        do{
            let trainsList = try decoder.decode(TrainMovementsResponseModel.self, from: responseData)
            success(trainsList.objTrainMovements ?? [])
        }catch{
            failure(parsingError)
        }
    }, failure: {error in
        failure(error)
    })
}
