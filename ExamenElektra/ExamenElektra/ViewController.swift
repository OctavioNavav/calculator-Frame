//
//  ViewController.swift
//  ExamenElektra
//
//  Created by GoNet on 01/03/19.
//  Copyright © 2019 GoNet. All rights reserved.
//

import UIKit
//import Alamofire
class ViewController: UIViewController {
    
    //var items = [elektra]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var usuario: UITextField!
    @IBOutlet weak var passw: UITextField!
    @IBAction func ingresar(_ sender: UIButton) {

        let username = usuario.text
        let password = passw.text

        if(username == "" || password == "")
        {
            let alert = UIAlertController(title: "ERROR", message: "Algo salio Mal!, verifica credenciales", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler:
                nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else {
//            var url = "https://devareenterprises.000webhostapp.com/Api/ElektraStore/v1/usuarios/login"
//            var parametros: Parameters = ["Usuario": usuario.text, "Passwprd": passw.text]
//            URLRequest(url, method(for: .post, Parameters: parametros, encoding: JSONEncoder.default, headers: nil))
//                .responseJSON(CompletionHandler:{ (resultado) in
//                    switch(resultado.result){
//                    case .success(let value): break
//                    case .failure(let error): break
//                    }
//                })
            performSegue(withIdentifier: "HomeSegue", sender: nil)
        }
    }
    
    
    
    ////////////////////////////////////////////////////////////////////////
    struct jsonstruct:Decodable {
        let productos:String
        
        
    }
    class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        @IBOutlet var tableview: UITableView!
        
        
        var arrdata = [jsonstruct]()
        override func viewDidLoad() {
            super.viewDidLoad()
            getdata()
        }
        
        func getdata(){
            let url = URL(string: "https://devareenterprises.000webhostapp.com/Api/ElektraStore/v1/productos")
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                do{if error == nil{
                    self.arrdata = try JSONDecoder().decode([jsonstruct].self, from: data!)
                    
                    for mainarr in self.arrdata{
                        //print(mainarr.name,":",mainarr.capital,":",mainarr.alpha3Code)
                        DispatchQueue.main.async {
                            self.tableview.reloadData()
                        }
                        
                    }
                    }
                    
                }catch{
                    print("Error in get json data")
                }
                
                }.resume()
        }
        
        
        //TableView
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.arrdata.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
            cell.lblname.text = "Productos : \(arrdata[indexPath.row].productos)"
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let detail:DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
            detail.strregion = "Productos :\(arrdata[indexPath.row].productos)"
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
}
