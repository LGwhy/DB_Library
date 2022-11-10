import sys
import pymysql
import time
from PyQt5 import QtCore, QtGui, QtWidgets
from PyQt5.QtWidgets import QApplication, QMainWindow,QMessageBox
from LoginUI import Ui_Login
from ReaderUI import Ui_Reader
from ConnectSQL import *
from AdministratorUI import Ui_administrator
from LibrarianUI import Ui_Librarian

#主类，通过选择不同身份类型来调用相应类UI界面
cursor,conn = connectSQL()
#通过构建Readerui子类来继承QtWidgets.Qwidget类方法和Ui_Reader界面类
class Readerui(QtWidgets.QMainWindow, Ui_Reader):
    def __init__(self, parent=None):#定义一个构造方法，用于初始化对象，self作为方法第一个参数代表实例对象本身
        super(Readerui, self).__init__(parent)#通过super方法来调用Readerui父类的__init__构造方法
        self.setupUi(self)#直接继承界面类，调用类的setupUi方法

#通过构建librarianui子类来继承QtWidgets.Qwidget类方法和Ui_Librarian界面类
class librarianui(QtWidgets.QMainWindow,Ui_Librarian):
    def __init__(self, parent=None):
        super(librarianui, self).__init__(parent)
        self.setupUi(self)

#通过构建sysadminui子类来继承QtWidgets.Qwidget类方法和Ui_administrator界面类
class sysadminui(QtWidgets.QMainWindow,Ui_administrator):
    def __init__(self, parent=None):
        super(sysadminui, self).__init__(parent)
        self.setupUi(self)

#通过构建homepage子类来继承QMainWindow类方法和Ui_Login界面类
class homepage(QMainWindow, Ui_Login):
    def __init__(self, parent=None):
        super(homepage, self).__init__(parent)
        self.setupUi(self)
        self.exitbt.clicked.connect(self.exit)
        self.loginbt.clicked.connect(self.login)
    def exit(self):#构造退出方法，显示退出提示
        # 设定弹窗提示分别表示“确认”和“您确认要退出吗？”
        rec_code=QMessageBox.question(self, "确认", "您确认要退出吗？", QMessageBox.Yes | QMessageBox.No)
        if rec_code != 65536:
            self.close()
    def login(self):#构造登录方法，显示登录提示
        ID=self.userline.text()
        PW=self.pwline.text()
        if ID=='' or PW=='':
            QMessageBox.warning(self, "警告", "请输入用户名/密码", QMessageBox.Yes)
        #通过选择不同类型身份调用相应身份界面
        else:
            if self.idbox.currentText()=='读者':
                sql = 'select * from readers where ID = "%s" and password="%s"' % (ID, PW)
                res = cursor.execute(sql)
                if res:
                    logintime=time.strftime("%Y-%m-%d", time.localtime())
                    sql='select * from loginrecord where time="%s"' %logintime
                    res=cursor.execute(sql)
                    logined = cursor.fetchall()
                    if  res:
                        last=logined[-1]
                        number=last[-1]
                        num=number+1
                        sql='INSERT INTO loginrecord(ID,time,number) VALUES(%s,"%s",%d)' %(ID,logintime,num)
                        cursor.execute(sql)
                        conn.commit()
                    else:
                        sql = 'INSERT INTO loginrecord(ID,time,number) VALUES(%s,"%s",%d)' % (ID, logintime, 1)
                        cursor.execute(sql)
                        conn.commit()
                    self.read = Readerui()
                    self.read.show()
                    self.close()
                else:
                    QMessageBox.warning(self, "警告", "密码错误，请重新输入！", QMessageBox.Yes)
            elif self.idbox.currentText()=='图书管理员':
                type='图书管理员'
                sql = 'select * from workers where ID = "%s" and password="%s" and type="%s" ' % (ID, PW, type)
                res = cursor.execute(sql)
                if res:
                    self.librarian = librarianui()
                    self.librarian.show()
                    self.close()
                    pass
                else:
                    QMessageBox.warning(self, "警告", "密码错误，请重新输入！", QMessageBox.Yes)
            elif self.idbox.currentText()=='系统管理员':
                type = '系统管理员'
                sql = 'select * from workers where ID = "%s" and password="%s" and type="%s"' % (ID, PW, type)
                res = cursor.execute(sql)
                if res:
                    self.sysadmin=sysadminui()
                    self.sysadmin.show()
                    self.close()
                else:
                    QMessageBox.warning(self, "警告", "密码错误，请重新输入！", QMessageBox.Yes)

#固定的，PyQt5程序都需要QApplication对象。sys.argv是命令行参数列表，确保程序可以双击运行
app = QApplication(sys.argv)
#初始化
myWin = homepage()
#将窗口控件显示在屏幕上
myWin.show()
#程序运行，sys.exit方法确保程序完整退出。
sys.exit(app.exec_())

