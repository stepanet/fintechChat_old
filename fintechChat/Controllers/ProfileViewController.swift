//
//  ProfileViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 14/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class QueueChoice {
    let queueGlobal = DispatchQueue.global()
    let queueMain = DispatchQueue.main
    let operation = OperationQueue.main
    
    
}


class ProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate  {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var takePicturesForProfile: UIButton!
    @IBOutlet var profileNameTxt: UITextField!
    
    @IBOutlet weak var aboutProfileTextView: UITextView!
    @IBOutlet weak var gcdBtn: UIButton!
    @IBOutlet var operationBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    var saveDataOnMemory = SaveData()
    let queue = QueueChoice()
    let queueTest = ReadWriteData.QueueChoiceTest()
    
    
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //невозможно. еще не определены view, subview, переменные
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        aboutProfileTextView.delegate = self
        profileNameTxt.delegate = self
        loadProfileData()
        print(queueTest.txtREadfile(nameOfFile: "fsdfsdfs"))
        
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //настроим интерфейс
        setupUI()
        btnEditUnHidden()
        fieldProfileDisable()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //уже известны точные размеры вью и размеры кнопки
    }
    
    
    //если изменили текст то поставим флаг - сохранить
    func textViewDidChange(_ textView: UITextView) {
        saveDataOnMemory.saveAbout = true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //максимум 60 символов
        if (profileNameTxt.text?.count)! < 61 {
            self.saveDataOnMemory.saveProfileName = true
            return true
        } else {
            profileNameTxt.text?.removeLast()
            return true
        }
    }
    
    
    
    @IBAction func tekePIctureBtnAction(_ sender: UIButton) {
        print("Выбери изображение профиля")
        takePhotoProfile(cameraOff: false)
    }

    
    private func loadProfileData() {
        queue.queueMain.async {
            self.profileImageView.image = ReadWriteData.getImage(nameOfFile: "userprofile.jpg")
            self.profileNameTxt.text = ReadWriteData.txtReadFile(nameOfFile: "profileName.txt")
            self.aboutProfileTextView.text = ReadWriteData.txtReadFile(nameOfFile: "profileAbout.txt")
        }
    }
    
    private func setupUI() {
    
        //можно было сделать через user defined runtime attributes, но здесь более наглядно  и понятно и редактировать удобней
        
        enum cornerRadius: CGFloat {
            case imageViewAndPhotoBtn = 40
            case editBtn = 5
        }

        
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        
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
        
        present(picker, animated: true, completion: {
            self.fieldProfileEnable()
        })

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
            self.saveDataOnMemory.savePhoto = true
            
        }
        dismiss(animated: true, completion: {
            self.btnSaveEnable()
            self.fieldProfileEnable()
            self.btnEditHidden()
            self.setupUI()
        })
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
            let selectedImage = UIImage(named: "placeholder-user")
            self.profileImageView.image = selectedImage
            self.saveDataOnMemory.savePhoto = false
            self.queue.queueGlobal.async {
                ReadWriteData.removeImage(nameOfFile: "userprofile.jpg")
            }
            self.btnSaveEnable()

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
    
    //Следим если юзер начал набирать текст или делать изменения
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        self.btnSaveEnable()
    }
    
    
    //открываем возможность редактировать профиль

    @IBAction func editData(_ sender: UIButton) {
        self.fieldProfileEnable()
        self.btnEditHidden()
        self.btnSaveDisable()
    }
    
    //делаем поля доступными для редактирования
    fileprivate func fieldProfileEnable() {
        self.profileNameTxt.isEnabled = true
        self.aboutProfileTextView.isEditable = true
        self.takePicturesForProfile.isEnabled = true
    }
    
    //делаем поля не доступными для редактирования
    fileprivate func fieldProfileDisable() {
        queue.queueMain.async {
            self.profileNameTxt.isEnabled = false
            self.aboutProfileTextView.isEditable = false
            self.takePicturesForProfile.isEnabled = false
        }
    }


    //если начато редактирование - активировать кнопки записи
    @IBAction func editActionStart(_ sender: Any) {
        self.btnSaveEnable()
    }
    
    //сохраняем данные
    @IBAction func safeData(_ sender: UIButton) {

        let selectedImage = self.profileImageView.image!
        let text = profileNameTxt.text!
        let textAbout = aboutProfileTextView.text!
        self.activityIndicator.startAnimating()
  
        switch sender.tag {
        case 0:
            self.btnSaveDisable()
            //save data try
            
            queue.queueGlobal.async {
                self.queue.queueGlobal.async {
                    //если изменили фото то сохраним
                    if self.saveDataOnMemory.savePhoto {
                        ReadWriteData.saveImageDocumentDirectory(nameOfFile: "userprofile.jpg", selectedImage: selectedImage)
                    }
                    if self.saveDataOnMemory.saveProfileName {
                        ReadWriteData.txtWriteFile(nameOfFile: "profileName.txt", text: text)
                    }
                    //если изменили данные о пользователе - сохраним
                    if self.saveDataOnMemory.saveAbout  {
                        ReadWriteData.txtWriteFile(nameOfFile: "profileAbout.txt", text: textAbout)
                    }
                }
                self.saveData()
                self.loadProfileData()
            }
            
        case 1:
                self.btnSaveDisable()
                //save data try
                queue.queueGlobal.async {
                    self.saveData()
                }
                default:
                    break
            }

    }
    

    //safe data
    fileprivate func saveData() {
        let queue = QueueChoice()
        for i in 1...30000 {
            print(i)
            if i == 30000 {
                queue.queueMain.async {
                    
                    //для проверки ошибки записи
                    let randomInt = Int.random(in: 0...1)
                    if randomInt == 1 {
                        self.saveDataOnMemory.saveData = false
                    }
                    
                    self.btnAfterSave()
                    self.showAlert(textMessage: self.saveDataOnMemory.textAlertFunc())
                }
            }
        }
        
        self.fieldProfileDisable()
    }
    
    
    
    //button and activity state
    fileprivate func btnAfterSave() {
        self.btnSaveEnable()
        self.btnEditUnHidden()
        self.activityIndicator.stopAnimating()
    }
    
    //safe button disable
    fileprivate func btnSaveDisable() {
        self.gcdBtn.isEnabled = false
        self.operationBtn.isEnabled = false
    }
    
    //safe button disable
    fileprivate func btnSaveEnable() {
        self.gcdBtn.isEnabled = true
        self.operationBtn.isEnabled = true
    }
    
    //
    fileprivate func btnEditHidden() {
        editBtn.isHidden = true
        gcdBtn.isHidden = false
        operationBtn.isHidden = false
    }

    //
    fileprivate func btnEditUnHidden() {
        editBtn.isHidden = false
        gcdBtn.isHidden = true
        operationBtn.isHidden = true
    }
    
    //алерт успешно / неуспешно
    func showAlert(textMessage: String) {
        let alertController = UIAlertController(title: nil, message: textMessage, preferredStyle: .alert)
        let actionSave = UIAlertAction(title: "ОК" , style: .default) { (action) in
            
        }
        let actionRepeat = UIAlertAction(title: "Повторить" , style: .default) { (action) in
            self.saveDataOnMemory.saveData = true
            self.saveData()
        }
            alertController.addAction(actionSave)
        if !saveDataOnMemory.saveData {
            alertController.addAction(actionRepeat)
        }
        self.present(alertController, animated: true, completion: nil)
    }

}

