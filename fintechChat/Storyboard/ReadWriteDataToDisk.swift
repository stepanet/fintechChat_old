//
//  ReadWriteDataToDisk.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 08/03/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import Foundation

public class ReadWriteData {
    

//сохранить изображение
    class func saveImageDocumentDirectory(nameOfFile: String, selectedImage: UIImage){

        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(nameOfFile)
        let image = selectedImage 
        print(paths)
        let imageData = image.jpegData(compressionQuality: 0.75)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
}


//получить файл из директории
    class func getImage(nameOfFile: String) -> UIImage {
    let fileManager = FileManager.default
    let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(nameOfFile)
    if fileManager.fileExists(atPath: imagePath){
        return UIImage(contentsOfFile: imagePath)!
    }else{
        return UIImage(named: "placeholder-user.jpg")!
    }
}
   
//удалить файл из директории
    class func removeImage(nameOfFile:String) {
    let fileManager = FileManager.default
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    guard let dirPath = paths.first else { return }
    let filePath = "\(dirPath)/\(nameOfFile)"
        do {
            try fileManager.removeItem(atPath: filePath)
        } catch let error as NSError {
            print(error.debugDescription)
        }}
    
  
//пишем данные в текст
    class func txtWriteFile(nameOfFile: String, text: String) {
        
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(nameOfFile)
        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {/* обработчик ошибок */}
    }
    }

//читаем текстовые файлы
    class func txtReadFile(nameOfFile: String) -> String {

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(nameOfFile)
                    do {
                        return try String(contentsOf: fileURL, encoding: .utf8)
                    }
                    catch {/* обработчик ошибок */}

            }
        return "Имя не доступно"
    }
    
    
    
    
    class QueueChoiceTest {
        var nameOfFile: String
        var text: String
        let queueGlobal = DispatchQueue.global()
        let queueMain = DispatchQueue.main
        let operation = OperationQueue.main
        
        init (nameOfFile: String = "", text: String = ""){
            self.nameOfFile = nameOfFile
            self.text = text
        }
        
        func txtREadfile(nameOfFile: String) -> String {
            
                return nameOfFile
            }
        }
}
