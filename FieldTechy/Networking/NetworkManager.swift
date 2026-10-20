//
//  NetworkManager.swift
//  FieldTechy
//
//  Created by Kowsalya on 20/10/26.
//

import Foundation
import Combine

final class NetworkManager {

    static let shared = NetworkManager()

    private let session = URLSession.shared

    private init() {}

    func post<Request: Encodable, Response: Decodable>(
        endpoint: String,
        body: Request,
        responseType: Response.Type
    ) -> AnyPublisher<Response, APIError> {

        guard let url = URL(
            string: APIConstants.baseURL + endpoint
        ) else {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )

        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            return Fail(
                error: APIError.message("Unable to encode request.")
            )
            .eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: request)
            .mapError { error -> APIError in
                .message(error.localizedDescription)
            }
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse
                else {
                    throw APIError.invalidResponse
                }

                guard (200...299).contains(response.statusCode) else {
                    if let body = try? JSONSerialization.jsonObject(
                        with: output.data
                    ) as? [String: Any],
                       let message = body["message"] as? String {
                        throw APIError.message(message)
                    }

                    throw APIError.serverError(response.statusCode)
                }

                return output.data
            }
            .mapError { error -> APIError in
                (error as? APIError) ??
                    .message(error.localizedDescription)
            }
            .decode(
                type: Response.self,
                decoder: JSONDecoder()
            )
            .mapError { error -> APIError in
                (error as? APIError) ??
                    .decodingError
            }
            .eraseToAnyPublisher()
    }
}
