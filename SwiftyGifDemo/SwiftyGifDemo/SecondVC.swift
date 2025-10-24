//
//  SecondVC.swift
//  SwiftyGifDemo
//
//  Created by Asif Habib on 09/08/23.
//

import UIKit

class SecondVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("secondVC")
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    

}

extension SecondVC: UICollectionViewDelegate {
    
}
extension SecondVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        do {
            let gif = try UIImage(gifName: "lol.gif", levelOfIntegrity: 1)
            cell.imageView.setGifImage(gif)
        } catch {
            print(error)
        }
        return cell
    }
    
    
}

extension SecondVC: UICollectionViewDelegateFlowLayout {
//    let layout = UICollectionViewFlowLayout()
//    layout.itemSize = CGSize(width: 300, height: 300)
//    layout.minimumInteritemSpacing = 10
//    layout.minimumLineSpacing = 10
//    collectionView?.collectionViewLayout = layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

