=============================
CSC 214 - Final Project
Chris Dalke & Nate Conroy
=============================

This ZIP file contains the code used to generate our dataset
and visualize the results.

the /Code folder contains a Java project which was used to collect the dataset.
There are several main files in this Java project, listed below:
Stage 1: Generates location database from location raw CSV file
Stage 2: Generates facial image database using Microsoft Emotion and Flickr APIs
Stage 3: Trims database of non-facial images
Stage 4: Calculates average emotion values for all locations

It's unnecessary to run the Java project since our dataset has already been
generated. Our main dataset can be found in the /Data folder.

Our visualization tool can be found in the Visualization folder. It's built using
HTML/JS, and running it requires a webserver to be run with /Visualizations as
the root folder.

Note: An easy-to-use http server can be installed using NPM:
1) npm install http-server -g
2) cd Visualizations
3) http-server -c-1

If you do not wish to run a server locally, an identical copy of the local
project has been uploaded to http://chrisdalke.com/csc249/ for convenience.

=============================
Contact Info:
Email: cdalke@u.rochester.edu
=============================
