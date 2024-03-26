#Patalinux Create Project
Petalinux tool requires the environment variable to be set in order to run the command lines.
1) Go to **Petalinux-install-dir** and write the command:

``
source <path-to-install-dir>/settings.sh
``

2) you can verify if the environment variable is set to **Petalinux** by entering the following command:

``
$PETALINUX
``

 In case if the variable is correctly setup, it will show you the path to the petalinux install folder

3) Create a new directory where you want to create the project:

``
mkdir <path-to-directory>/folder-name
``

4) Go to the directory and create new patalinux project.

5) Now the project can be created by the following command:

``
petalinux-create -t project --template zynqMP -n name 
``

