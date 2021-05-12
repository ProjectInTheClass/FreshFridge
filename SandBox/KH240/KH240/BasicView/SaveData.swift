//
//  SaveData.swift
//  KH240
//
//  Created by Park Youngeun on 2021/05/08.
//
import Foundation

class MyInfo : ObservableObject{
    @discardableResult
    
    func TotalProgress( a1: Double,
                        
                        b1: Double, b2: Double, b3: Double, b4: Double, b5: Double,

                        c1: Double, c2: Double, c3: Double, c4: Double, c5: Double,
                        c6: Double,
                                               
                        d1: Double, d2: Double, d3: Double, d4: Double, d5: Double,
                        d6: Double, d7: Double, d8: Double, d9: Double, d10: Double,
                        d11: Double, d12: Double, d13: Double, d14: Double, d15: Double,
                        d16: Double, d17: Double, d18: Double, d19: Double, d20: Double,
                        d21: Double, d22: Double, d23: Double, d24: Double, d25: Double,
                        d26: Double, d27: Double, d28: Double, d29: Double, d30: Double,
                        d31: Double, d32: Double, d33: Double,


                        e1: Double, e2: Double, e3: Double, e4: Double, e5: Double,
                        e6: Double, e7: Double, e8: Double, e9: Double, e10: Double,
                        e11: Double, e12: Double, e13: Double, e14: Double, e15: Double,
                        e16: Double, e17: Double, e18: Double, e19: Double, e20: Double,
                        e21: Double, e22: Double, e23: Double, e24: Double, e25: Double,
                        e26: Double, e27: Double, e28: Double, e29: Double, e30: Double,
                        e31: Double, e32: Double, e33: Double, e34: Double, e35: Double,
                        e36: Double, e37: Double, e38: Double,

                        f1: Double, f2: Double, f3: Double, f4: Double, f5: Double,
                        f6: Double, f7: Double, f8: Double, f9: Double, f10: Double,
                        f11: Double, f12: Double, f13: Double, f14: Double, f15: Double,
                        f16: Double, f17: Double, f18: Double, f19: Double, f20: Double,
                        f21: Double, f22: Double, f23: Double, f24: Double, f25: Double,
                        f26: Double, f27: Double, f28: Double, f29: Double, f30: Double,
                        f31: Double, f32: Double, f33: Double, f34: Double, f35: Double,
                        f36: Double, f37: Double, f38: Double,f39: Double, f40: Double,
                        f41: Double, f42: Double, f43: Double, f44: Double, f45: Double,
                        f46: Double, f47: Double, f48: Double, f49: Double, f50: Double,

                        g1: Double, g2: Double, g3: Double, g4: Double, g5: Double,
                        g6: Double, g7: Double, g8: Double, g9: Double, g10: Double,
                        g11: Double, g12: Double, g13: Double, g14: Double, g15: Double,
                        g16: Double, g17: Double, g18: Double, g19: Double, g20: Double,
                        g21: Double, g22: Double, g23: Double, g24: Double, g25: Double,
                        g26: Double, g27: Double, g28: Double, g29: Double, g30: Double,
                        g31: Double, g32: Double, g33: Double, g34: Double, g35: Double,
                        g36: Double, g37: Double,

                        h1: Double, h2: Double, h3: Double, h4: Double, h5: Double,
                        h6: Double, h7: Double, h8: Double, h9: Double, h10: Double,
                        h11: Double, h12: Double, h13: Double, h14: Double, h15: Double,
                        h16: Double, h17: Double, h18: Double, h19: Double, h20: Double,
                        h21: Double, h22: Double, h23: Double, h24: Double, h25: Double,
                        h26: Double, h27: Double, h28: Double, h29: Double, h30: Double,
                        h31: Double, h32: Double, h33: Double, h34: Double, h35: Double,
                        h36: Double,


                        i1: Double, i2: Double, i3: Double, i4: Double, i5: Double,
                        i6: Double, i7: Double, i8: Double, i9: Double, i10: Double,
                        i11: Double, i12: Double, i13: Double, i14: Double, i15: Double,
                        i16: Double, i17: Double, i18: Double, i19: Double, i20: Double,
                        i21: Double, i22: Double, i23: Double, i24: Double, i25: Double,
                        i26: Double, i27: Double, i28: Double, i29: Double, i30: Double,
                        i31: Double, i32: Double, i33: Double, i34: Double

                       ) -> Double{
        let result =
        a1 +
        
        b1 + b2 + b3 + b4 + b5 +
        
        c1 + c2 + c3 + c4 + c5 +
        c6 +
            
        d1 + d2 + d3 + d4 + d5 +
        d6 + d7 + d8 + d9 + d10 +
        d11 + d12 + d13 + d14 + d15 +
        d16 + d17 + d18 + d19 + d20 +
        d21 + d22 + d23 + d24 + d25 +
        d26 + d27 + d28 + d29 + d30 +
        d31 + d32 + d33 +
        
        e1 + e2 + e3 + e4 + e5 +
        e6 + e7 + e8 + e9 + e10 +
        e11 + e12 + e13 + e14 + e15 +
        e16 + e17 + e18 + e19 + e20 +
        e21 + e22 + e23 + e24 + e25 +
        e26 + e27 + e28 + e29 + e30 +
        e31 + e32 + e33 + e34 + e35 +
        e36 + e37 + e38 +
        
        f1 + f2 + f3 + f4 + f5 +
        f6 + f7 + f8 + f9 + f10 +
        f11 + f12 + f13 + f14 + f15 +
        f16 + f17 + f18 + f19 + f20 +
        f21 + f22 + f23 + f24 + f25 +
        f26 + f27 + f28 + f29 + f30 +
        f31 + f32 + f33 + f34 + f35 +
        f36 + f37 + f38 + f39 + f40 +
        f41 + f42 + f43 + f44 + f45 +
        f46 + f47 + f48 + f49 + f50 +
        
        g1 + g2 + g3 + g4 + g5 +
        g6 + g7 + g8 + g9 + g10 +
        g11 + g12 + g13 + g14 + g15 +
        g16 + g17 + g18 + g19 + g20 +
        g21 + g22 + g23 + g24 + g25 +
        g26 + g27 + g28 + g29 + g30 +
        g31 + g32 + g33 + g34 + g35 +
        g36 + g37 +
        
        h1 + h2 + h3 + h4 + h5 +
        h6 + h7 + h8 + h9 + h10 +
        h11 + h12 + h13 + h14 + h15 +
        h16 + h17 + h18 + h19 + h20 +
        h21 + h22 + h23 + h24 + h25 +
        h26 + h27 + h28 + h29 + h30 +
        h31 + h32 + h33 + h34 + h35 +
        h36 +
            
        i1 + i2 + i3 + i4 + i5 +
        i6 + i7 + i8 + i9 + i10 +
        i11 + i12 + i13 + i14 + i15 +
        i16 + i17 + i18 + i19 + i20 +
        i21 + i22 + i23 + i24 + i25 +
        i26 + i27 + i28 + i29 + i30 +
        i31 + i32 + i33 + i34
        return result
    }

    
    
func Progress1(a1: Double) -> Double{
    let result = a1
    return result
}


func Progress2(b1: Double, b2: Double, b3: Double, b4: Double, b5: Double) -> Double{
    let result = b1 + b2 + b3 + b4 + b5
    return result
}


func Progress3(c1: Double, c2: Double, c3: Double, c4: Double, c5: Double,
               c6: Double) -> Double{
    let result = c1 + c2 + c3 + c4 + c5 + c6
    return result
}


func Progress4(d1: Double, d2: Double, d3: Double, d4: Double, d5: Double,
               d6: Double, d7: Double, d8: Double, d9: Double, d10: Double,
               d11: Double, d12: Double, d13: Double, d14: Double, d15: Double,
               d16: Double, d17: Double, d18: Double, d19: Double, d20: Double,
               d21: Double, d22: Double, d23: Double, d24: Double, d25: Double,
               d26: Double, d27: Double, d28: Double, d29: Double, d30: Double,
               d31: Double, d32: Double, d33: Double) -> Double{
    let result = d1 + d2 + d3 + d4 + d5 +
        d6 + d7 + d8 + d9 + d10 +
        d11 + d12 + d13 + d14 + d15 +
        d16 + d17 + d18 + d19 + d20 +
        d21 + d22 + d23 + d24 + d25 +
        d26 + d27 + d28 + d29 + d30 +
        d31 + d32 + d33
    return result
}


func Progress5(e1: Double, e2: Double, e3: Double, e4: Double, e5: Double,
               e6: Double, e7: Double, e8: Double, e9: Double, e10: Double,
               e11: Double, e12: Double, e13: Double, e14: Double, e15: Double,
               e16: Double, e17: Double, e18: Double, e19: Double, e20: Double,
               e21: Double, e22: Double, e23: Double, e24: Double, e25: Double,
               e26: Double, e27: Double, e28: Double, e29: Double, e30: Double,
               e31: Double, e32: Double, e33: Double, e34: Double, e35: Double,
               e36: Double, e37: Double, e38: Double) -> Double{
    let result = e1 + e2 + e3 + e4 + e5 +
        e6 + e7 + e8 + e9 + e10 +
        e11 + e12 + e13 + e14 + e15 +
        e16 + e17 + e18 + e19 + e20 +
        e21 + e22 + e23 + e24 + e25 +
        e26 + e27 + e28 + e29 + e30 +
        e31 + e32 + e33 + e34 + e35 +
        e36 + e37 + e38
    return result
}


func Progress6(f1: Double, f2: Double, f3: Double, f4: Double, f5: Double,
               f6: Double, f7: Double, f8: Double, f9: Double, f10: Double,
               f11: Double, f12: Double, f13: Double, f14: Double, f15: Double,
               f16: Double, f17: Double, f18: Double, f19: Double, f20: Double,
               f21: Double, f22: Double, f23: Double, f24: Double, f25: Double,
               f26: Double, f27: Double, f28: Double, f29: Double, f30: Double,
               f31: Double, f32: Double, f33: Double, f34: Double, f35: Double,
               f36: Double, f37: Double, f38: Double,f39: Double, f40: Double,
               f41: Double, f42: Double, f43: Double, f44: Double, f45: Double,
               f46: Double, f47: Double, f48: Double, f49: Double, f50: Double
) -> Double{
    let result = f1 + f2 + f3 + f4 + f5 +
        f6 + f7 + f8 + f9 + f10 +
        f11 + f12 + f13 + f14 + f15 +
        f16 + f17 + f18 + f19 + f20 +
        f21 + f22 + f23 + f24 + f25 +
        f26 + f27 + f28 + f29 + f30 +
        f31 + f32 + f33 + f34 + f35 +
        f36 + f37 + f38 + f39 + f40 +
        f41 + f42 + f43 + f44 + f45 +
        f46 + f47 + f48 + f49 + f50
    return result
}


func Progress7(g1: Double, g2: Double, g3: Double, g4: Double, g5: Double,
               g6: Double, g7: Double, g8: Double, g9: Double, g10: Double,
               g11: Double, g12: Double, g13: Double, g14: Double, g15: Double,
               g16: Double, g17: Double, g18: Double, g19: Double, g20: Double,
               g21: Double, g22: Double, g23: Double, g24: Double, g25: Double,
               g26: Double, g27: Double, g28: Double, g29: Double, g30: Double,
               g31: Double, g32: Double, g33: Double, g34: Double, g35: Double,
               g36: Double, g37: Double
) -> Double{
    let result = g1 + g2 + g3 + g4 + g5 +
        g6 + g7 + g8 + g9 + g10 +
        g11 + g12 + g13 + g14 + g15 +
        g16 + g17 + g18 + g19 + g20 +
        g21 + g22 + g23 + g24 + g25 +
        g26 + g27 + g28 + g29 + g30 +
        g31 + g32 + g33 + g34 + g35 +
        g36 + g37
    return result
}


func Progress8(h1: Double, h2: Double, h3: Double, h4: Double, h5: Double,
               h6: Double, h7: Double, h8: Double, h9: Double, h10: Double,
               h11: Double, h12: Double, h13: Double, h14: Double, h15: Double,
               h16: Double, h17: Double, h18: Double, h19: Double, h20: Double,
               h21: Double, h22: Double, h23: Double, h24: Double, h25: Double,
               h26: Double, h27: Double, h28: Double, h29: Double, h30: Double,
               h31: Double, h32: Double, h33: Double, h34: Double, h35: Double,
               h36: Double
) -> Double{
    let result = h1 + h2 + h3 + h4 + h5 +
        h6 + h7 + h8 + h9 + h10 +
        h11 + h12 + h13 + h14 + h15 +
        h16 + h17 + h18 + h19 + h20 +
        h21 + h22 + h23 + h24 + h25 +
        h26 + h27 + h28 + h29 + h30 +
        h31 + h32 + h33 + h34 + h35 +
        h36
    return result
}


func Progress9(i1: Double, i2: Double, i3: Double, i4: Double, i5: Double,
               i6: Double, i7: Double, i8: Double, i9: Double, i10: Double,
               i11: Double, i12: Double, i13: Double, i14: Double, i15: Double,
               i16: Double, i17: Double, i18: Double, i19: Double, i20: Double,
               i21: Double, i22: Double, i23: Double, i24: Double, i25: Double,
               i26: Double, i27: Double, i28: Double, i29: Double, i30: Double,
               i31: Double, i32: Double, i33: Double, i34: Double
) -> Double{
    let result = i1 + i2 + i3 + i4 + i5 +
        i6 + i7 + i8 + i9 + i10 +
        i11 + i12 + i13 + i14 + i15 +
        i16 + i17 + i18 + i19 + i20 +
        i21 + i22 + i23 + i24 + i25 +
        i26 + i27 + i28 + i29 + i30 +
        i31 + i32 + i33 + i34
    return result
}


 
 //ona1 : 토글 a1
 //tva1 : 토탈벨류  a1
 //dva1 : 디테일벨류 a1
 

   @Published var ona1: Bool = UserDefaults.standard.bool(forKey: "ona1"){
        didSet{
           UserDefaults.standard.set(self.ona1, forKey: "ona1")
        }
   }
    
    @Published var onb1: Bool = UserDefaults.standard.bool(forKey: "onb1"){
        didSet{
            UserDefaults.standard.set(self.onb1, forKey: "onb1")
        }
    }
    
    @Published var onb2: Bool = UserDefaults.standard.bool(forKey: "onb2"){
        didSet{
            UserDefaults.standard.set(self.onb2, forKey: "onb2")
        }
    }
    
    @Published var onb3: Bool = UserDefaults.standard.bool(forKey: "onb3"){
        didSet{
            UserDefaults.standard.set(self.onb3, forKey: "onb3")
        }
    }
    
    @Published var onb4: Bool = UserDefaults.standard.bool(forKey: "onb4"){
        didSet{
            UserDefaults.standard.set(self.onb4, forKey: "onb4")
        }
    }
    
    @Published var onb5: Bool = UserDefaults.standard.bool(forKey: "onb5"){
        didSet{
            UserDefaults.standard.set(self.onb5, forKey: "onb5")
        }
    }
    
    @Published var onc1: Bool = UserDefaults.standard.bool(forKey: "onc1"){
        didSet{
            UserDefaults.standard.set(self.onb3, forKey: "onc1")
        }
    }
    
    @Published var onc2: Bool = UserDefaults.standard.bool(forKey: "onc2"){
        didSet{
            UserDefaults.standard.set(self.onc2, forKey: "onc2")
        }
    }
    
    @Published var onc3: Bool = UserDefaults.standard.bool(forKey: "onc3"){
        didSet{
            UserDefaults.standard.set(self.onc3, forKey: "onc3")
        }
    }
    
    @Published var onc4: Bool = UserDefaults.standard.bool(forKey: "onc4"){
        didSet{
            UserDefaults.standard.set(self.onc4, forKey: "onc4")
        }
    }
    
    @Published var onc5: Bool = UserDefaults.standard.bool(forKey: "onc5"){
        didSet{
            UserDefaults.standard.set(self.onc5, forKey: "onc5")
        }
    }
    
    @Published var onc6: Bool = UserDefaults.standard.bool(forKey: "onc6"){
        didSet{
            UserDefaults.standard.set(self.onc6, forKey: "onc6")
        }
    }
    
    @Published var ond1: Bool = UserDefaults.standard.bool(forKey: "ond1"){
        didSet{
            UserDefaults.standard.set(self.ond1, forKey: "ond1")
        }
    }
    
    @Published var ond2: Bool = UserDefaults.standard.bool(forKey: "ond2"){
        didSet{
            UserDefaults.standard.set(self.ond2, forKey: "ond2")
        }
    }
    
    @Published var ond3: Bool = UserDefaults.standard.bool(forKey: "ond3"){
        didSet{
            UserDefaults.standard.set(self.ond3, forKey: "ond3")
        }
    }
    
    @Published var ond4: Bool = UserDefaults.standard.bool(forKey: "ond4"){
        didSet{
            UserDefaults.standard.set(self.ond4, forKey: "ond4")
        }
    }
    
    @Published var ond5: Bool = UserDefaults.standard.bool(forKey: "ond5"){
        didSet{
            UserDefaults.standard.set(self.ond5, forKey: "ond5")
        }
    }
    
    @Published var ond6: Bool = UserDefaults.standard.bool(forKey: "ond6"){
        didSet{
            UserDefaults.standard.set(self.ond6, forKey: "ond6")
        }
    }
    
    @Published var ond7: Bool = UserDefaults.standard.bool(forKey: "ond7"){
        didSet{
            UserDefaults.standard.set(self.ond7, forKey: "ond7")
        }
    }
    
    @Published var ond8: Bool = UserDefaults.standard.bool(forKey: "ond8"){
        didSet{
            UserDefaults.standard.set(self.ond8, forKey: "ond8")
        }
    }
    
    @Published var ond9: Bool = UserDefaults.standard.bool(forKey: "ond9"){
        didSet{
            UserDefaults.standard.set(self.ond9, forKey: "ond9")
        }
    }
    
    @Published var ond10: Bool = UserDefaults.standard.bool(forKey: "ond10"){
        didSet{
            UserDefaults.standard.set(self.ond10, forKey: "ond10")
        }
    }
    
    @Published var ond11: Bool = UserDefaults.standard.bool(forKey: "ond11"){
        didSet{
            UserDefaults.standard.set(self.ond11, forKey: "ond11")
        }
    }
    
    @Published var ond12: Bool = UserDefaults.standard.bool(forKey: "ond12"){
        didSet{
            UserDefaults.standard.set(self.ond12, forKey: "ond12")
        }
    }
    
    @Published var ond13: Bool = UserDefaults.standard.bool(forKey: "ond13"){
        didSet{
            UserDefaults.standard.set(self.ond13, forKey: "ond13")
        }
    }
    
    @Published var ond14: Bool = UserDefaults.standard.bool(forKey: "ond14"){
        didSet{
            UserDefaults.standard.set(self.ond14, forKey: "ond14")
        }
    }
    
    @Published var ond15: Bool = UserDefaults.standard.bool(forKey: "ond15"){
        didSet{
            UserDefaults.standard.set(self.ond15, forKey: "ond15")
        }
    }
    
    @Published var ond16: Bool = UserDefaults.standard.bool(forKey: "ond16"){
        didSet{
            UserDefaults.standard.set(self.ond16, forKey: "ond16")
        }
    }
    
    @Published var ond17: Bool = UserDefaults.standard.bool(forKey: "ond17"){
        didSet{
            UserDefaults.standard.set(self.ond17, forKey: "ond17")
        }
    }
    
    @Published var ond18: Bool = UserDefaults.standard.bool(forKey: "ond18"){
        didSet{
            UserDefaults.standard.set(self.ond18, forKey: "ond18")
        }
    }
    
    @Published var ond19: Bool = UserDefaults.standard.bool(forKey: "ond19"){
        didSet{
            UserDefaults.standard.set(self.ond19, forKey: "ond19")
        }
    }
    
    @Published var ond20: Bool = UserDefaults.standard.bool(forKey: "ond20"){
        didSet{
            UserDefaults.standard.set(self.ond20, forKey: "ond20")
        }
    }
    
    @Published var ond21: Bool = UserDefaults.standard.bool(forKey: "ond21"){
        didSet{
            UserDefaults.standard.set(self.ond21, forKey: "ond21")
        }
    }
    
    @Published var ond22: Bool = UserDefaults.standard.bool(forKey: "ond22"){
        didSet{
            UserDefaults.standard.set(self.ond22, forKey: "ond22")
        }
    }
    
    @Published var ond23: Bool = UserDefaults.standard.bool(forKey: "ond23"){
        didSet{
            UserDefaults.standard.set(self.ond23, forKey: "ond23")
        }
    }
    
    @Published var ond24: Bool = UserDefaults.standard.bool(forKey: "ond24"){
        didSet{
            UserDefaults.standard.set(self.ond24, forKey: "ond24")
        }
    }
    
    @Published var ond25: Bool = UserDefaults.standard.bool(forKey: "ond25"){
        didSet{
            UserDefaults.standard.set(self.ond25, forKey: "ond25")
        }
    }
    
    @Published var ond26: Bool = UserDefaults.standard.bool(forKey: "ond26"){
        didSet{
            UserDefaults.standard.set(self.ond26, forKey: "ond26")
        }
    }
    
    @Published var ond27: Bool = UserDefaults.standard.bool(forKey: "ond27"){
        didSet{
            UserDefaults.standard.set(self.ond27, forKey: "ond27")
        }
    }
    
    @Published var ond28: Bool = UserDefaults.standard.bool(forKey: "ond28"){
        didSet{
            UserDefaults.standard.set(self.ond28, forKey: "ond28")
        }
    }
    
    @Published var ond29: Bool = UserDefaults.standard.bool(forKey: "ond29"){
        didSet{
            UserDefaults.standard.set(self.ond29, forKey: "ond29")
        }
    }
    
    @Published var ond30: Bool = UserDefaults.standard.bool(forKey: "ond30"){
        didSet{
            UserDefaults.standard.set(self.ond30, forKey: "ond30")
        }
    }
    
    @Published var ond31: Bool = UserDefaults.standard.bool(forKey: "ond31"){
        didSet{
            UserDefaults.standard.set(self.ond31, forKey: "ond31")
        }
    }
    
    @Published var ond32: Bool = UserDefaults.standard.bool(forKey: "ond32"){
        didSet{
            UserDefaults.standard.set(self.ond32, forKey: "ond32")
        }
    }
    
    @Published var ond33: Bool = UserDefaults.standard.bool(forKey: "ond33"){
        didSet{
            UserDefaults.standard.set(self.ond33, forKey: "ond33")
        }
    }
    
    @Published var one1: Bool = UserDefaults.standard.bool(forKey: "one1"){
        didSet{
            UserDefaults.standard.set(self.one1, forKey: "one1")
        }
    }
    
    @Published var one2: Bool = UserDefaults.standard.bool(forKey: "one2"){
        didSet{
            UserDefaults.standard.set(self.one2, forKey: "one2")
        }
    }
    
    @Published var one3: Bool = UserDefaults.standard.bool(forKey: "one3"){
        didSet{
            UserDefaults.standard.set(self.one3, forKey: "one3")
        }
    }
    
    @Published var one4: Bool = UserDefaults.standard.bool(forKey: "one4"){
        didSet{
            UserDefaults.standard.set(self.one4, forKey: "one4")
        }
    }
    
    @Published var one5: Bool = UserDefaults.standard.bool(forKey: "one5"){
        didSet{
            UserDefaults.standard.set(self.one5, forKey: "one5")
        }
    }
    
    @Published var one6: Bool = UserDefaults.standard.bool(forKey: "one6"){
        didSet{
            UserDefaults.standard.set(self.one6, forKey: "one6")
        }
    }
    
    @Published var one7: Bool = UserDefaults.standard.bool(forKey: "one7"){
        didSet{
            UserDefaults.standard.set(self.one7, forKey: "one7")
        }
    }
    
    @Published var one8: Bool = UserDefaults.standard.bool(forKey: "one8"){
        didSet{
            UserDefaults.standard.set(self.one8, forKey: "one8")
        }
    }
    
    @Published var one9: Bool = UserDefaults.standard.bool(forKey: "one9"){
        didSet{
            UserDefaults.standard.set(self.one9, forKey: "one9")
        }
    }
    
    @Published var one10: Bool = UserDefaults.standard.bool(forKey: "one10"){
        didSet{
            UserDefaults.standard.set(self.one10, forKey: "one10")
        }
    }
    
    @Published var one11: Bool = UserDefaults.standard.bool(forKey: "one11"){
        didSet{
            UserDefaults.standard.set(self.one11, forKey: "one11")
        }
    }
    
    @Published var one12: Bool = UserDefaults.standard.bool(forKey: "one12"){
        didSet{
            UserDefaults.standard.set(self.one12, forKey: "one12")
        }
    }
    
    @Published var one13: Bool = UserDefaults.standard.bool(forKey: "one13"){
        didSet{
            UserDefaults.standard.set(self.one13, forKey: "one13")
        }
    }
    
    @Published var one14: Bool = UserDefaults.standard.bool(forKey: "one14"){
        didSet{
            UserDefaults.standard.set(self.one14, forKey: "one14")
        }
    }
    
    @Published var one15: Bool = UserDefaults.standard.bool(forKey: "one15"){
        didSet{
            UserDefaults.standard.set(self.one15, forKey: "one15")
        }
    }
    
    @Published var one16: Bool = UserDefaults.standard.bool(forKey: "one16"){
        didSet{
            UserDefaults.standard.set(self.one16, forKey: "one16")
        }
    }
    
    @Published var one17: Bool = UserDefaults.standard.bool(forKey: "one17"){
        didSet{
            UserDefaults.standard.set(self.one17, forKey: "one17")
        }
    }
    
    @Published var one18: Bool = UserDefaults.standard.bool(forKey: "one18"){
        didSet{
            UserDefaults.standard.set(self.one18, forKey: "one18")
        }
    }
    
    @Published var one19: Bool = UserDefaults.standard.bool(forKey: "one19"){
        didSet{
            UserDefaults.standard.set(self.one19, forKey: "one19")
        }
    }
    
    @Published var one20: Bool = UserDefaults.standard.bool(forKey: "one20"){
        didSet{
            UserDefaults.standard.set(self.one20, forKey: "one20")
        }
    }
    
    @Published var one21: Bool = UserDefaults.standard.bool(forKey: "one21"){
        didSet{
            UserDefaults.standard.set(self.one21, forKey: "one21")
        }
    }
    
    @Published var one22: Bool = UserDefaults.standard.bool(forKey: "one22"){
        didSet{
            UserDefaults.standard.set(self.one22, forKey: "one22")
        }
    }
    
    @Published var one23: Bool = UserDefaults.standard.bool(forKey: "one23"){
        didSet{
            UserDefaults.standard.set(self.one23, forKey: "one23")
        }
    }
    
    @Published var one24: Bool = UserDefaults.standard.bool(forKey: "one24"){
        didSet{
            UserDefaults.standard.set(self.one24, forKey: "one24")
        }
    }
    
    @Published var one25: Bool = UserDefaults.standard.bool(forKey: "one25"){
        didSet{
            UserDefaults.standard.set(self.one25, forKey: "one25")
        }
    }
    
    @Published var one26: Bool = UserDefaults.standard.bool(forKey: "one26"){
        didSet{
            UserDefaults.standard.set(self.one26, forKey: "one26")
        }
    }
    
    @Published var one27: Bool = UserDefaults.standard.bool(forKey: "one27"){
        didSet{
            UserDefaults.standard.set(self.one27, forKey: "one27")
        }
    }
    
    @Published var one28: Bool = UserDefaults.standard.bool(forKey: "one28"){
        didSet{
            UserDefaults.standard.set(self.one28, forKey: "one28")
        }
    }
    
    @Published var one29: Bool = UserDefaults.standard.bool(forKey: "one29"){
        didSet{
            UserDefaults.standard.set(self.one29, forKey: "one29")
        }
    }
    
    @Published var one30: Bool = UserDefaults.standard.bool(forKey: "one30"){
        didSet{
            UserDefaults.standard.set(self.one30, forKey: "one30")
        }
    }
    
    @Published var one31: Bool = UserDefaults.standard.bool(forKey: "one31"){
        didSet{
            UserDefaults.standard.set(self.one31, forKey: "one31")
        }
    }
    
    @Published var one32: Bool = UserDefaults.standard.bool(forKey: "one32"){
        didSet{
            UserDefaults.standard.set(self.one32, forKey: "one32")
        }
    }
    
    @Published var one33: Bool = UserDefaults.standard.bool(forKey: "one33"){
        didSet{
            UserDefaults.standard.set(self.one33, forKey: "one33")
        }
    }
    
    @Published var one34: Bool = UserDefaults.standard.bool(forKey: "one34"){
        didSet{
            UserDefaults.standard.set(self.one34, forKey: "one34")
        }
    }
    
    @Published var one35: Bool = UserDefaults.standard.bool(forKey: "one35"){
        didSet{
            UserDefaults.standard.set(self.one35, forKey: "one35")
        }
    }
    
    @Published var one36: Bool = UserDefaults.standard.bool(forKey: "one36"){
        didSet{
            UserDefaults.standard.set(self.one36, forKey: "one36")
        }
    }
    
    @Published var one37: Bool = UserDefaults.standard.bool(forKey: "one37"){
        didSet{
            UserDefaults.standard.set(self.one37, forKey: "one37")
        }
    }
    
    @Published var one38: Bool = UserDefaults.standard.bool(forKey: "one38"){
        didSet{
            UserDefaults.standard.set(self.one38, forKey: "one38")
        }
    }
    
    @Published var onf1: Bool = UserDefaults.standard.bool(forKey: "onf1"){
        didSet{
            UserDefaults.standard.set(self.onf1, forKey: "onf1")
        }
    }
    
    @Published var onf2: Bool = UserDefaults.standard.bool(forKey: "onf2"){
        didSet{
            UserDefaults.standard.set(self.onf2, forKey: "onf2")
        }
    }
    
    @Published var onf3: Bool = UserDefaults.standard.bool(forKey: "onf3"){
        didSet{
            UserDefaults.standard.set(self.onf3, forKey: "onf3")
        }
    }
    
    @Published var onf4: Bool = UserDefaults.standard.bool(forKey: "onf4"){
        didSet{
            UserDefaults.standard.set(self.onf4, forKey: "onf4")
        }
    }
    
    @Published var onf5: Bool = UserDefaults.standard.bool(forKey: "onf5"){
        didSet{
            UserDefaults.standard.set(self.onf5, forKey: "onf5")
        }
    }
    
    @Published var onf6: Bool = UserDefaults.standard.bool(forKey: "onf6"){
        didSet{
            UserDefaults.standard.set(self.onf6, forKey: "onf6")
        }
    }
    
    @Published var onf7: Bool = UserDefaults.standard.bool(forKey: "onf7"){
        didSet{
            UserDefaults.standard.set(self.onf7, forKey: "onf7")
        }
    }
    
    @Published var onf8: Bool = UserDefaults.standard.bool(forKey: "onf8"){
        didSet{
            UserDefaults.standard.set(self.onf8, forKey: "onf8")
        }
    }
    
    @Published var onf9: Bool = UserDefaults.standard.bool(forKey: "onf9"){
        didSet{
            UserDefaults.standard.set(self.onf9, forKey: "onf9")
        }
    }
    
    @Published var onf10: Bool = UserDefaults.standard.bool(forKey: "onf10"){
        didSet{
            UserDefaults.standard.set(self.onf10, forKey: "onf10")
        }
    }
    
    @Published var onf11: Bool = UserDefaults.standard.bool(forKey: "onf11"){
        didSet{
            UserDefaults.standard.set(self.onf11, forKey: "onf11")
        }
    }
    
    @Published var onf12: Bool = UserDefaults.standard.bool(forKey: "onf12"){
        didSet{
            UserDefaults.standard.set(self.onf12, forKey: "onf12")
        }
    }
    
    @Published var onf13: Bool = UserDefaults.standard.bool(forKey: "onf13"){
        didSet{
            UserDefaults.standard.set(self.onf13, forKey: "onf13")
        }
    }
    
    @Published var onf14: Bool = UserDefaults.standard.bool(forKey: "onf14"){
        didSet{
            UserDefaults.standard.set(self.onf14, forKey: "onf14")
        }
    }
    
    @Published var onf15: Bool = UserDefaults.standard.bool(forKey: "onf15"){
        didSet{
            UserDefaults.standard.set(self.onf15, forKey: "onf15")
        }
    }
    
    @Published var onf16: Bool = UserDefaults.standard.bool(forKey: "onf16"){
        didSet{
            UserDefaults.standard.set(self.onf16, forKey: "onf16")
        }
    }
    
    @Published var onf17: Bool = UserDefaults.standard.bool(forKey: "onf17"){
        didSet{
            UserDefaults.standard.set(self.onf17, forKey: "onf17")
        }
    }
    
    @Published var onf18: Bool = UserDefaults.standard.bool(forKey: "onf18"){
        didSet{
            UserDefaults.standard.set(self.onf18, forKey: "onf18")
        }
    }
    
    @Published var onf19: Bool = UserDefaults.standard.bool(forKey: "onf19"){
        didSet{
            UserDefaults.standard.set(self.onf19, forKey: "onf19")
        }
    }
    
    @Published var onf20: Bool = UserDefaults.standard.bool(forKey: "onf20"){
        didSet{
            UserDefaults.standard.set(self.onf20, forKey: "onf20")
        }
    }
    
    @Published var onf21: Bool = UserDefaults.standard.bool(forKey: "onf21"){
        didSet{
            UserDefaults.standard.set(self.onf21, forKey: "onf21")
        }
    }
    
    @Published var onf22: Bool = UserDefaults.standard.bool(forKey: "onf22"){
        didSet{
            UserDefaults.standard.set(self.onf22, forKey: "onf22")
        }
    }
    
    @Published var onf23: Bool = UserDefaults.standard.bool(forKey: "onf23"){
        didSet{
            UserDefaults.standard.set(self.onf23, forKey: "onf23")
        }
    }
    
    @Published var onf24: Bool = UserDefaults.standard.bool(forKey: "onf24"){
        didSet{
            UserDefaults.standard.set(self.onf24, forKey: "onf24")
        }
    }
    
    @Published var onf25: Bool = UserDefaults.standard.bool(forKey: "onf25"){
        didSet{
            UserDefaults.standard.set(self.onf25, forKey: "onf25")
        }
    }
    
    @Published var onf26: Bool = UserDefaults.standard.bool(forKey: "onf26"){
        didSet{
            UserDefaults.standard.set(self.onf26, forKey: "onf26")
        }
    }
    
    @Published var onf27: Bool = UserDefaults.standard.bool(forKey: "onf27"){
        didSet{
            UserDefaults.standard.set(self.onf27, forKey: "onf27")
        }
    }
    
    @Published var onf28: Bool = UserDefaults.standard.bool(forKey: "onf28"){
        didSet{
            UserDefaults.standard.set(self.onf28, forKey: "onf28")
        }
    }
    
    @Published var onf29: Bool = UserDefaults.standard.bool(forKey: "onf29"){
        didSet{
            UserDefaults.standard.set(self.onf29, forKey: "onf29")
        }
    }
    
    @Published var onf30: Bool = UserDefaults.standard.bool(forKey: "onf30"){
        didSet{
            UserDefaults.standard.set(self.onf30, forKey: "onf30")
        }
    }
    
    @Published var onf31: Bool = UserDefaults.standard.bool(forKey: "onf31"){
        didSet{
            UserDefaults.standard.set(self.onf31, forKey: "onf31")
        }
    }
    
    @Published var onf32: Bool = UserDefaults.standard.bool(forKey: "onf32"){
        didSet{
            UserDefaults.standard.set(self.onf32, forKey: "onf32")
        }
    }
    
    @Published var onf33: Bool = UserDefaults.standard.bool(forKey: "onf33"){
        didSet{
            UserDefaults.standard.set(self.onf33, forKey: "onf33")
        }
    }
    
    @Published var onf34: Bool = UserDefaults.standard.bool(forKey: "onf34"){
        didSet{
            UserDefaults.standard.set(self.onf34, forKey: "onf34")
        }
    }
    
    @Published var onf35: Bool = UserDefaults.standard.bool(forKey: "onf35"){
        didSet{
            UserDefaults.standard.set(self.onf35, forKey: "onf35")
        }
    }
    
    @Published var onf36: Bool = UserDefaults.standard.bool(forKey: "onf36"){
        didSet{
            UserDefaults.standard.set(self.onf36, forKey: "onf36")
        }
    }
    
    @Published var onf37: Bool = UserDefaults.standard.bool(forKey: "onf37"){
        didSet{
            UserDefaults.standard.set(self.onf37, forKey: "onf37")
        }
    }
    
    @Published var onf38: Bool = UserDefaults.standard.bool(forKey: "onf38"){
        didSet{
            UserDefaults.standard.set(self.onf38, forKey: "onf38")
        }
    }
    
    @Published var onf39: Bool = UserDefaults.standard.bool(forKey: "onf39"){
        didSet{
            UserDefaults.standard.set(self.onf39, forKey: "onf39")
        }
    }
    
    @Published var onf40: Bool = UserDefaults.standard.bool(forKey: "onf40"){
        didSet{
            UserDefaults.standard.set(self.onf40, forKey: "onf40")
        }
    }
    
    @Published var onf41: Bool = UserDefaults.standard.bool(forKey: "onf41"){
        didSet{
            UserDefaults.standard.set(self.onf41, forKey: "onf41")
        }
    }
    
    @Published var onf42: Bool = UserDefaults.standard.bool(forKey: "onf42"){
        didSet{
            UserDefaults.standard.set(self.onf42, forKey: "onf42")
        }
    }
    
    @Published var onf43: Bool = UserDefaults.standard.bool(forKey: "onf43"){
        didSet{
            UserDefaults.standard.set(self.onf43, forKey: "onf43")
        }
    }
    
    @Published var onf44: Bool = UserDefaults.standard.bool(forKey: "onf44"){
        didSet{
            UserDefaults.standard.set(self.onf44, forKey: "onf44")
        }
    }
    
    @Published var onf45: Bool = UserDefaults.standard.bool(forKey: "onf45"){
        didSet{
            UserDefaults.standard.set(self.onf45, forKey: "onf45")
        }
    }
    
    @Published var onf46: Bool = UserDefaults.standard.bool(forKey: "onf46"){
        didSet{
            UserDefaults.standard.set(self.onf46, forKey: "onf46")
        }
    }
    
    @Published var onf47: Bool = UserDefaults.standard.bool(forKey: "onf47"){
        didSet{
            UserDefaults.standard.set(self.onf47, forKey: "onf47")
        }
    }
    
    @Published var onf48: Bool = UserDefaults.standard.bool(forKey: "onf48"){
        didSet{
            UserDefaults.standard.set(self.onf48, forKey: "onf48")
        }
    }
    
    @Published var onf49: Bool = UserDefaults.standard.bool(forKey: "onf49"){
        didSet{
            UserDefaults.standard.set(self.onf49, forKey: "onf49")
        }
    }
    
    @Published var onf50: Bool = UserDefaults.standard.bool(forKey: "onf50"){
        didSet{
            UserDefaults.standard.set(self.onf50, forKey: "onf50")
        }
    }
    
    @Published var ong1: Bool = UserDefaults.standard.bool(forKey: "ong1"){
        didSet{
            UserDefaults.standard.set(self.ong1, forKey: "ong1")
        }
    }
    
    @Published var ong2: Bool = UserDefaults.standard.bool(forKey: "ong2"){
        didSet{
            UserDefaults.standard.set(self.ong2, forKey: "ong2")
        }
    }
    
    @Published var ong3: Bool = UserDefaults.standard.bool(forKey: "ong3"){
        didSet{
            UserDefaults.standard.set(self.ong3, forKey: "ong3")
        }
    }
    
    @Published var ong4: Bool = UserDefaults.standard.bool(forKey: "ong4"){
        didSet{
            UserDefaults.standard.set(self.ong4, forKey: "ong4")
        }
    }
    
    @Published var ong5: Bool = UserDefaults.standard.bool(forKey: "ong5"){
        didSet{
            UserDefaults.standard.set(self.ong5, forKey: "ong5")
        }
    }
    
    @Published var ong6: Bool = UserDefaults.standard.bool(forKey: "ong6"){
        didSet{
            UserDefaults.standard.set(self.ong6, forKey: "ong6")
        }
    }
    
    @Published var ong7: Bool = UserDefaults.standard.bool(forKey: "ong7"){
        didSet{
            UserDefaults.standard.set(self.ong7, forKey: "ong7")
        }
    }
    
    @Published var ong8: Bool = UserDefaults.standard.bool(forKey: "ong8"){
        didSet{
            UserDefaults.standard.set(self.ong8, forKey: "ong8")
        }
    }
    
    @Published var ong9: Bool = UserDefaults.standard.bool(forKey: "ong9"){
        didSet{
            UserDefaults.standard.set(self.ong9, forKey: "ong9")
        }
    }
    
    @Published var ong10: Bool = UserDefaults.standard.bool(forKey: "ong10"){
        didSet{
            UserDefaults.standard.set(self.ong10, forKey: "ong10")
        }
    }
    
    @Published var ong11: Bool = UserDefaults.standard.bool(forKey: "ong11"){
        didSet{
            UserDefaults.standard.set(self.ong11, forKey: "ong11")
        }
    }
    
    @Published var ong12: Bool = UserDefaults.standard.bool(forKey: "ong12"){
        didSet{
            UserDefaults.standard.set(self.ong12, forKey: "ong12")
        }
    }
    
    @Published var ong13: Bool = UserDefaults.standard.bool(forKey: "ong13"){
        didSet{
            UserDefaults.standard.set(self.ong13, forKey: "ong13")
        }
    }
    
    @Published var ong14: Bool = UserDefaults.standard.bool(forKey: "ong14"){
        didSet{
            UserDefaults.standard.set(self.ong14, forKey: "ong14")
        }
    }
    
    @Published var ong15: Bool = UserDefaults.standard.bool(forKey: "ong15"){
        didSet{
            UserDefaults.standard.set(self.ong15, forKey: "ong15")
        }
    }
    
    @Published var ong16: Bool = UserDefaults.standard.bool(forKey: "ong16"){
        didSet{
            UserDefaults.standard.set(self.ong16, forKey: "ong16")
        }
    }
    
    @Published var ong17: Bool = UserDefaults.standard.bool(forKey: "ong17"){
        didSet{
            UserDefaults.standard.set(self.ong17, forKey: "ong17")
        }
    }
    
    @Published var ong18: Bool = UserDefaults.standard.bool(forKey: "ong18"){
        didSet{
            UserDefaults.standard.set(self.ong18, forKey: "ong18")
        }
    }
    
    @Published var ong19: Bool = UserDefaults.standard.bool(forKey: "ong19"){
        didSet{
            UserDefaults.standard.set(self.ong19, forKey: "ong19")
        }
    }
    
    @Published var ong20: Bool = UserDefaults.standard.bool(forKey: "ong20"){
        didSet{
            UserDefaults.standard.set(self.ong20, forKey: "ong20")
        }
    }
    
    @Published var ong21: Bool = UserDefaults.standard.bool(forKey: "ong21"){
        didSet{
            UserDefaults.standard.set(self.ong21, forKey: "ong21")
        }
    }
    
    @Published var ong22: Bool = UserDefaults.standard.bool(forKey: "ong22"){
        didSet{
            UserDefaults.standard.set(self.ong22, forKey: "ong22")
        }
    }
    
    @Published var ong23: Bool = UserDefaults.standard.bool(forKey: "ong23"){
        didSet{
            UserDefaults.standard.set(self.ong23, forKey: "ong23")
        }
    }
    
    @Published var ong24: Bool = UserDefaults.standard.bool(forKey: "ong24"){
        didSet{
            UserDefaults.standard.set(self.ong24, forKey: "ong24")
        }
    }
    
    @Published var ong25: Bool = UserDefaults.standard.bool(forKey: "ong25"){
        didSet{
            UserDefaults.standard.set(self.ong25, forKey: "ong25")
        }
    }
    
    @Published var ong26: Bool = UserDefaults.standard.bool(forKey: "ong26"){
        didSet{
            UserDefaults.standard.set(self.ong26, forKey: "ong26")
        }
    }
    
    @Published var ong27: Bool = UserDefaults.standard.bool(forKey: "ong27"){
        didSet{
            UserDefaults.standard.set(self.ong27, forKey: "ong27")
        }
    }
    
    @Published var ong28: Bool = UserDefaults.standard.bool(forKey: "ong28"){
        didSet{
            UserDefaults.standard.set(self.ong28, forKey: "ong28")
        }
    }
    
    @Published var ong29: Bool = UserDefaults.standard.bool(forKey: "ong29"){
        didSet{
            UserDefaults.standard.set(self.ong29, forKey: "ong29")
        }
    }
    
    @Published var ong30: Bool = UserDefaults.standard.bool(forKey: "ong30"){
        didSet{
            UserDefaults.standard.set(self.ong30, forKey: "ong30")
        }
    }
    
    @Published var ong31: Bool = UserDefaults.standard.bool(forKey: "ong31"){
        didSet{
            UserDefaults.standard.set(self.ong31, forKey: "ong31")
        }
    }
    
    @Published var ong32: Bool = UserDefaults.standard.bool(forKey: "ong32"){
        didSet{
            UserDefaults.standard.set(self.one32, forKey: "ong32")
        }
    }
    
    @Published var ong33: Bool = UserDefaults.standard.bool(forKey: "ong33"){
        didSet{
            UserDefaults.standard.set(self.ong33, forKey: "ong33")
        }
    }
    
    @Published var ong34: Bool = UserDefaults.standard.bool(forKey: "ong34"){
        didSet{
            UserDefaults.standard.set(self.ong34, forKey: "ong34")
        }
    }
    
    @Published var ong35: Bool = UserDefaults.standard.bool(forKey: "ong35"){
        didSet{
            UserDefaults.standard.set(self.ong35, forKey: "ong35")
        }
    }
    
    @Published var ong36: Bool = UserDefaults.standard.bool(forKey: "ong36"){
        didSet{
            UserDefaults.standard.set(self.ong36, forKey: "ong36")
        }
    }
    
    @Published var ong37: Bool = UserDefaults.standard.bool(forKey: "ong37"){
        didSet{
            UserDefaults.standard.set(self.ong37, forKey: "ong37")
        }
    }
    
    @Published var onh1: Bool = UserDefaults.standard.bool(forKey: "onh1"){
        didSet{
            UserDefaults.standard.set(self.onh1, forKey: "onh1")
        }
    }
    
    @Published var onh2: Bool = UserDefaults.standard.bool(forKey: "onh2"){
        didSet{
            UserDefaults.standard.set(self.onh2, forKey: "onh2")
        }
    }
    
    @Published var onh3: Bool = UserDefaults.standard.bool(forKey: "onh3"){
        didSet{
            UserDefaults.standard.set(self.onh3, forKey: "onh3")
        }
    }
    
    @Published var onh4: Bool = UserDefaults.standard.bool(forKey: "onh4"){
        didSet{
            UserDefaults.standard.set(self.onh4, forKey: "onh4")
        }
    }
    
    @Published var onh5: Bool = UserDefaults.standard.bool(forKey: "onh5"){
        didSet{
            UserDefaults.standard.set(self.onh5, forKey: "onh5")
        }
    }
    
    @Published var onh6: Bool = UserDefaults.standard.bool(forKey: "onh6"){
        didSet{
            UserDefaults.standard.set(self.onh6, forKey: "onh6")
        }
    }
    
    @Published var onh7: Bool = UserDefaults.standard.bool(forKey: "onh7"){
        didSet{
            UserDefaults.standard.set(self.onh7, forKey: "onh7")
        }
    }
    
    @Published var onh8: Bool = UserDefaults.standard.bool(forKey: "onh8"){
        didSet{
            UserDefaults.standard.set(self.onh8, forKey: "onh8")
        }
    }
    
    @Published var onh9: Bool = UserDefaults.standard.bool(forKey: "onh9"){
        didSet{
            UserDefaults.standard.set(self.onh9, forKey: "onh9")
        }
    }
    
    @Published var onh10: Bool = UserDefaults.standard.bool(forKey: "onh10"){
        didSet{
            UserDefaults.standard.set(self.onh10, forKey: "onh10")
        }
    }
    
    @Published var onh11: Bool = UserDefaults.standard.bool(forKey: "onh11"){
        didSet{
            UserDefaults.standard.set(self.onh11, forKey: "onh11")
        }
    }
    
    @Published var onh12: Bool = UserDefaults.standard.bool(forKey: "onh12"){
        didSet{
            UserDefaults.standard.set(self.onh12, forKey: "onh12")
        }
    }
    
    @Published var onh13: Bool = UserDefaults.standard.bool(forKey: "onh13"){
        didSet{
            UserDefaults.standard.set(self.onh13, forKey: "onh13")
        }
    }
    
    @Published var onh14: Bool = UserDefaults.standard.bool(forKey: "onh14"){
        didSet{
            UserDefaults.standard.set(self.onh14, forKey: "onh14")
        }
    }
    
    @Published var onh15: Bool = UserDefaults.standard.bool(forKey: "onh15"){
        didSet{
            UserDefaults.standard.set(self.onh15, forKey: "onh15")
        }
    }
    
    @Published var onh16: Bool = UserDefaults.standard.bool(forKey: "onh16"){
        didSet{
            UserDefaults.standard.set(self.onh16, forKey: "onh16")
        }
    }
    
    @Published var onh17: Bool = UserDefaults.standard.bool(forKey: "onh17"){
        didSet{
            UserDefaults.standard.set(self.onh17, forKey: "onh17")
        }
    }
    
    @Published var onh18: Bool = UserDefaults.standard.bool(forKey: "onh18"){
        didSet{
            UserDefaults.standard.set(self.onh18, forKey: "onh18")
        }
    }
    
    @Published var onh19: Bool = UserDefaults.standard.bool(forKey: "onh19"){
        didSet{
            UserDefaults.standard.set(self.onh19, forKey: "onh19")
        }
    }
    
    @Published var onh20: Bool = UserDefaults.standard.bool(forKey: "onh20"){
        didSet{
            UserDefaults.standard.set(self.onh20, forKey: "onh20")
        }
    }
    
    @Published var onh21: Bool = UserDefaults.standard.bool(forKey: "onh21"){
        didSet{
            UserDefaults.standard.set(self.onh21, forKey: "onh21")
        }
    }
    
    @Published var onh22: Bool = UserDefaults.standard.bool(forKey: "onh22"){
        didSet{
            UserDefaults.standard.set(self.onh22, forKey: "onh22")
        }
    }
    
    @Published var onh23: Bool = UserDefaults.standard.bool(forKey: "onh23"){
        didSet{
            UserDefaults.standard.set(self.onh23, forKey: "onh23")
        }
    }
    
    @Published var onh24: Bool = UserDefaults.standard.bool(forKey: "onh24"){
        didSet{
            UserDefaults.standard.set(self.onh24, forKey: "onh24")
        }
    }
    
    @Published var onh25: Bool = UserDefaults.standard.bool(forKey: "onh25"){
        didSet{
            UserDefaults.standard.set(self.onh25, forKey: "onh25")
        }
    }
    
    @Published var onh26: Bool = UserDefaults.standard.bool(forKey: "onh26"){
        didSet{
            UserDefaults.standard.set(self.onh26, forKey: "onh26")
        }
    }
    
    @Published var onh27: Bool = UserDefaults.standard.bool(forKey: "onh27"){
        didSet{
            UserDefaults.standard.set(self.onh27, forKey: "onh27")
        }
    }
    
    @Published var onh28: Bool = UserDefaults.standard.bool(forKey: "onh28"){
        didSet{
            UserDefaults.standard.set(self.onh28, forKey: "onh28")
        }
    }
    
    @Published var onh29: Bool = UserDefaults.standard.bool(forKey: "onh29"){
        didSet{
            UserDefaults.standard.set(self.onh29, forKey: "onh29")
        }
    }
    
    @Published var onh30: Bool = UserDefaults.standard.bool(forKey: "onh30"){
        didSet{
            UserDefaults.standard.set(self.onh30, forKey: "onh30")
        }
    }
    
    @Published var onh31: Bool = UserDefaults.standard.bool(forKey: "onh31"){
        didSet{
            UserDefaults.standard.set(self.onh31, forKey: "onh31")
        }
    }
    
    @Published var onh32: Bool = UserDefaults.standard.bool(forKey: "onh32"){
        didSet{
            UserDefaults.standard.set(self.onh32, forKey: "onh32")
        }
    }
    
    @Published var onh33: Bool = UserDefaults.standard.bool(forKey: "onh33"){
        didSet{
            UserDefaults.standard.set(self.onh33, forKey: "onh33")
        }
    }
    
    @Published var onh34: Bool = UserDefaults.standard.bool(forKey: "onh34"){
        didSet{
            UserDefaults.standard.set(self.onh34, forKey: "onh34")
        }
    }
    
    @Published var onh35: Bool = UserDefaults.standard.bool(forKey: "onh35"){
        didSet{
            UserDefaults.standard.set(self.onh35, forKey: "onh35")
        }
    }
    
    @Published var onh36: Bool = UserDefaults.standard.bool(forKey: "onh36"){
        didSet{
            UserDefaults.standard.set(self.onh36, forKey: "onh36")
        }
    }
    
    @Published var oni1: Bool = UserDefaults.standard.bool(forKey: "oni1"){
        didSet{
            UserDefaults.standard.set(self.oni1, forKey: "oni1")
        }
    }
    
    @Published var oni2: Bool = UserDefaults.standard.bool(forKey: "oni2"){
        didSet{
            UserDefaults.standard.set(self.oni2, forKey: "oni2")
        }
    }
    
    @Published var oni3: Bool = UserDefaults.standard.bool(forKey: "oni3"){
        didSet{
            UserDefaults.standard.set(self.oni3, forKey: "oni3")
        }
    }
    
    @Published var oni4: Bool = UserDefaults.standard.bool(forKey: "oni4"){
        didSet{
            UserDefaults.standard.set(self.oni4, forKey: "oni4")
        }
    }
    
    @Published var oni5: Bool = UserDefaults.standard.bool(forKey: "oni5"){
        didSet{
            UserDefaults.standard.set(self.oni5, forKey: "oni5")
        }
    }
    
    @Published var oni6: Bool = UserDefaults.standard.bool(forKey: "oni6"){
        didSet{
            UserDefaults.standard.set(self.oni6, forKey: "oni6")
        }
    }
    
    @Published var oni7: Bool = UserDefaults.standard.bool(forKey: "oni7"){
        didSet{
            UserDefaults.standard.set(self.oni7, forKey: "oni7")
        }
    }
    
    @Published var oni8: Bool = UserDefaults.standard.bool(forKey: "oni8"){
        didSet{
            UserDefaults.standard.set(self.oni8, forKey: "oni8")
        }
    }
    
    @Published var oni9: Bool = UserDefaults.standard.bool(forKey: "oni9"){
        didSet{
            UserDefaults.standard.set(self.oni9, forKey: "oni9")
        }
    }
    
    @Published var oni10: Bool = UserDefaults.standard.bool(forKey: "oni10"){
        didSet{
            UserDefaults.standard.set(self.oni10, forKey: "oni10")
        }
    }
    
    @Published var oni11: Bool = UserDefaults.standard.bool(forKey: "oni11"){
        didSet{
            UserDefaults.standard.set(self.oni11, forKey: "oni11")
        }
    }
    
    @Published var oni12: Bool = UserDefaults.standard.bool(forKey: "oni12"){
        didSet{
            UserDefaults.standard.set(self.oni12, forKey: "oni12")
        }
    }
    
    @Published var oni13: Bool = UserDefaults.standard.bool(forKey: "oni13"){
        didSet{
            UserDefaults.standard.set(self.oni13, forKey: "oni13")
        }
    }
    
    @Published var oni14: Bool = UserDefaults.standard.bool(forKey: "oni14"){
        didSet{
            UserDefaults.standard.set(self.oni14, forKey: "oni14")
        }
    }
    
    @Published var oni15: Bool = UserDefaults.standard.bool(forKey: "oni15"){
        didSet{
            UserDefaults.standard.set(self.oni15, forKey: "oni15")
        }
    }
    
    @Published var oni16: Bool = UserDefaults.standard.bool(forKey: "oni16"){
        didSet{
            UserDefaults.standard.set(self.oni16, forKey: "oni16")
        }
    }
    
    @Published var oni17: Bool = UserDefaults.standard.bool(forKey: "oni17"){
        didSet{
            UserDefaults.standard.set(self.oni17, forKey: "oni17")
        }
    }
    
    @Published var oni18: Bool = UserDefaults.standard.bool(forKey: "oni18"){
        didSet{
            UserDefaults.standard.set(self.oni18, forKey: "oni18")
        }
    }
    
    @Published var oni19: Bool = UserDefaults.standard.bool(forKey: "oni19"){
        didSet{
            UserDefaults.standard.set(self.oni19, forKey: "oni19")
        }
    }
    
    @Published var oni20: Bool = UserDefaults.standard.bool(forKey: "oni20"){
        didSet{
            UserDefaults.standard.set(self.oni20, forKey: "oni20")
        }
    }
    
    @Published var oni21: Bool = UserDefaults.standard.bool(forKey: "oni21"){
        didSet{
            UserDefaults.standard.set(self.oni21, forKey: "oni21")
        }
    }
    
    @Published var oni22: Bool = UserDefaults.standard.bool(forKey: "oni22"){
        didSet{
            UserDefaults.standard.set(self.oni22, forKey: "oni22")
        }
    }
    
    @Published var oni23: Bool = UserDefaults.standard.bool(forKey: "oni23"){
        didSet{
            UserDefaults.standard.set(self.oni23, forKey: "oni23")
        }
    }
    
    @Published var oni24: Bool = UserDefaults.standard.bool(forKey: "oni24"){
        didSet{
            UserDefaults.standard.set(self.oni24, forKey: "oni24")
        }
    }
    
    @Published var oni25: Bool = UserDefaults.standard.bool(forKey: "oni25"){
        didSet{
            UserDefaults.standard.set(self.oni25, forKey: "oni25")
        }
    }
    
    @Published var oni26: Bool = UserDefaults.standard.bool(forKey: "oni26"){
        didSet{
            UserDefaults.standard.set(self.oni26, forKey: "oni26")
        }
    }
    
    @Published var oni27: Bool = UserDefaults.standard.bool(forKey: "oni27"){
        didSet{
            UserDefaults.standard.set(self.oni27, forKey: "oni27")
        }
    }
    
    @Published var oni28: Bool = UserDefaults.standard.bool(forKey: "oni28"){
        didSet{
            UserDefaults.standard.set(self.oni28, forKey: "oni28")
        }
    }
    
    @Published var oni29: Bool = UserDefaults.standard.bool(forKey: "oni29"){
        didSet{
            UserDefaults.standard.set(self.oni29, forKey: "oni29")
        }
    }
    
    @Published var oni30: Bool = UserDefaults.standard.bool(forKey: "oni30"){
        didSet{
            UserDefaults.standard.set(self.oni30, forKey: "oni30")
        }
    }
    
    @Published var oni31: Bool = UserDefaults.standard.bool(forKey: "oni31"){
        didSet{
            UserDefaults.standard.set(self.oni31, forKey: "oni31")
        }
    }
    
    @Published var oni32: Bool = UserDefaults.standard.bool(forKey: "oni32"){
        didSet{
            UserDefaults.standard.set(self.oni32, forKey: "oni32")
        }
    }
    
    @Published var oni33: Bool = UserDefaults.standard.bool(forKey: "oni33"){
        didSet{
            UserDefaults.standard.set(self.oni33, forKey: "oni33")
        }
    }
    
    @Published var oni34: Bool = UserDefaults.standard.bool(forKey: "oni34"){
        didSet{
            UserDefaults.standard.set(self.oni34, forKey: "oni34")
        }
    }
    
    
    
    
    
    
    
    
    
    

    
    @Published var tva1: Double = UserDefaults.standard.double(forKey: "tva1"){
            didSet{
               UserDefaults.standard.set(self.tva1, forKey: "tva1")
            }
       }
        
        @Published var tvb1: Double = UserDefaults.standard.double(forKey: "tvb1"){
            didSet{
                UserDefaults.standard.set(self.tvb1, forKey: "tvb1")
            }
        }
        
        @Published var tvb2: Double = UserDefaults.standard.double(forKey: "tvb2"){
            didSet{
                UserDefaults.standard.set(self.tvb2, forKey: "tvb2")
            }
        }
        
        @Published var tvb3: Double = UserDefaults.standard.double(forKey: "tvb3"){
            didSet{
                UserDefaults.standard.set(self.tvb3, forKey: "tvb3")
            }
        }
        
        @Published var tvb4: Double = UserDefaults.standard.double(forKey: "tvb4"){
            didSet{
                UserDefaults.standard.set(self.tvb4, forKey: "tvb4")
            }
        }
        
        @Published var tvb5: Double = UserDefaults.standard.double(forKey: "tvb5"){
            didSet{
                UserDefaults.standard.set(self.tvb5, forKey: "tvb5")
            }
        }
        
        @Published var tvc1: Double = UserDefaults.standard.double(forKey: "tvc1"){
            didSet{
                UserDefaults.standard.set(self.tvb3, forKey: "tvc1")
            }
        }
        
        @Published var tvc2: Double = UserDefaults.standard.double(forKey: "tvc2"){
            didSet{
                UserDefaults.standard.set(self.tvc2, forKey: "tvc2")
            }
        }
        
        @Published var tvc3: Double = UserDefaults.standard.double(forKey: "tvc3"){
            didSet{
                UserDefaults.standard.set(self.tvc3, forKey: "tvc3")
            }
        }
        
        @Published var tvc4: Double = UserDefaults.standard.double(forKey: "tvc4"){
            didSet{
                UserDefaults.standard.set(self.tvc4, forKey: "tvc4")
            }
        }
        
        @Published var tvc5: Double = UserDefaults.standard.double(forKey: "tvc5"){
            didSet{
                UserDefaults.standard.set(self.tvc5, forKey: "tvc5")
            }
        }
        
        @Published var tvc6: Double = UserDefaults.standard.double(forKey: "tvc6"){
            didSet{
                UserDefaults.standard.set(self.tvc6, forKey: "tvc6")
            }
        }
        
        @Published var tvd1: Double = UserDefaults.standard.double(forKey: "tvd1"){
            didSet{
                UserDefaults.standard.set(self.tvd1, forKey: "tvd1")
            }
        }
        
        @Published var tvd2: Double = UserDefaults.standard.double(forKey: "tvd2"){
            didSet{
                UserDefaults.standard.set(self.tvd2, forKey: "tvd2")
            }
        }
        
        @Published var tvd3: Double = UserDefaults.standard.double(forKey: "tvd3"){
            didSet{
                UserDefaults.standard.set(self.tvd3, forKey: "tvd3")
            }
        }
        
        @Published var tvd4: Double = UserDefaults.standard.double(forKey: "tvd4"){
            didSet{
                UserDefaults.standard.set(self.tvd4, forKey: "tvd4")
            }
        }
        
        @Published var tvd5: Double = UserDefaults.standard.double(forKey: "tvd5"){
            didSet{
                UserDefaults.standard.set(self.tvd5, forKey: "tvd5")
            }
        }
        
        @Published var tvd6: Double = UserDefaults.standard.double(forKey: "tvd6"){
            didSet{
                UserDefaults.standard.set(self.tvd6, forKey: "tvd6")
            }
        }
        
        @Published var tvd7: Double = UserDefaults.standard.double(forKey: "tvd7"){
            didSet{
                UserDefaults.standard.set(self.tvd7, forKey: "tvd7")
            }
        }
        
        @Published var tvd8: Double = UserDefaults.standard.double(forKey: "tvd8"){
            didSet{
                UserDefaults.standard.set(self.tvd8, forKey: "tvd8")
            }
        }
        
        @Published var tvd9: Double = UserDefaults.standard.double(forKey: "tvd9"){
            didSet{
                UserDefaults.standard.set(self.tvd9, forKey: "tvd9")
            }
        }
        
        @Published var tvd10: Double = UserDefaults.standard.double(forKey: "tvd10"){
            didSet{
                UserDefaults.standard.set(self.tvd10, forKey: "tvd10")
            }
        }
        
        @Published var tvd11: Double = UserDefaults.standard.double(forKey: "tvd11"){
            didSet{
                UserDefaults.standard.set(self.tvd11, forKey: "tvd11")
            }
        }
        
        @Published var tvd12: Double = UserDefaults.standard.double(forKey: "tvd12"){
            didSet{
                UserDefaults.standard.set(self.tvd12, forKey: "tvd12")
            }
        }
        
        @Published var tvd13: Double = UserDefaults.standard.double(forKey: "tvd13"){
            didSet{
                UserDefaults.standard.set(self.tvd13, forKey: "tvd13")
            }
        }
        
        @Published var tvd14: Double = UserDefaults.standard.double(forKey: "tvd14"){
            didSet{
                UserDefaults.standard.set(self.tvd14, forKey: "tvd14")
            }
        }
        
        @Published var tvd15: Double = UserDefaults.standard.double(forKey: "tvd15"){
            didSet{
                UserDefaults.standard.set(self.tvd15, forKey: "tvd15")
            }
        }
        
        @Published var tvd16: Double = UserDefaults.standard.double(forKey: "tvd16"){
            didSet{
                UserDefaults.standard.set(self.tvd16, forKey: "tvd16")
            }
        }
        
        @Published var tvd17: Double = UserDefaults.standard.double(forKey: "tvd17"){
            didSet{
                UserDefaults.standard.set(self.tvd17, forKey: "tvd17")
            }
        }
        
        @Published var tvd18: Double = UserDefaults.standard.double(forKey: "tvd18"){
            didSet{
                UserDefaults.standard.set(self.tvd18, forKey: "tvd18")
            }
        }
        
        @Published var tvd19: Double = UserDefaults.standard.double(forKey: "tvd19"){
            didSet{
                UserDefaults.standard.set(self.tvd19, forKey: "tvd19")
            }
        }
        
        @Published var tvd20: Double = UserDefaults.standard.double(forKey: "tvd20"){
            didSet{
                UserDefaults.standard.set(self.tvd20, forKey: "tvd20")
            }
        }
        
        @Published var tvd21: Double = UserDefaults.standard.double(forKey: "tvd21"){
            didSet{
                UserDefaults.standard.set(self.tvd21, forKey: "tvd21")
            }
        }
        
        @Published var tvd22: Double = UserDefaults.standard.double(forKey: "tvd22"){
            didSet{
                UserDefaults.standard.set(self.tvd22, forKey: "tvd22")
            }
        }
        
        @Published var tvd23: Double = UserDefaults.standard.double(forKey: "tvd23"){
            didSet{
                UserDefaults.standard.set(self.tvd23, forKey: "tvd23")
            }
        }
        
        @Published var tvd24: Double = UserDefaults.standard.double(forKey: "tvd24"){
            didSet{
                UserDefaults.standard.set(self.tvd24, forKey: "tvd24")
            }
        }
        
        @Published var tvd25: Double = UserDefaults.standard.double(forKey: "tvd25"){
            didSet{
                UserDefaults.standard.set(self.tvd25, forKey: "tvd25")
            }
        }
        
        @Published var tvd26: Double = UserDefaults.standard.double(forKey: "tvd26"){
            didSet{
                UserDefaults.standard.set(self.tvd26, forKey: "tvd26")
            }
        }
        
        @Published var tvd27: Double = UserDefaults.standard.double(forKey: "tvd27"){
            didSet{
                UserDefaults.standard.set(self.tvd27, forKey: "tvd27")
            }
        }
        
        @Published var tvd28: Double = UserDefaults.standard.double(forKey: "tvd28"){
            didSet{
                UserDefaults.standard.set(self.tvd28, forKey: "tvd28")
            }
        }
        
        @Published var tvd29: Double = UserDefaults.standard.double(forKey: "tvd29"){
            didSet{
                UserDefaults.standard.set(self.tvd29, forKey: "tvd29")
            }
        }
        
        @Published var tvd30: Double = UserDefaults.standard.double(forKey: "tvd30"){
            didSet{
                UserDefaults.standard.set(self.tvd30, forKey: "tvd30")
            }
        }
        
        @Published var tvd31: Double = UserDefaults.standard.double(forKey: "tvd31"){
            didSet{
                UserDefaults.standard.set(self.tvd31, forKey: "tvd31")
            }
        }
        
        @Published var tvd32: Double = UserDefaults.standard.double(forKey: "tvd32"){
            didSet{
                UserDefaults.standard.set(self.tvd32, forKey: "tvd32")
            }
        }
        
        @Published var tvd33: Double = UserDefaults.standard.double(forKey: "tvd33"){
            didSet{
                UserDefaults.standard.set(self.tvd33, forKey: "tvd33")
            }
        }
        
        @Published var tve1: Double = UserDefaults.standard.double(forKey: "tve1"){
            didSet{
                UserDefaults.standard.set(self.tve1, forKey: "tve1")
            }
        }
        
        @Published var tve2: Double = UserDefaults.standard.double(forKey: "tve2"){
            didSet{
                UserDefaults.standard.set(self.tve2, forKey: "tve2")
            }
        }
        
        @Published var tve3: Double = UserDefaults.standard.double(forKey: "tve3"){
            didSet{
                UserDefaults.standard.set(self.tve3, forKey: "tve3")
            }
        }
        
        @Published var tve4: Double = UserDefaults.standard.double(forKey: "tve4"){
            didSet{
                UserDefaults.standard.set(self.tve4, forKey: "tve4")
            }
        }
        
        @Published var tve5: Double = UserDefaults.standard.double(forKey: "tve5"){
            didSet{
                UserDefaults.standard.set(self.tve5, forKey: "tve5")
            }
        }
        
        @Published var tve6: Double = UserDefaults.standard.double(forKey: "tve6"){
            didSet{
                UserDefaults.standard.set(self.tve6, forKey: "tve6")
            }
        }
        
        @Published var tve7: Double = UserDefaults.standard.double(forKey: "tve7"){
            didSet{
                UserDefaults.standard.set(self.tve7, forKey: "tve7")
            }
        }
        
        @Published var tve8: Double = UserDefaults.standard.double(forKey: "tve8"){
            didSet{
                UserDefaults.standard.set(self.tve8, forKey: "tve8")
            }
        }
        
        @Published var tve9: Double = UserDefaults.standard.double(forKey: "tve9"){
            didSet{
                UserDefaults.standard.set(self.tve9, forKey: "tve9")
            }
        }
        
        @Published var tve10: Double = UserDefaults.standard.double(forKey: "tve10"){
            didSet{
                UserDefaults.standard.set(self.tve10, forKey: "tve10")
            }
        }
        
        @Published var tve11: Double = UserDefaults.standard.double(forKey: "tve11"){
            didSet{
                UserDefaults.standard.set(self.tve11, forKey: "tve11")
            }
        }
        
        @Published var tve12: Double = UserDefaults.standard.double(forKey: "tve12"){
            didSet{
                UserDefaults.standard.set(self.tve12, forKey: "tve12")
            }
        }
        
        @Published var tve13: Double = UserDefaults.standard.double(forKey: "tve13"){
            didSet{
                UserDefaults.standard.set(self.tve13, forKey: "tve13")
            }
        }
        
        @Published var tve14: Double = UserDefaults.standard.double(forKey: "tve14"){
            didSet{
                UserDefaults.standard.set(self.tve14, forKey: "tve14")
            }
        }
        
        @Published var tve15: Double = UserDefaults.standard.double(forKey: "tve15"){
            didSet{
                UserDefaults.standard.set(self.tve15, forKey: "tve15")
            }
        }
        
        @Published var tve16: Double = UserDefaults.standard.double(forKey: "tve16"){
            didSet{
                UserDefaults.standard.set(self.tve16, forKey: "tve16")
            }
        }
        
        @Published var tve17: Double = UserDefaults.standard.double(forKey: "tve17"){
            didSet{
                UserDefaults.standard.set(self.tve17, forKey: "tve17")
            }
        }
        
        @Published var tve18: Double = UserDefaults.standard.double(forKey: "tve18"){
            didSet{
                UserDefaults.standard.set(self.tve18, forKey: "tve18")
            }
        }
        
        @Published var tve19: Double = UserDefaults.standard.double(forKey: "tve19"){
            didSet{
                UserDefaults.standard.set(self.tve19, forKey: "tve19")
            }
        }
        
        @Published var tve20: Double = UserDefaults.standard.double(forKey: "tve20"){
            didSet{
                UserDefaults.standard.set(self.tve20, forKey: "tve20")
            }
        }
        
        @Published var tve21: Double = UserDefaults.standard.double(forKey: "tve21"){
            didSet{
                UserDefaults.standard.set(self.tve21, forKey: "tve21")
            }
        }
        
        @Published var tve22: Double = UserDefaults.standard.double(forKey: "tve22"){
            didSet{
                UserDefaults.standard.set(self.tve22, forKey: "tve22")
            }
        }
        
        @Published var tve23: Double = UserDefaults.standard.double(forKey: "tve23"){
            didSet{
                UserDefaults.standard.set(self.tve23, forKey: "tve23")
            }
        }
        
        @Published var tve24: Double = UserDefaults.standard.double(forKey: "tve24"){
            didSet{
                UserDefaults.standard.set(self.tve24, forKey: "tve24")
            }
        }
        
        @Published var tve25: Double = UserDefaults.standard.double(forKey: "tve25"){
            didSet{
                UserDefaults.standard.set(self.tve25, forKey: "tve25")
            }
        }
        
        @Published var tve26: Double = UserDefaults.standard.double(forKey: "tve26"){
            didSet{
                UserDefaults.standard.set(self.tve26, forKey: "tve26")
            }
        }
        
        @Published var tve27: Double = UserDefaults.standard.double(forKey: "tve27"){
            didSet{
                UserDefaults.standard.set(self.tve27, forKey: "tve27")
            }
        }
        
        @Published var tve28: Double = UserDefaults.standard.double(forKey: "tve28"){
            didSet{
                UserDefaults.standard.set(self.tve28, forKey: "tve28")
            }
        }
        
        @Published var tve29: Double = UserDefaults.standard.double(forKey: "tve29"){
            didSet{
                UserDefaults.standard.set(self.tve29, forKey: "tve29")
            }
        }
        
        @Published var tve30: Double = UserDefaults.standard.double(forKey: "tve30"){
            didSet{
                UserDefaults.standard.set(self.tve30, forKey: "tve30")
            }
        }
        
        @Published var tve31: Double = UserDefaults.standard.double(forKey: "tve31"){
            didSet{
                UserDefaults.standard.set(self.tve31, forKey: "tve31")
            }
        }
        
        @Published var tve32: Double = UserDefaults.standard.double(forKey: "tve32"){
            didSet{
                UserDefaults.standard.set(self.tve32, forKey: "tve32")
            }
        }
        
        @Published var tve33: Double = UserDefaults.standard.double(forKey: "tve33"){
            didSet{
                UserDefaults.standard.set(self.tve33, forKey: "tve33")
            }
        }
        
        @Published var tve34: Double = UserDefaults.standard.double(forKey: "tve34"){
            didSet{
                UserDefaults.standard.set(self.tve34, forKey: "tve34")
            }
        }
        
        @Published var tve35: Double = UserDefaults.standard.double(forKey: "tve35"){
            didSet{
                UserDefaults.standard.set(self.tve35, forKey: "tve35")
            }
        }
        
        @Published var tve36: Double = UserDefaults.standard.double(forKey: "tve36"){
            didSet{
                UserDefaults.standard.set(self.tve36, forKey: "tve36")
            }
        }
        
        @Published var tve37: Double = UserDefaults.standard.double(forKey: "tve37"){
            didSet{
                UserDefaults.standard.set(self.tve37, forKey: "tve37")
            }
        }
        
        @Published var tve38: Double = UserDefaults.standard.double(forKey: "tve38"){
            didSet{
                UserDefaults.standard.set(self.tve38, forKey: "tve38")
            }
        }
        
        @Published var tvf1: Double = UserDefaults.standard.double(forKey: "tvf1"){
            didSet{
                UserDefaults.standard.set(self.tvf1, forKey: "tvf1")
            }
        }
        
        @Published var tvf2: Double = UserDefaults.standard.double(forKey: "tvf2"){
            didSet{
                UserDefaults.standard.set(self.tvf2, forKey: "tvf2")
            }
        }
        
        @Published var tvf3: Double = UserDefaults.standard.double(forKey: "tvf3"){
            didSet{
                UserDefaults.standard.set(self.tvf3, forKey: "tvf3")
            }
        }
        
        @Published var tvf4: Double = UserDefaults.standard.double(forKey: "tvf4"){
            didSet{
                UserDefaults.standard.set(self.tvf4, forKey: "tvf4")
            }
        }
        
        @Published var tvf5: Double = UserDefaults.standard.double(forKey: "tvf5"){
            didSet{
                UserDefaults.standard.set(self.tvf5, forKey: "tvf5")
            }
        }
        
        @Published var tvf6: Double = UserDefaults.standard.double(forKey: "tvf6"){
            didSet{
                UserDefaults.standard.set(self.tvf6, forKey: "tvf6")
            }
        }
        
        @Published var tvf7: Double = UserDefaults.standard.double(forKey: "tvf7"){
            didSet{
                UserDefaults.standard.set(self.tvf7, forKey: "tvf7")
            }
        }
        
        @Published var tvf8: Double = UserDefaults.standard.double(forKey: "tvf8"){
            didSet{
                UserDefaults.standard.set(self.tvf8, forKey: "tvf8")
            }
        }
        
        @Published var tvf9: Double = UserDefaults.standard.double(forKey: "tvf9"){
            didSet{
                UserDefaults.standard.set(self.tvf9, forKey: "tvf9")
            }
        }
        
        @Published var tvf10: Double = UserDefaults.standard.double(forKey: "tvf10"){
            didSet{
                UserDefaults.standard.set(self.tvf10, forKey: "tvf10")
            }
        }
        
        @Published var tvf11: Double = UserDefaults.standard.double(forKey: "tvf11"){
            didSet{
                UserDefaults.standard.set(self.tvf11, forKey: "tvf11")
            }
        }
        
        @Published var tvf12: Double = UserDefaults.standard.double(forKey: "tvf12"){
            didSet{
                UserDefaults.standard.set(self.tvf12, forKey: "tvf12")
            }
        }
        
        @Published var tvf13: Double = UserDefaults.standard.double(forKey: "tvf13"){
            didSet{
                UserDefaults.standard.set(self.tvf13, forKey: "tvf13")
            }
        }
        
        @Published var tvf14: Double = UserDefaults.standard.double(forKey: "tvf14"){
            didSet{
                UserDefaults.standard.set(self.tvf14, forKey: "tvf14")
            }
        }
        
        @Published var tvf15: Double = UserDefaults.standard.double(forKey: "tvf15"){
            didSet{
                UserDefaults.standard.set(self.tvf15, forKey: "tvf15")
            }
        }
        
        @Published var tvf16: Double = UserDefaults.standard.double(forKey: "tvf16"){
            didSet{
                UserDefaults.standard.set(self.tvf16, forKey: "tvf16")
            }
        }
        
        @Published var tvf17: Double = UserDefaults.standard.double(forKey: "tvf17"){
            didSet{
                UserDefaults.standard.set(self.tvf17, forKey: "tvf17")
            }
        }
        
        @Published var tvf18: Double = UserDefaults.standard.double(forKey: "tvf18"){
            didSet{
                UserDefaults.standard.set(self.tvf18, forKey: "tvf18")
            }
        }
        
        @Published var tvf19: Double = UserDefaults.standard.double(forKey: "tvf19"){
            didSet{
                UserDefaults.standard.set(self.tvf19, forKey: "tvf19")
            }
        }
        
        @Published var tvf20: Double = UserDefaults.standard.double(forKey: "tvf20"){
            didSet{
                UserDefaults.standard.set(self.tvf20, forKey: "tvf20")
            }
        }
        
        @Published var tvf21: Double = UserDefaults.standard.double(forKey: "tvf21"){
            didSet{
                UserDefaults.standard.set(self.tvf21, forKey: "tvf21")
            }
        }
        
        @Published var tvf22: Double = UserDefaults.standard.double(forKey: "tvf22"){
            didSet{
                UserDefaults.standard.set(self.tvf22, forKey: "tvf22")
            }
        }
        
        @Published var tvf23: Double = UserDefaults.standard.double(forKey: "tvf23"){
            didSet{
                UserDefaults.standard.set(self.tvf23, forKey: "tvf23")
            }
        }
        
        @Published var tvf24: Double = UserDefaults.standard.double(forKey: "tvf24"){
            didSet{
                UserDefaults.standard.set(self.tvf24, forKey: "tvf24")
            }
        }
        
        @Published var tvf25: Double = UserDefaults.standard.double(forKey: "tvf25"){
            didSet{
                UserDefaults.standard.set(self.tvf25, forKey: "tvf25")
            }
        }
        
        @Published var tvf26: Double = UserDefaults.standard.double(forKey: "tvf26"){
            didSet{
                UserDefaults.standard.set(self.tvf26, forKey: "tvf26")
            }
        }
        
        @Published var tvf27: Double = UserDefaults.standard.double(forKey: "tvf27"){
            didSet{
                UserDefaults.standard.set(self.tvf27, forKey: "tvf27")
            }
        }
        
        @Published var tvf28: Double = UserDefaults.standard.double(forKey: "tvf28"){
            didSet{
                UserDefaults.standard.set(self.tvf28, forKey: "tvf28")
            }
        }
        
        @Published var tvf29: Double = UserDefaults.standard.double(forKey: "tvf29"){
            didSet{
                UserDefaults.standard.set(self.tvf29, forKey: "tvf29")
            }
        }
        
        @Published var tvf30: Double = UserDefaults.standard.double(forKey: "tvf30"){
            didSet{
                UserDefaults.standard.set(self.tvf30, forKey: "tvf30")
            }
        }
        
        @Published var tvf31: Double = UserDefaults.standard.double(forKey: "tvf31"){
            didSet{
                UserDefaults.standard.set(self.tvf31, forKey: "tvf31")
            }
        }
        
        @Published var tvf32: Double = UserDefaults.standard.double(forKey: "tvf32"){
            didSet{
                UserDefaults.standard.set(self.tvf32, forKey: "tvf32")
            }
        }
        
        @Published var tvf33: Double = UserDefaults.standard.double(forKey: "tvf33"){
            didSet{
                UserDefaults.standard.set(self.tvf33, forKey: "tvf33")
            }
        }
        
        @Published var tvf34: Double = UserDefaults.standard.double(forKey: "tvf34"){
            didSet{
                UserDefaults.standard.set(self.tvf34, forKey: "tvf34")
            }
        }
        
        @Published var tvf35: Double = UserDefaults.standard.double(forKey: "tvf35"){
            didSet{
                UserDefaults.standard.set(self.tvf35, forKey: "tvf35")
            }
        }
        
        @Published var tvf36: Double = UserDefaults.standard.double(forKey: "tvf36"){
            didSet{
                UserDefaults.standard.set(self.tvf36, forKey: "tvf36")
            }
        }
        
        @Published var tvf37: Double = UserDefaults.standard.double(forKey: "tvf37"){
            didSet{
                UserDefaults.standard.set(self.tvf37, forKey: "tvf37")
            }
        }
        
        @Published var tvf38: Double = UserDefaults.standard.double(forKey: "tvf38"){
            didSet{
                UserDefaults.standard.set(self.tvf38, forKey: "tvf38")
            }
        }
        
        @Published var tvf39: Double = UserDefaults.standard.double(forKey: "tvf39"){
            didSet{
                UserDefaults.standard.set(self.tvf39, forKey: "tvf39")
            }
        }
        
        @Published var tvf40: Double = UserDefaults.standard.double(forKey: "tvf40"){
            didSet{
                UserDefaults.standard.set(self.tvf40, forKey: "tvf40")
            }
        }
        
        @Published var tvf41: Double = UserDefaults.standard.double(forKey: "tvf41"){
            didSet{
                UserDefaults.standard.set(self.tvf41, forKey: "tvf41")
            }
        }
        
        @Published var tvf42: Double = UserDefaults.standard.double(forKey: "tvf42"){
            didSet{
                UserDefaults.standard.set(self.tvf42, forKey: "tvf42")
            }
        }
        
        @Published var tvf43: Double = UserDefaults.standard.double(forKey: "tvf43"){
            didSet{
                UserDefaults.standard.set(self.tvf43, forKey: "tvf43")
            }
        }
        
        @Published var tvf44: Double = UserDefaults.standard.double(forKey: "tvf44"){
            didSet{
                UserDefaults.standard.set(self.tvf44, forKey: "tvf44")
            }
        }
        
        @Published var tvf45: Double = UserDefaults.standard.double(forKey: "tvf45"){
            didSet{
                UserDefaults.standard.set(self.tvf45, forKey: "tvf45")
            }
        }
        
        @Published var tvf46: Double = UserDefaults.standard.double(forKey: "tvf46"){
            didSet{
                UserDefaults.standard.set(self.tvf46, forKey: "tvf46")
            }
        }
        
        @Published var tvf47: Double = UserDefaults.standard.double(forKey: "tvf47"){
            didSet{
                UserDefaults.standard.set(self.tvf47, forKey: "tvf47")
            }
        }
        
        @Published var tvf48: Double = UserDefaults.standard.double(forKey: "tvf48"){
            didSet{
                UserDefaults.standard.set(self.tvf48, forKey: "tvf48")
            }
        }
        
        @Published var tvf49: Double = UserDefaults.standard.double(forKey: "tvf49"){
            didSet{
                UserDefaults.standard.set(self.tvf49, forKey: "tvf49")
            }
        }
        
        @Published var tvf50: Double = UserDefaults.standard.double(forKey: "tvf50"){
            didSet{
                UserDefaults.standard.set(self.tvf50, forKey: "tvf50")
            }
        }
        
        @Published var tvg1: Double = UserDefaults.standard.double(forKey: "tvg1"){
            didSet{
                UserDefaults.standard.set(self.tvg1, forKey: "tvg1")
            }
        }
        
        @Published var tvg2: Double = UserDefaults.standard.double(forKey: "tvg2"){
            didSet{
                UserDefaults.standard.set(self.tvg2, forKey: "tvg2")
            }
        }
        
        @Published var tvg3: Double = UserDefaults.standard.double(forKey: "tvg3"){
            didSet{
                UserDefaults.standard.set(self.tvg3, forKey: "tvg3")
            }
        }
        
        @Published var tvg4: Double = UserDefaults.standard.double(forKey: "tvg4"){
            didSet{
                UserDefaults.standard.set(self.tvg4, forKey: "tvg4")
            }
        }
        
        @Published var tvg5: Double = UserDefaults.standard.double(forKey: "tvg5"){
            didSet{
                UserDefaults.standard.set(self.tvg5, forKey: "tvg5")
            }
        }
        
        @Published var tvg6: Double = UserDefaults.standard.double(forKey: "tvg6"){
            didSet{
                UserDefaults.standard.set(self.tvg6, forKey: "tvg6")
            }
        }
        
        @Published var tvg7: Double = UserDefaults.standard.double(forKey: "tvg7"){
            didSet{
                UserDefaults.standard.set(self.tvg7, forKey: "tvg7")
            }
        }
        
        @Published var tvg8: Double = UserDefaults.standard.double(forKey: "tvg8"){
            didSet{
                UserDefaults.standard.set(self.tvg8, forKey: "tvg8")
            }
        }
        
        @Published var tvg9: Double = UserDefaults.standard.double(forKey: "tvg9"){
            didSet{
                UserDefaults.standard.set(self.tvg9, forKey: "tvg9")
            }
        }
        
        @Published var tvg10: Double = UserDefaults.standard.double(forKey: "tvg10"){
            didSet{
                UserDefaults.standard.set(self.tvg10, forKey: "tvg10")
            }
        }
        
        @Published var tvg11: Double = UserDefaults.standard.double(forKey: "tvg11"){
            didSet{
                UserDefaults.standard.set(self.tvg11, forKey: "tvg11")
            }
        }
        
        @Published var tvg12: Double = UserDefaults.standard.double(forKey: "tvg12"){
            didSet{
                UserDefaults.standard.set(self.tvg12, forKey: "tvg12")
            }
        }
        
        @Published var tvg13: Double = UserDefaults.standard.double(forKey: "tvg13"){
            didSet{
                UserDefaults.standard.set(self.tvg13, forKey: "tvg13")
            }
        }
        
        @Published var tvg14: Double = UserDefaults.standard.double(forKey: "tvg14"){
            didSet{
                UserDefaults.standard.set(self.tvg14, forKey: "tvg14")
            }
        }
        
        @Published var tvg15: Double = UserDefaults.standard.double(forKey: "tvg15"){
            didSet{
                UserDefaults.standard.set(self.tvg15, forKey: "tvg15")
            }
        }
        
        @Published var tvg16: Double = UserDefaults.standard.double(forKey: "tvg16"){
            didSet{
                UserDefaults.standard.set(self.tvg16, forKey: "tvg16")
            }
        }
        
        @Published var tvg17: Double = UserDefaults.standard.double(forKey: "tvg17"){
            didSet{
                UserDefaults.standard.set(self.tvg17, forKey: "tvg17")
            }
        }
        
        @Published var tvg18: Double = UserDefaults.standard.double(forKey: "tvg18"){
            didSet{
                UserDefaults.standard.set(self.tvg18, forKey: "tvg18")
            }
        }
        
        @Published var tvg19: Double = UserDefaults.standard.double(forKey: "tvg19"){
            didSet{
                UserDefaults.standard.set(self.tvg19, forKey: "tvg19")
            }
        }
        
        @Published var tvg20: Double = UserDefaults.standard.double(forKey: "tvg20"){
            didSet{
                UserDefaults.standard.set(self.tvg20, forKey: "tvg20")
            }
        }
        
        @Published var tvg21: Double = UserDefaults.standard.double(forKey: "tvg21"){
            didSet{
                UserDefaults.standard.set(self.tvg21, forKey: "tvg21")
            }
        }
        
        @Published var tvg22: Double = UserDefaults.standard.double(forKey: "tvg22"){
            didSet{
                UserDefaults.standard.set(self.tvg22, forKey: "tvg22")
            }
        }
        
        @Published var tvg23: Double = UserDefaults.standard.double(forKey: "tvg23"){
            didSet{
                UserDefaults.standard.set(self.tvg23, forKey: "tvg23")
            }
        }
        
        @Published var tvg24: Double = UserDefaults.standard.double(forKey: "tvg24"){
            didSet{
                UserDefaults.standard.set(self.tvg24, forKey: "tvg24")
            }
        }
        
        @Published var tvg25: Double = UserDefaults.standard.double(forKey: "tvg25"){
            didSet{
                UserDefaults.standard.set(self.tvg25, forKey: "tvg25")
            }
        }
        
        @Published var tvg26: Double = UserDefaults.standard.double(forKey: "tvg26"){
            didSet{
                UserDefaults.standard.set(self.tvg26, forKey: "tvg26")
            }
        }
        
        @Published var tvg27: Double = UserDefaults.standard.double(forKey: "tvg27"){
            didSet{
                UserDefaults.standard.set(self.tvg27, forKey: "tvg27")
            }
        }
        
        @Published var tvg28: Double = UserDefaults.standard.double(forKey: "tvg28"){
            didSet{
                UserDefaults.standard.set(self.tvg28, forKey: "tvg28")
            }
        }
        
        @Published var tvg29: Double = UserDefaults.standard.double(forKey: "tvg29"){
            didSet{
                UserDefaults.standard.set(self.tvg29, forKey: "tvg29")
            }
        }
        
        @Published var tvg30: Double = UserDefaults.standard.double(forKey: "tvg30"){
            didSet{
                UserDefaults.standard.set(self.tvg30, forKey: "tvg30")
            }
        }
        
        @Published var tvg31: Double = UserDefaults.standard.double(forKey: "tvg31"){
            didSet{
                UserDefaults.standard.set(self.tvg31, forKey: "tvg31")
            }
        }
        
        @Published var tvg32: Double = UserDefaults.standard.double(forKey: "tvg32"){
            didSet{
                UserDefaults.standard.set(self.tve32, forKey: "tvg32")
            }
        }
        
        @Published var tvg33: Double = UserDefaults.standard.double(forKey: "tvg33"){
            didSet{
                UserDefaults.standard.set(self.tvg33, forKey: "tvg33")
            }
        }
        
        @Published var tvg34: Double = UserDefaults.standard.double(forKey: "tvg34"){
            didSet{
                UserDefaults.standard.set(self.tvg34, forKey: "tvg34")
            }
        }
        
        @Published var tvg35: Double = UserDefaults.standard.double(forKey: "tvg35"){
            didSet{
                UserDefaults.standard.set(self.tvg35, forKey: "tvg35")
            }
        }
        
        @Published var tvg36: Double = UserDefaults.standard.double(forKey: "tvg36"){
            didSet{
                UserDefaults.standard.set(self.tvg36, forKey: "tvg36")
            }
        }
        
        @Published var tvg37: Double = UserDefaults.standard.double(forKey: "tvg37"){
            didSet{
                UserDefaults.standard.set(self.tvg37, forKey: "tvg37")
            }
        }
        
        @Published var tvh1: Double = UserDefaults.standard.double(forKey: "tvh1"){
            didSet{
                UserDefaults.standard.set(self.tvh1, forKey: "tvh1")
            }
        }
        
        @Published var tvh2: Double = UserDefaults.standard.double(forKey: "tvh2"){
            didSet{
                UserDefaults.standard.set(self.tvh2, forKey: "tvh2")
            }
        }
        
        @Published var tvh3: Double = UserDefaults.standard.double(forKey: "tvh3"){
            didSet{
                UserDefaults.standard.set(self.tvh3, forKey: "tvh3")
            }
        }
        
        @Published var tvh4: Double = UserDefaults.standard.double(forKey: "tvh4"){
            didSet{
                UserDefaults.standard.set(self.tvh4, forKey: "tvh4")
            }
        }
        
        @Published var tvh5: Double = UserDefaults.standard.double(forKey: "tvh5"){
            didSet{
                UserDefaults.standard.set(self.tvh5, forKey: "tvh5")
            }
        }
        
        @Published var tvh6: Double = UserDefaults.standard.double(forKey: "tvh6"){
            didSet{
                UserDefaults.standard.set(self.tvh6, forKey: "tvh6")
            }
        }
        
        @Published var tvh7: Double = UserDefaults.standard.double(forKey: "tvh7"){
            didSet{
                UserDefaults.standard.set(self.tvh7, forKey: "tvh7")
            }
        }
        
        @Published var tvh8: Double = UserDefaults.standard.double(forKey: "tvh8"){
            didSet{
                UserDefaults.standard.set(self.tvh8, forKey: "tvh8")
            }
        }
        
        @Published var tvh9: Double = UserDefaults.standard.double(forKey: "tvh9"){
            didSet{
                UserDefaults.standard.set(self.tvh9, forKey: "tvh9")
            }
        }
        
        @Published var tvh10: Double = UserDefaults.standard.double(forKey: "tvh10"){
            didSet{
                UserDefaults.standard.set(self.tvh10, forKey: "tvh10")
            }
        }
        
        @Published var tvh11: Double = UserDefaults.standard.double(forKey: "tvh11"){
            didSet{
                UserDefaults.standard.set(self.tvh11, forKey: "tvh11")
            }
        }
        
        @Published var tvh12: Double = UserDefaults.standard.double(forKey: "tvh12"){
            didSet{
                UserDefaults.standard.set(self.tvh12, forKey: "tvh12")
            }
        }
        
        @Published var tvh13: Double = UserDefaults.standard.double(forKey: "tvh13"){
            didSet{
                UserDefaults.standard.set(self.tvh13, forKey: "tvh13")
            }
        }
        
        @Published var tvh14: Double = UserDefaults.standard.double(forKey: "tvh14"){
            didSet{
                UserDefaults.standard.set(self.tvh14, forKey: "tvh14")
            }
        }
        
        @Published var tvh15: Double = UserDefaults.standard.double(forKey: "tvh15"){
            didSet{
                UserDefaults.standard.set(self.tvh15, forKey: "tvh15")
            }
        }
        
        @Published var tvh16: Double = UserDefaults.standard.double(forKey: "tvh16"){
            didSet{
                UserDefaults.standard.set(self.tvh16, forKey: "tvh16")
            }
        }
        
        @Published var tvh17: Double = UserDefaults.standard.double(forKey: "tvh17"){
            didSet{
                UserDefaults.standard.set(self.tvh17, forKey: "tvh17")
            }
        }
        
        @Published var tvh18: Double = UserDefaults.standard.double(forKey: "tvh18"){
            didSet{
                UserDefaults.standard.set(self.tvh18, forKey: "tvh18")
            }
        }
        
        @Published var tvh19: Double = UserDefaults.standard.double(forKey: "tvh19"){
            didSet{
                UserDefaults.standard.set(self.tvh19, forKey: "tvh19")
            }
        }
        
        @Published var tvh20: Double = UserDefaults.standard.double(forKey: "tvh20"){
            didSet{
                UserDefaults.standard.set(self.tvh20, forKey: "tvh20")
            }
        }
        
        @Published var tvh21: Double = UserDefaults.standard.double(forKey: "tvh21"){
            didSet{
                UserDefaults.standard.set(self.tvh21, forKey: "tvh21")
            }
        }
        
        @Published var tvh22: Double = UserDefaults.standard.double(forKey: "tvh22"){
            didSet{
                UserDefaults.standard.set(self.tvh22, forKey: "tvh22")
            }
        }
        
        @Published var tvh23: Double = UserDefaults.standard.double(forKey: "tvh23"){
            didSet{
                UserDefaults.standard.set(self.tvh23, forKey: "tvh23")
            }
        }
        
        @Published var tvh24: Double = UserDefaults.standard.double(forKey: "tvh24"){
            didSet{
                UserDefaults.standard.set(self.tvh24, forKey: "tvh24")
            }
        }
        
        @Published var tvh25: Double = UserDefaults.standard.double(forKey: "tvh25"){
            didSet{
                UserDefaults.standard.set(self.tvh25, forKey: "tvh25")
            }
        }
        
        @Published var tvh26: Double = UserDefaults.standard.double(forKey: "tvh26"){
            didSet{
                UserDefaults.standard.set(self.tvh26, forKey: "tvh26")
            }
        }
        
        @Published var tvh27: Double = UserDefaults.standard.double(forKey: "tvh27"){
            didSet{
                UserDefaults.standard.set(self.tvh27, forKey: "tvh27")
            }
        }
        
        @Published var tvh28: Double = UserDefaults.standard.double(forKey: "tvh28"){
            didSet{
                UserDefaults.standard.set(self.tvh28, forKey: "tvh28")
            }
        }
        
        @Published var tvh29: Double = UserDefaults.standard.double(forKey: "tvh29"){
            didSet{
                UserDefaults.standard.set(self.tvh29, forKey: "tvh29")
            }
        }
        
        @Published var tvh30: Double = UserDefaults.standard.double(forKey: "tvh30"){
            didSet{
                UserDefaults.standard.set(self.tvh30, forKey: "tvh30")
            }
        }
        
        @Published var tvh31: Double = UserDefaults.standard.double(forKey: "tvh31"){
            didSet{
                UserDefaults.standard.set(self.tvh31, forKey: "tvh31")
            }
        }
        
        @Published var tvh32: Double = UserDefaults.standard.double(forKey: "tvh32"){
            didSet{
                UserDefaults.standard.set(self.tvh32, forKey: "tvh32")
            }
        }
        
        @Published var tvh33: Double = UserDefaults.standard.double(forKey: "tvh33"){
            didSet{
                UserDefaults.standard.set(self.tvh33, forKey: "tvh33")
            }
        }
        
        @Published var tvh34: Double = UserDefaults.standard.double(forKey: "tvh34"){
            didSet{
                UserDefaults.standard.set(self.tvh34, forKey: "tvh34")
            }
        }
        
        @Published var tvh35: Double = UserDefaults.standard.double(forKey: "tvh35"){
            didSet{
                UserDefaults.standard.set(self.tvh35, forKey: "tvh35")
            }
        }
        
        @Published var tvh36: Double = UserDefaults.standard.double(forKey: "tvh36"){
            didSet{
                UserDefaults.standard.set(self.tvh36, forKey: "tvh36")
            }
        }
        
        @Published var tvi1: Double = UserDefaults.standard.double(forKey: "tvi1"){
            didSet{
                UserDefaults.standard.set(self.tvi1, forKey: "tvi1")
            }
        }
        
        @Published var tvi2: Double = UserDefaults.standard.double(forKey: "tvi2"){
            didSet{
                UserDefaults.standard.set(self.tvi2, forKey: "tvi2")
            }
        }
        
        @Published var tvi3: Double = UserDefaults.standard.double(forKey: "tvi3"){
            didSet{
                UserDefaults.standard.set(self.tvi3, forKey: "tvi3")
            }
        }
        
        @Published var tvi4: Double = UserDefaults.standard.double(forKey: "tvi4"){
            didSet{
                UserDefaults.standard.set(self.tvi4, forKey: "tvi4")
            }
        }
        
        @Published var tvi5: Double = UserDefaults.standard.double(forKey: "tvi5"){
            didSet{
                UserDefaults.standard.set(self.tvi5, forKey: "tvi5")
            }
        }
        
        @Published var tvi6: Double = UserDefaults.standard.double(forKey: "tvi6"){
            didSet{
                UserDefaults.standard.set(self.tvi6, forKey: "tvi6")
            }
        }
        
        @Published var tvi7: Double = UserDefaults.standard.double(forKey: "tvi7"){
            didSet{
                UserDefaults.standard.set(self.tvi7, forKey: "tvi7")
            }
        }
        
        @Published var tvi8: Double = UserDefaults.standard.double(forKey: "tvi8"){
            didSet{
                UserDefaults.standard.set(self.tvi8, forKey: "tvi8")
            }
        }
        
        @Published var tvi9: Double = UserDefaults.standard.double(forKey: "tvi9"){
            didSet{
                UserDefaults.standard.set(self.tvi9, forKey: "tvi9")
            }
        }
        
        @Published var tvi10: Double = UserDefaults.standard.double(forKey: "tvi10"){
            didSet{
                UserDefaults.standard.set(self.tvi10, forKey: "tvi10")
            }
        }
        
        @Published var tvi11: Double = UserDefaults.standard.double(forKey: "tvi11"){
            didSet{
                UserDefaults.standard.set(self.tvi11, forKey: "tvi11")
            }
        }
        
        @Published var tvi12: Double = UserDefaults.standard.double(forKey: "tvi12"){
            didSet{
                UserDefaults.standard.set(self.tvi12, forKey: "tvi12")
            }
        }
        
        @Published var tvi13: Double = UserDefaults.standard.double(forKey: "tvi13"){
            didSet{
                UserDefaults.standard.set(self.tvi13, forKey: "tvi13")
            }
        }
        
        @Published var tvi14: Double = UserDefaults.standard.double(forKey: "tvi14"){
            didSet{
                UserDefaults.standard.set(self.tvi14, forKey: "tvi14")
            }
        }
        
        @Published var tvi15: Double = UserDefaults.standard.double(forKey: "tvi15"){
            didSet{
                UserDefaults.standard.set(self.tvi15, forKey: "tvi15")
            }
        }
        
        @Published var tvi16: Double = UserDefaults.standard.double(forKey: "tvi16"){
            didSet{
                UserDefaults.standard.set(self.tvi16, forKey: "tvi16")
            }
        }
        
        @Published var tvi17: Double = UserDefaults.standard.double(forKey: "tvi17"){
            didSet{
                UserDefaults.standard.set(self.tvi17, forKey: "tvi17")
            }
        }
        
        @Published var tvi18: Double = UserDefaults.standard.double(forKey: "tvi18"){
            didSet{
                UserDefaults.standard.set(self.tvi18, forKey: "tvi18")
            }
        }
        
        @Published var tvi19: Double = UserDefaults.standard.double(forKey: "tvi19"){
            didSet{
                UserDefaults.standard.set(self.tvi19, forKey: "tvi19")
            }
        }
        
        @Published var tvi20: Double = UserDefaults.standard.double(forKey: "tvi20"){
            didSet{
                UserDefaults.standard.set(self.tvi20, forKey: "tvi20")
            }
        }
        
        @Published var tvi21: Double = UserDefaults.standard.double(forKey: "tvi21"){
            didSet{
                UserDefaults.standard.set(self.tvi21, forKey: "tvi21")
            }
        }
        
        @Published var tvi22: Double = UserDefaults.standard.double(forKey: "tvi22"){
            didSet{
                UserDefaults.standard.set(self.tvi22, forKey: "tvi22")
            }
        }
        
        @Published var tvi23: Double = UserDefaults.standard.double(forKey: "tvi23"){
            didSet{
                UserDefaults.standard.set(self.tvi23, forKey: "tvi23")
            }
        }
        
        @Published var tvi24: Double = UserDefaults.standard.double(forKey: "tvi24"){
            didSet{
                UserDefaults.standard.set(self.tvi24, forKey: "tvi24")
            }
        }
        
        @Published var tvi25: Double = UserDefaults.standard.double(forKey: "tvi25"){
            didSet{
                UserDefaults.standard.set(self.tvi25, forKey: "tvi25")
            }
        }
        
        @Published var tvi26: Double = UserDefaults.standard.double(forKey: "tvi26"){
            didSet{
                UserDefaults.standard.set(self.tvi26, forKey: "tvi26")
            }
        }
        
        @Published var tvi27: Double = UserDefaults.standard.double(forKey: "tvi27"){
            didSet{
                UserDefaults.standard.set(self.tvi27, forKey: "tvi27")
            }
        }
        
        @Published var tvi28: Double = UserDefaults.standard.double(forKey: "tvi28"){
            didSet{
                UserDefaults.standard.set(self.tvi28, forKey: "tvi28")
            }
        }
        
        @Published var tvi29: Double = UserDefaults.standard.double(forKey: "tvi29"){
            didSet{
                UserDefaults.standard.set(self.tvi29, forKey: "tvi29")
            }
        }
        
        @Published var tvi30: Double = UserDefaults.standard.double(forKey: "tvi30"){
            didSet{
                UserDefaults.standard.set(self.tvi30, forKey: "tvi30")
            }
        }
        
        @Published var tvi31: Double = UserDefaults.standard.double(forKey: "tvi31"){
            didSet{
                UserDefaults.standard.set(self.tvi31, forKey: "tvi31")
            }
        }
        
        @Published var tvi32: Double = UserDefaults.standard.double(forKey: "tvi32"){
            didSet{
                UserDefaults.standard.set(self.tvi32, forKey: "tvi32")
            }
        }
        
        @Published var tvi33: Double = UserDefaults.standard.double(forKey: "tvi33"){
            didSet{
                UserDefaults.standard.set(self.tvi33, forKey: "tvi33")
            }
        }
        
        @Published var tvi34: Double = UserDefaults.standard.double(forKey: "tvi34"){
            didSet{
                UserDefaults.standard.set(self.tvi34, forKey: "tvi34")
            }
        }
    
    
    @Published var dva1: Double = UserDefaults.standard.double(forKey: "dva1"){
               didSet{
                  UserDefaults.standard.set(self.dva1, forKey: "dva1")
               }
          }
           
           @Published var dvb1: Double = UserDefaults.standard.double(forKey: "dvb1"){
               didSet{
                   UserDefaults.standard.set(self.dvb1, forKey: "dvb1")
               }
           }
           
           @Published var dvb2: Double = UserDefaults.standard.double(forKey: "dvb2"){
               didSet{
                   UserDefaults.standard.set(self.dvb2, forKey: "dvb2")
               }
           }
           
           @Published var dvb3: Double = UserDefaults.standard.double(forKey: "dvb3"){
               didSet{
                   UserDefaults.standard.set(self.dvb3, forKey: "dvb3")
               }
           }
           
           @Published var dvb4: Double = UserDefaults.standard.double(forKey: "dvb4"){
               didSet{
                   UserDefaults.standard.set(self.dvb4, forKey: "dvb4")
               }
           }
           
           @Published var dvb5: Double = UserDefaults.standard.double(forKey: "dvb5"){
               didSet{
                   UserDefaults.standard.set(self.dvb5, forKey: "dvb5")
               }
           }
           
           @Published var dvc1: Double = UserDefaults.standard.double(forKey: "dvc1"){
               didSet{
                   UserDefaults.standard.set(self.dvb3, forKey: "dvc1")
               }
           }
           
           @Published var dvc2: Double = UserDefaults.standard.double(forKey: "dvc2"){
               didSet{
                   UserDefaults.standard.set(self.dvc2, forKey: "dvc2")
               }
           }
           
           @Published var dvc3: Double = UserDefaults.standard.double(forKey: "dvc3"){
               didSet{
                   UserDefaults.standard.set(self.dvc3, forKey: "dvc3")
               }
           }
           
           @Published var dvc4: Double = UserDefaults.standard.double(forKey: "dvc4"){
               didSet{
                   UserDefaults.standard.set(self.dvc4, forKey: "dvc4")
               }
           }
           
           @Published var dvc5: Double = UserDefaults.standard.double(forKey: "dvc5"){
               didSet{
                   UserDefaults.standard.set(self.dvc5, forKey: "dvc5")
               }
           }
           
           @Published var dvc6: Double = UserDefaults.standard.double(forKey: "dvc6"){
               didSet{
                   UserDefaults.standard.set(self.dvc6, forKey: "dvc6")
               }
           }
           
           @Published var dvd1: Double = UserDefaults.standard.double(forKey: "dvd1"){
               didSet{
                   UserDefaults.standard.set(self.dvd1, forKey: "dvd1")
               }
           }
           
           @Published var dvd2: Double = UserDefaults.standard.double(forKey: "dvd2"){
               didSet{
                   UserDefaults.standard.set(self.dvd2, forKey: "dvd2")
               }
           }
           
           @Published var dvd3: Double = UserDefaults.standard.double(forKey: "dvd3"){
               didSet{
                   UserDefaults.standard.set(self.dvd3, forKey: "dvd3")
               }
           }
           
           @Published var dvd4: Double = UserDefaults.standard.double(forKey: "dvd4"){
               didSet{
                   UserDefaults.standard.set(self.dvd4, forKey: "dvd4")
               }
           }
           
           @Published var dvd5: Double = UserDefaults.standard.double(forKey: "dvd5"){
               didSet{
                   UserDefaults.standard.set(self.dvd5, forKey: "dvd5")
               }
           }
           
           @Published var dvd6: Double = UserDefaults.standard.double(forKey: "dvd6"){
               didSet{
                   UserDefaults.standard.set(self.dvd6, forKey: "dvd6")
               }
           }
           
           @Published var dvd7: Double = UserDefaults.standard.double(forKey: "dvd7"){
               didSet{
                   UserDefaults.standard.set(self.dvd7, forKey: "dvd7")
               }
           }
           
           @Published var dvd8: Double = UserDefaults.standard.double(forKey: "dvd8"){
               didSet{
                   UserDefaults.standard.set(self.dvd8, forKey: "dvd8")
               }
           }
           
           @Published var dvd9: Double = UserDefaults.standard.double(forKey: "dvd9"){
               didSet{
                   UserDefaults.standard.set(self.dvd9, forKey: "dvd9")
               }
           }
           
           @Published var dvd10: Double = UserDefaults.standard.double(forKey: "dvd10"){
               didSet{
                   UserDefaults.standard.set(self.dvd10, forKey: "dvd10")
               }
           }
           
           @Published var dvd11: Double = UserDefaults.standard.double(forKey: "dvd11"){
               didSet{
                   UserDefaults.standard.set(self.dvd11, forKey: "dvd11")
               }
           }
           
           @Published var dvd12: Double = UserDefaults.standard.double(forKey: "dvd12"){
               didSet{
                   UserDefaults.standard.set(self.dvd12, forKey: "dvd12")
               }
           }
           
           @Published var dvd13: Double = UserDefaults.standard.double(forKey: "dvd13"){
               didSet{
                   UserDefaults.standard.set(self.dvd13, forKey: "dvd13")
               }
           }
           
           @Published var dvd14: Double = UserDefaults.standard.double(forKey: "dvd14"){
               didSet{
                   UserDefaults.standard.set(self.dvd14, forKey: "dvd14")
               }
           }
           
           @Published var dvd15: Double = UserDefaults.standard.double(forKey: "dvd15"){
               didSet{
                   UserDefaults.standard.set(self.dvd15, forKey: "dvd15")
               }
           }
           
           @Published var dvd16: Double = UserDefaults.standard.double(forKey: "dvd16"){
               didSet{
                   UserDefaults.standard.set(self.dvd16, forKey: "dvd16")
               }
           }
           
           @Published var dvd17: Double = UserDefaults.standard.double(forKey: "dvd17"){
               didSet{
                   UserDefaults.standard.set(self.dvd17, forKey: "dvd17")
               }
           }
           
           @Published var dvd18: Double = UserDefaults.standard.double(forKey: "dvd18"){
               didSet{
                   UserDefaults.standard.set(self.dvd18, forKey: "dvd18")
               }
           }
           
           @Published var dvd19: Double = UserDefaults.standard.double(forKey: "dvd19"){
               didSet{
                   UserDefaults.standard.set(self.dvd19, forKey: "dvd19")
               }
           }
           
           @Published var dvd20: Double = UserDefaults.standard.double(forKey: "dvd20"){
               didSet{
                   UserDefaults.standard.set(self.dvd20, forKey: "dvd20")
               }
           }
           
           @Published var dvd21: Double = UserDefaults.standard.double(forKey: "dvd21"){
               didSet{
                   UserDefaults.standard.set(self.dvd21, forKey: "dvd21")
               }
           }
           
           @Published var dvd22: Double = UserDefaults.standard.double(forKey: "dvd22"){
               didSet{
                   UserDefaults.standard.set(self.dvd22, forKey: "dvd22")
               }
           }
           
           @Published var dvd23: Double = UserDefaults.standard.double(forKey: "dvd23"){
               didSet{
                   UserDefaults.standard.set(self.dvd23, forKey: "dvd23")
               }
           }
           
           @Published var dvd24: Double = UserDefaults.standard.double(forKey: "dvd24"){
               didSet{
                   UserDefaults.standard.set(self.dvd24, forKey: "dvd24")
               }
           }
           
           @Published var dvd25: Double = UserDefaults.standard.double(forKey: "dvd25"){
               didSet{
                   UserDefaults.standard.set(self.dvd25, forKey: "dvd25")
               }
           }
           
           @Published var dvd26: Double = UserDefaults.standard.double(forKey: "dvd26"){
               didSet{
                   UserDefaults.standard.set(self.dvd26, forKey: "dvd26")
               }
           }
           
           @Published var dvd27: Double = UserDefaults.standard.double(forKey: "dvd27"){
               didSet{
                   UserDefaults.standard.set(self.dvd27, forKey: "dvd27")
               }
           }
           
           @Published var dvd28: Double = UserDefaults.standard.double(forKey: "dvd28"){
               didSet{
                   UserDefaults.standard.set(self.dvd28, forKey: "dvd28")
               }
           }
           
           @Published var dvd29: Double = UserDefaults.standard.double(forKey: "dvd29"){
               didSet{
                   UserDefaults.standard.set(self.dvd29, forKey: "dvd29")
               }
           }
           
           @Published var dvd30: Double = UserDefaults.standard.double(forKey: "dvd30"){
               didSet{
                   UserDefaults.standard.set(self.dvd30, forKey: "dvd30")
               }
           }
           
           @Published var dvd31: Double = UserDefaults.standard.double(forKey: "dvd31"){
               didSet{
                   UserDefaults.standard.set(self.dvd31, forKey: "dvd31")
               }
           }
           
           @Published var dvd32: Double = UserDefaults.standard.double(forKey: "dvd32"){
               didSet{
                   UserDefaults.standard.set(self.dvd32, forKey: "dvd32")
               }
           }
           
           @Published var dvd33: Double = UserDefaults.standard.double(forKey: "dvd33"){
               didSet{
                   UserDefaults.standard.set(self.dvd33, forKey: "dvd33")
               }
           }
           
           @Published var dve1: Double = UserDefaults.standard.double(forKey: "dve1"){
               didSet{
                   UserDefaults.standard.set(self.dve1, forKey: "dve1")
               }
           }
           
           @Published var dve2: Double = UserDefaults.standard.double(forKey: "dve2"){
               didSet{
                   UserDefaults.standard.set(self.dve2, forKey: "dve2")
               }
           }
           
           @Published var dve3: Double = UserDefaults.standard.double(forKey: "dve3"){
               didSet{
                   UserDefaults.standard.set(self.dve3, forKey: "dve3")
               }
           }
           
           @Published var dve4: Double = UserDefaults.standard.double(forKey: "dve4"){
               didSet{
                   UserDefaults.standard.set(self.dve4, forKey: "dve4")
               }
           }
           
           @Published var dve5: Double = UserDefaults.standard.double(forKey: "dve5"){
               didSet{
                   UserDefaults.standard.set(self.dve5, forKey: "dve5")
               }
           }
           
           @Published var dve6: Double = UserDefaults.standard.double(forKey: "dve6"){
               didSet{
                   UserDefaults.standard.set(self.dve6, forKey: "dve6")
               }
           }
           
           @Published var dve7: Double = UserDefaults.standard.double(forKey: "dve7"){
               didSet{
                   UserDefaults.standard.set(self.dve7, forKey: "dve7")
               }
           }
           
           @Published var dve8: Double = UserDefaults.standard.double(forKey: "dve8"){
               didSet{
                   UserDefaults.standard.set(self.dve8, forKey: "dve8")
               }
           }
           
           @Published var dve9: Double = UserDefaults.standard.double(forKey: "dve9"){
               didSet{
                   UserDefaults.standard.set(self.dve9, forKey: "dve9")
               }
           }
           
           @Published var dve10: Double = UserDefaults.standard.double(forKey: "dve10"){
               didSet{
                   UserDefaults.standard.set(self.dve10, forKey: "dve10")
               }
           }
           
           @Published var dve11: Double = UserDefaults.standard.double(forKey: "dve11"){
               didSet{
                   UserDefaults.standard.set(self.dve11, forKey: "dve11")
               }
           }
           
           @Published var dve12: Double = UserDefaults.standard.double(forKey: "dve12"){
               didSet{
                   UserDefaults.standard.set(self.dve12, forKey: "dve12")
               }
           }
           
           @Published var dve13: Double = UserDefaults.standard.double(forKey: "dve13"){
               didSet{
                   UserDefaults.standard.set(self.dve13, forKey: "dve13")
               }
           }
           
           @Published var dve14: Double = UserDefaults.standard.double(forKey: "dve14"){
               didSet{
                   UserDefaults.standard.set(self.dve14, forKey: "dve14")
               }
           }
           
           @Published var dve15: Double = UserDefaults.standard.double(forKey: "dve15"){
               didSet{
                   UserDefaults.standard.set(self.dve15, forKey: "dve15")
               }
           }
           
           @Published var dve16: Double = UserDefaults.standard.double(forKey: "dve16"){
               didSet{
                   UserDefaults.standard.set(self.dve16, forKey: "dve16")
               }
           }
           
           @Published var dve17: Double = UserDefaults.standard.double(forKey: "dve17"){
               didSet{
                   UserDefaults.standard.set(self.dve17, forKey: "dve17")
               }
           }
           
           @Published var dve18: Double = UserDefaults.standard.double(forKey: "dve18"){
               didSet{
                   UserDefaults.standard.set(self.dve18, forKey: "dve18")
               }
           }
           
           @Published var dve19: Double = UserDefaults.standard.double(forKey: "dve19"){
               didSet{
                   UserDefaults.standard.set(self.dve19, forKey: "dve19")
               }
           }
           
           @Published var dve20: Double = UserDefaults.standard.double(forKey: "dve20"){
               didSet{
                   UserDefaults.standard.set(self.dve20, forKey: "dve20")
               }
           }
           
           @Published var dve21: Double = UserDefaults.standard.double(forKey: "dve21"){
               didSet{
                   UserDefaults.standard.set(self.dve21, forKey: "dve21")
               }
           }
           
           @Published var dve22: Double = UserDefaults.standard.double(forKey: "dve22"){
               didSet{
                   UserDefaults.standard.set(self.dve22, forKey: "dve22")
               }
           }
           
           @Published var dve23: Double = UserDefaults.standard.double(forKey: "dve23"){
               didSet{
                   UserDefaults.standard.set(self.dve23, forKey: "dve23")
               }
           }
           
           @Published var dve24: Double = UserDefaults.standard.double(forKey: "dve24"){
               didSet{
                   UserDefaults.standard.set(self.dve24, forKey: "dve24")
               }
           }
           
           @Published var dve25: Double = UserDefaults.standard.double(forKey: "dve25"){
               didSet{
                   UserDefaults.standard.set(self.dve25, forKey: "dve25")
               }
           }
           
           @Published var dve26: Double = UserDefaults.standard.double(forKey: "dve26"){
               didSet{
                   UserDefaults.standard.set(self.dve26, forKey: "dve26")
               }
           }
           
           @Published var dve27: Double = UserDefaults.standard.double(forKey: "dve27"){
               didSet{
                   UserDefaults.standard.set(self.dve27, forKey: "dve27")
               }
           }
           
           @Published var dve28: Double = UserDefaults.standard.double(forKey: "dve28"){
               didSet{
                   UserDefaults.standard.set(self.dve28, forKey: "dve28")
               }
           }
           
           @Published var dve29: Double = UserDefaults.standard.double(forKey: "dve29"){
               didSet{
                   UserDefaults.standard.set(self.dve29, forKey: "dve29")
               }
           }
           
           @Published var dve30: Double = UserDefaults.standard.double(forKey: "dve30"){
               didSet{
                   UserDefaults.standard.set(self.dve30, forKey: "dve30")
               }
           }
           
           @Published var dve31: Double = UserDefaults.standard.double(forKey: "dve31"){
               didSet{
                   UserDefaults.standard.set(self.dve31, forKey: "dve31")
               }
           }
           
           @Published var dve32: Double = UserDefaults.standard.double(forKey: "dve32"){
               didSet{
                   UserDefaults.standard.set(self.dve32, forKey: "dve32")
               }
           }
           
           @Published var dve33: Double = UserDefaults.standard.double(forKey: "dve33"){
               didSet{
                   UserDefaults.standard.set(self.dve33, forKey: "dve33")
               }
           }
           
           @Published var dve34: Double = UserDefaults.standard.double(forKey: "dve34"){
               didSet{
                   UserDefaults.standard.set(self.dve34, forKey: "dve34")
               }
           }
           
           @Published var dve35: Double = UserDefaults.standard.double(forKey: "dve35"){
               didSet{
                   UserDefaults.standard.set(self.dve35, forKey: "dve35")
               }
           }
           
           @Published var dve36: Double = UserDefaults.standard.double(forKey: "dve36"){
               didSet{
                   UserDefaults.standard.set(self.dve36, forKey: "dve36")
               }
           }
           
           @Published var dve37: Double = UserDefaults.standard.double(forKey: "dve37"){
               didSet{
                   UserDefaults.standard.set(self.dve37, forKey: "dve37")
               }
           }
           
           @Published var dve38: Double = UserDefaults.standard.double(forKey: "dve38"){
               didSet{
                   UserDefaults.standard.set(self.dve38, forKey: "dve38")
               }
           }
           
           @Published var dvf1: Double = UserDefaults.standard.double(forKey: "dvf1"){
               didSet{
                   UserDefaults.standard.set(self.dvf1, forKey: "dvf1")
               }
           }
           
           @Published var dvf2: Double = UserDefaults.standard.double(forKey: "dvf2"){
               didSet{
                   UserDefaults.standard.set(self.dvf2, forKey: "dvf2")
               }
           }
           
           @Published var dvf3: Double = UserDefaults.standard.double(forKey: "dvf3"){
               didSet{
                   UserDefaults.standard.set(self.dvf3, forKey: "dvf3")
               }
           }
           
           @Published var dvf4: Double = UserDefaults.standard.double(forKey: "dvf4"){
               didSet{
                   UserDefaults.standard.set(self.dvf4, forKey: "dvf4")
               }
           }
           
           @Published var dvf5: Double = UserDefaults.standard.double(forKey: "dvf5"){
               didSet{
                   UserDefaults.standard.set(self.dvf5, forKey: "dvf5")
               }
           }
           
           @Published var dvf6: Double = UserDefaults.standard.double(forKey: "dvf6"){
               didSet{
                   UserDefaults.standard.set(self.dvf6, forKey: "dvf6")
               }
           }
           
           @Published var dvf7: Double = UserDefaults.standard.double(forKey: "dvf7"){
               didSet{
                   UserDefaults.standard.set(self.dvf7, forKey: "dvf7")
               }
           }
           
           @Published var dvf8: Double = UserDefaults.standard.double(forKey: "dvf8"){
               didSet{
                   UserDefaults.standard.set(self.dvf8, forKey: "dvf8")
               }
           }
           
           @Published var dvf9: Double = UserDefaults.standard.double(forKey: "dvf9"){
               didSet{
                   UserDefaults.standard.set(self.dvf9, forKey: "dvf9")
               }
           }
           
           @Published var dvf10: Double = UserDefaults.standard.double(forKey: "dvf10"){
               didSet{
                   UserDefaults.standard.set(self.dvf10, forKey: "dvf10")
               }
           }
           
           @Published var dvf11: Double = UserDefaults.standard.double(forKey: "dvf11"){
               didSet{
                   UserDefaults.standard.set(self.dvf11, forKey: "dvf11")
               }
           }
           
           @Published var dvf12: Double = UserDefaults.standard.double(forKey: "dvf12"){
               didSet{
                   UserDefaults.standard.set(self.dvf12, forKey: "dvf12")
               }
           }
           
           @Published var dvf13: Double = UserDefaults.standard.double(forKey: "dvf13"){
               didSet{
                   UserDefaults.standard.set(self.dvf13, forKey: "dvf13")
               }
           }
           
           @Published var dvf14: Double = UserDefaults.standard.double(forKey: "dvf14"){
               didSet{
                   UserDefaults.standard.set(self.dvf14, forKey: "dvf14")
               }
           }
           
           @Published var dvf15: Double = UserDefaults.standard.double(forKey: "dvf15"){
               didSet{
                   UserDefaults.standard.set(self.dvf15, forKey: "dvf15")
               }
           }
           
           @Published var dvf16: Double = UserDefaults.standard.double(forKey: "dvf16"){
               didSet{
                   UserDefaults.standard.set(self.dvf16, forKey: "dvf16")
               }
           }
           
           @Published var dvf17: Double = UserDefaults.standard.double(forKey: "dvf17"){
               didSet{
                   UserDefaults.standard.set(self.dvf17, forKey: "dvf17")
               }
           }
           
           @Published var dvf18: Double = UserDefaults.standard.double(forKey: "dvf18"){
               didSet{
                   UserDefaults.standard.set(self.dvf18, forKey: "dvf18")
               }
           }
           
           @Published var dvf19: Double = UserDefaults.standard.double(forKey: "dvf19"){
               didSet{
                   UserDefaults.standard.set(self.dvf19, forKey: "dvf19")
               }
           }
           
           @Published var dvf20: Double = UserDefaults.standard.double(forKey: "dvf20"){
               didSet{
                   UserDefaults.standard.set(self.dvf20, forKey: "dvf20")
               }
           }
           
           @Published var dvf21: Double = UserDefaults.standard.double(forKey: "dvf21"){
               didSet{
                   UserDefaults.standard.set(self.dvf21, forKey: "dvf21")
               }
           }
           
           @Published var dvf22: Double = UserDefaults.standard.double(forKey: "dvf22"){
               didSet{
                   UserDefaults.standard.set(self.dvf22, forKey: "dvf22")
               }
           }
           
           @Published var dvf23: Double = UserDefaults.standard.double(forKey: "dvf23"){
               didSet{
                   UserDefaults.standard.set(self.dvf23, forKey: "dvf23")
               }
           }
           
           @Published var dvf24: Double = UserDefaults.standard.double(forKey: "dvf24"){
               didSet{
                   UserDefaults.standard.set(self.dvf24, forKey: "dvf24")
               }
           }
           
           @Published var dvf25: Double = UserDefaults.standard.double(forKey: "dvf25"){
               didSet{
                   UserDefaults.standard.set(self.dvf25, forKey: "dvf25")
               }
           }
           
           @Published var dvf26: Double = UserDefaults.standard.double(forKey: "dvf26"){
               didSet{
                   UserDefaults.standard.set(self.dvf26, forKey: "dvf26")
               }
           }
           
           @Published var dvf27: Double = UserDefaults.standard.double(forKey: "dvf27"){
               didSet{
                   UserDefaults.standard.set(self.dvf27, forKey: "dvf27")
               }
           }
           
           @Published var dvf28: Double = UserDefaults.standard.double(forKey: "dvf28"){
               didSet{
                   UserDefaults.standard.set(self.dvf28, forKey: "dvf28")
               }
           }
           
           @Published var dvf29: Double = UserDefaults.standard.double(forKey: "dvf29"){
               didSet{
                   UserDefaults.standard.set(self.dvf29, forKey: "dvf29")
               }
           }
           
           @Published var dvf30: Double = UserDefaults.standard.double(forKey: "dvf30"){
               didSet{
                   UserDefaults.standard.set(self.dvf30, forKey: "dvf30")
               }
           }
           
           @Published var dvf31: Double = UserDefaults.standard.double(forKey: "dvf31"){
               didSet{
                   UserDefaults.standard.set(self.dvf31, forKey: "dvf31")
               }
           }
           
           @Published var dvf32: Double = UserDefaults.standard.double(forKey: "dvf32"){
               didSet{
                   UserDefaults.standard.set(self.dvf32, forKey: "dvf32")
               }
           }
           
           @Published var dvf33: Double = UserDefaults.standard.double(forKey: "dvf33"){
               didSet{
                   UserDefaults.standard.set(self.dvf33, forKey: "dvf33")
               }
           }
           
           @Published var dvf34: Double = UserDefaults.standard.double(forKey: "dvf34"){
               didSet{
                   UserDefaults.standard.set(self.dvf34, forKey: "dvf34")
               }
           }
           
           @Published var dvf35: Double = UserDefaults.standard.double(forKey: "dvf35"){
               didSet{
                   UserDefaults.standard.set(self.dvf35, forKey: "dvf35")
               }
           }
           
           @Published var dvf36: Double = UserDefaults.standard.double(forKey: "dvf36"){
               didSet{
                   UserDefaults.standard.set(self.dvf36, forKey: "dvf36")
               }
           }
           
           @Published var dvf37: Double = UserDefaults.standard.double(forKey: "dvf37"){
               didSet{
                   UserDefaults.standard.set(self.dvf37, forKey: "dvf37")
               }
           }
           
           @Published var dvf38: Double = UserDefaults.standard.double(forKey: "dvf38"){
               didSet{
                   UserDefaults.standard.set(self.dvf38, forKey: "dvf38")
               }
           }
           
           @Published var dvf39: Double = UserDefaults.standard.double(forKey: "dvf39"){
               didSet{
                   UserDefaults.standard.set(self.dvf39, forKey: "dvf39")
               }
           }
           
           @Published var dvf40: Double = UserDefaults.standard.double(forKey: "dvf40"){
               didSet{
                   UserDefaults.standard.set(self.dvf40, forKey: "dvf40")
               }
           }
           
           @Published var dvf41: Double = UserDefaults.standard.double(forKey: "dvf41"){
               didSet{
                   UserDefaults.standard.set(self.dvf41, forKey: "dvf41")
               }
           }
           
           @Published var dvf42: Double = UserDefaults.standard.double(forKey: "dvf42"){
               didSet{
                   UserDefaults.standard.set(self.dvf42, forKey: "dvf42")
               }
           }
           
           @Published var dvf43: Double = UserDefaults.standard.double(forKey: "dvf43"){
               didSet{
                   UserDefaults.standard.set(self.dvf43, forKey: "dvf43")
               }
           }
           
           @Published var dvf44: Double = UserDefaults.standard.double(forKey: "dvf44"){
               didSet{
                   UserDefaults.standard.set(self.dvf44, forKey: "dvf44")
               }
           }
           
           @Published var dvf45: Double = UserDefaults.standard.double(forKey: "dvf45"){
               didSet{
                   UserDefaults.standard.set(self.dvf45, forKey: "dvf45")
               }
           }
           
           @Published var dvf46: Double = UserDefaults.standard.double(forKey: "dvf46"){
               didSet{
                   UserDefaults.standard.set(self.dvf46, forKey: "dvf46")
               }
           }
           
           @Published var dvf47: Double = UserDefaults.standard.double(forKey: "dvf47"){
               didSet{
                   UserDefaults.standard.set(self.dvf47, forKey: "dvf47")
               }
           }
           
           @Published var dvf48: Double = UserDefaults.standard.double(forKey: "dvf48"){
               didSet{
                   UserDefaults.standard.set(self.dvf48, forKey: "dvf48")
               }
           }
           
           @Published var dvf49: Double = UserDefaults.standard.double(forKey: "dvf49"){
               didSet{
                   UserDefaults.standard.set(self.dvf49, forKey: "dvf49")
               }
           }
           
           @Published var dvf50: Double = UserDefaults.standard.double(forKey: "dvf50"){
               didSet{
                   UserDefaults.standard.set(self.dvf50, forKey: "dvf50")
               }
           }
           
           @Published var dvg1: Double = UserDefaults.standard.double(forKey: "dvg1"){
               didSet{
                   UserDefaults.standard.set(self.dvg1, forKey: "dvg1")
               }
           }
           
           @Published var dvg2: Double = UserDefaults.standard.double(forKey: "dvg2"){
               didSet{
                   UserDefaults.standard.set(self.dvg2, forKey: "dvg2")
               }
           }
           
           @Published var dvg3: Double = UserDefaults.standard.double(forKey: "dvg3"){
               didSet{
                   UserDefaults.standard.set(self.dvg3, forKey: "dvg3")
               }
           }
           
           @Published var dvg4: Double = UserDefaults.standard.double(forKey: "dvg4"){
               didSet{
                   UserDefaults.standard.set(self.dvg4, forKey: "dvg4")
               }
           }
           
           @Published var dvg5: Double = UserDefaults.standard.double(forKey: "dvg5"){
               didSet{
                   UserDefaults.standard.set(self.dvg5, forKey: "dvg5")
               }
           }
           
           @Published var dvg6: Double = UserDefaults.standard.double(forKey: "dvg6"){
               didSet{
                   UserDefaults.standard.set(self.dvg6, forKey: "dvg6")
               }
           }
           
           @Published var dvg7: Double = UserDefaults.standard.double(forKey: "dvg7"){
               didSet{
                   UserDefaults.standard.set(self.dvg7, forKey: "dvg7")
               }
           }
           
           @Published var dvg8: Double = UserDefaults.standard.double(forKey: "dvg8"){
               didSet{
                   UserDefaults.standard.set(self.dvg8, forKey: "dvg8")
               }
           }
           
           @Published var dvg9: Double = UserDefaults.standard.double(forKey: "dvg9"){
               didSet{
                   UserDefaults.standard.set(self.dvg9, forKey: "dvg9")
               }
           }
           
           @Published var dvg10: Double = UserDefaults.standard.double(forKey: "dvg10"){
               didSet{
                   UserDefaults.standard.set(self.dvg10, forKey: "dvg10")
               }
           }
           
           @Published var dvg11: Double = UserDefaults.standard.double(forKey: "dvg11"){
               didSet{
                   UserDefaults.standard.set(self.dvg11, forKey: "dvg11")
               }
           }
           
           @Published var dvg12: Double = UserDefaults.standard.double(forKey: "dvg12"){
               didSet{
                   UserDefaults.standard.set(self.dvg12, forKey: "dvg12")
               }
           }
           
           @Published var dvg13: Double = UserDefaults.standard.double(forKey: "dvg13"){
               didSet{
                   UserDefaults.standard.set(self.dvg13, forKey: "dvg13")
               }
           }
           
           @Published var dvg14: Double = UserDefaults.standard.double(forKey: "dvg14"){
               didSet{
                   UserDefaults.standard.set(self.dvg14, forKey: "dvg14")
               }
           }
           
           @Published var dvg15: Double = UserDefaults.standard.double(forKey: "dvg15"){
               didSet{
                   UserDefaults.standard.set(self.dvg15, forKey: "dvg15")
               }
           }
           
           @Published var dvg16: Double = UserDefaults.standard.double(forKey: "dvg16"){
               didSet{
                   UserDefaults.standard.set(self.dvg16, forKey: "dvg16")
               }
           }
           
           @Published var dvg17: Double = UserDefaults.standard.double(forKey: "dvg17"){
               didSet{
                   UserDefaults.standard.set(self.dvg17, forKey: "dvg17")
               }
           }
           
           @Published var dvg18: Double = UserDefaults.standard.double(forKey: "dvg18"){
               didSet{
                   UserDefaults.standard.set(self.dvg18, forKey: "dvg18")
               }
           }
           
           @Published var dvg19: Double = UserDefaults.standard.double(forKey: "dvg19"){
               didSet{
                   UserDefaults.standard.set(self.dvg19, forKey: "dvg19")
               }
           }
           
           @Published var dvg20: Double = UserDefaults.standard.double(forKey: "dvg20"){
               didSet{
                   UserDefaults.standard.set(self.dvg20, forKey: "dvg20")
               }
           }
           
           @Published var dvg21: Double = UserDefaults.standard.double(forKey: "dvg21"){
               didSet{
                   UserDefaults.standard.set(self.dvg21, forKey: "dvg21")
               }
           }
           
           @Published var dvg22: Double = UserDefaults.standard.double(forKey: "dvg22"){
               didSet{
                   UserDefaults.standard.set(self.dvg22, forKey: "dvg22")
               }
           }
           
           @Published var dvg23: Double = UserDefaults.standard.double(forKey: "dvg23"){
               didSet{
                   UserDefaults.standard.set(self.dvg23, forKey: "dvg23")
               }
           }
           
           @Published var dvg24: Double = UserDefaults.standard.double(forKey: "dvg24"){
               didSet{
                   UserDefaults.standard.set(self.dvg24, forKey: "dvg24")
               }
           }
           
           @Published var dvg25: Double = UserDefaults.standard.double(forKey: "dvg25"){
               didSet{
                   UserDefaults.standard.set(self.dvg25, forKey: "dvg25")
               }
           }
           
           @Published var dvg26: Double = UserDefaults.standard.double(forKey: "dvg26"){
               didSet{
                   UserDefaults.standard.set(self.dvg26, forKey: "dvg26")
               }
           }
           
           @Published var dvg27: Double = UserDefaults.standard.double(forKey: "dvg27"){
               didSet{
                   UserDefaults.standard.set(self.dvg27, forKey: "dvg27")
               }
           }
           
           @Published var dvg28: Double = UserDefaults.standard.double(forKey: "dvg28"){
               didSet{
                   UserDefaults.standard.set(self.dvg28, forKey: "dvg28")
               }
           }
           
           @Published var dvg29: Double = UserDefaults.standard.double(forKey: "dvg29"){
               didSet{
                   UserDefaults.standard.set(self.dvg29, forKey: "dvg29")
               }
           }
           
           @Published var dvg30: Double = UserDefaults.standard.double(forKey: "dvg30"){
               didSet{
                   UserDefaults.standard.set(self.dvg30, forKey: "dvg30")
               }
           }
           
           @Published var dvg31: Double = UserDefaults.standard.double(forKey: "dvg31"){
               didSet{
                   UserDefaults.standard.set(self.dvg31, forKey: "dvg31")
               }
           }
           
           @Published var dvg32: Double = UserDefaults.standard.double(forKey: "dvg32"){
               didSet{
                   UserDefaults.standard.set(self.dve32, forKey: "dvg32")
               }
           }
           
           @Published var dvg33: Double = UserDefaults.standard.double(forKey: "dvg33"){
               didSet{
                   UserDefaults.standard.set(self.dvg33, forKey: "dvg33")
               }
           }
           
           @Published var dvg34: Double = UserDefaults.standard.double(forKey: "dvg34"){
               didSet{
                   UserDefaults.standard.set(self.dvg34, forKey: "dvg34")
               }
           }
           
           @Published var dvg35: Double = UserDefaults.standard.double(forKey: "dvg35"){
               didSet{
                   UserDefaults.standard.set(self.dvg35, forKey: "dvg35")
               }
           }
           
           @Published var dvg36: Double = UserDefaults.standard.double(forKey: "dvg36"){
               didSet{
                   UserDefaults.standard.set(self.dvg36, forKey: "dvg36")
               }
           }
           
           @Published var dvg37: Double = UserDefaults.standard.double(forKey: "dvg37"){
               didSet{
                   UserDefaults.standard.set(self.dvg37, forKey: "dvg37")
               }
           }
           
           @Published var dvh1: Double = UserDefaults.standard.double(forKey: "dvh1"){
               didSet{
                   UserDefaults.standard.set(self.dvh1, forKey: "dvh1")
               }
           }
           
           @Published var dvh2: Double = UserDefaults.standard.double(forKey: "dvh2"){
               didSet{
                   UserDefaults.standard.set(self.dvh2, forKey: "dvh2")
               }
           }
           
           @Published var dvh3: Double = UserDefaults.standard.double(forKey: "dvh3"){
               didSet{
                   UserDefaults.standard.set(self.dvh3, forKey: "dvh3")
               }
           }
           
           @Published var dvh4: Double = UserDefaults.standard.double(forKey: "dvh4"){
               didSet{
                   UserDefaults.standard.set(self.dvh4, forKey: "dvh4")
               }
           }
           
           @Published var dvh5: Double = UserDefaults.standard.double(forKey: "dvh5"){
               didSet{
                   UserDefaults.standard.set(self.dvh5, forKey: "dvh5")
               }
           }
           
           @Published var dvh6: Double = UserDefaults.standard.double(forKey: "dvh6"){
               didSet{
                   UserDefaults.standard.set(self.dvh6, forKey: "dvh6")
               }
           }
           
           @Published var dvh7: Double = UserDefaults.standard.double(forKey: "dvh7"){
               didSet{
                   UserDefaults.standard.set(self.dvh7, forKey: "dvh7")
               }
           }
           
           @Published var dvh8: Double = UserDefaults.standard.double(forKey: "dvh8"){
               didSet{
                   UserDefaults.standard.set(self.dvh8, forKey: "dvh8")
               }
           }
           
           @Published var dvh9: Double = UserDefaults.standard.double(forKey: "dvh9"){
               didSet{
                   UserDefaults.standard.set(self.dvh9, forKey: "dvh9")
               }
           }
           
           @Published var dvh10: Double = UserDefaults.standard.double(forKey: "dvh10"){
               didSet{
                   UserDefaults.standard.set(self.dvh10, forKey: "dvh10")
               }
           }
           
           @Published var dvh11: Double = UserDefaults.standard.double(forKey: "dvh11"){
               didSet{
                   UserDefaults.standard.set(self.dvh11, forKey: "dvh11")
               }
           }
           
           @Published var dvh12: Double = UserDefaults.standard.double(forKey: "dvh12"){
               didSet{
                   UserDefaults.standard.set(self.dvh12, forKey: "dvh12")
               }
           }
           
           @Published var dvh13: Double = UserDefaults.standard.double(forKey: "dvh13"){
               didSet{
                   UserDefaults.standard.set(self.dvh13, forKey: "dvh13")
               }
           }
           
           @Published var dvh14: Double = UserDefaults.standard.double(forKey: "dvh14"){
               didSet{
                   UserDefaults.standard.set(self.dvh14, forKey: "dvh14")
               }
           }
           
           @Published var dvh15: Double = UserDefaults.standard.double(forKey: "dvh15"){
               didSet{
                   UserDefaults.standard.set(self.dvh15, forKey: "dvh15")
               }
           }
           
           @Published var dvh16: Double = UserDefaults.standard.double(forKey: "dvh16"){
               didSet{
                   UserDefaults.standard.set(self.dvh16, forKey: "dvh16")
               }
           }
           
           @Published var dvh17: Double = UserDefaults.standard.double(forKey: "dvh17"){
               didSet{
                   UserDefaults.standard.set(self.dvh17, forKey: "dvh17")
               }
           }
           
           @Published var dvh18: Double = UserDefaults.standard.double(forKey: "dvh18"){
               didSet{
                   UserDefaults.standard.set(self.dvh18, forKey: "dvh18")
               }
           }
           
           @Published var dvh19: Double = UserDefaults.standard.double(forKey: "dvh19"){
               didSet{
                   UserDefaults.standard.set(self.dvh19, forKey: "dvh19")
               }
           }
           
           @Published var dvh20: Double = UserDefaults.standard.double(forKey: "dvh20"){
               didSet{
                   UserDefaults.standard.set(self.dvh20, forKey: "dvh20")
               }
           }
           
           @Published var dvh21: Double = UserDefaults.standard.double(forKey: "dvh21"){
               didSet{
                   UserDefaults.standard.set(self.dvh21, forKey: "dvh21")
               }
           }
           
           @Published var dvh22: Double = UserDefaults.standard.double(forKey: "dvh22"){
               didSet{
                   UserDefaults.standard.set(self.dvh22, forKey: "dvh22")
               }
           }
           
           @Published var dvh23: Double = UserDefaults.standard.double(forKey: "dvh23"){
               didSet{
                   UserDefaults.standard.set(self.dvh23, forKey: "dvh23")
               }
           }
           
           @Published var dvh24: Double = UserDefaults.standard.double(forKey: "dvh24"){
               didSet{
                   UserDefaults.standard.set(self.dvh24, forKey: "dvh24")
               }
           }
           
           @Published var dvh25: Double = UserDefaults.standard.double(forKey: "dvh25"){
               didSet{
                   UserDefaults.standard.set(self.dvh25, forKey: "dvh25")
               }
           }
           
           @Published var dvh26: Double = UserDefaults.standard.double(forKey: "dvh26"){
               didSet{
                   UserDefaults.standard.set(self.dvh26, forKey: "dvh26")
               }
           }
           
           @Published var dvh27: Double = UserDefaults.standard.double(forKey: "dvh27"){
               didSet{
                   UserDefaults.standard.set(self.dvh27, forKey: "dvh27")
               }
           }
           
           @Published var dvh28: Double = UserDefaults.standard.double(forKey: "dvh28"){
               didSet{
                   UserDefaults.standard.set(self.dvh28, forKey: "dvh28")
               }
           }
           
           @Published var dvh29: Double = UserDefaults.standard.double(forKey: "dvh29"){
               didSet{
                   UserDefaults.standard.set(self.dvh29, forKey: "dvh29")
               }
           }
           
           @Published var dvh30: Double = UserDefaults.standard.double(forKey: "dvh30"){
               didSet{
                   UserDefaults.standard.set(self.dvh30, forKey: "dvh30")
               }
           }
           
           @Published var dvh31: Double = UserDefaults.standard.double(forKey: "dvh31"){
               didSet{
                   UserDefaults.standard.set(self.dvh31, forKey: "dvh31")
               }
           }
           
           @Published var dvh32: Double = UserDefaults.standard.double(forKey: "dvh32"){
               didSet{
                   UserDefaults.standard.set(self.dvh32, forKey: "dvh32")
               }
           }
           
           @Published var dvh33: Double = UserDefaults.standard.double(forKey: "dvh33"){
               didSet{
                   UserDefaults.standard.set(self.dvh33, forKey: "dvh33")
               }
           }
           
           @Published var dvh34: Double = UserDefaults.standard.double(forKey: "dvh34"){
               didSet{
                   UserDefaults.standard.set(self.dvh34, forKey: "dvh34")
               }
           }
           
           @Published var dvh35: Double = UserDefaults.standard.double(forKey: "dvh35"){
               didSet{
                   UserDefaults.standard.set(self.dvh35, forKey: "dvh35")
               }
           }
           
           @Published var dvh36: Double = UserDefaults.standard.double(forKey: "dvh36"){
               didSet{
                   UserDefaults.standard.set(self.dvh36, forKey: "dvh36")
               }
           }
           
           @Published var dvi1: Double = UserDefaults.standard.double(forKey: "dvi1"){
               didSet{
                   UserDefaults.standard.set(self.dvi1, forKey: "dvi1")
               }
           }
           
           @Published var dvi2: Double = UserDefaults.standard.double(forKey: "dvi2"){
               didSet{
                   UserDefaults.standard.set(self.dvi2, forKey: "dvi2")
               }
           }
           
           @Published var dvi3: Double = UserDefaults.standard.double(forKey: "dvi3"){
               didSet{
                   UserDefaults.standard.set(self.dvi3, forKey: "dvi3")
               }
           }
           
           @Published var dvi4: Double = UserDefaults.standard.double(forKey: "dvi4"){
               didSet{
                   UserDefaults.standard.set(self.dvi4, forKey: "dvi4")
               }
           }
           
           @Published var dvi5: Double = UserDefaults.standard.double(forKey: "dvi5"){
               didSet{
                   UserDefaults.standard.set(self.dvi5, forKey: "dvi5")
               }
           }
           
           @Published var dvi6: Double = UserDefaults.standard.double(forKey: "dvi6"){
               didSet{
                   UserDefaults.standard.set(self.dvi6, forKey: "dvi6")
               }
           }
           
           @Published var dvi7: Double = UserDefaults.standard.double(forKey: "dvi7"){
               didSet{
                   UserDefaults.standard.set(self.dvi7, forKey: "dvi7")
               }
           }
           
           @Published var dvi8: Double = UserDefaults.standard.double(forKey: "dvi8"){
               didSet{
                   UserDefaults.standard.set(self.dvi8, forKey: "dvi8")
               }
           }
           
           @Published var dvi9: Double = UserDefaults.standard.double(forKey: "dvi9"){
               didSet{
                   UserDefaults.standard.set(self.dvi9, forKey: "dvi9")
               }
           }
           
           @Published var dvi10: Double = UserDefaults.standard.double(forKey: "dvi10"){
               didSet{
                   UserDefaults.standard.set(self.dvi10, forKey: "dvi10")
               }
           }
           
           @Published var dvi11: Double = UserDefaults.standard.double(forKey: "dvi11"){
               didSet{
                   UserDefaults.standard.set(self.dvi11, forKey: "dvi11")
               }
           }
           
           @Published var dvi12: Double = UserDefaults.standard.double(forKey: "dvi12"){
               didSet{
                   UserDefaults.standard.set(self.dvi12, forKey: "dvi12")
               }
           }
           
           @Published var dvi13: Double = UserDefaults.standard.double(forKey: "dvi13"){
               didSet{
                   UserDefaults.standard.set(self.dvi13, forKey: "dvi13")
               }
           }
           
           @Published var dvi14: Double = UserDefaults.standard.double(forKey: "dvi14"){
               didSet{
                   UserDefaults.standard.set(self.dvi14, forKey: "dvi14")
               }
           }
           
           @Published var dvi15: Double = UserDefaults.standard.double(forKey: "dvi15"){
               didSet{
                   UserDefaults.standard.set(self.dvi15, forKey: "dvi15")
               }
           }
           
           @Published var dvi16: Double = UserDefaults.standard.double(forKey: "dvi16"){
               didSet{
                   UserDefaults.standard.set(self.dvi16, forKey: "dvi16")
               }
           }
           
           @Published var dvi17: Double = UserDefaults.standard.double(forKey: "dvi17"){
               didSet{
                   UserDefaults.standard.set(self.dvi17, forKey: "dvi17")
               }
           }
           
           @Published var dvi18: Double = UserDefaults.standard.double(forKey: "dvi18"){
               didSet{
                   UserDefaults.standard.set(self.dvi18, forKey: "dvi18")
               }
           }
           
           @Published var dvi19: Double = UserDefaults.standard.double(forKey: "dvi19"){
               didSet{
                   UserDefaults.standard.set(self.dvi19, forKey: "dvi19")
               }
           }
           
           @Published var dvi20: Double = UserDefaults.standard.double(forKey: "dvi20"){
               didSet{
                   UserDefaults.standard.set(self.dvi20, forKey: "dvi20")
               }
           }
           
           @Published var dvi21: Double = UserDefaults.standard.double(forKey: "dvi21"){
               didSet{
                   UserDefaults.standard.set(self.dvi21, forKey: "dvi21")
               }
           }
           
           @Published var dvi22: Double = UserDefaults.standard.double(forKey: "dvi22"){
               didSet{
                   UserDefaults.standard.set(self.dvi22, forKey: "dvi22")
               }
           }
           
           @Published var dvi23: Double = UserDefaults.standard.double(forKey: "dvi23"){
               didSet{
                   UserDefaults.standard.set(self.dvi23, forKey: "dvi23")
               }
           }
           
           @Published var dvi24: Double = UserDefaults.standard.double(forKey: "dvi24"){
               didSet{
                   UserDefaults.standard.set(self.dvi24, forKey: "dvi24")
               }
           }
           
           @Published var dvi25: Double = UserDefaults.standard.double(forKey: "dvi25"){
               didSet{
                   UserDefaults.standard.set(self.dvi25, forKey: "dvi25")
               }
           }
           
           @Published var dvi26: Double = UserDefaults.standard.double(forKey: "dvi26"){
               didSet{
                   UserDefaults.standard.set(self.dvi26, forKey: "dvi26")
               }
           }
           
           @Published var dvi27: Double = UserDefaults.standard.double(forKey: "dvi27"){
               didSet{
                   UserDefaults.standard.set(self.dvi27, forKey: "dvi27")
               }
           }
           
           @Published var dvi28: Double = UserDefaults.standard.double(forKey: "dvi28"){
               didSet{
                   UserDefaults.standard.set(self.dvi28, forKey: "dvi28")
               }
           }
           
           @Published var dvi29: Double = UserDefaults.standard.double(forKey: "dvi29"){
               didSet{
                   UserDefaults.standard.set(self.dvi29, forKey: "dvi29")
               }
           }
           
           @Published var dvi30: Double = UserDefaults.standard.double(forKey: "dvi30"){
               didSet{
                   UserDefaults.standard.set(self.dvi30, forKey: "dvi30")
               }
           }
           
           @Published var dvi31: Double = UserDefaults.standard.double(forKey: "dvi31"){
               didSet{
                   UserDefaults.standard.set(self.dvi31, forKey: "dvi31")
               }
           }
           
           @Published var dvi32: Double = UserDefaults.standard.double(forKey: "dvi32"){
               didSet{
                   UserDefaults.standard.set(self.dvi32, forKey: "dvi32")
               }
           }
           
           @Published var dvi33: Double = UserDefaults.standard.double(forKey: "dvi33"){
               didSet{
                   UserDefaults.standard.set(self.dvi33, forKey: "dvi33")
               }
           }
           
           @Published var dvi34: Double = UserDefaults.standard.double(forKey: "dvi34"){
               didSet{
                   UserDefaults.standard.set(self.dvi34, forKey: "dvi34")
               }
           }
}
