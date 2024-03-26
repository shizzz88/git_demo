#Patalinux Create Project
Petalinux tool requires the environment variable to be set in order to run the command lines.
Go to **Petalinux-install-dir** and write the command:

``
source <path-to-install-dir>/settings.sh
``

3) you can verify if the environment variable is set to **Petalinux** by entering the following command:

´´
$PETALINUX
``

5) In case if the variable is correctly setup, it will show you the path to the petalinux install folder

6) Now the project can be created by the following command:

``
petalinux-create -t project --template zynqMP -n name -d <target-folder>
``

