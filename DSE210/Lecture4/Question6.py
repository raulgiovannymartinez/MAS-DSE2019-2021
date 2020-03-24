# import libraries
import matplotlib.pyplot as plt
import numpy as np

# define the axis
X1 = np.array(np.arange(-5,5,1))
X2 = (3/4)*X1 + 3 

# Create the plot
plt.plot(X1,X2)
plt.title('Linear Classifier')
plt.xlabel('X1')
plt.ylabel('X2')
plt.grid(True)
plt.xticks(np.arange(-5, 6, step=1))
plt.yticks(np.arange(-1, 7, step=1))

# Show the plot
plt.show()
