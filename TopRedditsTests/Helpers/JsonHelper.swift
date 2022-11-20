//
//  DataToJson.swift
//  TopRedditsTests
//
//  Created by Arthur Givigir on 19/11/22.
//

import Foundation

enum JsonFile: String {
    case topReddits = "top_reddits"
}

class JsonHelper {
    static func dataFrom(_ file: JsonFile) -> Data? {
        let path = Bundle(for: self).path(forResource: file.rawValue, ofType: "json")!
        let jsonString = try! String(contentsOfFile: path, encoding: .utf8)
        return jsonString.data(using: .utf8)
    }
    
    static func objectFrom<T: Decodable>(_ file: JsonFile) -> T? {
        let decoder = JSONDecoder()
        guard let data = JsonHelper.dataFrom(file) else { return nil }
        return try? decoder.decode(T.self, from: data)
    }
}
