//
//  ProfileViewController.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 14/02/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate,
    UITextViewDelegate, UITextFieldDelegate  {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var takePicturesForProfile: UIButton!
    @IBOutlet var profileNameTxt: UITextField!
    
    @IBOutlet weak var aboutProfileTextView: UITextView!
    @IBOutlet weak var gcdBtn: UIButton!
    @IBOutlet var operationBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    var saveDataOnMemory = SaveData()
    let operationQueue = ReadWriteData.OperationDataManager()
    let gcdQueue = ReadWriteData.GCDDataManager()
    
  
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

    //подгрузим данные в профиль
    private func loadProfileData() {

        var profileNameTxt:String?
        var aboutProfileTextView:String?
        var profileImageView:UIImage
        
        //new version - using class
        
            gcdQueue.nameOfFile = "profileName.txt"
            profileNameTxt =  self.gcdQueue.txtREadfile()
            gcdQueue.nameOfFile = "profileAbout.txt"
            aboutProfileTextView = self.gcdQueue.txtREadfile()
            gcdQueue.nameOfFile = "userprofile.jpg"
            profileImageView = self.gcdQueue.getImage()

        
        gcdQueue.queueMain.async {
            self.profileNameTxt.text =  profileNameTxt
            self.aboutProfileTextView.text = aboutProfileTextView
            self.profileImageView.image = profileImageView
        }
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
            self.gcdQueue.queueGlobal.async {
                self.gcdQueue.removeImage(nameOfFile: "userprofile.jpg")
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
        gcdQueue.queueMain.async {
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
        print("self.activityIndicator.startAnimating()")
        self.activityIndicator.startAnimating()
        self.btnSaveDisable()
        let selectedImage = self.profileImageView.image!
        let text = profileNameTxt.text!
        let textAbout = aboutProfileTextView.text!

        switch sender.tag {
        case 0:
           
            if self.saveDataOnMemory.saveProfileName {
                gcdQueue.nameOfFile = "profileName.txt"
                gcdQueue.text = text
                gcdQueue.txtWriteFile()
            }
            
            if self.saveDataOnMemory.saveAbout  {
                gcdQueue.nameOfFile = "profileAbout.txt"
                gcdQueue.text = textAbout
                gcdQueue.txtWriteFile()
            }
            
            if self.saveDataOnMemory.savePhoto {
                gcdQueue.nameOfFile = "userprofile.jpg"
                gcdQueue.selectedImage = selectedImage
                gcdQueue.saveImage()
            }
            
            gcdQueue.queueGlobal.async {
                self.saveDataStart()
                self.loadProfileData()
            }

            
        case 1:
            operationQueue.operationQueue.addOperation {
                if self.saveDataOnMemory.saveProfileName {
                    self.operationQueue.nameOfFile = "profileName.txt"
                    self.operationQueue.text = text
                    self.operationQueue.txtWriteFile()
                }
            }
            
        operationQueue.operationQueue.waitUntilAllOperationsAreFinished()
            operationQueue.operationQueue.addOperation {
                if self.saveDataOnMemory.saveAbout {
                    self.operationQueue.nameOfFile = "profileAbout.txt"
                    self.operationQueue.text = textAbout
                    self.operationQueue.txtWriteFile()
                    
                }
            }
            operationQueue.operationQueue.waitUntilAllOperationsAreFinished()
            operationQueue.operationQueue.addOperation {
                if self.saveDataOnMemory.savePhoto {
                    self.operationQueue.nameOfFile = "userprofile.jpg"
                    self.operationQueue.selectedImage = selectedImage
                    self.operationQueue.saveImage()
                }
            }
            operationQueue.operationQueue.waitUntilAllOperationsAreFinished()
            operationQueue.operationQueue.addOperation {
                self.saveDataStart()
                self.loadProfileData()
            }
            
            default:
                    break
            }
    }

    //safe data
    fileprivate func saveDataStart() {
        for i in 1...150000 {
            print(i)
            if i == 150000 {
                //self.saveDataOnMemory.saveData = true
                //self.btnAfterSave()
                gcdQueue.queueMain.async {
                    self.showAlert(textMessage: self.saveDataOnMemory.textAlertFunc())
                }
            }
        }
        
        self.fieldProfileDisable()
        gcdQueue.queueMain.async {
            self.btnAfterSave()
            self.activityIndicator.stopAnimating()
        }
    }
    
    //button and activity state
    fileprivate func btnAfterSave() {
        self.btnSaveEnable()
        self.btnEditUnHidden()
    }
    
    //safe button disable
    fileprivate func btnSaveDisable() {

            self.gcdBtn.isEnabled = false
            self.operationBtn.isEnabled = false
    }
    
    //safe button enable
    fileprivate func btnSaveEnable() {
        gcdQueue.queueMain.async {
            self.gcdBtn.isEnabled = true
            self.operationBtn.isEnabled = true
        }
    }
    
    //
    fileprivate func btnEditHidden() {
        editBtn.isHidden = true
        gcdBtn.isHidden = false
        operationBtn.isHidden = false
    }

    //
    fileprivate func btnEditUnHidden() {
        gcdQueue.queueMain.async {
            self.editBtn.isHidden = false
            self.gcdBtn.isHidden = true
            self.operationBtn.isHidden = true
        }
    }
    
    //алерт успешно / неуспешно
    func showAlert(textMessage: String) {
        let alertController = UIAlertController(title: nil, message: textMessage, preferredStyle: .alert)
        let actionSave = UIAlertAction(title: "ОК" , style: .default) { (action) in
            
        }
        let actionRepeat = UIAlertAction(title: "Повторить" , style: .default) { (action) in
            self.activityIndicator.startAnimating()
            self.saveDataOnMemory.saveData = true
            self.gcdQueue.queueMain.async {
                self.saveDataStart()
                self.loadProfileData()
            }

        }
            alertController.addAction(actionSave)
        if !saveDataOnMemory.saveData {
            alertController.addAction(actionRepeat)
        }
        self.present(alertController, animated: true, completion: nil)
    }

}

