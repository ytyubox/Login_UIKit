#  Login module UIKit

This is a login module design practice, the ViewController / View only needs fallowing lines:

```swift

class ViewController: UIViewController {

    let oAuth = OAuth()
    @IBOutlet var OAuthButton:[OAuthButton]!

}

extension ViewController: OAuthDelegate {
    func oAuthComplete(_ result: Result<OAuthCredential, Error>) {
    /* handle OAuthCredential or Error */
    
    }
}
```

Skills:
1. Template pattern: using super class function with `fatarError()`, make sure it will be override.
2. Pass Result by delegate: Every object has its continue job delegate.
