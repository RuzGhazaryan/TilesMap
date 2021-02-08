//
//  GetTilesetsRequest.swift
//  TilesMap
//
//  Created by Ruzanna Ghazaryan on 2/7/21.
//

import Foundation
import NetworkLayer

class GetTilesetsRequest: ApiRequest<GetTilesetsResponse> {
    init() {
        super.init(path: "41glvzt1c", method: .get)
    }
}

enum GetTilesetsResponse: ApiResponse {
    
    typealias DataType = Farm

    case found(weather: DataType)
    case error

    static func successResponse(with code: Int, data: DataType?) -> GetTilesetsResponse {
        switch code {
        case 200:
            guard let data = data else {
                return .error
            }
            return .found(weather: data)
        default:
            return .error
        }
    }
    
    static func errorResponse(with code: Int, data: ApiError?) -> GetTilesetsResponse {
        return .error
    }
}
