# Machine Learning Course Projects

## Project 1: skin detection
The objective of the project is to build a classification to detect faces and other skin areas of human bodies in pictures. Two classifiers, naive Bayes and Bayesian decision, are chosen. The result shows that the accuracy of Bayesian decision based on RGB or YIQ color model can get 86.5%. The result outperforms the other strategies. 

## Project 2: digit recognition
The objective of the system is to identify a digit. The digit is composed by a dot matrix, each dot is a LED light. Some LED on the matrix are defects. The problem takes challenges to the digit recognition. In my implemented classifier, it can recognize digits composed by a few defected dots and the ability to recognize rotated digits.

## Acknowledgement and references
In project 1, the set of pictures with ground truth are from the link http://web.fsktm.um.edu.my/~cschan/downloads_skin_dataset.html

In project 2, the referred paper is
A. Khotanzad and Y. H. Hong, "Invariant image recognition by Zernike moments," in IEEE Transactions on Pattern Analysis and Machine Intelligence, vol. 12, no. 5, pp. 489-497, May 1990.

The referred source code for Zernike moments are from these links:
http://www.mathworks.com/matlabcentral/fileexchange/38900-zernike-moments
http://liris.cnrs.fr/christian.wolf/software/zernike/