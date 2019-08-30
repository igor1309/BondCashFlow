//
//  SaveDoneCancelButtons.swift
//  Restaurants
//
//  Created by Igor Malyarov on 15.08.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SaveDoneCancelButtons: View {
    @Environment(\.presentationMode) var presentation
    var isCancelRed = false
    var doneButtonTitle = "Done" //  or "Save"
    var closure: () -> Void
    var willDismiss = true
    
    var body: some View {
        HStack {
            Button("Cancel") {
                self.presentation.wrappedValue.dismiss()
            }
            .foregroundColor(isCancelRed ? Color.systemRed : Color.accentColor)
            
            Spacer()
            
            Button(doneButtonTitle) {
                self.closure()
                if self.willDismiss {
                    self.presentation.wrappedValue.dismiss()
                }
            }
            .foregroundColor(Color.accentColor)
        }
    }
}

#if DEBUG
struct SaveDoneCancelButtons_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SaveDoneCancelButtons(isCancelRed: true,
                                  doneButtonTitle: "Save",
                                  closure: {})
                .padding()
            
            SaveDoneCancelButtons(closure: {},
                                  willDismiss: false)
                .padding()
        }
    }
}
#endif
