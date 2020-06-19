//
//  NPAuthProvider.swift
//  Login_UIKit
//
//  Created by 游宗諭 on 2020/6/19.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import Foundation

protocol NameProvider:NSObject {
    func name() -> String
}
protocol PasswordProvider:NSObject {
    func password() ->String
}
class NPAuthProvider: OAuthProvider {
    typealias NPProvider = NameProvider & PasswordProvider
    convenience init(npProvider:NPProvider,
                     oAuthProviderDelegate: OAuthProviderDelegate?) {
        self.init()
        self.npProvider = npProvider
        self.oAuthProviderDelegate = oAuthProviderDelegate
    }
    unowned var npProvider: NPProvider!
    let url:URL = URL(string: "https://apple.com")!
    override func startLogin() {
        let name = npProvider.password()
        let pw = npProvider.password()
        var request = URLRequest(url: url)
        request.httpBody = (name + "," + pw).data(using: .utf8)
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { res , data ,error in
            let result: Result<URLSession.DataTaskPublisher.Output,Error>
            defer {
                DispatchQueue.main.async {
                    self.didFinishTask(result)
                }
            }
            if let error = error {
                result = .failure(error)
                return
            }
            result = .success((res!,data!))
        }
        .resume()
    }
    
    func didFinishTask(_ result:Result<URLSession.DataTaskPublisher.Output,Error>) {
        let nextResult:OAuth.OAuthResult = result.map(mapping)
        oAuthProviderDelegate?.didReceived(nextResult)
    }
    
}

private func mapping( _ result:
    URLSession.DataTaskPublisher.Output) -> OAuthCredential {
    OAuthCredential(token: "someToken", name: "some name", email: "some@mail.com")
    
}
