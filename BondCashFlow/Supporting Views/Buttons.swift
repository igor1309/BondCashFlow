//
//  Buttons.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 03.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

/**
Button with nice `padding` (EdgeInsets) for `trailing` location inside `navigationBarItems`. It has a name and `closure` to perform.

- Parameters:
    - name: name of the Button
    - closure: closure to perform
*/
struct TrailingButton: View {
    @Environment(\.presentationMode) var presentation
    var name: String
    var closure: () -> Void
    
    var body: some View {
        Button(action: {
            self.closure()
        }) {
            Text(name)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
        }
    }
}

/// Button with nice `padding` (EdgeInsets) for `leading` location inside `navigationBarItems`.
/// It has a name and `closure` to perform.
///
/// - Parameters:
///     - name: name of the Button
///     - closure: closure to perform
struct LeadingButton: View {
    @Environment(\.presentationMode) var presentation
    var name: String
    var closure: () -> Void
    
    var body: some View {
        Button(action: {
            self.closure()
        }) {
            Text(name)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 16))
        }
    }
}




struct TrailingButtonSFSymbol: View {
    @Environment(\.presentationMode) var presentation
    var systemName: String
    var closure: () -> Void
    
    var body: some View {
        Button(action: {
            self.closure()
        }) {
            Image(systemName: systemName)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 0))
        }
    }
}


struct LeadingButtonSFSymbol: View {
    @Environment(\.presentationMode) var presentation
    var systemName: String
    var closure: () -> Void
    
    var body: some View {
        Button(action: {
            self.closure()
        }) {
            Image(systemName: systemName)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 16))
        }
    }
}

