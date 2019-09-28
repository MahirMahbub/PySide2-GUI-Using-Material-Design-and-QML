# -*- coding: utf-8 -*-
"""
Created on Fri Sep 20 14:12:53 2019

@author: Mahir Mahbub
"""
import sys
import os
from PySide2.QtWidgets import QApplication,QMessageBox, QWidget
from PySide2.QtQuick import QQuickView
from PySide2.QtCore import QObject,QUrl
from PySide2.QtQml import QQmlApplicationEngine
from PySide2 import QtGui
import pyaes

def radioButton_1():
    global mode
    
    #print("ECB")
    mode = "CTR"
def foo():
    #for i in range(1000000):
        #print(i)
    global mode
    global operation_mode
    global file_path
    global folder_path
    global key_path
    file_text = view.findChild(QObject, "textField")
    file_path = file_text.property("text")
    folder_text = view.findChild(QObject, "savePathField")
    folder_path = folder_text.property("text")
    key_text = view.findChild(QObject, "keyField")
    key_path = key_text.property("text")
    key_value = None
    with open(file_path[8:], mode='rb') as file: # b is important -> binary
        file_to_operate = file.read()
    with open(key_path[8:], mode='rb') as file: # b is important -> binary
        key_value = file.read()
    #key_value = os.urandom(32)
    if mode == "CTR" and operation_mode == "Encrypt":
        aes = pyaes.AESModeOfOperationCTR(key_value)
        ciphertext = aes.encrypt(file_to_operate)
        with open(folder_path[8:]+"/Encrypted_"+os.path.basename(file_path), mode='wb') as file: # b is important -> binary
            file.write(ciphertext)
    if mode == "CTR" and operation_mode== "Decrypt":
        aes = pyaes.AESModeOfOperationCTR(key_value)
        decrypted = aes.decrypt(file_to_operate)
        with open(folder_path[8:]+"/Decrypted_"+os.path.basename(file_path)[1:], mode='wb') as file: # b is important -> binary
            file.write(decrypted)
    if mode == "OFB" and operation_mode == "Encrypt":
        aes = pyaes.AESModeOfOperationOFB(key_value)
        ciphertext = aes.encrypt(file_to_operate)
        with open(folder_path[8:]+"/Encrypted_"+os.path.basename(file_path), mode='wb') as file: # b is important -> binary
            file.write(ciphertext)
    if mode == "OFB" and operation_mode== "Decrypt":
        aes = pyaes.AESModeOfOperationOFB(key_value)
        decrypted = aes.decrypt(file_to_operate)
        with open(folder_path[8:]+"/Decrypted_"+os.path.basename(file_path)[1:], mode='wb') as file: # b is important -> binary
            file.write(decrypted)
            
    print(file_path, folder_path, key_path) 

def radioButton_2():
    global mode
    #print("CFB")
    mode = "OFB"

def radioButtonOperation_1():
    global operation_mode
    #print("Encrypt")
    operation_mode = "Encrypt"

def radioButtonOperation_2():
    global operation_mode
    #print("Decrypt")
    operation_mode = "Decrypt"

def confirmation():
    pass


    #print(file_path)


os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"
global app
app = None

global file_path
global folder_path
global key_path
try:
    app = QApplication([])
except RuntimeError:
    app = None
    app = QApplication([])

engine = QQmlApplicationEngine()
context = engine.rootContext()
context.setContextProperty("main", engine)
engine.load('aes.qml')
global view
#get root of GUI Tree
view = engine.rootObjects()[0]
#Find Child of the tree
radio_button1 = view.findChild(QObject, "radioButton1")
radio_button2 = view.findChild(QObject, "radioButton2")

radio_button_operation1 = view.findChild(QObject, "radioButtonOperation1")
radio_button_operation2 = view.findChild(QObject, "radioButtonOperation2")
# mode select
global mode
mode = "CTR"
radio_button1.clicked.connect(radioButton_1)
radio_button2.clicked.connect(radioButton_2)
#print(mode)
# operation Select
global operation_mode
operation_mode = "Encrypt"
radio_button_operation1.clicked.connect(radioButtonOperation_1)
radio_button_operation2.clicked.connect(radioButtonOperation_2)
#####



#####
confirm = view.findChild(QObject, "confirmOperation")
confirm.clicked.connect(foo)

view.show()
app.exec_()