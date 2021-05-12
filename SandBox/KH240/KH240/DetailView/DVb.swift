//
//  DVb.swift
//  KH240
//
//  Created by Park Youngeun on 2021/05/09.
//

import SwiftUI

struct DVb: View {
    @State private var isPresented = false
    @EnvironmentObject var myInfo: MyInfo
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        VStack{
            List{
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    HStack{
                        Text("1. 구석기 시대(채집과 사냥 중심의 생활)")
                        if myInfo.onb1 == false {
                            Text("완료")
                                .foregroundColor(.blue)
                        } else{Text("")}
                    }
                })
                .fullScreenCover(isPresented: $isPresented, content: {
                                    MDVb1()
                })
                
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    HStack{
                        Text("2. 신석기 시대(생산 경제의 탄생)")
                        if myInfo.onb2 == false {
                            Text("완료")
                                .foregroundColor(.blue)
                        } else{Text("")}
                    }
                })
                .fullScreenCover(isPresented: $isPresented, content: {
                                    MDVb2()
                })
                
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    HStack{
                        Text("3. 신석기 시대(원시 신앙과 예술)")
                        if myInfo.onb3 == false {
                            Text("완료")
                                .foregroundColor(.blue)
                        } else{Text("")}
                    }
                })
                .fullScreenCover(isPresented: $isPresented, content: {
                                    MDVb3()
                })
                
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    HStack{
                        Text("4. 청동기 시대(사회 계급의 발생과 국가 탄생)")
                        if myInfo.onb4 == false {
                            Text("완료")
                                .foregroundColor(.blue)
                        } else{Text("")}
                    }
                })
                .fullScreenCover(isPresented: $isPresented, content: {
                                    MDVb4()
                })
                
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    HStack{
                        Text("5. 초기 철기 시대(기술과 경쟁의 심화)")
                        if myInfo.onb5 == false {
                            Text("완료")
                                .foregroundColor(.blue)
                        } else{Text("")}
                    }
                })
                .fullScreenCover(isPresented: $isPresented, content: {
                                    MDVb5()
                })
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                    Button(action : {
                        self.mode.wrappedValue.dismiss()
                    }){
                    Text("Ⅱ. 선사 시대")
                })
    }
}

struct DVb_Previews: PreviewProvider {
    static var previews: some View {
        DVb()
            .environmentObject(MyInfo())
    }
}
