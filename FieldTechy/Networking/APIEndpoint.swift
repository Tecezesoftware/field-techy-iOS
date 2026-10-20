//
//  APIEndpoint.swift
//  FieldTechy
//
//  Created by Kowsalya on 20/10/26.
//


import Foundation
enum enviornmentUrl: String{
    case Dev = "https://api.dev-ft.demotechhub.xyz"
    case Prod = ""
}

enum APIConstants {
    
    static let enviornment:enviornmentUrl = .Dev
    
    // Replace with your actual development/staging base URL.
    static let baseURL = enviornment.rawValue

    enum Endpoint {
        static let signUp = "/api/auth/register"
        static let login = "/api/auth/login"
    }
}
