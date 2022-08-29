//
//  NetworkService.swift
//  CodingChallenge
//
//  Created by Mirosław Hudaszek on 25/08/2022.
//

import SwiftUI

enum ShiftsError: Error {
    case badUrl
}

enum ResponseType: String {
    case week
    case _4day = "4day"
    case list
}

struct ShiftsService {
    struct FetchRequest {
        let responseType: ResponseType
        let shiftStart: String
        let address: String
    }
    
    let fetchShifts: (_ request: FetchRequest) async throws -> [ShiftRespone]
}

extension ShiftsService {
    static func live(urlSession: URLSession = .shared) -> Self {
        .init(fetchShifts: { request in
            var components = URLComponents()
            components.scheme = "https"
            components.host = "staging-app.shiftkey.com"
            components.path = "/api/v2/available_shifts"
            
            components.queryItems = [
                URLQueryItem(name: "type", value: request.responseType.rawValue),
                URLQueryItem(name: "start", value: request.shiftStart),
                URLQueryItem(name: "address", value: request.address)
            ]
            
            guard let url = components.url else {
                throw ShiftsError.badUrl
            }
            
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let (data, _) = try await URLSession.shared.backportData(for: request)
            return try JSONDecoder().decode(ShiftDataRespone.self, from: data).data
        })
    }
}

extension URLSession {
    func backportData(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let data = data, let response = response else {
                    // tu jakis inny error jeszcze rzucic
                    return
                }
                continuation.resume(returning: (data, response))
            }.resume()
        }
    }
}
