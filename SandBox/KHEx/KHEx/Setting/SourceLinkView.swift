//
//  SourceLinkView.swift
//  KH
//
//  Created by Park Youngeun on 2021/04/19.
//

import SwiftUI

struct SourceLinkView: View {
    var body: some View {
        GroupBox(){
            HStack{
                Text("문의 및 의견 보내기")
                Spacer()
                Link("Korea Hitory 300", destination: URL(string: "http://www.wikipedia.com")!)
                Image(systemName: "arrow.up.right.square")
            }
            .font(.footnote)
        }
    }
}

struct SourceLinkView_Previews: PreviewProvider {
    static var previews: some View {
        SourceLinkView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
