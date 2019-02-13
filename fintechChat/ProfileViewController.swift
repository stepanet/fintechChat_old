//
//  ProfileViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 14/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var takePicturesForProfile: UIButton!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var aboutProfileTextView: UITextView!
    @IBOutlet weak var editProfileBtn: UIButton!
    
    
    override func awakeFromNib() {
        //невозможно. еще не определены переменные
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //настроим интерфейс
        setupUI()
        
        //не знаем точные размеры вью, поэтому берем размеры кнопки под SE
        print(editProfileBtn.frame)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //уже известны точные размеры вью и размеры кнопки
        print(editProfileBtn.frame)
    }
    
    
    @IBAction func tekePIctureBtnAction(_ sender: UIButton) {
         print("Выбери изображение профиля")
        handleSelectProfileImageView()
    }


    private func setupUI() {
    
        enum cornerRadius: CGFloat {
            case imageViewAndPhotoBtn = 40
            case editBtn = 10
        }
        
        profileImageView.layer.cornerRadius = cornerRadius.imageViewAndPhotoBtn.rawValue //radiusUI
        profileImageView.clipsToBounds = true
        
        takePicturesForProfile.layer.cornerRadius = cornerRadius.imageViewAndPhotoBtn.rawValue
        takePicturesForProfile.clipsToBounds = true
        
        editProfileBtn.layer.cornerRadius = cornerRadius.editBtn.rawValue
        editProfileBtn.clipsToBounds = true
        editProfileBtn.tintColor = .black
        editProfileBtn.layer.borderWidth = 1
        editProfileBtn.layer.borderColor = UIColor.black.cgColor
        
    }
    
    //выбор картинки в профайл
    func handleSelectProfileImageView(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
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


}
