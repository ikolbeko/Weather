//
//  String+Extensions.swift
//  weather
//
//  Created by Илья Колбеко on 20.02.22.
//

import Foundation

extension String {
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
