//
//  APIError.swift
//  NewsAppReview
//
//  Created by Jungjin Park on 2024-06-23.
//

import Foundation

struct APIErrorMessage: Decodable {
    var error: Bool
    var reason: String
}

enum APIError: LocalizedError {
    case invalidResponse
    case invalidReqestError(String)
    case transportError(Error)
    case validationError(String)
    case decodingError
    case serverError(statusCode: Int, reason: String? = nil, retryAfter: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response"
        case .invalidReqestError(let message):
            return "Invalid request: \(message)"
        case .transportError(let error):
            return "Transport error: \(error)"
        case .validationError(let reason):
            return "Validation error: \(reason)"
        case .decodingError:
            return "The server returned data in an unexpected format. Try updating the app."
        case .serverError(let statusCode, let reason, let retryAfter):
            return "Server error with code: \(statusCode), reason: \(reason ?? "no reason given"), retry after: \(retryAfter ?? "no retry after provided")"
        }
    }
}
