//
//  Service.swift
//  AppleStore
//
//  Created by Akib Quraishi on 26/09/2019.
//  Copyright © 2019 AkibiOS. All rights reserved.
//

import Foundation

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

class NetworkService {
    
    
    private enum APIError: Error {
        case unknownError
        case connectionError
        case invalidCredentials
        case invalidRequest
        case notFound
        case invalidResponse
        case serverError
        case serverUnavailable
        case timeOut
        case unsuppotedURL
        case responseDataError
    }
    
    private static func checkErrorCode(_ errorCode: Int) -> APIError {
        switch errorCode {
        case 400:
            return .invalidRequest
        case 401:
            return .invalidCredentials
        case 404:
            return .notFound
        //Add morr according to your requirments
        default:
            return .unknownError
        }
    }
    
    
    
    func fetchRequest<T: Decodable>(urlString:String, httpMethod:HTTPMethod, completion: @escaping (Result<T, Error>) -> ()) {
        
        // NSLog(#function + " 🔵 🔵 🔵 URL:\(urlString), \n parameters: \(String(describing: parameters)) \n 🔵 🔵 🔵")
        
        // Create Request
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
    
        
        // Create URLSession instance
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        session.dataTask(with: request)  { (data, resp, err) in
            
            //Http Status Code
            if let statusCode = resp?.getStatusCode() {
                print("Http Status Code: \(statusCode)")
            }
            
            if let err = err {
                completion(.failure(err))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.responseDataError))
                return
            }
            
            
            /* Debug Data
             NSLog(#function + " 🔵 Output Raw Data Size \(urlString): \(data)")
             let outputDataStr  = String(data: data, encoding: String.Encoding.utf8) as String?
             NSLog(#function + " 🔵 Output String:\(String(describing: outputDataStr))")
           */
            
            
            do {
                let parsedObj = try JSONDecoder().decode(T.self, from: data)
                completion(.success(parsedObj))
            } catch let jsonErr {
                print("🔴 Failed to decode json:", jsonErr)
                completion(.failure(jsonErr))
            }
            
            }.resume()
    }
    
    
}


extension URLResponse {
    
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
