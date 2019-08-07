# MKQRScanner

[![CI Status](https://img.shields.io/travis/mkhglab@gmail.com/MKQRScanner.svg?style=flat)](https://travis-ci.org/mkhglab@gmail.com/MKQRScanner)
[![Version](https://img.shields.io/cocoapods/v/MKQRScanner.svg?style=flat)](https://cocoapods.org/pods/MKQRScanner)
[![License](https://img.shields.io/cocoapods/l/MKQRScanner.svg?style=flat)](https://cocoapods.org/pods/MKQRScanner)
[![Platform](https://img.shields.io/cocoapods/p/MKQRScanner.svg?style=flat)](https://cocoapods.org/pods/MKQRScanner)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Screenshots:

<img src="https://github.com/MKHGLab/MKQRScanner/blob/master/Screenshots/screenshot_home.png" width="200px" > <img src="https://github.com/MKHGLab/MKQRScanner/blob/master/Screenshots/screenshot_scan_QR.png" width="200px" >

Sample Usage:

```swift
import UIKit
import MKQRScanner

class ViewController: UIViewController {
    @IBOutlet weak var infoLbl: UILabel!

    var scanner: MKQRScanner?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func scanTapped(_ sender: Any) {
        scanner = MKQRScanner(navigationController: navigationController, delegate: self)
        scanner?.start()
    }
}

extension ViewController: MKQRScannerDelegate {
    func scanFailed(error: Error) {
        print(#function)
        print(error)
    }

    func scanSuccessful(result: String) {
        print(result)
        infoLbl.text = result
    }
    
    func scanCanceled() {
        print(#function)
        infoLbl.text = "Scan canceled"
    }   
}
```

## Installation

MKQRScanner is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MKQRScanner'
```

## Author
Md. Kamrul Hasan, mhgolap11@gmail.com

© MKHG Lab, mkhglab@gmail.com

## License

MKQRScanner is available under the MIT license. See the LICENSE file for more info.
