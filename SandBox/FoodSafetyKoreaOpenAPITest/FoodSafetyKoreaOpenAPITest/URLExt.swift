//
//  URLExt.swift
//  FoodSafetyKoreaOpenAPITest
//
//  Created by changae choi on 2020/12/31.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map
        { URLQueryItem(name: $0.0, value: $0.1) }
        
        return components?.url
    }
}
