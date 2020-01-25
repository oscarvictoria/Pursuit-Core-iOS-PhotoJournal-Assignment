//
//  PostViewController.swift
//  PhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 1/23/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import AVFoundation

class PostViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var photoLibraryImage: UIImageView!
    
    var imageObjects = [ImageObject]()
    
    var imagePickerController = UIImagePickerController()
    
    let dataPersistance = PersistenceHelper(filename: "images.plist")
    
    
//    private var selectedImage: UIImage? {
//        didSet {
//            appendNewPhotoToCollection()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        textView.delegate = self
        textView.text = "Enter photo description here"
        textView.textColor = UIColor.lightGray
        //        loadImageObjects()
        
    }
    
    private func loadImageObjects() {
        do {
            imageObjects = try dataPersistance.loadEvents()
        } catch {
            print("error")
        }
    }
    
//    func appendNewPhotoToCollection() {
//        guard let image = selectedImage else {
//            print("image is nil")
//            return
//        }
//
//        print("original image size is \(image.size)")
//
//        // the size for resizing of the image
//        //        let size = UIScreen.main.bounds.size
//        //        // we will maintain the aspect ratio of the image
//        //        let rec = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(origin: CGPoint.zero, size: size))
//
//        // resize image
//        //        let resizeImage = image.resizeImage(to: rec.size.width, height: rec.size.height)
//
//        //        print("new image size is \(resizeImage.size)")
//        guard let resizedImageData = image.jpegData(compressionQuality: 1.0) else {
//            return
//        }
//
//
//        // create an image object using the image selected
//        let imageObject = ImageObject(imageData: resizedImageData, date: Date())
//
//        // insert new imageObject into imageObjects
//        imageObjects.insert(imageObject, at: 0)
//
//
//        // create an indexPath for insertion into collection view
//
//        //        let indexPath = IndexPath(row: 0, section: 0)
//
//        // insert new cell into collection view
//        //        tableView.insertRows(at: [indexPath], with: .fade)
//        //        collectionView.insertItems(at: [indexPath])
//
//
//
//        // Persist imageObject to documents directory
//        do {
//            try dataPersistance.create(item: imageObject)
//        } catch {
//            print("saving error")
//        }
//    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        print("dismiss")
        dismiss(animated: true)
    }
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    @IBAction func photos(_ sender: UIBarButtonItem) {
        self.showImageController(isCameraSelected: false)
    }
    
    
    @IBAction func camera(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    
    private func showImageController(isCameraSelected: Bool) {
        // source type default will be .photosLibrary
        imagePickerController.sourceType = .photoLibrary
        
        if isCameraSelected {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true)
    }
}


extension  PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // we need to access the UIImagePickerController.InfoKey.orginalImage key tp get the UImage that was selected.
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("Image selected not found")
            return
        }
        photoLibraryImage.image = image
//        selectedImage = image
        
        dismiss(animated: true)
    }
}

extension PostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
           textView.textColor = UIColor.black
        }
    }
}
