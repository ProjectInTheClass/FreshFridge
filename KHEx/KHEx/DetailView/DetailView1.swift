//
//  DetailView1.swift
//  KHEx
//
//  Created by Park Youngeun on 2021/05/05.
//

import SwiftUI

struct DetailView1: View {
    @State private var isPresented = false
    @EnvironmentObject var myInfo: MyInfo
    
    var body: some View {
        
            List{
                Button(action: {
                    self.isPresented.toggle()
                }, label: {
                    HStack{
                        Text("1. 구석기 시대")
                        if myInfo.ckOn1 == false {
                            Text("완료")
                                .foregroundColor(.blue)
                        } else{Text("")}
                    }
                })
                .fullScreenCover(isPresented: $isPresented, content: {
                                    MDetailView1()
                    
                })
                    
                    
                    
                    
                Button(action: {
                        self.isPresented.toggle()
                    }, label: {
                        HStack{
                            Text("2. 신석기 시대(생활양식의 변화")
                            if myInfo.ckOn2 == false {
                                Text("완료")
                                    .foregroundColor(.blue)
                            } else{Text("")}
                        }
                    })
                    .fullScreenCover(isPresented: $isPresented, content: {
                        MDetailView2()
                })
                    
                    
                Button(action: {
                        self.isPresented.toggle()
                    }, label: {
                        HStack{
                            Text("3. 신석기 시대(원시신앙)")
                            if myInfo.ckOn3 == false {
                                Text("완료")
                                    .foregroundColor(.blue)
                            } else{Text("")}
                        }
                    })
                    .fullScreenCover(isPresented: $isPresented, content: {
                        MDetailView3()
                })
                
                
                Button(action: {
                        self.isPresented.toggle()
                    }, label: {
                        HStack{
                            Text("4. 청동기 시대")
                            if myInfo.ckOn4 == false {
                                Text("완료")
                                    .foregroundColor(.blue)
                            } else{Text("")}
                        }
                    })
                    .fullScreenCover(isPresented: $isPresented, content: {
                        MDetailView4()
                })
                
                Button(action: {
                        self.isPresented.toggle()
                    }, label: {
                        HStack{
                            Text("5. 초기 철기 시대")
                            if myInfo.ckOn5 == false {
                                Text("완료")
                                    .foregroundColor(.blue)
                            } else{Text("")}
                        }
                    })
                    .fullScreenCover(isPresented: $isPresented, content: {
                        MDetailView5()
                })
                
            }
        
                
    }
}

struct DetailView1_Previews: PreviewProvider {
    static var previews: some View {
        DetailView1()
            .environmentObject(MyInfo())
    }
}
