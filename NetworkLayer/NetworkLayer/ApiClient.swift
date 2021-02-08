//
//  ApiClient.swift
//  TilesMap

import Foundation

public class ApiClient {
    public static let shared = ApiClient()
    public var baseUrl: URL!
    
    public  func execute<RequestType: ApiRequest<ResponseType>, ResponseType>(request: RequestType, completion: @escaping (RequestType, ResponseType) -> Void) {
        guard let urlRequest = createUrlRequest(from: request) else { assertionFailure();  return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let response = response {
                    let httpResponse = response as! HTTPURLResponse
                    let response = ResponseType.parseResponse(with: httpResponse.statusCode, data: data)
                    completion(request, response)
                }
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    fileprivate func createUrlRequest<RequestType: ApiRequest<ResponseType>, ResponseType>(from apiRequest: RequestType) -> URLRequest?
    {
        guard let url = URL(string: "\(apiRequest.path)", relativeTo: baseUrl) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = apiRequest.method.rawValue
        urlRequest.httpBody = apiRequest.body
        return urlRequest
    }
}
