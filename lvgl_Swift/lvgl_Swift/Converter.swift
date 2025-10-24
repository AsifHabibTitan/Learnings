////
////  Converter.swift
////  lvgl_Swift
////
////  Created by Asif Habib on 05/08/24.
////
//
//import Foundation
//import UIKit
//
//enum ImageMode: String {
//    case ICF_TRUE_COLOR_ARGB8332
//    case ICF_TRUE_COLOR_ARGB8565
//    case ICF_TRUE_COLOR_ARGB8565_RBSWAP
//    case ICF_TRUE_COLOR_ARGB8888
//    case CF_ALPHA_1_BIT
//    case CF_ALPHA_2_BIT
//    case CF_ALPHA_4_BIT
//    case CF_ALPHA_8_BIT
//    case CF_INDEXED_1_BIT
//    case CF_INDEXED_2_BIT
//    case CF_INDEXED_4_BIT
//    case CF_INDEXED_8_BIT
//    case CF_RAW
//    case CF_RAW_CHROMA
//    case CF_RAW_ALPHA
//    case CF_TRUE_COLOR
//    case CF_TRUE_COLOR_ALPHA
//    case CF_TRUE_COLOR_CHROMA
//    case CF_RGB565A8
//}
//
//struct ConverterOptions {
//    var cf: ImageMode
//    var outputFormat: OutputMode
//    var binaryFormat: ImageMode
//    var outName: String
//}
//
//enum OutputMode {
//    case C
//    case BIN
//}
//
//class Converter {
//    var w: Int
//    var h: Int
//    var raw_len: Int
//    var cf: ImageMode
//    var outputFormat: OutputMode
//    var alpha: Bool
//    var chroma: Bool
//    var d_out: [UInt8]
//    var imageData: [UInt8]
//    var options: ConverterOptions
//    var r_act: Int
//    var b_act: Int
//    var g_act: Int
//    var r_earr: [Int]
//    var g_earr: [Int]
//    var b_earr: [Int]
//    var r_nerr: Int
//    var g_nerr: Int
//    var b_nerr: Int
//    var pass: Int
//
//    init(w: Int, h: Int, imageData: [UInt8], alpha: Bool, options: ConverterOptions) {
//        self.w = w
//        self.h = h
//        self.imageData = imageData
//        self.r_earr = []
//        self.g_earr = []
//        self.b_earr = []
//        self.r_nerr = 0
//        self.g_nerr = 0
//        self.b_nerr = 0
//        self.pass = 0
//        self.cf = options.cf
//        self.alpha = alpha
//        self.outputFormat = options.outputFormat
//        self.options = options
//        self.d_out = []
//        self.r_act = 0
//        self.g_act = 0
//        self.b_act = 0
//        self.raw_len = 0
//        self.chroma = false
//    }
//
//    func getNumPasses() -> Int {
//        return (self.cf == .CF_RGB565A8) ? 2 : 1
//    }
//
//    func convert() async -> Data {
//        var needsFormatSwap = (self.outputFormat == .BIN && ImageModeUtil.isTrueColor(mode: self.cf))
//        var oldColorFormat = self.cf
//        
//        if needsFormatSwap {
//            self.cf = self.options.binaryFormat
//        }
//        
//        for pass in 0..<self.getNumPasses() {
//            for y in 0..<self.h {
//                self.dith_reset()
//                for x in 0..<self.w {
//                    self.conv_px(x: x, y: y)
//                }
//            }
//        }
//        
//        if needsFormatSwap {
//            self.cf = oldColorFormat
//        }
//        
//        let header32Bit = UInt32((4 | (self.w << 10) | (self.h << 21)) & 0xFFFFFFFF)
//        var finalBinary = Data(count: self.d_out.count + 4)
//        finalBinary[0] = UInt8((header32Bit & 0xFF))
//        finalBinary[1] = UInt8((header32Bit & 0xFF00) >> 8)
//        finalBinary[2] = UInt8((header32Bit & 0xFF0000) >> 16)
//        finalBinary[3] = UInt8((header32Bit & 0xFF000000) >> 24)
//        
//        for (index, value) in self.d_out.enumerated() {
//            finalBinary[index + 4] = value
//        }
//        
//        return finalBinary
//    }
//
//    private func conv_px(x: Int, y: Int) {
//        let startIndex = ((y * self.w) + x) * 4
//        let a = self.alpha ? self.imageData[startIndex + 3] : 0xff
//        let r = self.imageData[startIndex]
//        let g = self.imageData[startIndex + 1]
//        let b = self.imageData[startIndex + 2]
//        
//        if self.cf == .ICF_TRUE_COLOR_ARGB8565 || self.cf == .ICF_TRUE_COLOR_ARGB8565_RBSWAP {
//            self.dith_next(r: Int(r), g: Int(g), b: Int(b), x: x)
//        }
//
//        if self.cf == .ICF_TRUE_COLOR_ARGB8565_RBSWAP {
//            let c16 = (UInt16(self.r_act) << 8) | (UInt16(self.g_act) << 3) | (UInt16(self.b_act) >> 3)
//            self.d_out.append(UInt8((c16 >> 8) & 0xFF))
//            self.d_out.append(UInt8(c16 & 0xFF))
//            if self.alpha {
//                self.d_out.append(a)
//            }
//        }
//    }
//
//    private func dith_reset() {
//        if self.options.dith {
//            self.r_nerr = 0
//            self.g_nerr = 0
//            self.b_nerr = 0
//        }
//    }
//
//    private func dith_next(r: Int, g: Int, b: Int, x: Int) {
//        if self.options.dith {
//            self.r_act = r + self.r_nerr + self.r_earr[x + 1]
//            self.r_earr[x + 1] = 0
//            self.g_act = g + self.g_nerr + self.g_earr[x + 1]
//            self.g_earr[x + 1] = 0
//            self.b_act = b + self.b_nerr + self.b_earr[x + 1]
//            self.b_earr[x + 1] = 0
//
//            if self.cf == .ICF_TRUE_COLOR_ARGB8332 {
//                self.r_act = self.classify_pixel(px: self.r_act, classifyBits: 3)
//                self.g_act = self.classify_pixel(px: self.g_act, classifyBits: 3)
//                self.b_act = self.classify_pixel(px: self.b_act, classifyBits: 2)
//            } else if self.cf == .ICF_TRUE_COLOR_ARGB8565 || self.cf == .ICF_TRUE_COLOR_ARGB8565_RBSWAP {
//                self.r_act = self.classify_pixel(px: self.r_act, classifyBits: 5)
//                self.g_act = self.classify_pixel(px: self.g_act, classifyBits: 6)
//                self.b_act = self.classify_pixel(px: self.b_act, classifyBits: 5)
//            }
//
//            self.r_nerr = r - self.r_act
//            self.g_nerr = g - self.g_act
//            self.b_nerr = b - self.b_act
//            self.r_earr[x + 1] = self.r_nerr
//            self.g_earr[x + 1] = self.g_nerr
//            self.b_earr[x + 1] = self.b_nerr
//        } else {
//            self.r_act = r
//            self.g_act = g
//            self.b_act = b
//        }
//    }
//
//    private func classify_pixel(px: Int, classifyBits: Int) -> Int {
//        let step = 255 / ((1 << classifyBits) - 1)
//        return round_half_up(value: Double(px) / Double(step)) * step
//    }
//}
//
//class ImageModeUtil {
//    static func isTrueColor(mode: ImageMode) -> Bool {
//        return mode.rawValue.hasPrefix("CF_TRUE_COLOR")
//    }
//}
//
//func round_half_up(value: Double) -> Int {
//    return Int(value.rounded(.toNearestOrEven))
//}



import UIKit

// Round half up function
func roundHalfUp(value: Float) -> Int {
    return Int(value.rounded(.toNearestOrEven))
}

// Enum for ImageMode
enum ImageMode: UInt32 {
    case ICF_TRUE_COLOR_ARGB8332 = 0
    case ICF_TRUE_COLOR_ARGB8565 = 1
    case ICF_TRUE_COLOR_ARGB8565_RBSWAP = 2
    case ICF_TRUE_COLOR_ARGB8888 = 3
    case CF_ALPHA_1_BIT = 4
    case CF_ALPHA_2_BIT = 5
    case CF_ALPHA_4_BIT = 6
    case CF_ALPHA_8_BIT = 7
    case CF_INDEXED_1_BIT = 8
    case CF_INDEXED_2_BIT = 9
    case CF_INDEXED_4_BIT = 10
    case CF_INDEXED_8_BIT = 11
    case CF_RAW = 12
    case CF_RAW_CHROMA = 13
    case CF_RAW_ALPHA = 14
    case CF_TRUE_COLOR = 15
    case CF_TRUE_COLOR_ALPHA = 16
    case CF_TRUE_COLOR_CHROMA = 17
    case CF_RGB565A8 = 18
}

// Enum for OutputMode
enum OutputMode {
    case C
    case BIN
}

class ImageModeUtil {
    static func isTrueColor(mode: ImageMode) -> Bool {
        switch mode {
        case .ICF_TRUE_COLOR_ARGB8332, .ICF_TRUE_COLOR_ARGB8565, .ICF_TRUE_COLOR_ARGB8565_RBSWAP, .ICF_TRUE_COLOR_ARGB8888, .CF_TRUE_COLOR, .CF_TRUE_COLOR_ALPHA, .CF_TRUE_COLOR_CHROMA:
            return true
        default:
            return false
        }
    }
}

// Struct for ConverterOptions
struct ConverterOptions {
    var dith: Bool
    var cf: ImageMode
    var outputFormat: OutputMode
    var binaryFormat: ImageMode
    var swapEndian: Bool
    var outName: String
    var useLegacyFooterOrder: Bool
    var use565A8alpha: Bool
    var overrideWidth: Int?
    var overrideHeight: Int?
}

// Class for Converter
class Converter {
    var w: Int
    var h: Int
    var cf: ImageMode
    var outputFormat: OutputMode
    var alpha: Bool
    var options: ConverterOptions
    var dOut: [UInt8]
    var imageData: [UInt8]
    var rAct: Int
    var gAct: Int
    var bAct: Int
    var rEarr: [Int]
    var gEarr: [Int]
    var bEarr: [Int]
    var rNerr: Int
    var gNerr: Int
    var bNerr: Int
    var pass: Int
    
    init(w: Int, h: Int, imageData: [UInt8], alpha: Bool, options: ConverterOptions) {
        self.w = w
        self.h = h
        self.imageData = imageData
        print("got image data as:", imageData)
        self.alpha = alpha
        self.cf = options.cf
        self.outputFormat = options.outputFormat
        self.options = options
        self.dOut = []
        self.rAct = 0
        self.gAct = 0
        self.bAct = 0
        self.rEarr = Array(repeating: 0, count: w + 2)
        self.gEarr = Array(repeating: 0, count: w + 2)
        self.bEarr = Array(repeating: 0, count: w + 2)
        self.rNerr = 0
        self.gNerr = 0
        self.bNerr = 0
        self.pass = 0
    }
    
    func getNumPasses() -> Int {
        return self.cf == .CF_RGB565A8 ? 2 : 1
    }
    
    func convert() async -> Data? {
        self.dOut = []
        
        var oldColorFormat: ImageMode?
        let needsFormatSwap = self.outputFormat == .BIN && ImageModeUtil.isTrueColor(mode: self.cf)
        print("need format swap? :", needsFormatSwap)
        if needsFormatSwap {
            oldColorFormat = self.cf
            self.cf = self.options.binaryFormat
        }
        
        for y in 0..<self.h {
            self.dithReset()
            for x in 0..<self.w {
                self.convPx(x: x, y: y)
            }
        }
        
        if needsFormatSwap {
            if let oldColorFormat = oldColorFormat {
                self.cf = oldColorFormat
            }
        }
        
//        var header32Bit: UInt32 = 0
//        header32Bit |= UInt32(self.cf.rawValue) & 0xFF
//        header32Bit |= (UInt32(self.w) << 10) & 0xFFFC00
//        header32Bit |= (UInt32(self.h) << 21) & 0xFFE00000
        let lv_cf = 4
        let header32Bit = UInt32(lv_cf) | (UInt32(self.w) << 10) | (UInt32(self.h) << 21)

//        var finalBinary = Data(capacity: self.dOut.count + 4)
        var finalBinary = [UInt8](repeating: 0, count: 4)
//        finalBinary.append(UInt8((header32Bit >> 0) & 0xFF))
//        finalBinary.append(UInt8((header32Bit >> 8) & 0xFF))
//        finalBinary.append(UInt8((header32Bit >> 16) & 0xFF))
//        finalBinary.append(UInt8((header32Bit >> 24) & 0xFF))

        finalBinary[0] = UInt8(header32Bit & 0xFF)
        finalBinary[1] = UInt8((header32Bit & 0xFF00) >> 8)
        finalBinary[2] = UInt8((header32Bit & 0xFF0000) >> 16)
        finalBinary[3] = UInt8((header32Bit & 0xFF000000) >> 24)
        finalBinary.append(contentsOf: self.dOut)
        let finalData = Data(finalBinary)
        print("returning finalBinary: ", finalData)
        return Data(finalData)
    }
    
    private func convPx(x: Int, y: Int) {
        let startIndex = ((y * self.w) + x) * 4
        let r = Int(self.imageData[startIndex])
        let g = Int(self.imageData[startIndex + 1])
        let b = Int(self.imageData[startIndex + 2])
        let a = self.alpha ? Int(self.imageData[startIndex + 3]) : 0xFF
        
        if self.cf == .ICF_TRUE_COLOR_ARGB8565 || self.cf == .ICF_TRUE_COLOR_ARGB8565_RBSWAP || self.cf == .ICF_TRUE_COLOR_ARGB8332 || self.cf == .ICF_TRUE_COLOR_ARGB8888 || self.cf == .CF_RGB565A8 {
            print("calling dithNext with r,g,b,x, w", r,g,b,x, self.w)
            self.dithNext(r: r, g: g, b: b, x: x)
        }
        
        if self.cf == .ICF_TRUE_COLOR_ARGB8565_RBSWAP {
            let c16 = ((self.rAct << 8) | (self.gAct << 3) | (self.bAct >> 3))
            self.dOut.append(UInt8((c16 >> 8) & 0xFF))
            self.dOut.append(UInt8(c16 & 0xFF))
            if self.alpha {
                self.dOut.append(UInt8(a))
            }
        }
//        print("after conv_px:", self.dOut)
    }
    
    private func dithReset() {
        if self.options.dith {
            self.rNerr = 0
            self.gNerr = 0
            self.bNerr = 0
        }
    }
    
    private func dithNext(r: Int, g: Int, b: Int, x: Int) {
        if self.options.dith {
            self.rAct = r + self.rNerr + self.rEarr[x + 1]
            self.gAct = g + self.gNerr + self.gEarr[x + 1]
            self.bAct = b + self.bNerr + self.bEarr[x + 1]
            self.rEarr[x + 1] = 0
            self.gEarr[x + 1] = 0
            self.bEarr[x + 1] = 0
            self.rNerr = r - self.rAct
            self.gNerr = g - self.gAct
            self.bNerr = b - self.bAct
            self.rNerr = roundHalfUp(value: Float(7 * self.rNerr) / 16)
            self.gNerr = roundHalfUp(value: Float(7 * self.gNerr) / 16)
            self.bNerr = roundHalfUp(value: Float(7 * self.bNerr) / 16)
            self.rEarr[x] += roundHalfUp(value: Float(3 * self.rNerr) / 16)
            self.gEarr[x] += roundHalfUp(value: Float(3 * self.gNerr) / 16)
            self.bEarr[x] += roundHalfUp(value: Float(3 * self.bNerr) / 16)
            self.rEarr[x + 1] += roundHalfUp(value: Float(5 * self.rNerr) / 16)
            self.gEarr[x + 1] += roundHalfUp(value: Float(5 * self.gNerr) / 16)
            self.bEarr[x + 1] += roundHalfUp(value: Float(5 * self.bNerr) / 16)
            self.rEarr[x + 2] += roundHalfUp(value: Float(self.rNerr) / 16)
            self.gEarr[x + 2] += roundHalfUp(value: Float(self.gNerr) / 16)
            self.bEarr[x + 2] += roundHalfUp(value: Float(self.bNerr) / 16)
        } else {
            if self.cf == .ICF_TRUE_COLOR_ARGB8332 {
                self.rAct = self.classifyPixel(value: r, bits: 3)
                self.gAct = self.classifyPixel(value: g, bits: 3)
                self.bAct = self.classifyPixel(value: b, bits: 2)
                if self.rAct > 0xE0 { self.rAct = 0xE0 }
                if self.gAct > 0xE0 { self.gAct = 0xE0 }
                if self.bAct > 0xC0 { self.bAct = 0xC0 }
            } else if self.cf == .ICF_TRUE_COLOR_ARGB8565 || self.cf == .ICF_TRUE_COLOR_ARGB8565_RBSWAP || self.cf == .CF_RGB565A8 {
                self.rAct = self.classifyPixel(value: r, bits: 5)
                self.gAct = self.classifyPixel(value: g, bits: 6)
                self.bAct = self.classifyPixel(value: b, bits: 5)
                if self.rAct > 0xF8 { self.rAct = 0xF8 }
                if self.gAct > 0xFC { self.gAct = 0xFC }
                if self.bAct > 0xF8 { self.bAct = 0xF8 }
            } else if self.cf == .ICF_TRUE_COLOR_ARGB8888 {
                self.rAct = self.classifyPixel(value: r, bits: 8)
                self.gAct = self.classifyPixel(value: g, bits: 8)
                self.bAct = self.classifyPixel(value: b, bits: 8)
                if self.rAct > 0xFF { self.rAct = 0xFF }
                if self.gAct > 0xFF { self.gAct = 0xFF }
                if self.bAct > 0xFF { self.bAct = 0xFF }
            }
            print("after dithNext: ract, gact, bact", self.rAct, self.gAct, self.bAct)
        }
    }
    
//    private func classifyPixel(value: Int, bits: Int) -> Int {
//        let maxVal = (1 << bits) - 1
//        return roundHalfUp(value: Float(value) * Float(maxVal) / 255.0)
//    }
    private func classifyPixel(value: Int, bits: Int) -> Int {
        let tmp = 1 << (8 - bits)  // Calculate the quantization factor
//        var val = (value + tmp / 2) / tmp * tmp  // Quantize the value and round it
        var val = Int(round(Float(value) / Float(tmp))) * tmp
        if val < 0 { val = 0 }  // Ensure the value is not less than 0
        return val
    }
}

// Function to load image and get its pixel data
func loadImageData(image: UIImage) -> [UInt8]? {
    guard let cgImage = image.cgImage else { return nil }
    
    let width = cgImage.width
    let height = cgImage.height
    let bitsPerComponent = 8
    let bytesPerPixel = 4
    let bytesPerRow = bytesPerPixel * width
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    var rawData = [UInt8](repeating: 0, count: height * bytesPerRow)
    
    let context = CGContext(
        data: &rawData,
        width: width,
        height: height,
        bitsPerComponent: bitsPerComponent,
        bytesPerRow: bytesPerRow,
        space: colorSpace,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    )
    
    context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    
    return rawData
}

// Function to get image from bundle
func loadImageFromBundle(named imageName: String) -> UIImage? {
    if let imagePath = Bundle.main.path(forResource: imageName, ofType: "png"),
       let image = UIImage(contentsOfFile: imagePath) {
        return image
    }
    return nil
}
