//
//  AppleOAuthProvider.swift
//  Login_UIKit
//
//  Created by 游宗諭 on 2020/6/19.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import Foundation
import AuthenticationServices

class AppleOAuthProvider:OAuthProvider {
    private
    struct AppleError:Error {
        var message:String
        init(_ m:String) {
            self.message = m
        }
    }
    convenience init(
        _ presentationAnchor:ASPresentationAnchor,
        oAuthProviderDelegate: OAuthProviderDelegate?
    ) {
        self.init()
        self.oAuthProviderDelegate = oAuthProviderDelegate
        self.presentationAnchor = presentationAnchor
    }
    
    private typealias AppleResult =  Result<ASAuthorizationAppleIDCredential,Error>
    
    weak var presentationAnchor:ASPresentationAnchor?
    
    override func startLogin() {
        print(Self.self,#function)
        
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        
        request.requestedScopes = [.fullName, .email]
        
        let authController = ASAuthorizationController(
            authorizationRequests: [request])
        
        authController.presentationContextProvider = self
        
        authController.delegate = self
        
        // REMINDER: - go mock first
        authController.performRequests()
    }
    private
    func handle(result: AppleResult) {
        print(Self.self, #function)
        let appleCredential = try! result.get()
        let credential = OAuthCredential(
            token: appleCredential.user,
            name: appleCredential.fullName?.description,
            email: appleCredential.email)
        oAuthProviderDelegate?.didReceived(.success(credential))
    }
    deinit {
        print(Self.self, #function)
    }
}

extension AppleOAuthProvider: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        presentationAnchor!
    }
    
    
}
extension AppleOAuthProvider: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            let message = "authorization.credential is nil"
            let error = AppleError(message)
            self.handle(result: .failure(error))
            return
        }
        
        handle(result: .success(credential))
        // upload credential to api
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Show error
        self.handle(result: .failure(error))
    }
    
}
