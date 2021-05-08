//
//  SettingLabelView.swift
//  KH
//
//  Created by Park Youngeun on 2021/04/19.
//

import SwiftUI

struct SettingsLabelView: View {
    var labelText: String
    var labelImage: String
    
    var body: some View {
        HStack {
            Text(labelText .uppercased()).fontWeight(.bold)
            Spacer()
            Image(systemName: labelImage)
        }
    }
}

struct SettingsLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabelView(labelText: "한국사300", labelImage: "info.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
