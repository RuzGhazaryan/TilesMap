//
//  ApiError.swift
//  TilesMap

import Foundation

public class ApiError: Error, Decodable {
    var code: Int!
    var message: String?

    private enum CodingKeys: String, CodingKey {
        case code = "status"
        case message = "error"
    }
}

enum NonApiError: Error {
    case requestFailed
    case invalidData
    case jsonDecodingFailure
    case unknownError
}
