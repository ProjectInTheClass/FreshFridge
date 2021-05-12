//  MyCircleProgressView.swift
//  KH240
//  Created by Park Youngeun on 2021/05/09.

import SwiftUI

struct MyCircleProgressView1: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("dpview1") var dpview1 : Double = 0.0
    
    var body: some View {
        let dpview1:Double = myInfo.Progress1(
            a1: myInfo.dva1)
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: 30, height: 30)
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(dpview1))
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .fill(dpview1 == 1 ? Color.green : Color.red)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut)//부드럽게 움직임
            VStack{
                Text("\(Int(dpview1 * 100))" + "%")
                    .foregroundColor(dpview1 == 1 ?
                                        Color.green : Color.blue)
                    .font(.caption2)
            }
        }
        .padding(30)
    }
    
}

struct MyCircleProgressView2: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("dpview2") var dpview2 : Double = 0.0
    
    var body: some View {
        let dpview2:Double = myInfo.Progress2(
            b1: myInfo.dvb1, b2: myInfo.dvb2, b3: myInfo.dvb3, b4: myInfo.dvb4, b5: myInfo.dvb5
        )
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: 30, height: 30)
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(dpview2))
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .fill(dpview2 == 1 ? Color.green : Color.red)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut)//부드럽게 움직임
            VStack{
                Text("\(Int(dpview2 * 100))" + "%")
                    .foregroundColor(dpview2 == 1 ?
                                        Color.green : Color.blue)
                    .font(.caption2)
            }
        }
        .padding(30)
    }
    
}

struct MyCircleProgressView3: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("dpview3") var dpview3 : Double = 0.0
    
    var body: some View {
        let dpview3:Double = myInfo.Progress3(
            c1: myInfo.dvc1, c2: myInfo.dvc2, c3: myInfo.dvc3, c4: myInfo.dvc4, c5: myInfo.dvc5, c6: myInfo.dvc6
        )
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: 30, height: 30)
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(dpview3))
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .fill(dpview3 == 100 ? Color.green : Color.red)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut)//부드럽게 움직임
            VStack{
                Text("\(Int(dpview3))" + "%")
                    .foregroundColor(dpview3 == 100 ?
                                        Color.green : Color.blue)
                    .font(.caption2)
            }
        }
        .padding(30)
    }
    
}

struct MyCircleProgressView4: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("dpview4") var dpview4 : Double = 0.0
    
    var body: some View {
        let dpview4:Double = myInfo.Progress4(
            d1: myInfo.dvd1, d2: myInfo.dvd2, d3: myInfo.dvd3, d4: myInfo.dvd4, d5: myInfo.dvd5,
            d6: myInfo.dvd6, d7: myInfo.dvd7, d8: myInfo.dvd8, d9: myInfo.dvd9, d10: myInfo.dvd10,
            d11: myInfo.dvd11, d12: myInfo.dvd12, d13: myInfo.dvd13, d14: myInfo.dvd14, d15: myInfo.dvd15,
            d16: myInfo.dvd16, d17: myInfo.dvd17, d18: myInfo.dvd18, d19: myInfo.dvd19, d20: myInfo.dvd20,
            d21: myInfo.dvd21, d22: myInfo.dvd22, d23: myInfo.dvd23, d24: myInfo.dvd24, d25: myInfo.dvd25,
            d26: myInfo.dvd26, d27: myInfo.dvd27, d28: myInfo.dvd28, d29: myInfo.dvd29, d30: myInfo.dvd30,
            d31: myInfo.dvd31, d32: myInfo.dvd32, d33: myInfo.dvd33
        )
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: 30, height: 30)
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(dpview4))
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .fill(dpview4 == 100 ? Color.green : Color.red)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut)//부드럽게 움직임
            VStack{
                Text("\(Int(dpview4))" + "%")
                    .foregroundColor(dpview4 == 100 ?
                                        Color.green : Color.blue)
                    .font(.caption2)
            }
        }
        .padding(30)
    }
}

struct MyCircleProgressView5: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("dpview5") var dpview5 : Double = 0.0
    
    var body: some View {
        let dpview5:Double = myInfo.Progress5(
            e1: myInfo.dve1, e2: myInfo.dve2, e3: myInfo.dve3, e4: myInfo.dve4, e5: myInfo.dve5,
            e6: myInfo.dve6, e7: myInfo.dve7, e8: myInfo.dve8, e9: myInfo.dve9, e10: myInfo.dve10,
            e11: myInfo.dve11, e12: myInfo.dve12, e13: myInfo.dve13, e14: myInfo.dve14, e15: myInfo.dve15,
            e16: myInfo.dve16, e17: myInfo.dve17, e18: myInfo.dve18, e19: myInfo.dve19, e20: myInfo.dve20,
            e21: myInfo.dve21, e22: myInfo.dve22, e23: myInfo.dve23, e24: myInfo.dve24, e25: myInfo.dve25,
            e26: myInfo.dve26, e27: myInfo.dve27, e28: myInfo.dve28, e29: myInfo.dve29, e30: myInfo.dve30,
            e31: myInfo.dve31, e32: myInfo.dve32, e33: myInfo.dve33, e34: myInfo.dve34, e35: myInfo.dve35,
            e36: myInfo.dve36, e37: myInfo.dve37, e38: myInfo.dve38
        )
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: 30, height: 30)
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(dpview5))
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .fill(dpview5 == 100 ? Color.green : Color.red)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut)//부드럽게 움직임
            VStack{
                Text("\(Int(dpview5))" + "%")
                    .foregroundColor(dpview5 == 100 ?
                                        Color.green : Color.blue)
                    .font(.caption2)
            }
        }
        .padding(30)
    }
}

struct MyCircleProgressView6: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("dpview5") var dpview6 : Double = 0.0
    
    var body: some View {
        let dpview6:Double = myInfo.Progress6(
            f1: myInfo.dvf1, f2: myInfo.dvf2, f3: myInfo.dvf3, f4: myInfo.dvf4, f5: myInfo.dvf5,
            f6: myInfo.dvf6, f7: myInfo.dvf7, f8: myInfo.dvf8, f9: myInfo.dvf9, f10: myInfo.dvf10,
            f11: myInfo.dvf11, f12: myInfo.dvf12, f13: myInfo.dvf13, f14: myInfo.dvf14, f15: myInfo.dvf15,
            f16: myInfo.dvf16, f17: myInfo.dvf17, f18: myInfo.dvf18, f19: myInfo.dvf19, f20: myInfo.dvf20,
            f21: myInfo.dvf21, f22: myInfo.dvf22, f23: myInfo.dvf23, f24: myInfo.dvf24, f25: myInfo.dvf25,
            f26: myInfo.dvf26, f27: myInfo.dvf27, f28: myInfo.dvf28, f29: myInfo.dvf29, f30: myInfo.dvf30,
            f31: myInfo.dvf31, f32: myInfo.dvf32, f33: myInfo.dvf33, f34: myInfo.dvf34, f35: myInfo.dvf35,
            f36: myInfo.dvf36, f37: myInfo.dvf37, f38: myInfo.dvf38, f39: myInfo.dvf39, f40: myInfo.dvf40,
            f41: myInfo.dvf41, f42: myInfo.dvf42, f43: myInfo.dvf43, f44: myInfo.dvf44, f45: myInfo.dvf45,
            f46: myInfo.dvf46, f47: myInfo.dvf47, f48: myInfo.dvf48, f49: myInfo.dvf49, f50: myInfo.dvf50
        )
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: 30, height: 30)
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(dpview6))
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .fill(dpview6 == 100 ? Color.green : Color.red)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut)//부드럽게 움직임
            VStack{
                Text("\(Int(dpview6))" + "%")
                    .foregroundColor(dpview6 == 100 ?
                                        Color.green : Color.blue)
                    .font(.caption2)
            }
        }
        .padding(30)
    }
}

struct MyCircleProgressView7: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("dpview7") var dpview7 : Double = 0.0
    
    var body: some View {
        let dpview7:Double = myInfo.Progress7(
            g1: myInfo.dvg1, g2: myInfo.dvg2, g3: myInfo.dvg3, g4: myInfo.dvg4, g5: myInfo.dvg5,
            g6: myInfo.dvg6, g7: myInfo.dvg7, g8: myInfo.dvg8, g9: myInfo.dvg9, g10: myInfo.dvg10,
            g11: myInfo.dvg11, g12: myInfo.dvg12, g13: myInfo.dvg13, g14: myInfo.dvg14, g15: myInfo.dvg15,
            g16: myInfo.dvg16, g17: myInfo.dvg17, g18: myInfo.dvg18, g19: myInfo.dvg19, g20: myInfo.dvg20,
            g21: myInfo.dvg21, g22: myInfo.dvg22, g23: myInfo.dvg23, g24: myInfo.dvg24, g25: myInfo.dvg25,
            g26: myInfo.dvg26, g27: myInfo.dvg27, g28: myInfo.dvg28, g29: myInfo.dvg29, g30: myInfo.dvg30,
            g31: myInfo.dvg31, g32: myInfo.dvg32, g33: myInfo.dvg33, g34: myInfo.dvg34, g35: myInfo.dvg35,
            g36: myInfo.dvg36, g37: myInfo.dvg37
        )
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: 30, height: 30)
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(dpview7))
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .fill(dpview7 == 100 ? Color.green : Color.red)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut)//부드럽게 움직임
            VStack{
                Text("\(Int(dpview7))" + "%")
                    .foregroundColor(dpview7 == 100 ?
                                        Color.green : Color.blue)
                    .font(.caption2)
            }
        }
        .padding(30)
    }
}

struct MyCircleProgressView8: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("dpview8") var dpview8 : Double = 0.0
    
    var body: some View {
        let dpview8:Double = myInfo.Progress8(
            h1: myInfo.dvh1, h2: myInfo.dvh2, h3: myInfo.dvh3, h4: myInfo.dvh4, h5: myInfo.dvh5,
            h6: myInfo.dvh6, h7: myInfo.dvh7, h8: myInfo.dvh8, h9: myInfo.dvh9, h10: myInfo.dvh10,
            h11: myInfo.dvh11, h12: myInfo.dvh12, h13: myInfo.dvh13, h14: myInfo.dvh14, h15: myInfo.dvh15,
            h16: myInfo.dvh16, h17: myInfo.dvh17, h18: myInfo.dvh18, h19: myInfo.dvh19, h20: myInfo.dvh20,
            h21: myInfo.dvh21, h22: myInfo.dvh22, h23: myInfo.dvh23, h24: myInfo.dvh24, h25: myInfo.dvh25,
            h26: myInfo.dvh26, h27: myInfo.dvh27, h28: myInfo.dvh28, h29: myInfo.dvh29, h30: myInfo.dvh30,
            h31: myInfo.dvh31, h32: myInfo.dvh32, h33: myInfo.dvh33, h34: myInfo.dvh34, h35: myInfo.dvh35,
            h36: myInfo.dvh36
        )
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: 30, height: 30)
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(dpview8))
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .fill(dpview8 == 100 ? Color.green : Color.red)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut)//부드럽게 움직임
            VStack{
                Text("\(Int(dpview8))" + "%")
                    .foregroundColor(dpview8 == 100 ?
                                        Color.green : Color.blue)
                    .font(.caption2)
            }
        }
        .padding(30)
    }
}

struct MyCircleProgressView9: View {
    @EnvironmentObject var myInfo: MyInfo
    @AppStorage("dpview9") var dpview9 : Double = 0.0
    
    var body: some View {
        let dpview9:Double = myInfo.Progress9(
            i1: myInfo.dvi1, i2: myInfo.dvi2, i3: myInfo.dvi3, i4: myInfo.dvi4, i5: myInfo.dvi5,
            i6: myInfo.dvi6, i7: myInfo.dvi7, i8: myInfo.dvi8, i9: myInfo.dvi9, i10: myInfo.dvi10,
            i11: myInfo.dvi11, i12: myInfo.dvi12, i13: myInfo.dvi13, i14: myInfo.dvi14, i15: myInfo.dvi15,
            i16: myInfo.dvi16, i17: myInfo.dvi17, i18: myInfo.dvi18, i19: myInfo.dvi19, i20: myInfo.dvi20,
            i21: myInfo.dvi21, i22: myInfo.dvi22, i23: myInfo.dvi23, i24: myInfo.dvi24, i25: myInfo.dvi25,
            i26: myInfo.dvi26, i27: myInfo.dvi27, i28: myInfo.dvi28, i29: myInfo.dvi29, i30: myInfo.dvi30,
            i31: myInfo.dvi31, i32: myInfo.dvi32, i33: myInfo.dvi33, i34: myInfo.dvi34
        )
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                .frame(width: 30, height: 30)
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: CGFloat(dpview9))
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .fill(dpview9 == 100 ? Color.green : Color.red)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut)//부드럽게 움직임
            VStack{
                Text("\(Int(dpview9))" + "%")
                    .foregroundColor(dpview9 == 100 ?
                                        Color.green : Color.blue)
                    .font(.caption2)
            }
        }
        .padding(30)
    }
}






















struct MyCircleProgressView1_Previews: PreviewProvider {
    static var previews: some View {
        MyCircleProgressView1()
    }
}

