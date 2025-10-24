//
//  ButtonViewController.swift
//  DGChartsPOC
//
//  Created by Asif Habib on 26/04/25.
//

import UIKit

class ButtonViewController: UIViewController {
    private var showNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        button.setTitle("Show Name", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Asif Habib"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(showNameButton)
        showNameButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        showNameButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        showNameButton.backgroundColor = .lightGray
        showNameButton.layer.cornerRadius = 10
        showNameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showNameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        showNameButton.addTarget(self, action: #selector(toggleLabel), for: .touchUpInside)
        
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: showNameButton.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc private func toggleLabel() {
        nameLabel.isHidden.toggle()
        let buttonTitle = nameLabel.isHidden ? "Show Name" : "Hide Name"
        showNameButton.setTitle(buttonTitle, for: .normal)
    }


}

#Preview {
    ButtonViewController()
}
