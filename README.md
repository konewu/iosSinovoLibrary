# iosSinovoLibrary

[![CI Status](https://img.shields.io/travis/konewu/iosSinovoLibrary.svg?style=flat)](https://travis-ci.org/konewu/iosSinovoLibrary)
[![Version](https://img.shields.io/cocoapods/v/iosSinovoLibrary.svg?style=flat)](https://cocoapods.org/pods/iosSinovoLibrary)
[![License](https://img.shields.io/cocoapods/l/iosSinovoLibrary.svg?style=flat)](https://cocoapods.org/pods/iosSinovoLibrary)
[![Platform](https://img.shields.io/cocoapods/p/iosSinovoLibrary.svg?style=flat)](https://cocoapods.org/pods/iosSinovoLibrary)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

1、In order for the app to be able to access Bluetooth，Info.plist  must  add  the following settings
        a、Privacy - Bluetooth Always Usage Description
        b、Privacy - Bluetooth Peripheral Usage Description
2、In order for the app to be able to access WIFI information，
      a、 Add capability  [Access Wifi Information] on  TARGETS
      b、Info.plist  must  add  the following settings
            1、Privacy - Location Always and When In Use Usage Description
            2、Privacy - Location When In Use Usage Description
            3、Privacy - Location Usage Description

## Installation

iosSinovoLibrary is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'iosSinovoLibrary'
```

## Author

konewu, 379301272@qq.com

## License

iosSinovoLibrary is available under the MIT license. See the LICENSE file for more info.
