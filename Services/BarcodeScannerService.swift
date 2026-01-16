//
//  BarcodeScannerService.swift
//  ClashOfCans
//
//  Created on 2025-01-27.
//

import AVFoundation
import UIKit

class BarcodeScannerService: NSObject, ObservableObject {
    @Published var detectedBarcode: String?
    @Published var errorMessage: String?
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    override init() {
        super.init()
    }
    
    func setupCamera(in view: UIView) -> Bool {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            errorMessage = "Camera not available"
            return false
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [.ean13, .ean8, .upce, .code128]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            captureSession?.startRunning()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
    
    func stopSession() {
        captureSession?.stopRunning()
        videoPreviewLayer?.removeFromSuperlayer()
    }
}

extension BarcodeScannerService: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           let barcodeString = metadataObject.stringValue {
            detectedBarcode = barcodeString
            stopSession()
        }
    }
}

