//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 1/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataPersistance = PersistenceHelper(filename: "images.plist")
    
    var photoObjects = [ImageObject]()
    
    var someImageObject: ImageObject?
    

    var selectedImage: UIImage?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadImageObjects()
    }
    
    private func loadImageObjects() {
         do {
             photoObjects = try dataPersistance.loadEvents()
         } catch {
             print("error")
         }
     }
    
    @IBAction func newEvent(segue: UIStoryboardSegue) {
        guard let photo = segue.source as? PostViewController else {
            fatalError("failed to access CreateEventController")
        }
        
        photoObjects = photo.imageObjects
        
    
//        selectedImage = photo.photoLibraryImage.image
    }
    
    @IBAction func settings(_ sender: UIButton) {
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
    

    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoObjects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoCell else {
            fatalError("error")
        }
        cell.photoImageView.image = selectedImage
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}

