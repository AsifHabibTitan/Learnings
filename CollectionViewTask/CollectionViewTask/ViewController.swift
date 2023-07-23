import UIKit

class ViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    var img = UIImage() // used if we want to set image only once
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 120, height: 120)
        collectionView.collectionViewLayout = layout
        collectionView.register(CustomCell.nib(), forCellWithReuseIdentifier: "CustomCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // try loading image once only
//        self.setImage(from: "https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg")
    }
    func setImage(from urlString: String) {
            if let imageUrl = URL(string: urlString) {
                URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, _, error) in
                    if let error = error {
                        print("Error downloading image: \(error)")
                        return
                    }
                    if let data = data, let image = UIImage(data: data) {
                        print("data loaded \(data)")
                        DispatchQueue.main.async {
                            self?.img = image
                        }
                    }
                }.resume()
            }
        }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("you tapped item at \(indexPath)")
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.layer.borderColor = UIColor.black.cgColor
        cell.setImage(from: "https://cdn.arstechnica.net/wp-content/uploads/2018/06/macOS-Mojave-Dynamic-Wallpaper-transition.jpg")
//        cell.imageView.image = self.img   // use when setting image only once
        cell.cellLabel.text = String("Image \(indexPath.row + 1)")
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        let height = (collectionView.frame.height - 30) / 3
         return CGSize(width: width, height: height)
    }
}

