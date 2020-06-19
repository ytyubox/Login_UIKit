//
//  ViewController.swift
//  Login_UIKit
//
//  Created by 游宗諭 on 2020/6/19.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let oauth = OAuth()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let oauthButtons = OAuth.makeAvaliableButtons(oAuth: oauth)
        let w ,h,s:CGFloat
        (w,h,s) = (50, 100, 10)
        for bIndex in oauthButtons.indices {
            let button = oauthButtons[bIndex]
            view.addSubview(button)
            button.frame = CGRect(
                x: (h + s) * CGFloat(bIndex),
                y: 100,
                width: w,
                height: h)
        }
        oauth.oAuthDelegate = self
    }


}

extension ViewController: OAuthDelegate {
    func oAuthComplete(_ result: Result<OAuthCredential, Error>) {
        print(Self.self, #function)
        let message:String
        defer {
            let saltedMessage = "didGet " + message
            let alert = UIAlertController(title: saltedMessage, message: "", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
        }
        do {
            message = try result.get().token
        } catch {
            message = error.localizedDescription
        }
    }
    
    
}
