import Foundation

extension URLSession {
    func backportData(for request: URLRequest, delegate: URLSessionTaskDelegate? = nil) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let data = data, let response = response else {
                    continuation.resume(throwing: ShiftsError.badData)
                    return
                }
                continuation.resume(returning: (data, response))
            }.resume()
        }
    }
}
