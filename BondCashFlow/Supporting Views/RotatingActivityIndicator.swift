//
//  RotatingActivityIndicator.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 02.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RotatingActivityIndicator: View {
    var text: String = "загрузка…"
    var color: Color = .systemGray2
    
    var body: some View {
        HStack {
            RotatingSqureSplit(color: color)
            
            Text(text)
                .foregroundColor(.secondary)
        }
    }
}

struct RotatingSqureSplit: View {
    var color: Color = .systemGray2
    @State private var isAnimated = false
    
    var body: some View {
        Image(systemName: "square.split.2x2.fill")
            .foregroundColor(color)
            .rotationEffect(.degrees(isAnimated ? 0 : -720), anchor: .center)
            .opacity(isAnimated ? 0 : 1)
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true).speed(2/3))
            .onAppear {
                self.isAnimated = true
        }
    }
}

struct RotatingActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        RotatingActivityIndicator(text: "загрузка и обработка данных…",
                                  color: .systemBlue)
    }
}
