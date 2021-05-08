//
//  ContentView.swift
//  KHEx
//
//  Created by Park Youngeun on 2021/05/05.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingSettings: Bool = false
 // @State private var progress: CGFloat = 0
    
    var body: some View {
        NavigationView{
            VStack{
                MyProgressView()
                    .padding()
                
                List{
                  //  ProgressBar()
                    
                    NavigationLink(
                        destination:
                            DetailView1()
                            ,
                        label: {
                            HStack{
                               CircularProgress1()
                                    .frame(width: 50, height: 50, alignment: .center)
                                Text("1. 선사 시대")
                                   
                            }
                           
                        })
                        .padding(.all, -10)
                        
                    NavigationLink(
                        destination:
                            VStack{
                                /*
                                Slider(value: $progress)
                                    .padding()
    */
                                Text("Destination")
                            }
                            ,
                        label: {
                            HStack{
                                CircularProgress1()
                                     .frame(width: 50, height: 50, alignment: .center)
                                Text("2. 고조선과 여러 나라")
                            }
                        })
                        .padding(.all, -10)
                    
                    NavigationLink(
                        destination:
                            VStack{
                                /*
                                Slider(value: $progress)
                                    .padding()
    */
                                Text("Destination")
                            }
                            ,
                        label: {
                            HStack{
                                CircularProgress1()
                                     .frame(width: 50, height: 50, alignment: .center)
                                Text("3. 삼국 시대")
                            }
                        })
                        .padding(.all, -10)
                    
                    
                    NavigationLink(
                        destination:
                            VStack{
                                /*
                                Slider(value: $progress)
                                    .padding()
    */
                                Text("Destination")
                            }
                            ,
                        label: {
                            HStack{
                                CircularProgress1()
                                     .frame(width: 50, height: 50, alignment: .center)
                                Text("4. 남북국 시대")
                            }
                        })
                        .padding(.all, -10)
                    
                    
                    NavigationLink(
                        destination:
                            VStack{
                                /*
                                Slider(value: $progress)
                                    .padding()
    */
                                Text("Destination")
                            }
                            ,
                        label: {
                            HStack{
                                CircularProgress1()
                                     .frame(width: 50, height: 50, alignment: .center)
                                Text("5. 고려 시대")
                            }
                        })
                        .padding(.all, -10)
                    
                    
                    NavigationLink(
                        destination:
                            VStack{
                                Text("Destination")
                            }
                            ,
                        label: {
                            HStack{
                                CircularProgress1()
                                     .frame(width: 50, height: 50, alignment: .center)
                                Text("6. 조선 전기")
                            }
                        })
                        .padding(.all, -10)
                    
                    
                    NavigationLink(
                        destination:
                            VStack{
                                /*
                                Slider(value: $progress)
                                    .padding()
    */
                                Text("Destination")
                            }
                            ,
                        label: {
                            HStack{
                                CircularProgress1()
                                     .frame(width: 50, height: 50, alignment: .center)
                                Text("7. 조선 후기")
                            }
                        })
                        .padding(.all, -10)
                    
                    
                    NavigationLink(
                        destination:
                            VStack{
                                /*
                                Slider(value: $progress)
                                    .padding()
    */
                                Text("Destination")
                            }
                            ,
                        label: {
                            HStack{
                                CircularProgress1()
                                     .frame(width: 50, height: 50, alignment: .center)
                                Text("8. 근대 개항기")
                            }
                        })
                        .padding(.all, -10)
                    
                    
                    NavigationLink(
                        destination:
                            VStack{
                                /*
                                Slider(value: $progress)
                                    .padding()
    */
                                Text("Destination")
                            }
                            ,
                        label: {
                            HStack{
                                CircularProgress1()
                                     .frame(width: 50, height: 50, alignment: .center)
                                Text("9. 민족 독립 운동기")
                            }
                        })
                        .padding(.all, -10)
                    
                    
                    NavigationLink(
                        destination:
                            VStack{
                                /*
                                Slider(value: $progress)
                                    .padding()
    */
                                Text("Destination")
                            }
                            ,
                        label: {
                            HStack{
                                CircularProgress1()
                                     .frame(width: 50, height: 50, alignment: .center)
                                Text("10. 현대")
                            }
                        })
                        .padding(.all, -10)
                        
                }
                .navigationBarTitle("한능검 포인트 300"
                    , displayMode: .inline)
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            isShowingSettings = true
                        }){
                            Image(systemName: "slider.horizontal.3")
                        }
                        .sheet(isPresented: $isShowingSettings){
                            SettingsView()
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
