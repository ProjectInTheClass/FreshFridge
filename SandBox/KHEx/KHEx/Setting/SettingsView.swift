//
//  SettingsView.swift
//  KH
//
//  Created by Park Youngeun on 2021/04/19.
//
import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    @EnvironmentObject var myInfo: MyInfo
    @State private var isShowAlert = false
    @State private var selectText = "x"

    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 20) {
                    
                    
                    //-Section1
                    GroupBox(
                        label:
                            SettingsLabelView(labelText: "한국사 출제 포인트 300", labelImage: "info.circle")
                    ){
                        Divider() .padding(.vertical, 4)
                        HStack(alignment: .center, spacing: 10){
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(9.0)
                            
                        Text("한국사 출제 포인트 300 앱은 한국사능력검정시험 초, 중급을 준비하는 수험생들을 위해 제작되었습니다. 300개의 출제 주제에 맞춰 기출문제 풀이와 해설을 함께 수록하였으며 학습 진도를 체크할 수 있어 계획성 있게 공부할수 있도록 하였습니다.")
                            .font(.footnote)
                       }
                    }
                    
                    //-Section2
                    GroupBox(
                      label:
                      SettingsLabelView(labelText: "앱정보", labelImage: "apps.iphone")
                    ) {
                      SettingRowView(name: "개발자", content: "nopimuli")
                      SettingRowView(name: "디자이너", content: "Robert Petras")
                      SettingRowView(name: "Compatibility", content: "iOS 14")
                      SettingRowView(name: "Website", linkLabel: "SwiftUI Masterclass", linkDestination: "swiftuimasterclass.com")
                      SettingRowView(name: "Twitter", linkLabel: "@RobertPetras", linkDestination: "twitter.com/robertpetras")
                      SettingRowView(name: "SwiftUI", content: "2.0")
                      SettingRowView(name: "Version", content: "1.1.0")
                    }
                    
                    Button(action: {
                        isShowAlert.toggle()
                    }, label: {
                        HStack{
                            Image(systemName: "paintbrush.fill")
                            Text("데이터 초기화")
                        }
                    })
                    .alert(isPresented: $isShowAlert, content: {
                        let primaryButton =
                            Alert.Button.default(Text("아니오")){
                                selectText = "cancel"
                            }
                        let secondaryButton =
                            Alert.Button.default(Text("예")){
                                myInfo.ckOn1 = true
                                myInfo.detailprogress1 = 0.0
                                myInfo.totalvalue1 = 0.0
                                
                                myInfo.ckOn2 = true
                                myInfo.detailprogress2 = 0.0
                                myInfo.totalvalue2 = 0.0
                                
                                myInfo.ckOn3 = true
                                myInfo.detailprogress3 = 0.0
                                myInfo.totalvalue3 = 0.0
                                
                                myInfo.ckOn4 = true
                                myInfo.detailprogress4 = 0.0
                                myInfo.totalvalue4 = 0.0
                                
                                myInfo.ckOn5 = true
                                myInfo.detailprogress5 = 0.0
                                myInfo.totalvalue5 = 0.0
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                                
                            }
                        return Alert(title: Text("모든 학습한 내용을 삭제합니다."), primaryButton: primaryButton,
                              secondaryButton: secondaryButton)
                    })
                }
    }
}
    }
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
}

       
