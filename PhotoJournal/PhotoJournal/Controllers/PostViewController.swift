//
//  PostViewController.swift
//  PhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 1/23/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var imagePickerController = UIImagePickerController()
    

    private var selectedImage: UIImage? {
          didSet {
              
          }
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        imagePickerController.delegate = self
       
    }
    
    
    
    private func showImageController(isCameraSelected: Bool) {
        // source type default will be .photosLibrary
        imagePickerController.sourceType = .photoLibrary
        
        if isCameraSelected {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }


    @IBAction func cancel(_ sender: UIBarButtonItem) {
        print("dismiss")
        dismiss(animated: true, completion: nil)
    }

    

}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? PhotoCell else {
            fatalError("error")
        }
        return cell
    }
}

extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension  PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // we need to access the UIImagePickerController.InfoKey.orginalImage key tp get the UImage that was selected.
//        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
//            print("Image selected not found")
//            return
//        }
//        selectedImage = image

        dismiss(animated: true)
    }
}

