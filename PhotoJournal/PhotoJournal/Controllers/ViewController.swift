//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 1/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
//    var imagePickerController = UIImagePickerController()
    
//    private var selectedImage: UIImage? {
//          didSet {
//
//          }
//      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
//        imagePickerController.delegate = self
        
    }
    
    
    
    
    @IBAction func newEvent(segue: UIStoryboardSegue) {
        
        guard segue.source is PostViewController else {
            fatalError("failed to access CreateEventController")
        }
        
    }
    
    
    @IBAction func settings(_ sender: UIButton) {
        print("button cliked")
        let alertAction = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: nil)
        let editAction = UIAlertAction(title: "Edit", style: .default) { (action) in
            let downloadView = self.storyboard?.instantiateViewController(withIdentifier: "down") as! PostViewController
            self.present(downloadView, animated:true, completion:nil)
        }
        
        let shareAction = UIAlertAction(title: "Share", style: .default)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertAction.addAction(deleteAction)
        alertAction.addAction(editAction)
        alertAction.addAction(shareAction)
        alertAction.addAction(cancelAction)
        present(alertAction, animated: true)
    }
    
    func showEditViewController() {
        
    }
    
    
//    private func showImageController(isCameraSelected: Bool) {
//        // source type default will be .photosLibrary
//        imagePickerController.sourceType = .photoLibrary
//
//        if isCameraSelected {
//            imagePickerController.sourceType = .camera
//        }
//        present(imagePickerController, animated: true)
//    }

    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

