//
//  ProgressController.swift
//  UpperQuizz
//
//  Created by Emanuel Flores Martínez on 20/07/21.
//

import UIKit
import VHProgressBar
// MARK: - MainTabController Class
final class ProgressController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(progressData2!)
        //      ------------------------------------
        let bp = HorizontalProgressBar(frame: CGRect(x: 50, y: 150, width: 300, height: 40))
        bp.progress = CGFloat(progressData2!.promedioGeneral/10)
        self.view.addSubview(bp)
        
        if progressData2!.historialEvaluaciones.count > 1{
            for i in progressData2!.historialEvaluaciones{
                var c = 250
                print(i.evaluacionID)
                print(i.puntajeTotal)
                print(i.nombreExamen)
                let cp = CircularProgressView2(frame: CGRect(x: 70, y: c, width: 100, height: 100))
                cp.progress = CGFloat(i.puntajeTotal/10)
                self.view.addSubview(cp)
                c = c + 50
            }
        }
//
    }

// Solo locales
    let progressData2 = LocalDataManager.getData(of: miProgreso.self, from: "mi_progreso")
//    model View
//    View
    
}

