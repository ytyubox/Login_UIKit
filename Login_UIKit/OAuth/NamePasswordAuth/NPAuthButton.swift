//
//  NPAuthButton.swift
//  Login_UIKit
//
//  Created by 游宗諭 on 2020/6/19.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import UIKit
class NPAuthButton: OAuthButton {
    override func config() {
        self.backgroundColor = .red
        self.setTitle("登入", for: .normal)
    }
    unowned var npProvider:NPAuthProvider.NPProvider!
    override func shouldBeOverrideFunc() {
        let provider = NPAuthProvider(npProvider: npProvider,
                                      oAuthProviderDelegate: oAuth)
        let oauthID = OauthID( id: "Name and Password",
                               provider: provider)
        oAuth?.startLogin(with: oauthID)
    }
}
