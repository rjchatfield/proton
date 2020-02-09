//
//  AttributesDecoding.swift
//  Proton
//
//  Created by Rajdeep Kwatra on 17/1/20.
//  Copyright © 2020 Rajdeep Kwatra. All rights reserved.
//

import Foundation

public protocol AttributesDecoding {
    associatedtype TypeToDecode
    var name: String { get }
    func decode(_ value: TypeToDecode) -> Attributes
}

public struct AnyAttributeDecoding<EncodedType>: AttributesDecoding {
    public let name: String
    let decoding: (EncodedType) -> Attributes

    public init<D: AttributesDecoding>(_ decoder: D) where EncodedType == D.TypeToDecode {
        self.name = decoder.name
        self.decoding = decoder.decode
    }

    public func decode(_ value: EncodedType) -> Attributes {
        return decoding(value)
    }
}