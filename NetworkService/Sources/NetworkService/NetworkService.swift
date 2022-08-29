import SwiftUI
import Model

public enum ShiftsError: Error {
    case badUrl
    case badData
}

public enum ResponseType: String {
    case week
    case _4day = "4day"
    case list
}

public struct ShiftsService {
    public struct FetchRequest {
        public let responseType: ResponseType
        public let shiftStart: String
        public let address: String
        
        public  init(responseType: ResponseType, shiftStart: String, address: String) {
            self.responseType = responseType
            self.shiftStart = shiftStart
            self.address = address
        }
    }
    
    public let fetchShifts: (_ request: FetchRequest) async throws -> [ShiftRespone]
}

extension ShiftsService {
    public static func live(urlSession: URLSession = .shared) -> Self {
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
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(ShiftDataRespone.self, from: data).data
        })
    }
}
