//
//  DetailViewa.swift
//  KH240
//
//  Created by Park Youngeun on 2021/05/09.
//

import SwiftUI
import AVKit

struct DVa: View {
    @State private var isPresented = false
    @EnvironmentObject var myInfo: MyInfo
    @Environment(\.presentationMode) var mode
    @State var audioPlayer: AVAudioPlayer!
    
    
    var body: some View {
        List{
            Button(action: {
                self.isPresented.toggle()
            }, label: {
                HStack{
                    Text("1. 한국사 오리엔테이션(시대 구분)")
                    if myInfo.ona1 == false {
                        Text("완료")
                            .foregroundColor(.blue)
                            .animation(.easeInOut)//부드럽게 움직임
                    } else{Text("")}
                }
            })
            .fullScreenCover(isPresented: $isPresented, content: {MDVa1()})
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                    Button(action : {
                        self.mode.wrappedValue.dismiss()
                    }){
                    Text("Ⅰ. 한국사 자르기")
                })
    }
}

struct DVa_Previews: PreviewProvider {
    static var previews: some View {
        DVa()
            .environmentObject(MyInfo())
    }
}
