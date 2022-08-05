//
//  opacityExtension.swift
//  Flags
//
//  Created by Daria Andrioaie on 05.08.2022.
//

import Foundation
import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

extension View {
    func addOpacityToStripe(stripe: Stripe, currentFlag: Flag) -> some View {
        var parent = stripe.parent

        while parent !== currentFlag && parent.parent != nil {
            parent = parent.parent!
        }
        
        if parent === currentFlag {
            return self.opacity(1)
        }
        else {
            return self.opacity(0.4)
        }
        
    }
}
