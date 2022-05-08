//
//  ViewController.swift
//  SpacePhoto-LAB
//
//  Created by Jadson on 8/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    let photoInfoController = PhotoInfoController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        photoInfoController.fetchPhotoInfo { photoInfo in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        guard let url = photoInfo.url.withHTTPS() else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.title = photoInfo.title
                    self.photoImageView.image = image
                    self.descriptionLabel.text = photoInfo.description
                    if let copyright = photoInfo.copyright {
                        self.copyrightLabel.text = copyright
                    } else {
                        self.copyrightLabel.isHidden = true
                    }
                }
            }
        }
        
        task.resume()
    }
    
    
    
}

