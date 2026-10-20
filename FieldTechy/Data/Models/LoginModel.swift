//
//  LoginModel.swift
//  FieldTechy
//
//  Created by Kowsalya on 20/10/26.
//

import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable {
    let accessToken: String
    let user: LoginUser
}

struct LoginUser: Decodable {
    let id: Int
    let email: String
    let role: String
    let regionId: Int
}
