//
//  URL+Extensions.swift
//  weather
//
//  Created by Илья Колбеко on 23.02.22.
//

import Foundation

extension URL {
    static func url(with path: String,
                    endpoint: String,
                    queryParams: [String: Any]) -> URL? {
        guard let url = URL(string: path)?.appendingPathComponent(endpoint),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0, value: "\($1)") }
        return urlComponents.url
    }
}
