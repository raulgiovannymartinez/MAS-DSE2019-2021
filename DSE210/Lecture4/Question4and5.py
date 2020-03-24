##################################################################################################
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D
   
# Our 2-dimensional distribution will be over variables X and Y
N = 60
#X = np.linspace(-9, 9, N)
#Y = np.linspace(-3, 4, N)
X = np.linspace(-3, 3, N)
Y = np.linspace(-3, 3, N)
X, Y = np.meshgrid(X, Y)
   
# Mean vector and covariance matrix
mu = np.array([0, 0])
#Sigma = np.array([[ 9 , 0], [0,  1]])
Sigma = np.array([[ 1 , -0.75], [-0.75,  1]])

   
# Pack X and Y into a single 3-dimensional array
pos = np.empty(X.shape + (2,))
pos[:, :, 0] = X
pos[:, :, 1] = Y
   
def multivariate_gaussian(pos, mu, Sigma):
    """Return the multivariate Gaussian distribution on array pos.
   
    pos is an array constructed by packing the meshed arrays of variables
    x_1, x_2, x_3, ..., x_k into its _last_ dimension.
   
    """
   
    n = mu.shape[0]
    Sigma_det = np.linalg.det(Sigma)
    Sigma_inv = np.linalg.inv(Sigma)
    N = np.sqrt((2*np.pi)**n * Sigma_det)
    # This einsum call calculates (x-mu)T.Sigma-1.(x-mu) in a vectorized
    # way across all the input variables.
    fac = np.einsum('...k,kl,...l->...', pos-mu, Sigma_inv, pos-mu)
   
    return np.exp(-fac / 2) / N
   
# The distribution on the variables X, Y packed into pos.
Z = multivariate_gaussian(pos, mu, Sigma)
   
# Create a surface plot and projected filled contour plot under it.
fig = plt.figure(figsize=(10,10))
ax = fig.gca(projection='3d')
ax.plot_surface(X, Y, Z, rstride=3, cstride=3, linewidth=1, antialiased=True,
                cmap=cm.viridis)
   
cset = ax.contourf(X, Y, Z, zdir='z', offset=-0.3, cmap=cm.viridis)
   
# Adjust the limits, ticks and view angle
ax.set_zlim(-0.3,0.25)
#ax.set_zticks(np.linspace(0,0.2,5))
ax.set_xlabel('x-axis')
ax.set_ylabel('y-axis')
ax.view_init(25, 80)
   
plt.show()


##################################################################################################


import matplotlib.pyplot as plt
#Sigma = np.array([[ 9 , 0], [0,  1]])
Sigma = np.array([[ 1 , -0.75], [-0.75,  1]])
x, y = np.random.multivariate_normal([0,0], Sigma, 100).T
plt.plot(x, y, 'x')
plt.axis('equal')
plt.show()









