# PMWebView

[![CI Status](https://img.shields.io/travis/PattoMotto/PMWebView.svg?style=flat)](https://travis-ci.org/PattoMotto/PMWebView)
[![Version](https://img.shields.io/cocoapods/v/PMWebView.svg?style=flat)](https://cocoapods.org/pods/PMWebView)
[![License](https://img.shields.io/cocoapods/l/PMWebView.svg?style=flat)](https://cocoapods.org/pods/PMWebView)
[![Platform](https://img.shields.io/cocoapods/p/PMWebView.svg?style=flat)](https://cocoapods.org/pods/PMWebView)

## Preview
![pmwebview-1](https://user-images.githubusercontent.com/1745000/43672817-0c0cd820-97e0-11e8-9f8f-c44533ad5283.gif)

## Example

```swift
extension ViewController {
    private func presentPMWevViewAsChild() {
        let vc = PMWebViewBuilder.build(
            url: url,
            output: self
        )
        pmWebViewInput = vc
        addChildViewController(vc)
        vc.didMove(toParentViewController: self)
    }

    private func presentPMWevViewAsModal() {
        let vc = PMWebViewBuilder.build(
            url: url,
            output: self
        )
        pmWebViewInput = vc
        present(vc, animated: true)
    }
}

extension ViewController: PMWebViewOutput {
    func webViewWillAppear() {
        print("webViewWillAppear")
    }

    func webViewWillDisappear() {
        print("webViewWillDisappear")
    }
}

```
More details in `Example project`

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

PMWebView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PMWebView'
```

## Author

PattoMotto

## License

PMWebView is available under the MIT license. See the LICENSE file for more info.
