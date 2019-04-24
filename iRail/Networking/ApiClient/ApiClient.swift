//
//  ApiClient.swift
//  iRail
//
//  Created by Sri Anumala on 4/23/19.
//  Copyright © 2019 Sri Anumala. All rights reserved.
//

import Foundation
import Alamofire

let serviceError = NSError(domain:"", code:500, userInfo:[ NSLocalizedDescriptionKey: "Service Unavilable!"])
let parsingError = NSError(domain:"", code:403, userInfo:[ NSLocalizedDescriptionKey: "Unable to parse data!"])



struct ApiClient{
    
    static func requestGETURL(_ strURL: String, parameters: [String: String]? = nil, headers: [String: String]? = nil, success:@escaping (Data?) -> Void, failure:@escaping (Error) -> Void) {
        print(strURL)
        Alamofire.request(strURL, method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseData{(responseObject) -> Void in
            if responseObject.result.isSuccess{
                success(responseObject.result.value)
            }else{
                failure(responseObject.result.error ?? serviceError)
            }
        }
    }
}

