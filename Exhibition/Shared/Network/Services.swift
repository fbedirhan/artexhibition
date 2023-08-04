//
//  Service.swift
//  Exhibition
//
//  Created by Bedirhan Yıldız on 2.08.2023.
//

import Foundation
import Moya

enum Services {
    
    case GetCollection(queryParams: [String: Any]? = nil)
    case GetCollectionDetail(id: String, queryParams: [String: Any]? = nil)
}

extension Services: TargetType {
    var baseURL: URL {
        return URL(string: NetworkConstants.baseURL)!
    }
    
    
    var path: String {
        switch self {
        case .GetCollection(_):
            return ""
        case .GetCollectionDetail(let id,_):
            return "/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .GetCollection(var queryParams), .GetCollectionDetail(_,var queryParams):
            if queryParams == nil {
                queryParams = [:]
            }
            queryParams?["key"] = NetworkConstants.apiKey
            return .requestParameters(parameters: queryParams ?? [:], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
}
