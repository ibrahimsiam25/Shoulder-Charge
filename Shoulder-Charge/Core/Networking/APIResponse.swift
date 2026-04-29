//
//  APIResponse.swift
//  Shoulder-Charge
//
//  Created by Eslam Elnady on 29/04/2026.
//


struct APIResponse<T: Decodable>: Decodable {
    let success: Int
    let result: T
}