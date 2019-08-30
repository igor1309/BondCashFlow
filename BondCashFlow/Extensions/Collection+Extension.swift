//
//  Collection+Extension.swift
//
//  Created by Igor Malyarov on 01.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import Foundation

//  as in macOS Catalina 10.15 Beta 5 Release Notes
//  https://developer.apple.com/documentation/macos_release_notes/macos_catalina_10_15_beta_5_release_notes

public extension Set {
    subscript(member: Element) -> Bool {
        get { contains(member) }
        set {
            if newValue {
                insert(member)
            } else {
                remove(member)
            }
        }
    }
}

public struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    public typealias Index = Base.Index
    public typealias Element = (index: Index, element: Base.Element)
    
    public let base: Base
    
    public var startIndex: Index { base.startIndex }
    
    public var endIndex: Index { base.endIndex }
    
    public func index(after i: Index) -> Index {
        base.index(after: i)
    }
    
    public func index(before i: Index) -> Index {
        base.index(before: i)
    }
    
    public func index(_ i: Index, offsetBy distance: Int) -> Index {
        base.index(i, offsetBy: distance)
    }
    
    public subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}

public extension RandomAccessCollection {
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}
