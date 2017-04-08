//
//  NEPhotoDetailViewController.swift
//  CS51-Demo
//
//  Created by Nathan Eidelson on 3/26/17.
//  Copyright © 2017 Nathan Eidelson. All rights reserved.
//

import UIKit

class NEPhotoLogDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    // A photo log is * optional *
    // If a photo log is defined, we display it and prevent all updates.
    // If a photo log is not defined, we allow the user to create and update the photo.
    var photoLog: PhotoLog?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var uploadFromCameraRollButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.nameTextField.delegate = self
        self.notesTextView.delegate =  self
    }

    override func viewWillAppear(_ animated: Bool) {
        // This function is called AFTER the segue
        if let photoLog = self.photoLog {
            // If a photo log already exists, we set all the fields
            self.nameTextField.text = photoLog.name
            self.setImage(image: photoLog.image)
            if let notes = photoLog.notes {
                self.notesTextView.text = notes
            }
        } else {
            // Otherwise we enable editing
            self.nameTextField.isUserInteractionEnabled = true
            self.notesTextView.isEditable = true
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(NEPhotoLogDetailViewController.onDoneClick))
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // This will cause the keyboard to close when the user hits done/enter
        self.view.endEditing(true)
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // This will cause the keyboard to close when the user hits done/enter
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func onDoneClick() {
        guard
            let image = self.imageView.image,
            let name = self.nameTextField.text,
            let notes = self.notesTextView.text
        else {
            self.dismiss(animated: true, completion: nil)
            return
        }

        // This create method is left incomplete for you to finish if interested.
        PhotoLog.create(image: image, name: name, notes: notes)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
        self.uploadFromCameraRollButton.isHidden = true;
        self.takePhotoButton.isHidden = true;
    }
    
    @IBAction func onTakePhotoClick(_ sender: Any) {
        let imagePicker = UIImagePickerController();
        // Setting the delegate tells the imagePicker who it should notify for changes
        // This will cause an error unless we then implement the delegate methods!
        imagePicker.delegate = self;
        
        // We only use the camera as a source if it is availible!
        // Note that it is NOT availible in simulator.
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera;
            self.present(imagePicker, animated: true, completion: nil);
        }
    }

    @IBAction func onUploadFromCameraRollClicked(_ sender: Any) {
        let imagePicker = UIImagePickerController();
        // Setting the delegate tells the imagePicker who it should notify for changes
        // This will cause an error unless we then implement the delegate methods!
        imagePicker.delegate = self;
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary;
            self.present(imagePicker, animated: true, completion: nil);
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // In this function, 'self' corresponds to the the calling object (which is the image picker).
        // We then dismiss self to dismiss the image picker.
        self.dismiss(animated: true, completion: nil)
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        return;
    }

}
