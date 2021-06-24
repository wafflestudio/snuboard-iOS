//
//  UnderlinedTextFieldView.swift
//  snuboard
//
//  Created by Subeen Park on 2021/06/14.
//

import SwiftUI

struct UnderlinedTextFieldView: View {
    
    
    private var label = "DefaultLabel"
    private var placeholder = ""
    private var secureMode = false
    @Binding var field: String
    @State private var isEditing = false
    
    init(label: String, placeholder: String, secureMode: Bool=false, field: Binding<String>) {
        self.label = label
        self.placeholder = placeholder
        self.secureMode = secureMode
        self._field = field
    }
    
    var body: some View {
        VStack(spacing: 2)
        {
            HStack {
                
            Text(label)
                .foregroundColor(Const.ColorSet.Gray3.color)
                .font(.system(size: 14))
            Spacer()
            }
            
            if secureMode {
                SecureField("", text: $field)
                    .frame(height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .modifier(ClearButton(text: $field, show: $isEditing))
                
            }
            
            else {
                TextField("", text: $field) {
                    isEditing in
                    self.isEditing = isEditing
                }
                    .frame(height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .modifier(ClearButton(text: $field, show: $isEditing))
                    .disableAutocorrection(true)
            }
            
            
            Divider()
             .frame(height: 1)
             .padding(.horizontal, 30)
                .background(Const.ColorSet.Gray4.color)
        }
    }
}

//struct UnderlinedTextFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        UnderlinedTextFieldView()
//    }
//}
