//
//  APIError.swift
//  FieldTechy
//
//  Created by Kowsalya on 20/10/26.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError
    case message(String)
    case noInternet

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid API URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .serverError(let code):
            return "Server returned status code \(code)."
        case .decodingError:
            return "Unable to read the server response."
        case .message(let message):
            return message
        case .noInternet:
            return "Please check your internet connection."
        }
    }
}
