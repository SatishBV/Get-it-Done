//
//  Checkbox.swift
//  Get it Done
//
//  Created by Satish Bandaru on 26/06/21.
//

import Foundation
import SwiftUI

struct Checkbox: View {
    @Binding var checked: Bool
    var color: Color

    var body: some View {
        Image(systemName: checked ? "checkmark.circle.fill" : "circle")
            .resizable()
            .foregroundColor(checked ? Color.black.opacity(0.7) : color)
            .frame(width: 24, height: 24)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

struct Checkbox_Preview: PreviewProvider {
    struct CheckboxViewHolder: View {
        @State var checked = false

        var body: some View {
            Checkbox(checked: $checked, color: .gray)
        }
    }

    static var previews: some View {
        CheckboxViewHolder()
    }
}
