//
//  URLSession+Extensions.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import Foundation

extension URLSession {
    
    enum SessionError: Error {
        case noData
        case statusCode
    }
    
    func dataTask<T: Decodable>(with url: URL,
                                completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        return self.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, response, error)
                return
            }
            
            if let response = response as? HTTPURLResponse,
               (200..<300).contains(response.statusCode) == false {
                completionHandler(nil, response, SessionError.statusCode)
            }
            
            guard let data = data else {
                completionHandler(nil, response, SessionError.noData)
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completionHandler(decoded, response, nil)
            } catch(let error) {
                completionHandler(nil, response, error)
            }
        }
    }
    
    
    func getData<T: Decodable>(url: String, completion: @escaping (T) -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data: T?, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let value = data {
                    completion(value)
                }
            }).resume()
        }
    }
}
