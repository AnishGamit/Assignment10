//
//  ViewCell.swift
//  Assignment10
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewCell: UIViewController {

    private var dataarray = [String]()
    private var tableview = UITableView()
    private let toolbar:UIToolbar = {
        let toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        toolbar.items = [space,add]
        return toolbar
    }()
    private let btnLogout:UIButton = {
        let btn = UIButton()
        btn.setTitle("LogOut", for: .normal)
        btn.addTarget(self, action: #selector(logoutclk), for: .touchUpInside)
        btn.tintColor = .white
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 6
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(toolbar)
        view.addSubview(tableview)
        view.addSubview(btnLogout)
        view.backgroundColor = .white
        setUptableview()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataarray = FMS.getfiles()
        tableview.reloadData()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func setUptableview(){
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let toolbarHGeight:CGFloat = view.safeAreaInsets.top + 20.0
        btnLogout.frame = CGRect(x: 10, y: 25, width: 80, height: 30)
        toolbar.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height:toolbarHGeight)
        tableview.frame = CGRect(x: 0, y: toolbar.bottom+10, width:view.frame.size.width, height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
}

extension ViewCell:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataarray.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let filepath = FMS.getDocDir().appendingPathComponent(dataarray[indexPath.row] + ".text")
        do{
            try FileManager.default.removeItem(at:filepath)
            self.dataarray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            print("delete")
        }catch{
            print("Error")
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = dataarray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = AddFiles()
        cell.f = dataarray[indexPath.row]
        navigationController?.pushViewController(cell, animated: true)
    }
    @objc func handleAdd(){
        let vc = AddFiles()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func logoutclk(){
        UserDefaults.standard.setValue(nil, forKey: "uname")
        self.dismiss(animated: true)
        let sc = Login()
        navigationController?.pushViewController(sc, animated: true)
    }
}
