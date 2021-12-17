//
//  AddFiles.swift
//  Assignment10
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AddFiles: UIViewController {

    var f:String? = ""
    private let txtFname:UITextField = {
        let txt = UITextField()
        txt.textColor = .black
        txt.placeholder = "Enter FileName"
        txt.textAlignment = .center
        txt.backgroundColor = .white
        txt.layer.cornerRadius = 10.0
        txt.backgroundColor = .white
        txt.layer.borderWidth = 0
        txt.layer.shadowColor = UIColor.black.cgColor
        txt.layer.shadowOffset = CGSize(width: 4, height: 4)
        txt.layer.shadowOpacity = 0.5
        txt.layer.shadowRadius = 5.0
        return txt
    }()
    
    private let txtContent:UITextView = {
        let txt = UITextView()
        txt.text = ""
        txt.textAlignment = .left
        txt.backgroundColor = .gray
        txt.layer.cornerRadius = 10.0
        txt.layer.borderWidth = 0
        txt.layer.shadowColor = UIColor.black.cgColor
        txt.layer.shadowOffset = CGSize(width: 4, height: 4)
        txt.layer.shadowOpacity = 0.5
        txt.layer.shadowRadius = 5.0
        return txt
    }()
    
    private let btnSave:UIButton = {
        let btn = UIButton()
        btn.setTitle("SAVE", for: .normal)
        btn.addTarget(self, action: #selector(savenote), for: .touchUpInside)
        btn.tintColor = .white
        btn.backgroundColor = UIColor(red: 0.4, green: 1.5, blue: 0.2, alpha: 0.5)
        btn.layer.cornerRadius = 10
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.layer.shadowOpacity = 0.5
        return btn
    }()
    
    @objc private func savenote(){
        let name = txtFname.text!
        let content = txtContent.text!
        let filepath = FMS.getDocDir().appendingPathComponent("\(name).text")
        do{
            try content.write(to: filepath, atomically: true, encoding: .utf8)
        }catch{
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(txtFname)
        view.addSubview(txtContent)
        view.addSubview(btnSave)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        do {
            let filename = FMS.getDocDir().appendingPathComponent(f! +
                ".text")
            let fetcgcontent = try String(contentsOf: filename)
            txtFname.text = f
            txtContent.text = fetcgcontent
        } catch {
            print("Error")
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        txtFname.frame = CGRect(x: 40, y: 100, width: view.frame.width - 80, height: 40)
        txtContent.frame = CGRect(x: 40, y: txtFname.bottom + 20, width: view.frame.width-80, height: 160)
        btnSave.frame = CGRect(x: 40, y: txtContent.bottom + 50, width: view.frame.width-80, height: 40)
    }

}
