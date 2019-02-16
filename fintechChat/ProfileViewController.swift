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
        //print(editProfileBtn.frame)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //настроим интерфейс
        setupUI()
        
        //не знаем точные размеры вью, поэтому берем размеры кнопки из интерфейса
        print(editProfileBtn.frame)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //уже известны точные размеры вью и размеры кнопки
        #if DEBUG
            print(editProfileBtn.frame)
        #endif
    }
    
    
    @IBAction func tekePIctureBtnAction(_ sender: UIButton) {
        print("Выбери изображение профиля")
        handleSelectProfileImageView()
    }

    @IBAction func darkThemeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            setupDarkTheme()
        } else {
            setupUI()
        }
    }
    
    private func setupUI() {
    
        enum cornerRadius: CGFloat {
            case imageViewAndPhotoBtn = 40
            case editBtn = 18
        }
        
        self.view.backgroundColor = .white
        
        profileImageView.layer.cornerRadius = cornerRadius.imageViewAndPhotoBtn.rawValue //radiusUI
        profileImageView.clipsToBounds = true
        
        takePicturesForProfile.layer.cornerRadius = cornerRadius.imageViewAndPhotoBtn.rawValue
        takePicturesForProfile.clipsToBounds = true
        takePicturesForProfile.layer.borderWidth = 0
        takePicturesForProfile.layer.backgroundColor = UIColor(named: "blueColor")?.cgColor
        
        editProfileBtn.layer.cornerRadius = cornerRadius.editBtn.rawValue
        editProfileBtn.clipsToBounds = true
        editProfileBtn.tintColor = .black
        editProfileBtn.layer.borderWidth = 1
        editProfileBtn.layer.borderColor = UIColor.black.cgColor
        editProfileBtn.backgroundColor = .white

    }
    
    func setupDarkTheme() {
        //для себя :)
        
        self.view.backgroundColor = UIColor(named: "yellowColor")
        takePicturesForProfile.layer.borderWidth = 3
        takePicturesForProfile.layer.borderColor = UIColor(named: "yellowColor")?.cgColor
        takePicturesForProfile.layer.backgroundColor = UIColor(named: "darkColor")?.cgColor
        editProfileBtn.backgroundColor = UIColor(named: "darkColor")
        editProfileBtn.tintColor = UIColor(named: "yellowColor")
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
