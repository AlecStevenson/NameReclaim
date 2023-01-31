//
//  ViewController.swift
//  NameReclaim
//
//  Created by alec stevenson on 10/11/22.
//


import UIKit
import SwiftUI
 
 class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
     @IBOutlet weak var saveImageView: UIImageView!
     @IBOutlet weak var fetchImageView: UIImageView!
 
     override func viewDidLoad() {
         super.viewDidLoad()
 
         let textField = UITextField(frame: CGRect(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.size.width)!, height: 30))
         textField.borderStyle = .roundedRect
 
 
         self.navigationItem.titleView = textField
 
     }
     
     @IBAction func saveImageButtonPressed(_ sender: UIButton) {
         
     }
     
     @IBAction func fetchImageButtonPressed(_ sender: UIButton) {
         
     }
     
     @objc func cameraButtonPressed() {
         let picker = UIImagePickerController()
         picker.delegate = self
         picker.allowsEditing = true
         picker.sourceType = .photoLibrary
         present(picker, animated: true)
     }
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         guard let userPickedImage = info[.editedImage] as? UIImage else { return }
         saveImageView.image = userPickedImage
         picker.dismiss(animated: true)
     }
 
 }

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
}




