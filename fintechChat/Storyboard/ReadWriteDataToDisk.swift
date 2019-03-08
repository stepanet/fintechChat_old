//
//  ReadWriteDataToDisk.swift
//  fintechChat
//
//  Created by Jack Sp@rroW on 08/03/2019.
//  Copyright © 2019 Jack Sp@rroW. All rights reserved.
//

import Foundation

public class ReadWriteData {
    
    
    
    ////Create Directory :
    class func createDirectory(){
        print(#function)
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("customDirectory")
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
    }

//Save Image At Document Directory :
    class func saveImageDocumentDirectory(nameOfFile: String, selectedImage: UIImage){

        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(nameOfFile)
        let image = selectedImage 
        print(paths)
        let imageData = image.jpegData(compressionQuality: 0.75)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
}
    
    
////Get Document Directory Path :
class func getDirectoryPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    print(documentsDirectory)
    return documentsDirectory
}

////Get Image from Document Directory :
    class func getImage(nameOfFile: String) -> UIImage {

    let fileManager = FileManager.default
    let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(nameOfFile)
    if fileManager.fileExists(atPath: imagePath){
        print(UIImage(contentsOfFile: imagePath) as Any)
        return UIImage(contentsOfFile: imagePath)!
    }else{
        print("No Image")
        return UIImage(named: "placeholder-user.jpg")!
    }
}

////Delete Directory :
//func deleteDirectory(){
//    let fileManager = NSFileManager.defaultManager()
//    let paths = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent(“customDirectory”)
//    if fileManager.fileExistsAtPath(paths){
//        try! fileManager.removeItemAtPath(paths)
//    }else{
//        print(“Something wronge.”)
//    }
//}
}
