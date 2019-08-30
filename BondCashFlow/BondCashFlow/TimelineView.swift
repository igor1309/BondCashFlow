//
//  ContentView.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 22.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Row: View {
    @State var hasData = false
    
    var body: some View {
        HStack {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .frame(width: 1, height: 52)
                    .offset(x: 4)
                    .foregroundColor(.systemOrange)
                
                Circle()
                    .fill(hasData ? Color.systemOrange : Color.white)
                    .overlay(Circle().stroke(Color.systemOrange))
                    .frame(width: 7, height: 7)
                    //  overlay with stroke adds extra size need to x-offset to compensate
                    .offset(x:1, y: 12)
                
            }
            
            VStack(alignment: .leading) {
                Text("Hello World").font(.headline).foregroundColor(Color.primary)
                Text("dfl alfg").font(.subheadline).foregroundColor(Color.secondary)
            }
        }
    }
}

struct Timeline: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(0 ..< 25) { item in
                    Row(hasData: item % 2 == 1)
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            .padding()
    }
}

struct TimelineView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Grid()
                    .padding()
                
                Timeline()
            }
                
                .navigationBarTitle("Calendar")
        }
    }
}

#if DEBUG
struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        TimelineView()
            //                Row()
            .previewLayout(.sizeThatFits)
    }
}
#endif
