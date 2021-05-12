//
//  KHProgressView.swift
//  KH240
//
//  Created by Park Youngeun on 2021/05/09.
//

import SwiftUI

struct MyProgressView: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("total") var totalprogress: Double = 0.0
    
    var body: some View {
        
 let totalprogress:Double =
            
            myInfo.TotalProgress(
             a1: myInfo.tva1,
             
             b1: myInfo.tvb1, b2: myInfo.tvb2, b3: myInfo.tvb3, b4: myInfo.tvb4, b5: myInfo.tvb5,

             c1: myInfo.tvc1, c2: myInfo.tvc2, c3: myInfo.tvc3, c4: myInfo.tvc4, c5: myInfo.tvc5,
             c6: myInfo.tvc6,
                                    
             d1: myInfo.tvd1, d2: myInfo.tvd2, d3: myInfo.tvd3, d4: myInfo.tvd4, d5: myInfo.tvd5,
             d6: myInfo.tvd6, d7: myInfo.tvd7, d8: myInfo.tvd8, d9: myInfo.tvd9, d10: myInfo.tvd10,
             d11: myInfo.tvd11, d12: myInfo.tvd12, d13: myInfo.tvd13, d14: myInfo.tvd14, d15: myInfo.tvd15,
             d16: myInfo.tvd16, d17: myInfo.tvd17, d18: myInfo.tvd18, d19: myInfo.tvd19, d20: myInfo.tvd20,
             d21: myInfo.tvd21, d22: myInfo.tvd22, d23: myInfo.tvd23, d24: myInfo.tvd24, d25: myInfo.tvd25,
             d26: myInfo.tvd26, d27: myInfo.tvd27, d28: myInfo.tvd28, d29: myInfo.tvd29, d30: myInfo.tvd30,
             d31: myInfo.tvd31, d32: myInfo.tvd32, d33: myInfo.tvd33,

             e1: myInfo.tve1, e2: myInfo.tve2, e3: myInfo.tve3, e4: myInfo.tve4, e5: myInfo.tve5,
             e6: myInfo.tve6, e7: myInfo.tve7, e8: myInfo.tve8, e9: myInfo.tve9, e10: myInfo.tve10,
             e11: myInfo.tve11, e12: myInfo.tve12, e13: myInfo.tve13, e14: myInfo.tve14, e15: myInfo.tve15,
             e16: myInfo.tve16, e17: myInfo.tve17, e18: myInfo.tve18, e19: myInfo.tve19, e20: myInfo.tve20,
             e21: myInfo.tve21, e22: myInfo.tve22, e23: myInfo.tve23, e24: myInfo.tve24, e25: myInfo.tve25,
             e26: myInfo.tve26, e27: myInfo.tve27, e28: myInfo.tve28, e29: myInfo.tve29, e30: myInfo.tve30,
             e31: myInfo.tve31, e32: myInfo.tve32, e33: myInfo.tve33, e34: myInfo.tve34, e35: myInfo.tve35,
             e36: myInfo.tve36, e37: myInfo.tve37, e38: myInfo.tve38,

             f1: myInfo.tvf1, f2: myInfo.tvf2, f3: myInfo.tvf3, f4: myInfo.tvf4, f5: myInfo.tvf5,
             f6: myInfo.tvf6, f7: myInfo.tvf7, f8: myInfo.tvf8, f9: myInfo.tvf9, f10: myInfo.tvf10,
             f11: myInfo.tvf11, f12: myInfo.tvf12, f13: myInfo.tvf13, f14: myInfo.tvf14, f15: myInfo.tvf15,
             f16: myInfo.tvf16, f17: myInfo.tvf17, f18: myInfo.tvf18, f19: myInfo.tvf19, f20: myInfo.tvf20,
             f21: myInfo.tvf21, f22: myInfo.tvf22, f23: myInfo.tvf23, f24: myInfo.tvf24, f25: myInfo.tvf25,
             f26: myInfo.tvf26, f27: myInfo.tvf27, f28: myInfo.tvf28, f29: myInfo.tvf29, f30: myInfo.tvf30,
             f31: myInfo.tvf31, f32: myInfo.tvf32, f33: myInfo.tvf33, f34: myInfo.tvf34, f35: myInfo.tvf35,
             f36: myInfo.tvf36, f37: myInfo.tvf37, f38: myInfo.tvf38, f39: myInfo.tvf39, f40: myInfo.tvf40,
             f41: myInfo.tvf41, f42: myInfo.tvf42, f43: myInfo.tvf43, f44: myInfo.tvf44, f45: myInfo.tvf45,
             f46: myInfo.tvf46, f47: myInfo.tvf47, f48: myInfo.tvf48, f49: myInfo.tvf49, f50: myInfo.tvf50,

             g1: myInfo.tvg1, g2: myInfo.tvg2, g3: myInfo.tvg3, g4: myInfo.tvg4, g5: myInfo.tvg5,
             g6: myInfo.tvg6, g7: myInfo.tvg7, g8: myInfo.tvg8, g9: myInfo.tvg9, g10: myInfo.tvg10,
             g11: myInfo.tvg11, g12: myInfo.tvg12, g13: myInfo.tvg13, g14: myInfo.tvg14, g15: myInfo.tvg15,
             g16: myInfo.tvg16, g17: myInfo.tvg17, g18: myInfo.tvg18, g19: myInfo.tvg19, g20: myInfo.tvg20,
             g21: myInfo.tvg21, g22: myInfo.tvg22, g23: myInfo.tvg23, g24: myInfo.tvg24, g25: myInfo.tvg25,
             g26: myInfo.tvg26, g27: myInfo.tvg27, g28: myInfo.tvg28, g29: myInfo.tvg29, g30: myInfo.tvg30,
             g31: myInfo.tvg31, g32: myInfo.tvg32, g33: myInfo.tvg33, g34: myInfo.tvg34, g35: myInfo.tvg35,
             g36: myInfo.tvg36, g37: myInfo.tvg37,

             h1: myInfo.tvh1, h2: myInfo.tvh2, h3: myInfo.tvh3, h4: myInfo.tvh4, h5: myInfo.tvh5,
             h6: myInfo.tvh6, h7: myInfo.tvh7, h8: myInfo.tvh8, h9: myInfo.tvh9, h10: myInfo.tvh10,
             h11: myInfo.tvh11, h12: myInfo.tvh12, h13: myInfo.tvh13, h14: myInfo.tvh14, h15: myInfo.tvh15,
             h16: myInfo.tvh16, h17: myInfo.tvh17, h18: myInfo.tvh18, h19: myInfo.tvh19, h20: myInfo.tvh20,
             h21: myInfo.tvh21, h22: myInfo.tvh22, h23: myInfo.tvh23, h24: myInfo.tvh24, h25: myInfo.tvh25,
             h26: myInfo.tvh26, h27: myInfo.tvh27, h28: myInfo.tvh28, h29: myInfo.tvh29, h30: myInfo.tvh30,
             h31: myInfo.tvh31, h32: myInfo.tvh32, h33: myInfo.tvh33, h34: myInfo.tvh34, h35: myInfo.tvh35,
             h36: myInfo.tvh36,

             i1: myInfo.tvi1, i2: myInfo.tvi2, i3: myInfo.tvi3, i4: myInfo.tvi4, i5: myInfo.tvi5,
             i6: myInfo.tvi6, i7: myInfo.tvi7, i8: myInfo.tvi8, i9: myInfo.tvi9, i10: myInfo.tvi10,
             i11: myInfo.tvi11, i12: myInfo.tvi12, i13: myInfo.tvi13, i14: myInfo.tvi14, i15: myInfo.tvi15,
             i16: myInfo.tvi16, i17: myInfo.tvi17, i18: myInfo.tvi18, i19: myInfo.tvi19, i20: myInfo.tvi20,
             i21: myInfo.tvi21, i22: myInfo.tvi22, i23: myInfo.tvi23, i24: myInfo.tvi24, i25: myInfo.tvi25,
             i26: myInfo.tvi26, i27: myInfo.tvi27, i28: myInfo.tvi28, i29: myInfo.tvi29, i30: myInfo.tvi30,
             i31: myInfo.tvi31, i32: myInfo.tvi32, i33: myInfo.tvi33, i34: myInfo.tvi34
        )
        ProgressView("전체 진도율  \(Int(round(totalprogress)))%", value: totalprogress, total: 100.0)
    }
}


/*
struct MyProgressView_Previews: PreviewProvider {
    static var previews: some View {
        MyProgressView()
    }
}
*/
