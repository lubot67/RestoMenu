from dosql import *
import cgi
import json

def index(req, order_id):
    order_id = cgi.escape(order_id)
    x = doSql()
    rets = x.execqry("select * from get_resto_order_perid('" + order_id + "');", False)
    result = []
    for ret in rets:
        stringed = map(str, ret)
        result.append(stringed)

    return json.dumps(result)
