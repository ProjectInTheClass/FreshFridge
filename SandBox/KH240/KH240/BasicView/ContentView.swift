//  ContentView.swift
//  KH240
//  Created by Nopimuli on 2021/05/08.


import SwiftUI

struct ContentView: View {
    @State private var isShowingSettings: Bool = false
    @EnvironmentObject var myInfo: MyInfo
    
    var body: some View {
        NavigationView{
            VStack{
                MyProgressView()
                    .padding()
                
                List{
                    NavigationLink(
                        destination:
                        DVa()
                            ,
                        label: {
                            HStack{
                                MyCircleProgressView1()
                                    .frame(width: 50, height: 50, alignment: .center)
                                Text("Ⅰ. 한국사 자르기")
                            }
                           
                        })
                        .padding(.all, -10)
                    
                    NavigationLink(
                        destination:
                        DVb()
                            ,
                        label: {
                            HStack{
                                MyCircleProgressView2()
                                    .frame(width: 50, height: 50, alignment: .center)
                                Text("Ⅱ. 선사 시대")
                            }
                        })
                        .padding(.all, -10)
                    
                    NavigationLink(
                        destination:
                        Text("")
                            //DetailView1()
                            ,
                        label: {
                            HStack{
                                MyCircleProgressView3()
                                    .frame(width: 50, height: 50, alignment: .center)
                                Text("Ⅲ. 고조선과 여러나라")
                            }
                        })
                        .padding(.all, -10)
                    
                    NavigationLink(
                        destination:
                        Text("")
                            //DetailView1()
                            ,
                        label: {
                            HStack{
                                MyCircleProgressView4()
                                    .frame(width: 50, height: 50, alignment: .center)
                                Text("Ⅳ. 삼국 시대와 남북국 시대")
                            }
                        })
                        .padding(.all, -10)

                    NavigationLink(
                        destination:
                        Text("")
                            //DetailView1()
                            ,
                        label: {
                            HStack{
                                MyCircleProgressView5()
                                    .frame(width: 50, height: 50, alignment: .center)
                                Text("Ⅴ. 고려 시대")
                            }
                        })
                        .padding(.all, -10)
                    
                    NavigationLink(
                        destination:
                        Text("")
                            //DetailView1()
                            ,
                        label: {
                            HStack{
                                MyCircleProgressView6()
                                    .frame(width: 50, height: 50, alignment: .center)
                                Text("Ⅵ. 조선 시대")
                            }
                        })
                        .padding(.all, -10)
                    
                    NavigationLink(
                        destination:
                        Text("")
                            //DetailView1()
                            ,
                        label: {
                            HStack{
                                MyCircleProgressView7()
                                    .frame(width: 50, height: 50, alignment: .center)
                                Text("Ⅶ. 근대 개항기")
                            }
                        })
                        .padding(.all, -10)
                    
                    NavigationLink(
                        destination:
                        Text("")
                            //DetailView1()
                            ,
                        label: {
                            HStack{
                                MyCircleProgressView8()
                                    .frame(width: 50, height: 50, alignment: .center)
                                Text("Ⅷ. 민족 독립 운동기")
                            }
                        })
                        .padding(.all, -10)
                    
                    NavigationLink(
                        destination:
                        Text("")
                            //DetailView1()
                            ,
                        label: {
                            HStack{
                                MyCircleProgressView9()
                                    .frame(width: 50, height: 50, alignment: .center)
                                Text("Ⅸ. 현대, 대한민국의 발전")
                            }
                        })
                        .padding(.all, -10)

                }
                
                .navigationBarTitle ("한국사 출제 포인트 240"
                    , displayMode: .inline)
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            isShowingSettings = true
                        }){
                            Image(systemName: "slider.horizontal.3")
                        }
                        .fullScreenCover(isPresented: $isShowingSettings){
                            SettingView()
                        }
                )
                    
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MyInfo())
    }
}
