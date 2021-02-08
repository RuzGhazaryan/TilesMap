//
//  ApiResponse.swift
//  TilesMap

import Foundation

public protocol ApiResponse {
    associatedtype DataType
    static func parseSuccessResponse(with code: Int, data: Data?) -> Self
    static func successResponse(with code: Int, data: DataType?) -> Self
    static func errorResponse(with code: Int, data: ApiError?) -> Self
}

extension ApiResponse {
    static func parseResponse(with code: Int, data: Data?) -> Self {
        switch code {
        case 200..<300:
            return parseSuccessResponse(with: code, data: data)
        case 400..<500, 500..<600:
            let errorData = try? parseData(type: ApiError.self, data: data)
            return errorResponse(with: code, data: errorData)
        default:
            return errorResponse(with: code, data: nil)
        }
    }
    
    static func parseData<T: Decodable>(type: T.Type, data: Data?) throws -> T {
        if let data = data {
            do {
                return try JSONDecoder.decoder().decode(type, from: data)
            } catch let jsonErr {
                print("Decoding error: \(jsonErr)")
                throw NonApiError.jsonDecodingFailure
            }
        } else {
            throw NonApiError.invalidData
        }
    }
}

extension ApiResponse where DataType == Void {
   public static func parseSuccessResponse(with code: Int, data: Data?) -> Self {
        return successResponse(with: code, data: nil)
    }
}

extension ApiResponse where DataType: Decodable {
    public static func parseSuccessResponse(with code: Int, data: Data?) -> Self {
        let responseData = try? parseData(type: DataType.self, data: data)
        return successResponse(with: code, data: responseData)
    }
}

extension JSONDecoder {
    static func decoder(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .formatted(DateFormatter.iso8601Full)) -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        return decoder
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
