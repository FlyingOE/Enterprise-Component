import pandas as pd
from qpython import qconnection
q = qconnection.QConnection(host = 'vt0dmkdl01', port = 17006)
q.open()
print q.sync('til 10')
print q.sync('10#tradeBar')
pd.DataFrame(q.sync('10#tradeBar'))
