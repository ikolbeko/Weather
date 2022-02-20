//
//  URLSession+Extensions.swift
//  weather
//
//  Created by Илья Колбеко on 19.02.22.
//

import Foundation

extension URLSession {

    // 1
    enum SessionError: Error {
        case noData
        case statusCode
    }

    // 2
    func dataTask<T: Decodable>(with url: URL,
                                completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        // 3
        return self.dataTask(with: url) { (data, response, error) in
            // 4
            guard error == nil else {
                completionHandler(nil, response, error)
                return
            }

            // 5
            if let response = response as? HTTPURLResponse,
                (200..<300).contains(response.statusCode) == false {
                completionHandler(nil, response, SessionError.statusCode)
            }

            // 6
            guard let data = data else {
                completionHandler(nil, response, SessionError.noData)
                return
            }

            // 7
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completionHandler(decoded, response, nil)
            } catch(let error) {
                completionHandler(nil, response, error)
            }
        }
    }
}
