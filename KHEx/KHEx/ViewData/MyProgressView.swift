//
//  ProgressView.swift
//  KHEx
//
//  Created by Park Youngeun on 2021/05/07.
//

import SwiftUI

struct MyProgressView: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("total") var totalprocess: Double = 0.0
    
    
    
    var body: some View {
        let totalprocess:Double = myInfo.TotalProgress(a1: myInfo.totalvalue1, a2: myInfo.totalvalue2, a3: myInfo.totalvalue3, a4: myInfo.totalvalue4, a5: myInfo.totalvalue5)
        ProgressView("전체 진도율  \(Int(round(totalprocess)))%", value: totalprocess, total: 100.0)
    }
}

struct MyProgressView_Previews: PreviewProvider {
    static var previews: some View {
        MyProgressView()
    }
}

