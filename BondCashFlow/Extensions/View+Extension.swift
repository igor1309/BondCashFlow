//
//  View+Extension.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 04.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

extension View {
    /// [Rounded Borders in SwiftUI - Stack Overflow](https://stackoverflow.com/questions/57753997/rounded-borders-in-swiftui)
    ///
    /// Usage:
    /// .addBorder(Color.width, width: 1, cornerRadius: 10)
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat = 16) -> some View where S: ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(content, lineWidth: width))
    }
    
    /// View extension to make view look like card, with default values.
    /// - Parameter borderColor: color of the border
    /// - Parameter width: border witdth
    /// - Parameter cornerRadius: corner radius
    public func cardStyle(borderColor: Color = .systemGray5, width: CGFloat = 1, cornerRadius: CGFloat = 16) -> some View {
        return padding().overlay(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous).strokeBorder(borderColor))
        
    }
}
