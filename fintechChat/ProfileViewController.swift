//
//  ProfileViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 14/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var takePicturesForProfile: UIButton!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var aboutProfileTextView: UITextView!
    @IBOutlet weak var editProfileBtn: UIButton!

    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    
    override func awakeFromNib() {
        //невозможно. еще не определены переменные
        //print(editProfileBtn.frame)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //настроим интерфейс
        setupUI()
        //не знаем точные размеры вью, поэтому берем размеры кнопки из Main.storyboard
        print(editProfileBtn.frame)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //уже известны точные размеры вью и размеры кнопки
            print(editProfileBtn.frame)
    }
    
    
    @IBAction func tekePIctureBtnAction(_ sender: UIButton) {
        print("Выбери изображение профиля")
        takePhotoProfile(cameraOff: false)
    }


    private func setupUI() {
    
        //можно было сделать через user defined runtime attributes
        
        enum cornerRadius: CGFloat {
            case imageViewAndPhotoBtn = 40
            case editBtn = 18
        }
        
//        self.view.backgroundColor = .white
        
        
        
        profileImageView.layer.cornerRadius = cornerRadius.imageViewAndPhotoBtn.rawValue //radiusUI
        profileImageView.clipsToBounds = true
        
        takePicturesForProfile.layer.cornerRadius = cornerRadius.imageViewAndPhotoBtn.rawValue
        takePicturesForProfile.clipsToBounds = true

        editProfileBtn.layer.cornerRadius = cornerRadius.editBtn.rawValue
        editProfileBtn.clipsToBounds = true
        editProfileBtn.tintColor = .black
        editProfileBtn.layer.borderWidth = 1
        editProfileBtn.layer.borderColor = UIColor.black.cgColor
        editProfileBtn.backgroundColor = .white
    }
    
 
    //выбор фотографии в профайл
    func handleSelectProfileImageView(_ source: ImageSource){

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
  
        switch source {
            case .camera:
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                takePhotoProfile(cameraOff: true)
                return
            }
             picker.sourceType = .camera
        case .photoLibrary:
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectImageFromPicker:UIImage?

        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectImageFromPicker = originalImage
        }
        if let selectedImage = selectImageFromPicker {
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    private func takePhotoProfile(cameraOff: Bool) {
        
        var titleForCamera = "Фото"
        
        if cameraOff {
            titleForCamera = "Камера не доступна"
        }
        
        let alertController = UIAlertController(title: "", message: "Выберите фотографию для профиля", preferredStyle: .actionSheet)
        let actionPhoto = UIAlertAction(title: titleForCamera , style: .default) { (action) in
            
            self.handleSelectProfileImageView(.camera)
        }
        let actionLibrary = UIAlertAction(title: "Библиотека", style: .default) { (action) in
            self.handleSelectProfileImageView(.photoLibrary)
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel) { (action) in
            print("cancel")
        }
        alertController.addAction(actionPhoto)
        alertController.addAction(actionLibrary)
        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

