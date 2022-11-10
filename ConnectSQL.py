#连接类，用于连接mysql数据库
import pymysql
def connectSQL():
    conn = pymysql.connect(host='localhost', user='root',password='1234',database='library')
    cursor = conn.cursor()
    return cursor, conn