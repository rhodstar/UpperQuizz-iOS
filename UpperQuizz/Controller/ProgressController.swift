//
//  ProgressController.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 20/07/21.
//

import UIKit
// MARK: - MainTabController Class
final class ProgressController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(progressData2!)
        var titulo = LabelTittle()
        titulo = LabelTittle(frame: CGRect(x: 50, y: 5, width: 300, height: 300))
        titulo.text = "Promedio General: " + String(progressData2!.promedioGeneral)
        self.view.addSubview(titulo)
        //      ------------------------------------
        let bp = HorizontalProgressBar(frame: CGRect(x: 50, y: 170, width: 300, height: 40))
        bp.progress = CGFloat(progressData2!.promedioGeneral/10)
        self.view.addSubview(bp)
        
        if progressData2!.historialEvaluaciones.count > 1{
            for i in progressData2!.historialEvaluaciones{
                print(i.evaluacionID)
                print(i.puntajeTotal)
                print(i.nombreExamen)
            }
        }
        
        let cp = CircularProgressView2(frame: CGRect(x: 70, y: 400, width: 100, height: 100))
        cp.progress = 0.7
        self.view.addSubview(cp)
        var porcentaje = LabelTittle(frame: CGRect(x: 70+35, y: 400, width: 100, height: 100))
        porcentaje.text = String(70) + "%"
        self.view.addSubview(porcentaje)
//
    }

// Solo locales
    let progressData2 = LocalDataManager.getData(of: miProgreso.self, from: "mi_progreso")
//    model View
//    View
    
}

