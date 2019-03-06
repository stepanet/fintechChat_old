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
    @IBOutlet var profileNameTxt: UITextField!
    
    @IBOutlet weak var aboutProfileTextView: UITextView!
    @IBOutlet weak var gcdBtn: UIButton!
    @IBOutlet var operationBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //невозможно. еще не определены view, subview, переменные
        //print(editProfileBtn.frame)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //настроим интерфейс
        setupUI()
        
        //не знаем точные размеры вью, поэтому берем размеры кнопки из Main.storyboard
        //print(editProfileBtn.frame)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //уже известны точные размеры вью и размеры кнопки
        //print(editProfileBtn.frame)
    }
    
    
    @IBAction func tekePIctureBtnAction(_ sender: UIButton) {
        print("Выбери изображение профиля")
        takePhotoProfile(cameraOff: false)
    }


    private func setupUI() {
    
        //можно было сделать через user defined runtime attributes, но здесь более наглядно  и понятно и редактировать удобней
        
        enum cornerRadius: CGFloat {
            case imageViewAndPhotoBtn = 40
            case editBtn = 5
        }
        
        gcdBtn.isHidden = true
        operationBtn.isHidden = true
        editBtn.isHidden = false
        
        self.view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        profileNameTxt.backgroundColor = ThemeManager.currentTheme().backgroundColor
        profileNameTxt.textColor = ThemeManager.currentTheme().titleTextColor
        aboutProfileTextView.backgroundColor = ThemeManager.currentTheme().backgroundColor
        aboutProfileTextView.textColor = ThemeManager.currentTheme().titleTextColor
        

        profileImageView.layer.cornerRadius = cornerRadius.imageViewAndPhotoBtn.rawValue //radiusUI
        profileImageView.clipsToBounds = true
        
        takePicturesForProfile.layer.cornerRadius = cornerRadius.imageViewAndPhotoBtn.rawValue
        takePicturesForProfile.clipsToBounds = true
        takePicturesForProfile.backgroundColor = ThemeManager.currentTheme().editBtn

        gcdBtn.layer.cornerRadius = cornerRadius.editBtn.rawValue
        gcdBtn.clipsToBounds = true
        gcdBtn.tintColor = ThemeManager.currentTheme().titleTextColor
        gcdBtn.layer.borderWidth = 1
        gcdBtn.layer.borderColor = ThemeManager.currentTheme().titleTextColor.cgColor//UIColor.black.cgColor
        gcdBtn.backgroundColor = ThemeManager.currentTheme().backgroundColor
        
        operationBtn.layer.cornerRadius = cornerRadius.editBtn.rawValue
        operationBtn.clipsToBounds = true
        operationBtn.tintColor = ThemeManager.currentTheme().titleTextColor
        operationBtn.layer.borderWidth = 1
        operationBtn.layer.borderColor = ThemeManager.currentTheme().titleTextColor.cgColor//UIColor.black.cgColor
        operationBtn.backgroundColor = ThemeManager.currentTheme().backgroundColor
        
        editBtn.layer.cornerRadius = cornerRadius.editBtn.rawValue
        editBtn.clipsToBounds = true
        editBtn.tintColor = ThemeManager.currentTheme().titleTextColor
        editBtn.layer.borderWidth = 1
        editBtn.layer.borderColor = ThemeManager.currentTheme().titleTextColor.cgColor//UIColor.black.cgColor
        editBtn.backgroundColor = ThemeManager.currentTheme().backgroundColor
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
        let deletePhotoProfile = UIAlertAction(title: "Удалить фото", style: .destructive) { (action) in
            self.profileImageView.image = UIImage(named: "placeholder-user")
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel) { (action) in
        }
        alertController.addAction(actionPhoto)
        alertController.addAction(actionLibrary)
        alertController.addAction(actionCancel)
        if self.profileImageView.image != UIImage(named: "placeholder-user") {
            alertController.addAction(deletePhotoProfile)
            
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func closeProfileView(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editData(_ sender: UIButton) {
        
        editBtn.isHidden = true
        gcdBtn.isHidden = false
        operationBtn.isHidden = false
        
    }
    
    @IBAction func safeData(_ sender: UIButton) {
       
        editBtn.isHidden = false
        gcdBtn.isHidden = true
        operationBtn.isHidden = true
        
        switch sender.tag {
        case 0:
            print(gcdBtn.titleLabel?.text)
        case 1:
            print(operationBtn.titleLabel?.text!)
            
        default:
            break
        }
        
    }
    
}

