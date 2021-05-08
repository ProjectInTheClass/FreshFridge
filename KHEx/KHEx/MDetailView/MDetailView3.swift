//
//  MDetailView3.swift
//  KHEx
//
//  Created by Park Youngeun on 2021/05/08.
//

import SwiftUI

struct MDetailView3: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var revealDetails1 = false
    @State private var revealDetails2 = false
    @State private var revealDetails3 = false
    @EnvironmentObject var myInfo : MyInfo
    @State private var isShowAlert = false
    @State private var selectText = "x"
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    DisclosureGroup("1단계. 핵심 정리", isExpanded: $revealDetails1){
                        VStack{
                            Text("청동기 시대의 생활상에 대해 알아보도록 해요.")
                            Image("1")
                                .resizable()
                                .aspectRatio(contentMode: .fit
                                )
                        }
                        
                        
                        Button("그럼 확인학습을 풀어 봅시다"){
                            revealDetails1.toggle()
                            revealDetails2.toggle()
                        }
                    }
                    
                    
                    DisclosureGroup("2단계. 확인 학습", isExpanded: $revealDetails2){
                        Text("청동기 시대와 관련된 문제를 풀어 봅시다.")
                        Image("2")
                            .resizable()
                            .aspectRatio(contentMode: .fit
                            )
                        
                        Button("그럼 기출문항을 풀어 봅시다"){
                            revealDetails2.toggle()
                            revealDetails3.toggle()
                        }
                    }
                    
                    DisclosureGroup("3단계. 기출문제 풀이", isExpanded: $revealDetails3){
                        Text("청동기 시대와 관련된 문제를 풀어 봅시다.")
                        Image("3")
                            .resizable()
                            .aspectRatio(contentMode: .fit
                            )
                        
                        Button("마치기"){
                            isShowAlert.toggle()
                        }
                        .alert(isPresented: $isShowAlert, content: {
                           // Alert(title: Text("alert"), dismissButton: .cancel())
                            let primaryButton =
                                Alert.Button.default(Text("더 학습할래요.")){
                                    selectText = "cancel"
                                }
                            let secondaryButton =
                                Alert.Button.default(Text("예")){
                                    revealDetails3.toggle()
                                    myInfo.ckOn3 = false
                                    myInfo.detailprogress3 = 0.2
                                    myInfo.totalvalue3 = 0.4
                                    presentationMode.wrappedValue.dismiss()
                                }
                            return Alert(title: Text("구석기 시대에 사용한 뗀석기, 약탈경제, 무리 생활에 대한 내용을 이해하셨나요?"), primaryButton: primaryButton,
                                  secondaryButton: secondaryButton)
                        })
                    }
                }
                
            }
            .navigationBarTitle("구석기 시대의 생활")
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "return")
            }))
        }
    }
}

struct MDetailView3_Previews: PreviewProvider {
    static var previews: some View {
        MDetailView3()
            .environmentObject(MyInfo())
    }
}
