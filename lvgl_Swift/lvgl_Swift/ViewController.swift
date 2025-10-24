//
//  ViewController.swift
//  lvgl_Swift
//
//  Created by Asif Habib on 05/08/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Example usage
        if let image = loadImageFromBundle(named: "dog"), let imageData = loadImageData(image: image) {

            let options = ConverterOptions(
                dith: false,
                cf: .CF_TRUE_COLOR,
                outputFormat: .BIN,
                binaryFormat: .ICF_TRUE_COLOR_ARGB8565_RBSWAP,
                swapEndian: false,
                outName: "example_output",
                useLegacyFooterOrder: false,
                use565A8alpha: false,
                overrideWidth: nil,
                overrideHeight: nil
            )

            let converter = Converter(w: Int(image.size.width), h: Int(image.size.height), imageData: imageData, alpha: false, options: options)
            
            if let imageView = createImageView(from: image) {
                // Add the image view to the view controller's view
                self.view.addSubview(imageView)
                imageView.center = self.view.center
                        }
            Task {
                if let binaryData = await converter.convert() as? Data {
                    // Save binaryData to file or use it as needed
                    let binaryFilePath = FileManager.default.temporaryDirectory.appendingPathComponent("output.bin")
                    do {
                        try binaryData.write(to: binaryFilePath)
                        print("Binary file saved to \(binaryFilePath.path)")
                    } catch {
                        print("Failed to save binary file: \(error)")
                    }
                }
            }
            
        } else {
            print("Failed to load image or extract image data.")
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
            bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        )
//        print(">> rawData after context :", rawData)
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        print(">> rawData after context.draw :", rawData)
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

    func createImageView(from image: UIImage) -> UIImageView? {
            guard let imageData = loadImageData(image: image) else { return nil }
            
            // Convert the raw image data back into a UIImage
            let width = Int(image.size.width)
            let height = Int(image.size.height)
            let bytesPerPixel = 4
            let bytesPerRow = bytesPerPixel * width
            
            let colorSpace = CGColorSpace(name: CGColorSpace.sRGB)!
            let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
            
            guard let dataProvider = CGDataProvider(data: NSData(bytes: imageData, length: imageData.count)) else { return nil }
            guard let cgImage = CGImage(
                width: width,
                height: height,
                bitsPerComponent: 8,
                bitsPerPixel: 32,
                bytesPerRow: bytesPerRow,
                space: colorSpace,
                bitmapInfo: CGBitmapInfo(rawValue: bitmapInfo),
                provider: dataProvider,
                decode: nil,
                shouldInterpolate: true,
                intent: .defaultIntent
            ) else { return nil }
            
            let newImage = UIImage(cgImage: cgImage)
            
            // Create and return an image view with the new image
            let imageView = UIImageView(image: newImage)
            imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
            return imageView
        }
    }




