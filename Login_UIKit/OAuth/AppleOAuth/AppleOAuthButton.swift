//
//  AppleOAuthButton.swift
//  Login_UIKit
//
//  Created by 游宗諭 on 2020/6/19.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import UIKit

class AppleOAuthButton:OAuthButton {
    override func config() {
        self.backgroundColor = .black
        self.setTitle("apple", for: .normal)
    }
    
    
    override func shouldBeOverrideFunc() {
        print(#function)
        let provider = AppleOAuthProvider(window!,
                                          oAuthProviderDelegate: oAuth)
        let oauthID = OauthID( id: "apple",
                               provider: provider)
        oAuth?.startLogin(with: oauthID)
    }
}
