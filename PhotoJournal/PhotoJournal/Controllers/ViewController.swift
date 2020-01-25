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
    
    private var selectedImage: UIImage? {
          didSet {
              appendNewPhotoToCollection()
          }
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
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
//        let photos = photoObjects[indexPath.row]
       
        print("Can pass data?")
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
    
    func appendNewPhotoToCollection() {
        guard let image = selectedImage else {
            print("image is nil")
            return
        }
        
        print("original image size is \(image.size)")
        
        // the size for resizing of the image
//        let size = UIScreen.main.bounds.size
//        // we will maintain the aspect ratio of the image
//        let rec = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
        
        // resize image
//        let resizeImage = image.resizeImage(to: rec.size.width, height: rec.size.height)
        
//        print("new image size is \(resizeImage.size)")
        guard let resizedImageData = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        
        // create an image object using the image selected
        let imageObject = ImageObject(imageData: resizedImageData, date: Date())
        
        // insert new imageObject into imageObjects
        photoObjects.insert(imageObject, at: 0)
        
        // create an indexPath for insertion into collection view
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        // insert new cell into collection view
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        // Persist imageObject to documents directory
        do {
            try dataPersistance.create(item: imageObject)
        } catch {
            print("saving error")
        }
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

