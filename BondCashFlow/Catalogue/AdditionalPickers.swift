//
//  AdditionalPickers.swift
//  BondCashFlow
//
//  Created by Igor Malyarov on 02.09.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct CbondOperationPicker: View {
    @Binding var cbondOperation: String
    
    var body: some View {
        Picker(selection: $cbondOperation, label: Text("Операция")) {
            Text("Потоки").tag("get_flow")
            Text("Эмиссии").tag("get_emissions")
        }
    }
}

struct CbondLimitPicker: View {
    @Binding var cbondLimit: Int
    
    var body: some View {
        Picker(selection: $cbondLimit, label: Text("Лимит запроса")) {
            Text("0").tag(0)
            Text("1").tag(1)
            Text("10").tag(10)
            Text("50").tag(50)
            Text("100").tag(100)
            Text("500").tag(500)
            Text("1000").tag(1000)
        }
    }
}

struct CbondOffsetPicker: View {
    @Binding var cbondOffset: Int
    
    var body: some View {
        Picker(selection: $cbondOffset, label: Text("Сдвиг")) {
            Text("0").tag(0)
            Text("10").tag(10)
            Text("50").tag(50)
            Text("100").tag(100)
            Text("500").tag(500)
            Text("1000").tag(1000)
        }
    }
}

struct AdditionalPickers_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                CbondOperationPicker(cbondOperation: .constant("get_emissions"))
                CbondLimitPicker(cbondLimit: .constant(10))
                CbondOffsetPicker(cbondOffset: .constant(50))
            }
        }
    }
}
