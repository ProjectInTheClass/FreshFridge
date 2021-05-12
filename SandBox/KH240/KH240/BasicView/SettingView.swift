//  SettingView.swift
//  KH240
//  Created by Park Youngeun on 2021/05/08.

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowAlert = false
    @State private var selectText = "x"
    @EnvironmentObject var myInfo: MyInfo
    @State private var revealDetails = false
    
    var body: some View {
NavigationView{
    ScrollView(.vertical, showsIndicators: false)
     {VStack(spacing: 20){
            GroupBox(label: HStack
            {
                Text("한국사 출제 포인트 240")
                Spacer()
                Image(systemName: "info.circle")
            })
            {
                Divider() .padding(.vertical, 4)
                HStack(alignment: .center, spacing: 10){
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .cornerRadius(9.0)
                    Text("<한국사 출제 포인트 240> 앱은 한국사능력검정시험(심화 1,2,3급)을 준비하는 수험생들을 위해 제작되었습니다. 240개의 출제 주제, 확인 학습 및 기출문제를 상세한 해설과 함께 수록하였으며 학습 진도를 체크할 수 있어 계획성 있게 공부하실 수 있습니다.")
                        .font(.footnote)
                   }
            }
            
            DisclosureGroup("한국사능력검정시험 안내", isExpanded: $revealDetails){
                VStack{
                    Image("info")
                        .resizable()
                        .aspectRatio(contentMode: .fit
                        )
                    HStack{
                        Spacer()
                        Link("한국사능력검정시험 안내 및 접수 링크", destination: URL(string: "http://www.historyexam.go.kr")!)
                        Image(systemName: "arrow.up.right.square")
                    }
                    .font(.footnote)
                }
            }
            .padding()
            
            
            GroupBox(label:
                HStack {
                    Text("앱 정보")
                    Spacer()
                    Image(systemName: "apps.iphone")
                }
            )
              {
                Divider() .padding(.vertical, 4)
                VStack{
                    HStack {
                        Text("문의 및 의견 보내기")
                        Spacer()
                    }
                    HStack {
                        Text("")
                        Spacer()
                    }
                    HStack {
                        Text("nopimuli@gmail.com")
                        Spacer()
                    }
                    HStack {
                        Text("")
                        Spacer()
                    }
                    HStack {
                        Text("Langauge : SwiftUI2.0")
                        Spacer()
                        Text("")
                    }
                    HStack {
                        Text("")
                        Spacer()
                    }
                    HStack {
                        Text("App Version : 1.0")
                        Spacer()
                        Text("")
                    }
                    HStack {
                        Text("")
                        Spacer()
                    }
                    HStack {
                        Text("이 앱은 iOS14부터 사용하실수 있습니다.")
                        Spacer()
                        Text("")
                    }
                }
            }
            Button(action: {
                isShowAlert.toggle()
            }, label: {
                HStack{
                    Image(systemName: "paintbrush.fill")
                        .foregroundColor(.red)
                    Text("데이터 초기화")
                        .foregroundColor(.red)
                }
            })
            .alert(isPresented: $isShowAlert, content: {
                let primaryButton =
                    Alert.Button.default(Text("아니오")){
                        selectText = "cancel"
                    }
                let secondaryButton =
                    Alert.Button.default(Text("예")){
                        myInfo.ona1 = true
                                
                        myInfo.onb1 = true
                        myInfo.onb2 = true
                        myInfo.onb3 = true
                        myInfo.onb4 = true
                        myInfo.onb5 = true
                        myInfo.onc1 = true
                        myInfo.onc2 = true
                        myInfo.onc3 = true
                        myInfo.onc4 = true
                        myInfo.onc5 = true
                        myInfo.onc6 = true
                        myInfo.ond1 = true
                        myInfo.ond2 = true
                        myInfo.ond3 = true
                        myInfo.ond4 = true
                        myInfo.ond5 = true
                        myInfo.ond6 = true
                        myInfo.ond7 = true
                        myInfo.ond8 = true
                        myInfo.ond9 = true
                        myInfo.ond10 = true
                        myInfo.ond11 = true
                        myInfo.ond12 = true
                        myInfo.ond13 = true
                        myInfo.ond14 = true
                        myInfo.ond15 = true
                        myInfo.ond16 = true
                        myInfo.ond17 = true
                        myInfo.ond18 = true
                        myInfo.ond19 = true
                        myInfo.ond20 = true
                        myInfo.ond21 = true
                        myInfo.ond22 = true
                        myInfo.ond23 = true
                        myInfo.ond24 = true
                        myInfo.ond25 = true
                        myInfo.ond26 = true
                        myInfo.ond27 = true
                        myInfo.ond28 = true
                        myInfo.ond29 = true
                        myInfo.ond30 = true
                        myInfo.ond31 = true
                        myInfo.ond32 = true
                        myInfo.ond33 = true
                        myInfo.one1 = true
                        myInfo.one2 = true
                        myInfo.one3 = true
                        myInfo.one4 = true
                        myInfo.one5 = true
                        myInfo.one6 = true
                        myInfo.one7 = true
                        myInfo.one8 = true
                        myInfo.one9 = true
                        myInfo.one10 = true
                        myInfo.one11 = true
                        myInfo.one12 = true
                        myInfo.one13 = true
                        myInfo.one14 = true
                        myInfo.one15 = true
                        myInfo.one16 = true
                        myInfo.one17 = true
                        myInfo.one18 = true
                        myInfo.one19 = true
                        myInfo.one20 = true
                        myInfo.one21 = true
                        myInfo.one22 = true
                        myInfo.one23 = true
                        myInfo.one24 = true
                        myInfo.one25 = true
                        myInfo.one26 = true
                        myInfo.one27 = true
                        myInfo.one28 = true
                        myInfo.one29 = true
                        myInfo.one30 = true
                        myInfo.one31 = true
                        myInfo.one32 = true
                        myInfo.one33 = true
                        myInfo.one34 = true
                        myInfo.one35 = true
                        myInfo.one36 = true
                        myInfo.one37 = true
                        myInfo.one38 = true
                        myInfo.onf1 = true
                        myInfo.onf2 = true
                        myInfo.onf3 = true
                        myInfo.onf4 = true
                        myInfo.onf5 = true
                        myInfo.onf6 = true
                        myInfo.onf7 = true
                        myInfo.onf8 = true
                        myInfo.onf9 = true
                        myInfo.onf10 = true
                        myInfo.onf11 = true
                        myInfo.onf12 = true
                        myInfo.onf13 = true
                        myInfo.onf14 = true
                        myInfo.onf15 = true
                        myInfo.onf16 = true
                        myInfo.onf17 = true
                        myInfo.onf18 = true
                        myInfo.onf19 = true
                        myInfo.onf20 = true
                        myInfo.onf21 = true
                        myInfo.onf22 = true
                        myInfo.onf23 = true
                        myInfo.onf24 = true
                        myInfo.onf25 = true
                        myInfo.onf26 = true
                        myInfo.onf27 = true
                        myInfo.onf28 = true
                        myInfo.onf29 = true
                        myInfo.onf30 = true
                        myInfo.onf31 = true
                        myInfo.onf32 = true
                        myInfo.onf33 = true
                        myInfo.onf34 = true
                        myInfo.onf35 = true
                        myInfo.onf36 = true
                        myInfo.onf37 = true
                        myInfo.onf38 = true
                        myInfo.onf39 = true
                        myInfo.onf40 = true
                        myInfo.onf41 = true
                        myInfo.onf42 = true
                        myInfo.onf43 = true
                        myInfo.onf44 = true
                        myInfo.onf45 = true
                        myInfo.onf46 = true
                        myInfo.onf47 = true
                        myInfo.onf48 = true
                        myInfo.onf49 = true
                        myInfo.onf50 = true
                        myInfo.ong1 = true
                        myInfo.ong2 = true
                        myInfo.ong3 = true
                        myInfo.ong4 = true
                        myInfo.ong5 = true
                        myInfo.ong6 = true
                        myInfo.ong7 = true
                        myInfo.ong8 = true
                        myInfo.ong9 = true
                        myInfo.ong10 = true
                        myInfo.ong11 = true
                        myInfo.ong12 = true
                        myInfo.ong13 = true
                        myInfo.ong14 = true
                        myInfo.ong15 = true
                        myInfo.ong16 = true
                        myInfo.ong17 = true
                        myInfo.ong18 = true
                        myInfo.ong19 = true
                        myInfo.ong20 = true
                        myInfo.ong21 = true
                        myInfo.ong22 = true
                        myInfo.ong23 = true
                        myInfo.ong24 = true
                        myInfo.ong25 = true
                        myInfo.ong26 = true
                        myInfo.ong27 = true
                        myInfo.ong28 = true
                        myInfo.ong29 = true
                        myInfo.ong30 = true
                        myInfo.ong31 = true
                        myInfo.ong32 = true
                        myInfo.ong33 = true
                        myInfo.ong34 = true
                        myInfo.ong35 = true
                        myInfo.ong36 = true
                        myInfo.ong37 = true
                        myInfo.onh1 = true
                        myInfo.onh2 = true
                        myInfo.onh3 = true
                        myInfo.onh4 = true
                        myInfo.onh5 = true
                        myInfo.onh6 = true
                        myInfo.onh7 = true
                        myInfo.onh8 = true
                        myInfo.onh9 = true
                        myInfo.onh10 = true
                        myInfo.onh11 = true
                        myInfo.onh12 = true
                        myInfo.onh13 = true
                        myInfo.onh14 = true
                        myInfo.onh15 = true
                        myInfo.onh16 = true
                        myInfo.onh17 = true
                        myInfo.onh18 = true
                        myInfo.onh19 = true
                        myInfo.onh20 = true
                        myInfo.onh21 = true
                        myInfo.onh22 = true
                        myInfo.onh23 = true
                        myInfo.onh24 = true
                        myInfo.onh25 = true
                        myInfo.onh26 = true
                        myInfo.onh27 = true
                        myInfo.onh28 = true
                        myInfo.onh29 = true
                        myInfo.onh30 = true
                        myInfo.onh31 = true
                        myInfo.onh32 = true
                        myInfo.onh33 = true
                        myInfo.onh34 = true
                        myInfo.onh35 = true
                        myInfo.onh36 = true
                        myInfo.oni1 = true
                        myInfo.oni2 = true
                        myInfo.oni3 = true
                        myInfo.oni4 = true
                        myInfo.oni5 = true
                        myInfo.oni6 = true
                        myInfo.oni7 = true
                        myInfo.oni8 = true
                        myInfo.oni9 = true
                        myInfo.oni10 = true
                        myInfo.oni11 = true
                        myInfo.oni12 = true
                        myInfo.oni13 = true
                        myInfo.oni14 = true
                        myInfo.oni15 = true
                        myInfo.oni16 = true
                        myInfo.oni17 = true
                        myInfo.oni18 = true
                        myInfo.oni19 = true
                        myInfo.oni20 = true
                        myInfo.oni21 = true
                        myInfo.oni22 = true
                        myInfo.oni23 = true
                        myInfo.oni24 = true
                        myInfo.oni25 = true
                        myInfo.oni26 = true
                        myInfo.oni27 = true
                        myInfo.oni28 = true
                        myInfo.oni29 = true
                        myInfo.oni30 = true
                        myInfo.oni31 = true
                        myInfo.oni32 = true
                        myInfo.oni33 = true
                        myInfo.oni34 = true
                        
                        myInfo.tva1 = 0.0
                        myInfo.tvb1 = 0.0
                        myInfo.tvb2 = 0.0
                        myInfo.tvb3 = 0.0
                        myInfo.tvb4 = 0.0
                        myInfo.tvb5 = 0.0
                        myInfo.tvc1 = 0.0
                        myInfo.tvc2 = 0.0
                        myInfo.tvc3 = 0.0
                        myInfo.tvc4 = 0.0
                        myInfo.tvc5 = 0.0
                        myInfo.tvc6 = 0.0
                        myInfo.tvd1 = 0.0
                        myInfo.tvd2 = 0.0
                        myInfo.tvd3 = 0.0
                        myInfo.tvd4 = 0.0
                        myInfo.tvd5 = 0.0
                        myInfo.tvd6 = 0.0
                        myInfo.tvd7 = 0.0
                        myInfo.tvd8 = 0.0
                        myInfo.tvd9 = 0.0
                        myInfo.tvd10 = 0.0
                        myInfo.tvd11 = 0.0
                        myInfo.tvd12 = 0.0
                        myInfo.tvd13 = 0.0
                        myInfo.tvd14 = 0.0
                        myInfo.tvd15 = 0.0
                        myInfo.tvd16 = 0.0
                        myInfo.tvd17 = 0.0
                        myInfo.tvd18 = 0.0
                        myInfo.tvd19 = 0.0
                        myInfo.tvd20 = 0.0
                        myInfo.tvd21 = 0.0
                        myInfo.tvd22 = 0.0
                        myInfo.tvd23 = 0.0
                        myInfo.tvd24 = 0.0
                        myInfo.tvd25 = 0.0
                        myInfo.tvd26 = 0.0
                        myInfo.tvd27 = 0.0
                        myInfo.tvd28 = 0.0
                        myInfo.tvd29 = 0.0
                        myInfo.tvd30 = 0.0
                        myInfo.tvd31 = 0.0
                        myInfo.tvd32 = 0.0
                        myInfo.tvd33 = 0.0
                        myInfo.tve1 = 0.0
                        myInfo.tve2 = 0.0
                        myInfo.tve3 = 0.0
                        myInfo.tve4 = 0.0
                        myInfo.tve5 = 0.0
                        myInfo.tve6 = 0.0
                        myInfo.tve7 = 0.0
                        myInfo.tve8 = 0.0
                        myInfo.tve9 = 0.0
                        myInfo.tve10 = 0.0
                        myInfo.tve11 = 0.0
                        myInfo.tve12 = 0.0
                        myInfo.tve13 = 0.0
                        myInfo.tve14 = 0.0
                        myInfo.tve15 = 0.0
                        myInfo.tve16 = 0.0
                        myInfo.tve17 = 0.0
                        myInfo.tve18 = 0.0
                        myInfo.tve19 = 0.0
                        myInfo.tve20 = 0.0
                        myInfo.tve21 = 0.0
                        myInfo.tve22 = 0.0
                        myInfo.tve23 = 0.0
                        myInfo.tve24 = 0.0
                        myInfo.tve25 = 0.0
                        myInfo.tve26 = 0.0
                        myInfo.tve27 = 0.0
                        myInfo.tve28 = 0.0
                        myInfo.tve29 = 0.0
                        myInfo.tve30 = 0.0
                        myInfo.tve31 = 0.0
                        myInfo.tve32 = 0.0
                        myInfo.tve33 = 0.0
                        myInfo.tve34 = 0.0
                        myInfo.tve35 = 0.0
                        myInfo.tve36 = 0.0
                        myInfo.tve37 = 0.0
                        myInfo.tve38 = 0.0
                        myInfo.tvf1 = 0.0
                        myInfo.tvf2 = 0.0
                        myInfo.tvf3 = 0.0
                        myInfo.tvf4 = 0.0
                        myInfo.tvf5 = 0.0
                        myInfo.tvf6 = 0.0
                        myInfo.tvf7 = 0.0
                        myInfo.tvf8 = 0.0
                        myInfo.tvf9 = 0.0
                        myInfo.tvf10 = 0.0
                        myInfo.tvf11 = 0.0
                        myInfo.tvf12 = 0.0
                        myInfo.tvf13 = 0.0
                        myInfo.tvf14 = 0.0
                        myInfo.tvf15 = 0.0
                        myInfo.tvf16 = 0.0
                        myInfo.tvf17 = 0.0
                        myInfo.tvf18 = 0.0
                        myInfo.tvf19 = 0.0
                        myInfo.tvf20 = 0.0
                        myInfo.tvf21 = 0.0
                        myInfo.tvf22 = 0.0
                        myInfo.tvf23 = 0.0
                        myInfo.tvf24 = 0.0
                        myInfo.tvf25 = 0.0
                        myInfo.tvf26 = 0.0
                        myInfo.tvf27 = 0.0
                        myInfo.tvf28 = 0.0
                        myInfo.tvf29 = 0.0
                        myInfo.tvf30 = 0.0
                        myInfo.tvf31 = 0.0
                        myInfo.tvf32 = 0.0
                        myInfo.tvf33 = 0.0
                        myInfo.tvf34 = 0.0
                        myInfo.tvf35 = 0.0
                        myInfo.tvf36 = 0.0
                        myInfo.tvf37 = 0.0
                        myInfo.tvf38 = 0.0
                        myInfo.tvf39 = 0.0
                        myInfo.tvf40 = 0.0
                        myInfo.tvf41 = 0.0
                        myInfo.tvf42 = 0.0
                        myInfo.tvf43 = 0.0
                        myInfo.tvf44 = 0.0
                        myInfo.tvf45 = 0.0
                        myInfo.tvf46 = 0.0
                        myInfo.tvf47 = 0.0
                        myInfo.tvf48 = 0.0
                        myInfo.tvf49 = 0.0
                        myInfo.tvf50 = 0.0
                        myInfo.tvg1 = 0.0
                        myInfo.tvg2 = 0.0
                        myInfo.tvg3 = 0.0
                        myInfo.tvg4 = 0.0
                        myInfo.tvg5 = 0.0
                        myInfo.tvg6 = 0.0
                        myInfo.tvg7 = 0.0
                        myInfo.tvg8 = 0.0
                        myInfo.tvg9 = 0.0
                        myInfo.tvg10 = 0.0
                        myInfo.tvg11 = 0.0
                        myInfo.tvg12 = 0.0
                        myInfo.tvg13 = 0.0
                        myInfo.tvg14 = 0.0
                        myInfo.tvg15 = 0.0
                        myInfo.tvg16 = 0.0
                        myInfo.tvg17 = 0.0
                        myInfo.tvg18 = 0.0
                        myInfo.tvg19 = 0.0
                        myInfo.tvg20 = 0.0
                        myInfo.tvg21 = 0.0
                        myInfo.tvg22 = 0.0
                        myInfo.tvg23 = 0.0
                        myInfo.tvg24 = 0.0
                        myInfo.tvg25 = 0.0
                        myInfo.tvg26 = 0.0
                        myInfo.tvg27 = 0.0
                        myInfo.tvg28 = 0.0
                        myInfo.tvg29 = 0.0
                        myInfo.tvg30 = 0.0
                        myInfo.tvg31 = 0.0
                        myInfo.tvg32 = 0.0
                        myInfo.tvg33 = 0.0
                        myInfo.tvg34 = 0.0
                        myInfo.tvg35 = 0.0
                        myInfo.tvg36 = 0.0
                        myInfo.tvg37 = 0.0
                        myInfo.tvh1 = 0.0
                        myInfo.tvh2 = 0.0
                        myInfo.tvh3 = 0.0
                        myInfo.tvh4 = 0.0
                        myInfo.tvh5 = 0.0
                        myInfo.tvh6 = 0.0
                        myInfo.tvh7 = 0.0
                        myInfo.tvh8 = 0.0
                        myInfo.tvh9 = 0.0
                        myInfo.tvh10 = 0.0
                        myInfo.tvh11 = 0.0
                        myInfo.tvh12 = 0.0
                        myInfo.tvh13 = 0.0
                        myInfo.tvh14 = 0.0
                        myInfo.tvh15 = 0.0
                        myInfo.tvh16 = 0.0
                        myInfo.tvh17 = 0.0
                        myInfo.tvh18 = 0.0
                        myInfo.tvh19 = 0.0
                        myInfo.tvh20 = 0.0
                        myInfo.tvh21 = 0.0
                        myInfo.tvh22 = 0.0
                        myInfo.tvh23 = 0.0
                        myInfo.tvh24 = 0.0
                        myInfo.tvh25 = 0.0
                        myInfo.tvh26 = 0.0
                        myInfo.tvh27 = 0.0
                        myInfo.tvh28 = 0.0
                        myInfo.tvh29 = 0.0
                        myInfo.tvh30 = 0.0
                        myInfo.tvh31 = 0.0
                        myInfo.tvh32 = 0.0
                        myInfo.tvh33 = 0.0
                        myInfo.tvh34 = 0.0
                        myInfo.tvh35 = 0.0
                        myInfo.tvh36 = 0.0
                        myInfo.tvi1 = 0.0
                        myInfo.tvi2 = 0.0
                        myInfo.tvi3 = 0.0
                        myInfo.tvi4 = 0.0
                        myInfo.tvi5 = 0.0
                        myInfo.tvi6 = 0.0
                        myInfo.tvi7 = 0.0
                        myInfo.tvi8 = 0.0
                        myInfo.tvi9 = 0.0
                        myInfo.tvi10 = 0.0
                        myInfo.tvi11 = 0.0
                        myInfo.tvi12 = 0.0
                        myInfo.tvi13 = 0.0
                        myInfo.tvi14 = 0.0
                        myInfo.tvi15 = 0.0
                        myInfo.tvi16 = 0.0
                        myInfo.tvi17 = 0.0
                        myInfo.tvi18 = 0.0
                        myInfo.tvi19 = 0.0
                        myInfo.tvi20 = 0.0
                        myInfo.tvi21 = 0.0
                        myInfo.tvi22 = 0.0
                        myInfo.tvi23 = 0.0
                        myInfo.tvi24 = 0.0
                        myInfo.tvi25 = 0.0
                        myInfo.tvi26 = 0.0
                        myInfo.tvi27 = 0.0
                        myInfo.tvi28 = 0.0
                        myInfo.tvi29 = 0.0
                        myInfo.tvi30 = 0.0
                        myInfo.tvi31 = 0.0
                        myInfo.tvi32 = 0.0
                        myInfo.tvi33 = 0.0
                        myInfo.tvi34 = 0.0
                       
                        myInfo.dva1 = 0.0
                        myInfo.dvb1 = 0.0
                        myInfo.dvb2 = 0.0
                        myInfo.dvb3 = 0.0
                        myInfo.dvb4 = 0.0
                        myInfo.dvb5 = 0.0
                        myInfo.dvc1 = 0.0
                        myInfo.dvc2 = 0.0
                        myInfo.dvc3 = 0.0
                        myInfo.dvc4 = 0.0
                        myInfo.dvc5 = 0.0
                        myInfo.dvc6 = 0.0
                        myInfo.dvd1 = 0.0
                        myInfo.dvd2 = 0.0
                        myInfo.dvd3 = 0.0
                        myInfo.dvd4 = 0.0
                        myInfo.dvd5 = 0.0
                        myInfo.dvd6 = 0.0
                        myInfo.dvd7 = 0.0
                        myInfo.dvd8 = 0.0
                        myInfo.dvd9 = 0.0
                        myInfo.dvd10 = 0.0
                        myInfo.dvd11 = 0.0
                        myInfo.dvd12 = 0.0
                        myInfo.dvd13 = 0.0
                        myInfo.dvd14 = 0.0
                        myInfo.dvd15 = 0.0
                        myInfo.dvd16 = 0.0
                        myInfo.dvd17 = 0.0
                        myInfo.dvd18 = 0.0
                        myInfo.dvd19 = 0.0
                        myInfo.dvd20 = 0.0
                        myInfo.dvd21 = 0.0
                        myInfo.dvd22 = 0.0
                        myInfo.dvd23 = 0.0
                        myInfo.dvd24 = 0.0
                        myInfo.dvd25 = 0.0
                        myInfo.dvd26 = 0.0
                        myInfo.dvd27 = 0.0
                        myInfo.dvd28 = 0.0
                        myInfo.dvd29 = 0.0
                        myInfo.dvd30 = 0.0
                        myInfo.dvd31 = 0.0
                        myInfo.dvd32 = 0.0
                        myInfo.dvd33 = 0.0
                        myInfo.dve1 = 0.0
                        myInfo.dve2 = 0.0
                        myInfo.dve3 = 0.0
                        myInfo.dve4 = 0.0
                        myInfo.dve5 = 0.0
                        myInfo.dve6 = 0.0
                        myInfo.dve7 = 0.0
                        myInfo.dve8 = 0.0
                        myInfo.dve9 = 0.0
                        myInfo.dve10 = 0.0
                        myInfo.dve11 = 0.0
                        myInfo.dve12 = 0.0
                        myInfo.dve13 = 0.0
                        myInfo.dve14 = 0.0
                        myInfo.dve15 = 0.0
                        myInfo.dve16 = 0.0
                        myInfo.dve17 = 0.0
                        myInfo.dve18 = 0.0
                        myInfo.dve19 = 0.0
                        myInfo.dve20 = 0.0
                        myInfo.dve21 = 0.0
                        myInfo.dve22 = 0.0
                        myInfo.dve23 = 0.0
                        myInfo.dve24 = 0.0
                        myInfo.dve25 = 0.0
                        myInfo.dve26 = 0.0
                        myInfo.dve27 = 0.0
                        myInfo.dve28 = 0.0
                        myInfo.dve29 = 0.0
                        myInfo.dve30 = 0.0
                        myInfo.dve31 = 0.0
                        myInfo.dve32 = 0.0
                        myInfo.dve33 = 0.0
                        myInfo.dve34 = 0.0
                        myInfo.dve35 = 0.0
                        myInfo.dve36 = 0.0
                        myInfo.dve37 = 0.0
                        myInfo.dve38 = 0.0
                        myInfo.dvf1 = 0.0
                        myInfo.dvf2 = 0.0
                        myInfo.dvf3 = 0.0
                        myInfo.dvf4 = 0.0
                        myInfo.dvf5 = 0.0
                        myInfo.dvf6 = 0.0
                        myInfo.dvf7 = 0.0
                        myInfo.dvf8 = 0.0
                        myInfo.dvf9 = 0.0
                        myInfo.dvf10 = 0.0
                        myInfo.dvf11 = 0.0
                        myInfo.dvf12 = 0.0
                        myInfo.dvf13 = 0.0
                        myInfo.dvf14 = 0.0
                        myInfo.dvf15 = 0.0
                        myInfo.dvf16 = 0.0
                        myInfo.dvf17 = 0.0
                        myInfo.dvf18 = 0.0
                        myInfo.dvf19 = 0.0
                        myInfo.dvf20 = 0.0
                        myInfo.dvf21 = 0.0
                        myInfo.dvf22 = 0.0
                        myInfo.dvf23 = 0.0
                        myInfo.dvf24 = 0.0
                        myInfo.dvf25 = 0.0
                        myInfo.dvf26 = 0.0
                        myInfo.dvf27 = 0.0
                        myInfo.dvf28 = 0.0
                        myInfo.dvf29 = 0.0
                        myInfo.dvf30 = 0.0
                        myInfo.dvf31 = 0.0
                        myInfo.dvf32 = 0.0
                        myInfo.dvf33 = 0.0
                        myInfo.dvf34 = 0.0
                        myInfo.dvf35 = 0.0
                        myInfo.dvf36 = 0.0
                        myInfo.dvf37 = 0.0
                        myInfo.dvf38 = 0.0
                        myInfo.dvf39 = 0.0
                        myInfo.dvf40 = 0.0
                        myInfo.dvf41 = 0.0
                        myInfo.dvf42 = 0.0
                        myInfo.dvf43 = 0.0
                        myInfo.dvf44 = 0.0
                        myInfo.dvf45 = 0.0
                        myInfo.dvf46 = 0.0
                        myInfo.dvf47 = 0.0
                        myInfo.dvf48 = 0.0
                        myInfo.dvf49 = 0.0
                        myInfo.dvf50 = 0.0
                        myInfo.dvg1 = 0.0
                        myInfo.dvg2 = 0.0
                        myInfo.dvg3 = 0.0
                        myInfo.dvg4 = 0.0
                        myInfo.dvg5 = 0.0
                        myInfo.dvg6 = 0.0
                        myInfo.dvg7 = 0.0
                        myInfo.dvg8 = 0.0
                        myInfo.dvg9 = 0.0
                        myInfo.dvg10 = 0.0
                        myInfo.dvg11 = 0.0
                        myInfo.dvg12 = 0.0
                        myInfo.dvg13 = 0.0
                        myInfo.dvg14 = 0.0
                        myInfo.dvg15 = 0.0
                        myInfo.dvg16 = 0.0
                        myInfo.dvg17 = 0.0
                        myInfo.dvg18 = 0.0
                        myInfo.dvg19 = 0.0
                        myInfo.dvg20 = 0.0
                        myInfo.dvg21 = 0.0
                        myInfo.dvg22 = 0.0
                        myInfo.dvg23 = 0.0
                        myInfo.dvg24 = 0.0
                        myInfo.dvg25 = 0.0
                        myInfo.dvg26 = 0.0
                        myInfo.dvg27 = 0.0
                        myInfo.dvg28 = 0.0
                        myInfo.dvg29 = 0.0
                        myInfo.dvg30 = 0.0
                        myInfo.dvg31 = 0.0
                        myInfo.dvg32 = 0.0
                        myInfo.dvg33 = 0.0
                        myInfo.dvg34 = 0.0
                        myInfo.dvg35 = 0.0
                        myInfo.dvg36 = 0.0
                        myInfo.dvg37 = 0.0
                        myInfo.dvh1 = 0.0
                        myInfo.dvh2 = 0.0
                        myInfo.dvh3 = 0.0
                        myInfo.dvh4 = 0.0
                        myInfo.dvh5 = 0.0
                        myInfo.dvh6 = 0.0
                        myInfo.dvh7 = 0.0
                        myInfo.dvh8 = 0.0
                        myInfo.dvh9 = 0.0
                        myInfo.dvh10 = 0.0
                        myInfo.dvh11 = 0.0
                        myInfo.dvh12 = 0.0
                        myInfo.dvh13 = 0.0
                        myInfo.dvh14 = 0.0
                        myInfo.dvh15 = 0.0
                        myInfo.dvh16 = 0.0
                        myInfo.dvh17 = 0.0
                        myInfo.dvh18 = 0.0
                        myInfo.dvh19 = 0.0
                        myInfo.dvh20 = 0.0
                        myInfo.dvh21 = 0.0
                        myInfo.dvh22 = 0.0
                        myInfo.dvh23 = 0.0
                        myInfo.dvh24 = 0.0
                        myInfo.dvh25 = 0.0
                        myInfo.dvh26 = 0.0
                        myInfo.dvh27 = 0.0
                        myInfo.dvh28 = 0.0
                        myInfo.dvh29 = 0.0
                        myInfo.dvh30 = 0.0
                        myInfo.dvh31 = 0.0
                        myInfo.dvh32 = 0.0
                        myInfo.dvh33 = 0.0
                        myInfo.dvh34 = 0.0
                        myInfo.dvh35 = 0.0
                        myInfo.dvh36 = 0.0
                        myInfo.dvi1 = 0.0
                        myInfo.dvi2 = 0.0
                        myInfo.dvi3 = 0.0
                        myInfo.dvi4 = 0.0
                        myInfo.dvi5 = 0.0
                        myInfo.dvi6 = 0.0
                        myInfo.dvi7 = 0.0
                        myInfo.dvi8 = 0.0
                        myInfo.dvi9 = 0.0
                        myInfo.dvi10 = 0.0
                        myInfo.dvi11 = 0.0
                        myInfo.dvi12 = 0.0
                        myInfo.dvi13 = 0.0
                        myInfo.dvi14 = 0.0
                        myInfo.dvi15 = 0.0
                        myInfo.dvi16 = 0.0
                        myInfo.dvi17 = 0.0
                        myInfo.dvi18 = 0.0
                        myInfo.dvi19 = 0.0
                        myInfo.dvi20 = 0.0
                        myInfo.dvi21 = 0.0
                        myInfo.dvi22 = 0.0
                        myInfo.dvi23 = 0.0
                        myInfo.dvi24 = 0.0
                        myInfo.dvi25 = 0.0
                        myInfo.dvi26 = 0.0
                        myInfo.dvi27 = 0.0
                        myInfo.dvi28 = 0.0
                        myInfo.dvi29 = 0.0
                        myInfo.dvi30 = 0.0
                        myInfo.dvi31 = 0.0
                        myInfo.dvi32 = 0.0
                        myInfo.dvi33 = 0.0
                        myInfo.dvi34 = 0.0
                
                    }
                return Alert(title: Text("학습한 모든 내용을 삭제합니다."), primaryButton: primaryButton,
                      secondaryButton: secondaryButton)
              })
            }
    .navigationBarItems(leading: Button(action: {
        presentationMode.wrappedValue.dismiss()
    }, label: {
        Image(systemName: "return")
    }))
          }
   
        }

    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(MyInfo())
    }
}
