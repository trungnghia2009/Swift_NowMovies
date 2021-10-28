///https://viblo.asia/p/opaque-return-types-trong-swift-LzD5dg90ljY

// If protocol contains associatedtype, we cannot return protocol type as normal
// Need to use opaque type "some"

import Foundation

protocol MobileOS {
    associatedtype Version
    var version: Version { get }
    init(version: Version)
}

struct iOS: MobileOS {
    var version: Float
}

struct Android: MobileOS {
    var version: String
}

// Using opaque type
func buildPreferredOS() -> some MobileOS {
    return iOS(version: 5.2)
}

let a = buildPreferredOS()
a.version

// Using generic type
func buildOS<T: MobileOS>(version: T.Version) -> T {
    return T(version: version)
}

let android: Android = buildOS(version: "not")

// Only allow to return one specific type
func buildSome() -> some MobileOS {
    let isEven = Int.random(in: 0...100) % 2 == 0
    return isEven ? iOS(version: 13.1) : iOS(version: 13.0)
    // return isEven ? iOS(version: 13.1) : Android(version: "Pie") // 2 types, got error
}
