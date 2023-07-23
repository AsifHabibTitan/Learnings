//
//  ViewController.swift
//  CollectionViewTask2
//
//  Created by Asif Habib on 17/07/23.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    @IBOutlet weak var customCell: UICollectionViewCell!
    @IBOutlet weak var collectionView: UICollectionView!
    
//    @IBOutlet weak var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: "collectionViewCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height / 3)
        collectionView.collectionViewLayout = layout
    }

}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("running 1")
        return 100
    }
}

extension ViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("calling second func")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
//        cell.setImage(from: "https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg")
//
//        cell.cellLabel.text = String("Image \(indexPath.row + 1)")
//        cell.frame.size = CGSize(width: 100, height: 100)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.setImage(from: "https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg")
        cell.lbl.text = String(indexPath.row + 1)
        return cell
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        let height = (collectionView.frame.width - 30) / 3
        return CGSize(width: width, height: height)
    }
}
