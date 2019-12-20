//
//  NetworkManager.swift
//  TWWorkshop
//
//  Created by sarath-7196 on 20/12/19.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

typealias ApiResponse = (Data?, Error?) -> Void

enum APIResponse<T> {
    case success(T)
    case error(Error)
}

enum APIError: Error {
    case unknown, badResponse, jsonDecoderError, imageDownload, imageConvert
}

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager.init()
    
    var session: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
    }
    
    private override init() {
        
    }
    
    func getData(with urlStr: String, completion: @escaping ApiResponse) {
        guard let url = URL.init(string: urlStr) else {
            completion(nil, nil)
            return
        }
        let request = URLRequest.init(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }
        task.resume()
    }
    
    func get<T: Decodable>(with request: URLRequest, type: T ,completion: @escaping (APIResponse<T>) -> Void) {
        
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(.error(error!))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode, data != nil else {
                completion(.error(APIError.badResponse))
                return
            }
            
            do {
                let value = try JSONDecoder().decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(.success(value))
                }
            } catch {
                completion(.error(APIError.jsonDecoderError))
            }
        }
        
        task.resume()
    }
    
}
