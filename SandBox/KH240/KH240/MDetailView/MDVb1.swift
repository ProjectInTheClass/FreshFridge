//
//  MDVb1.swift
//  KH240
//
//  Created by Park Youngeun on 2021/05/09.
//

import SwiftUI

struct MDVb1: View {
    
    @EnvironmentObject var myInfo : MyInfo
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isShowAlert = false
    @State private var selectText = "x"
    
    @State private var revealDetails1 = false
    @State private var revealDetails2 = false
    @State private var revealDetails3 = false
    
    @State private var answer1 = false
    @State private var answer2 = false
    @State private var answer3 = false
    @State private var answer4 = false
    @State private var answer5 = false
    @State private var answer6 = false
    
    @State private var answer11 = false
    @State private var answer12 = false
    @State private var answer13 = false
    @State private var answer14 = false
    @State private var answer15 = false
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                List{
                    DisclosureGroup("1단계. 핵심 정리", isExpanded: $revealDetails1){
                        VStack{
                            Text("선사시대의 출발 지점인 구석기 시대의 생활상에 대해 알아보도록 해요.")
                            Image("b1e1")
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
                        
                        HStack{
                            ZStack{
                               Text("1번")
                               if answer1 == true && answer2 == false{
                                Image(systemName: "circlebadge")
                                   .resizable()
                                   .frame(width: 30, height: 30, alignment: .center)
                                   .foregroundColor(.blue)}
                           else if answer1 == false && answer2 == true{
                                Image(systemName: "multiply")
                                   .resizable()
                                   .frame(width: 30, height: 30, alignment: .center)
                                   .foregroundColor(.red)}else{Text("")}
                            }
                            Text("구석기 시대에 다용도로 사용한 뗀석기는 주먹도끼이다.")
                        }
                    
                        HStack{
                            Button(action: {
                                self.answer1.toggle()
                            }, label: {
                                Text("O")})
                            if self.answer1 == true{ Text("정답입니다.")
                                .foregroundColor(.blue)
                            }
                            
                        }
                        HStack{
                            Button(action: {
                                self.answer2.toggle()
                            }, label: {
                                    Text("X")})
                            if self.answer2 == true{
                                Text("오답입니다. 주먹도끼는 밀개, 긁개, 찌드개 등과 함께 구석기 시대의 뗀석기입니다. 구석기 시대 말기에는 슴베찌르개와 같은 잔석기도 사용하였습니다.")
                                    .foregroundColor(.red)
                            }
                        }
                           
                        HStack{
                            ZStack{
                               Text("2번")
                               if answer3 == false && answer4 == true{
                                Image(systemName: "circlebadge")
                                   .resizable()
                                   .frame(width: 30, height: 30, alignment: .center)
                                   .foregroundColor(.blue)}
                           else if answer3 == true && answer4 == false{
                                Image(systemName: "multiply")
                                   .resizable()
                                   .frame(width: 30, height: 30, alignment: .center)
                                    .foregroundColor(.red)}else{Text("")}
                            }
                            Text("구석기 시대는 주로 농경과 목축을 하면서 정착생활을 주로 했다.")
                        }
                    
                        HStack{
                            Button(action: {
                                self.answer3.toggle()
                            }, label: {
                                Text("O")})
                            if self.answer3 == true{ Text("오답입니다. 농경과 목축을 시작한 것은 신석기 시대부터의 일입니다.")
                                .foregroundColor(.red)
                            }
                        }
                        HStack{
                            Button(action: {
                                self.answer4.toggle()
                            }, label: {
                                    Text("X")})
                            if self.answer4 == true{
                                Text("정답입니다.")
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        
                        HStack{
                            ZStack{
                               Text("3번")
                               if answer5 == true && answer6 == false{
                                Image(systemName: "circlebadge")
                                   .resizable()
                                   .frame(width: 30, height: 30, alignment: .center)
                                   .foregroundColor(.blue)}
                           else if answer5 == false && answer6 == true{
                                Image(systemName: "multiply")
                                   .resizable()
                                   .frame(width: 30, height: 30, alignment: .center)
                                    .foregroundColor(.red)}else{Text("")}
                            }
                            Text("구석기 시대는 무리를 이끄는 지도자가 있었으나 사회적 관계는 평등을 유지했다.")
                        }
                        HStack{
                            Button(action: {
                                self.answer5.toggle()
                            }, label: {
                                Text("O")})
                            if self.answer5 == true{ Text("정답입니다.")
                                .foregroundColor(.blue)
                            }
                        }
                        HStack{
                            Button(action: {
                                self.answer6.toggle()
                            }, label: {
                                    Text("X")})
                            if self.answer6 == true{
                                Text("오답입니다. 구석기 시대는 평등한 사회였습니다.")
                                    .foregroundColor(.red)
                            }
                        }
                        
                        Button("그럼 기출문항을 풀어 봅시다"){
                            revealDetails2.toggle()
                            revealDetails3.toggle()
                                }
                        }
                        
                    DisclosureGroup("3단계. 기출문제 풀이", isExpanded: $revealDetails3){
                        
                        
                        HStack{
                            Text("2020년 53회 ")
                            ZStack{
                                if answer11 == false && answer12 == true && answer13 == false && answer14 == false && answer15 == false{
                                Image(systemName: "circlebadge")
                                   .resizable()
                                   .frame(width: 30, height: 30, alignment: .center)
                                   .foregroundColor(.blue)}
                           else if  answer11 == false && answer12 == false && answer13 == false && answer14 == false && answer15 == false{
                                Text("")
                           }else {
                            Image(systemName: "multiply")
                               .resizable()
                               .frame(width: 30, height: 30, alignment: .center)
                               .foregroundColor(.red)}
                           }
                        }
                        
                        
    
                        Image("b1q1")
                            .resizable()
                            .aspectRatio(contentMode: .fit
                            )
                        
                        VStack(alignment: .leading){
                            HStack{
                                Button(action: {
                                    self.answer11.toggle()
                                }, label: {
                                    Image(systemName: "1.circle")})
                                Text("가락바퀴를 이용하여 실을 뽑았다.")
                            }
                            if answer11 == true {Text("오답입니다. 가락바퀴는 실을 뽑기 위한 도구로 신석기 시대부터 사용되었습니다.")
                                .foregroundColor(.red)
                            }
                        }
                        
                        VStack(alignment: .leading){
                            HStack{
                                Button(action: {
                                    self.answer12.toggle()
                                    self.answer11 = false
                                    self.answer13 = false
                                    self.answer14 = false
                                    self.answer15 = false
                                    
                                }, label: {
                                    Image(systemName: "2.circle")})
                                Text("주로 동굴이나 막집에서 거주하였다.")
                            }
                            if answer12 == true {Text("정답입니다.")
                                .foregroundColor(.blue)
                            }
                            }
                      
                        VStack(alignment: .leading){
                            HStack{
                                Button(action: {
                                    self.answer13.toggle()
                                }, label: {
                                    Image(systemName: "3.circle")})
                                Text("지배자의 무덤으로 고인돌을 축조하였다.")
                            }
                            if answer13 == true {Text("오답입니다. 권력을 가진 지배자의 무덤인 고인돌은 청동기 시대부터 만들어졌습니다.")
                                .foregroundColor(.red)
                            }
                        }
                        VStack(alignment: .leading){
                            HStack{
                                Button(action: {
                                    self.answer14.toggle()
                                }, label: {
                                    Image(systemName: "4.circle")})
                                Text("반달돌칼을 사용하여 곡물을 수확하였다.")
                            }
                            if answer14 == true {Text("오답입니다. 반달돌칼을 정교하게 돌을 갈아 제작한 석기로 청동기 시대에 사용한 농기구입니다.")
                                .foregroundColor(.red)
                            }
                        }
                        VStack(alignment: .leading){
                            HStack{
                                Button(action: {
                                    self.answer15.toggle()
                                }, label: {
                                    Image(systemName: "5.circle")})
                                Text("빗살무늬 토기를 제작하여 식량을 저장하였다.")
                            }
                            if answer15 == true {Text("오답입니다. 빗살무늬토기는 뾰족한 바닥과 빗살모양의 무늬를 특징으로 하는 신석기 시대의 대표적 토기입니다. 토기는 저장 수단으로 신석기 시대부터 사용되었습니다.")
                                .foregroundColor(.red)
                            }
                        }
                        
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
                                    myInfo.onb1 = false
                                    myInfo.dvb1 = 0.2
                                    myInfo.tvb1 = 0.5
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

struct MDVb1_Previews: PreviewProvider {
    static var previews: some View {
        MDVb1()
    }
}
