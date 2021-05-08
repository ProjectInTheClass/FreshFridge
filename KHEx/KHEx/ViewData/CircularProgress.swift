//
//  CircularProgress.swift
//  KHEx
//
//  Created by Park Youngeun on 2021/05/07.
//
import SwiftUI

struct CircularProgress1: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("noti1") var process: Double = 0.0

    var body: some View {
        
        let process:Double = myInfo.Progress(a: myInfo.detailprogress1, b: myInfo.detailprogress2, c: myInfo.detailprogress3, d: myInfo.detailprogress4, e: myInfo.detailprogress5)
        
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: 30, height: 30)
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(process))
              //  .stroke(Color.red, lineWidth: 20)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .fill(process == 1 ? Color.green : Color.red)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut)//부드럽게 움직임
            VStack{
                Text("\(Int(process * 100))" + "%")
                    .foregroundColor(process == 1 ?
                                        Color.green : Color.blue)
                    .font(.caption2)
                
                //Text("\(String(format: "%.2f", (progress * 100)))" + "%")
            }
            
        }
        .padding(30)
    }
}







struct CircularProgress_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgress1()
            .environmentObject(MyInfo())
    }
}
