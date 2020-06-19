//
//  OAuthButton.swift
//  Login_UIKit
//
//  Created by 游宗諭 on 2020/6/19.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import UIKit.UIButton

class OAuthButton: UIButton {
    var iconImage:UIImage!
    var title:String!
    weak var oAuth:OAuth?
    convenience init(oAuth:OAuth) {
        self.init()
        self.oAuth = oAuth
        self.config()
        addTarget(
            self,
            action: #selector(didTapSelf),
            for: .touchUpInside)
    }
    
    @objc func didTapSelf() {
        shouldBeOverrideFunc()
    }
    func config() {
        
    }
    func shouldBeOverrideFunc() {
        fatalError("Subclass of OAuthButton should override \(#function)")
    }
}
