import numpy as np

#x = np.matrix([[1,-10,5,6],[4,8,3,1],[1,9,4,-400],[7,0,-90,-40]])
#x = np.matrix([1,-10,5,6])
x = np.matrix([[1],[-10],[5],[6]])
x_T = np.transpose(x)

a = np.matmul(x,x_T)
a_T = np.transpose(a)

b = np.matmul(x_T,x)
b_T = np.transpose(b)

c = x + x_T
c_T = np.transpose(c)

d = x - x_T
d_T = np.transpose(d)

