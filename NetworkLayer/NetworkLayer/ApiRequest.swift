//
//  ApiRequest.swift
//  TilesMap

import Foundation

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

open class ApiRequest<ResponseType: ApiResponse> {
    var path: String
    var method: HttpMethod
    var body: Data?
    var isAuthorized: Bool

    public init<T: Encodable>(path: String, method: HttpMethod, data: T? = nil, isAuthorized: Bool = false) {
        let queryCharSet = NSCharacterSet.urlQueryAllowed
        self.path = path.addingPercentEncoding(withAllowedCharacters: queryCharSet)!
        self.method = method
        self.body = try? JSONEncoder().encode(data)
        self.isAuthorized = isAuthorized
    }

    public init(path: String, method: HttpMethod, isAuthorized: Bool = false) {
        let queryCharSet = NSCharacterSet.urlQueryAllowed
        self.path = path.addingPercentEncoding(withAllowedCharacters: queryCharSet)!
        self.method = method
        self.isAuthorized = isAuthorized
    }
}
