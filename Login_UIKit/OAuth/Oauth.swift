//
//  Oauth.swift
//  Login_UIKit
//
//  Created by 游宗諭 on 2020/6/19.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import Foundation

protocol OAuthDelegate:AnyObject {
    func oAuthComplete(_ result:OAuth.OAuthResult)
}

class OAuth {
    typealias OAuthResult =  Result<OAuthCredential,Error>
    static func makeAvaliableButtons(oAuth: OAuth) -> [OAuthButton] { [
        AppleOAuthButton(oAuth: oAuth),
        ]
    }
    var provider:OAuthProvider?
    weak var oAuthDelegate:OAuthDelegate?
    let serverAuth = ServerAuth()
    func startLogin(with oauthID:OauthID) {
        self.provider = oauthID.provider
        provider?.startLogin()
        serverAuth.continueDelegate = self
    }
    
}
extension OAuth: OAuthProviderDelegate {
    func didReceived(_ result:OAuthResult) {
        print(Self.self, #function)
        let token = try! result.get().token
        self.serverAuth.login(token)
    }
    
}


extension OAuth: ServerAuthDelegate {
    func didReceive(result: ServerAuth.ServerAuthResult) {
        let rt = makeOAuthResult(result)
        oAuthDelegate?.oAuthComplete(rt)
    }
}

private func makeOAuthResult(
    _ result: ServerAuth.ServerAuthResult
) -> OAuth.OAuthResult  {
    result.map { (json) -> OAuthCredential in
        OAuthCredential(token: json._令牌,
                        name: json._名字,
                        email: nil)
    }
}
