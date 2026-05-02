//
//  APIResponse.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//


struct EventsResponse<T: Decodable>: Decodable {
    let success: Int
    let result: T?

    enum CodingKeys: String, CodingKey {
        case success, result
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Int.self, forKey: .success)
        result = try container.decodeIfPresent(T.self, forKey: .result)
    }
}