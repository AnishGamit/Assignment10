//
//  FMS.swift
//  Assignment10
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
class FMS {
    static func getDocDir() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask)
        print("Doc Dir:\(path[0])")
        return path[0]
    }
    static func getfiles()-> Array<String> {
        let fm = FileManager.default
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var files = [String]()
        do{
            let items = try fm.contentsOfDirectory(atPath: path.path)
            for item in items{
                if item.contains(".text"){
                    files.append(item.components(separatedBy: ".").first ?? "")
                }
            }
        }catch{
            
        }
        return files
    }
}
