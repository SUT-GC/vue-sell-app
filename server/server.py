#! -*- coding:utf8 -*-

from flask import Flask
app = Flask(__name__)

from seller_data import seller
from goods_data import goods
from ratings_data import ratings

import json

@app.route('/shop')
def shop():
    return seller

@app.route('/groups')
def groups():
    return goods

@app.route('/ratings')
def rattings():
    return ratings

if __name__ == '__main__':
    app.run(port=8888)
