//
//  CollectionViewCell.swift
//  CollectionViewTask2
//
//  Created by Asif Habib on 18/07/23.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lbl: UILabel!
    
    static func nib() -> UINib {
          return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    public func setImage(from urlStr: String) {
        
        imageView.sd_setImage(with: URL(string: urlStr), placeholderImage: UIImage(), options: .refreshCached) { (image,error,cacheType,imageURL) in
            if let image = image, error == nil {
                print("cachetype: \(cacheType), imgurl: \(imageURL!)")
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
