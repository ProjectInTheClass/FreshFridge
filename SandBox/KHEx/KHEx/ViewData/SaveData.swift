//
//  SaveData.swift
//  KHEx
//
//  Created by Park Youngeun on 2021/05/06.
//

import Foundation

class MyInfo : ObservableObject{
    
    func TotalProgress(a1: Double, a2: Double, a3: Double, a4: Double, a5: Double) -> Double{
        let result = a1 + a2 + a3 + a4 + a5
        return result
    }
    
    
    
    func Progress(a: Double, b: Double, c: Double, d: Double, e: Double) -> Double{
        let result = a + b + c + d + e
        return result
    }
    

    
    
    
    
    
    @Published var ckOn1: Bool = UserDefaults.standard.bool(forKey: "ckOn1"){
        didSet{
            UserDefaults.standard.set(self.ckOn1, forKey: "ckOn1")
        }
    }
    
    @Published var ckOn2: Bool = UserDefaults.standard.bool(forKey: "ckOn2"){
        didSet{
            UserDefaults.standard.set(self.ckOn2, forKey: "ckOn2")
        }
    }
    
    @Published var ckOn3: Bool = UserDefaults.standard.bool(forKey: "ckOn3"){
        didSet{
            UserDefaults.standard.set(self.ckOn3, forKey: "ckOn3")
        }
    }
    
    @Published var ckOn4: Bool = UserDefaults.standard.bool(forKey: "ckOn4"){
        didSet{
            UserDefaults.standard.set(self.ckOn4, forKey: "ckOn4")
        }
    }
    
    @Published var ckOn5: Bool = UserDefaults.standard.bool(forKey: "ckOn5"){
        didSet{
            UserDefaults.standard.set(self.ckOn5, forKey: "ckOn5")
        }
    }
    
    
    
    
    
    @Published var detailprogress1: Double = UserDefaults.standard.double(forKey: "num1"){
        didSet{
            UserDefaults.standard.set(self.detailprogress1, forKey: "num1")
        }
    }
    
    @Published var detailprogress2: Double = UserDefaults.standard.double(forKey: "num2"){
        didSet{
            UserDefaults.standard.set(self.detailprogress2, forKey: "num2")
        }
    }
    @Published var detailprogress3: Double = UserDefaults.standard.double(forKey: "num3"){
        didSet{
            UserDefaults.standard.set(self.detailprogress3, forKey: "num3")
        }
    }
    @Published var detailprogress4: Double = UserDefaults.standard.double(forKey: "num4"){
        didSet{
            UserDefaults.standard.set(self.detailprogress4, forKey: "num4")
        }
    }
    @Published var detailprogress5: Double = UserDefaults.standard.double(forKey: "num5"){
        didSet{
            UserDefaults.standard.set(self.detailprogress5, forKey: "num5")
        }
    }
    
    
    
    
    
    
    
    
    
    
    @Published var totalvalue1: Double = UserDefaults.standard.double(forKey: "totalnum1"){
        didSet{
            UserDefaults.standard.set(self.totalvalue1, forKey: "totalnum1")
        }
    }
    
    @Published var totalvalue2: Double = UserDefaults.standard.double(forKey: "totalnum2"){
        didSet{
            UserDefaults.standard.set(self.totalvalue2, forKey: "totalnum2")
        }
    }
    
    @Published var totalvalue3: Double = UserDefaults.standard.double(forKey: "totalnum3"){
        didSet{
            UserDefaults.standard.set(self.totalvalue3, forKey: "totalnum3")
        }
    }
    
    @Published var totalvalue4: Double = UserDefaults.standard.double(forKey: "totalnum4"){
        didSet{
            UserDefaults.standard.set(self.totalvalue4, forKey: "totalnum4")
        }
    }
    
    @Published var totalvalue5: Double = UserDefaults.standard.double(forKey: "totalnum5"){
        didSet{
            UserDefaults.standard.set(self.totalvalue5, forKey: "totalnum5")
        }
    }
}
