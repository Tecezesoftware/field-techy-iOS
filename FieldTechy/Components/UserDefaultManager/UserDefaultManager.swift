//
//  UserDefaultManager.swift
//  FieldTechy
//
//  Created by Kowsalya on 24/08/26.
//

import Foundation

final class UserDefaultsManager {

    static let shared = UserDefaultsManager()

    private init() {}

    private enum Keys {
        static let isLoggedIn = "isLoggedIn"
        static let isClient = "isClient"
    }

    // MARK: - Save Login Status
    func setLoginStatus(_ isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: Keys.isLoggedIn)
    }

    // MARK: - Get Login Status
    var isLoggedIn: Bool {
        return UserDefaults.standard.bool(
            forKey: Keys.isLoggedIn
        )
    }
    
    //MARK: - Set Client/Engineer Login Status
    func setIsClient(_ isClient: Bool) {
        UserDefaults.standard.set(isClient, forKey: Keys.isClient)
    }
    
    // MARK: - Get Client/Engineer Login Status
    var getIsClient: Bool {
        return UserDefaults.standard.bool(
            forKey: Keys.isClient
        )
    }
    
    // MARK: - Logout
    func logout() {
        UserDefaults.standard.set(
            false,
            forKey: Keys.isLoggedIn
        )
    }
}
