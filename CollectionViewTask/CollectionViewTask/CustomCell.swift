import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func nib() -> UINib {
          return UINib(nibName: "CustomCell", bundle: nil)
    }
    @IBOutlet weak var cellLabel: UILabel!
    func setImage(from urlString: String) {
        print("setting image")
            if let imageUrl = URL(string: urlString) {
                URLSession.shared.dataTask(with: imageUrl) { [weak self] (data, _, error) in
                    if let error = error {
                        print("Error downloading image: \(error)")
                        return
                    }
                    if let data = data, let image = UIImage(data: data) {
                        print("data loaded \(data)")
                        DispatchQueue.main.async {
                            self?.imageView.image = image
                        }
                    }
                }.resume()
            }
        }
}
