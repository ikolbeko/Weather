//
//  URLSession+Extensions.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import Foundation

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? JSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func networkDataTask(with url: URL, completionHandler: @escaping (WeatherData?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

//extension URLSession {
//
//    // 1
//    enum SessionError: Error {
//        case noData
//        case statusCode
//    }
//
//    /// Wraps the standard dataTask method with a JSON decode attempt using the passed generic type.
//    /// Throws an error if decoding fails
//    /// - Parameters:
//    ///   - url: The URL to be retrieved.
//    ///   - completionHandler: The completion handler to be called once decoding is complete / fails
//    /// - Returns: The new session data task
//
//    // 2
//    func dataTask<T: Decodable>(with url: URL,
//                                completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//
//        // 3
//        return self.dataTask(with: url) { (data, response, error) in
//            // 4
//            guard error == nil else {
//                completionHandler(nil, response, error)
//                return
//            }
//
//            // 5
//            if let response = response as? HTTPURLResponse,
//                (200..<300).contains(response.statusCode) == false {
//                completionHandler(nil, response, SessionError.statusCode)
//            }
//
//            // 6
//            guard let data = data else {
//                completionHandler(nil, response, SessionError.noData)
//                return
//            }
//
//            // 7
//            do {
//                let decoded = try JSONDecoder().decode(T.self, from: data)
//                completionHandler(decoded, response, nil)
//            } catch(let error) {
//                completionHandler(nil, response, error)
//            }
//        }
//    }
//}
