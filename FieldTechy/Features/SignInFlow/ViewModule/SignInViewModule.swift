//
//  SignInViewModule.swift
//  FieldTechy
//
//  Created by Kowsalya on 11/08/26.
//



import Foundation
import Combine

// MARK: - Auth Service
final class AuthService {

    func login(
        email: String,
        password: String
    ) -> AnyPublisher<LoginResponse, APIError> {

        let body = LoginRequest(
            email: email,
            password: password
        )

        return NetworkManager.shared.post(
            endpoint: APIConstants.Endpoint.login,
            body: body,
            responseType: LoginResponse.self
        )
    }
}

// MARK: - Auth ViewModel
final class signInViewModel: ObservableObject {

    @Published var isLoading = false
    @Published var loginResponse: LoginResponse?
    @Published var errorMessage: String?

    private let authService = AuthService()
    private var cancellables = Set<AnyCancellable>()

    func login(email: String, password: String) {

        let trimmedEmail = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedEmail.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter your email and password."
            return
        }

        errorMessage = nil
        loginResponse = nil
        isLoading = true

        authService.login(
            email: trimmedEmail,
            password: password
        )
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] completion in
                guard let self = self else { return }

                self.isLoading = false

                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            },
            receiveValue: { [weak self] response in
                guard let self = self else { return }

                guard !response.accessToken.isEmpty else {
                    self.errorMessage = "Access token is empty."
                    return
                }

                self.loginResponse = response
            }
        )
        .store(in: &cancellables)
    }
}
