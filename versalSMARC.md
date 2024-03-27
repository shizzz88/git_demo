# Create the Vivado Project

1) Launch Vivado
```bash
module load xilinx/2023.2
vivado &
```

1) Download the Versal Customer Extensible Embedded Platform Example.
   1) Click menu **Tools -> Vivado Store...**
   2) Click **OK** to agree to download open source examples from web.
   3) Select **Example Designs ->Platform ->** `Versal Extensible Embedded Platform part_support` , and click the download button on the tool bar.
   4) Click **Close** after the installation is complete.
2) Create the Versal Extensible Embedded Part Support Platform Example project.
   1) Click **File -> Project -> Open Example...**
   2) Click **Next**.
   3) Select `Versal Extensible Embedded Platform (Part based)` in Select Project Template window. Then click **Next**.
   4) In Project Name dialog set Project name to `VersalSMARC`, and select a valid project location. Keep **Create project subdirectory** option checked. Then, click **Next**.
   5) In default part dialog, select `xcve2302-sfva784-2MP-e-S`. Then, click **Next**.
   6) Configure the Clocks Settings. You can enable more clocks, update output frequency, and define default clock in this view. In this example, you can keep the default settings.
   7) Configure the Interrupt Settings. You can choose how many interrupt should this platform supports. 63 interrupts mode will use two AXI_INTC in cascade mode. In this example, you can keep the default setting.
   8) Enable AIE or not. In this example, you can keep the default setting.
   9) Click **Next**
   10) Review the new project summary and click **Finish**.
   11) After a while, you will see the design example has been generated.

The generated design should look like this:

![VersalSMARC Block Diagram](bd.png)

# Configure the Block

1) Configure the Versal_cips IP.
   1) Double-click `CIPS_0` in the Block Diagram window. Click **Next**, then click **PS PMC** to config the PS-PMC parts one by one.
   2) Open the **PSPMC** tab.
   3) Go to **Boot Mode**, and make sure, the first **QSPI** and **SD1/eMMC1** are selected and configured as follows (Warnings can be ignored for now):
      1) QSPI:
         1) Mode: **Single**
         2) Data Mode: **x4**
         3) Loopback Clock: **NOT CHECKED**
         4) Requested QSPI Reference Clock Frequency (MHz): **300**
      2) SD1/eMMC1:
         1) Slot Type: **SD 2.0**
         2) Detect Location: **NOT CHECKED**
         3) Bus Power Location: **CHECKED**
         4) WP Location: **NOT CHECKED**
         5) HSD: **0x4**
         6) HSD: **0x2C**
   4) Go to **Peripherals** and enable / configure the following **Peripherals**:
      1) USB 2.0
      2) GEM0
         1) MDIO: **CHECKED**
         2) Requested Frequency (MHz): **125**
      3) GEM1
         1) MDIO: **NOT CHECKED**
         2) Requested Frequency (MHz): **125**
      4) UART0
         1) Baud Rate: **115200**
         2) RTS CTS: **NOT CHECKED**
         3) Requested Frequency (MHz): **100**
      5) LPD_ISC0
         1) Requested Frequency (MHz): **100**
      6) LPD_ISC1
         1) Requested Frequency (MHz): **100**
   5) Go to **IO** and configure the *IO* pins as follows:
      1) SD1/eMMC1: **PMC_MIO 26 .. 36**
         1) Bus Power: **PMC_MIO 51**
      2) GEM0: **PS_MIO 0 .. 11**
         1) ENET0 MDIO: **PS_MIO 24 .. 25**
      3) GEM1: **PS_MIO 12 .. 23**
      4) USB 2.0: **PMC_MIO 13 .. 25**
      5) UART0: **PMC_MIO 8 .. 9**
      6) LPD_I2C0: **PMC_MIO 34 .. 35**
      7) LPD_I2C1: **PMC_MIO 36 .. 37**
![IO Configuration](io.png)

   6) Click **Finish** to exit PS PMC configuration.
   7) Click **Finish** to exit Versal_cips configuration.
2) Configure the `noc_ddr4` IP.
   1) Double-click the `noc_ddr4` IP. Click **DDR Basic** tab, and configure the following settings for this tab:
      1) Controller Type: **DDR4 SDRAM**
      2) Clock selection: **Memory Clock**
      3) Memory Clock period (ps): **1000**
      5) Input System Clock Period (ps): **5000 (200.0MHz)**
      6) System Clock: **Differential**
      7) Enable Internal Responder: **CHECKED**
   2) Click **DDR Memory** tab, configure the following settings for this tab:
      1) Device Type: **Components**
      2) Speed Bin (Monolithic/3DS): **DDR4-2400U(18-18-18)**
      3) Base Component Width: **x16**
      4) Row Address Width: **17**
      5) Number of Channels: **Single**
      6) Data Width per Channel (Including ECC bits if enabled): **64**
      7) Ranks: **1**
      8) Stack Height: **1**
      9) Slot: **Single**

# Create the **Constraint** file for the DDR

1) Validate the block design by clicking **Validate Design** button or press **F6**
   1) The **Critial Warning** (seen below) related to axi_intc_0 can be ignored for now.
```
[BD 41-759] The input pins (listed below) are either not connected or do not have a source port, and they don't have a tie-off specified. These pins are tied-off to all 0's to avoid error in Implementation flow.
Please check your design and connect them as needed: 
/axi_intc_0/intr
```
2)  Update the module wrapper file.
   1) In **Sources** tab, right-click the **ext_platform_part_wrapper** file.
   2) Select **Remove file from project** and select **also delete the project local file form disk** and click **OK**.
   3) Right-click **ext_platform_part.bd** in Design Sources group.
   4) Select **Create HDL Wrapper...** .
   5) Select **Let Vivado manage wrapper and auto-update**.
   6) Click **OK** to generate wrapper for block design.
3) Add a blank constraint file to the project.
   1) In **Sources** tab, right-click the **Constraints** folder.
   2) Select **Add Sources...**.
   3) Select **Add or create constraints** and click **Next**.
   4) Select **Create File** and click **Next**.
   5) Set the file name to `ddr` and click **OK**.
   6) Click **Finish**.
4) Click **Run Synthesis**
5) Click **OK** and wait until the synthesis is complete.
6) Select **Open Synthesized Design** and click **OK**.
7) Click **Tools** -> **I/O Planning** -> **Advanced I/O Planner**
    1) Press **...** under **IO Bank**
    2) Select **DDRMC_X0Y0**, this should automatically select **I/O Bank 700**, **I/O Bank 701**, and **I/O Bank 702**
    3) Press **OK**
    4) Check **ext_platform_part_i/noc_ddr4/inst/MC0_ddrc**
    5) Press **OK**
    6) Save the Constraints by pressing **Ctrl + S**
    7) Select **Sect an existing file** -> **ddr.xdc**
    8) Press **OK**

# Export the Hardware

1) Close the Synthesized Design window.
2) Click **File** -> **Export** -> **Export Platform...**
3) Click **Next**.
4) Select **Hardware** and click **Next**.
5) Select **Pre-synthesis**, because we’re not making an DFX platform. Click **Next**.
6) Keep the **Platform Properties** as they are or change them as needed. Click **Next**.
7) Set the XSA file name to **versal_smarc_platform_hw**, click **Next**.
8) Review the summary. Click **Finish**.

# Create the Vitis Software Platform

## Setup the Versal common image
1) Download the [Versal common image](https://www.xilinx.com/member/forms/download/xef.html?filename=xilinx-versal-common-v2023.2_10140544.tar.gz) (current version is 2023.2, but you can check for the latest version [here](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-platforms.html))
2) Copy the downloaded file to the **Workspace** directory, selected during the Vivado project generation.
3) Extract the downloaded file. `tar xf xilinx-versal-common-v2023.2_10140544.tar.gz`
4) Install the sysroot
```bash
cd xilinx-versal-common-v2023.2_10140544
./sdk.sh -d .
```
Use the `-d` option to provide a full pathname to the output directory. (This is an example. `.` means current directory).

## Create the Device Tree File
1) Create a new folder in the **Workspace** directory, named `device-tree`.
2) Download the example [system-user.dtsi](https://github.com/Xilinx/Vitis-Tutorials/blob/2023.2/Vitis_Platform_Creation/Design_Tutorials/03_Edge_VCK190/ref_files/step2_pfm/system-user.dtsi) file and save it in the `device-tree` folder.
3) Open the file and change `model` from `Xilinx custom-vck190` to `VersalSMARC`. -- TODO: Do any other changes need to be made?
4) In the `device-tree` folder execute the following commands to create the device tree file:
```bash
xsct
createdts -hw ../VersalSMARC/versal_smarc_platform_hw.xsa -zocl  -out . -platform-name VersalSMARC  -git-branch xlnx_rel_v2023.2 -dtsi system-user.dtsi -compile
exit
```

## Setup XRT
1) Download the [XRT](https://www.xilinx.com/bin/public/openDownload?filename=xrt_202320.2.16.204_22.04-amd64-xrt.deb) (current version is 2023.2, but you can check for the latest version [here](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-platforms.html))
2) Copy the downloaded file to the **Workspace** directory, selected during the Vivado project generation.
3) Unpack the downloaded deb file. `ar x xrt_202320.2.16.204_22.04-amd64-xrt.deb`
4) Unpack the unpacked data.tar file into the folder `xrt`.
```bash
mkdir xrt
tar -xf data.tar -C xrt
```
5) Setup the XILINX_XRT environment variable to point to `xrt/opt/xilinx/xrt`.
```bash
export XILINX_XRT=/path/to/workspace/xrt/opt/xilinx/xrt
```

## Create the Vitis Platform
1) Go to the **Workspace** directory and start Vitis like this (`-w` is to specify the workspace. `.` means the current worksapce directory).
```bash
vitis -w .
```
2) In the Vitis Unified IDE, from menu select **File > New Component > Platform** to create a platform component.
3) In the **Create Platform Component** setup dialog
   1) Enter the platform component name and location. For this example, type `versal_smarc_platform`, use default location and click **Next**.
   2) Click **Broswe** button, select the XSA file generated by the Vivado. In this case, it is `versal_smarc_platform_hw.xsa`, and click **Next**.
   3) Set the operating system to **aie_runtime**.
   4) Set the processor to **ai_eigine**.
   5) Click **Next**.
   6) Review the summary and click **Finish**.
4) Add the Linux domain.
   1) Click the **+** button to add a domain. <br>![Add Domain](add_domain.png)
   2) Set Name to **xrt**.
   3) Change OS to **linux**.
   4) Click **OK**.
5) Set up the software settings in the Platform configuration view by clicking the **psv_cortexa72** domain, browse to the locations and select the directory or file needed to complete the dialog box for the following:
   1) **Display Name**: It has already been updated to `xrt`.
   2) **Bif file**: Click the ![Add Domain](gen_bif.png) button next to **Browse** to generate bif file or click **Browse** to select existing bif file.
   3) **Pre-Built Image Directory**: Browse to **xilinx-versal-common-v2023.2** and click **OK**.
   4) **DTB File**: Browse to **device-tree/VersalSMARC/psu_cortexa72_0/device_tree_domain/bsp** and select **system.dtb**, then click OK.
   5) Select **versal_smarc_platform** platform component in the flow navigator, then click the Build button to build the platform.

## Create an Application and boot image for the VersalSMARC platform
1) Creating Vector Addition Application
   1) Click **File > New Complonent > From Examples**.
   2) Select **Acceleration Examples > Installed Examples Repository > Simple Vector Addition**.
   3) Click **Create Application from Template**. The project creation wizard would pop up.
      1) Input the **System project name** as `vadd` and use the default location for **System project location**. Then click **Next**.
      2) Select `versal_smarc_platform` platform, click **Next**.
      3) Set **Kernel Image** to `xilinx-versal-common-v2023.2/Image`.
      4) Set **Root FS** to `xilinx-versal-common-v2023.2/rootfs.ext4`.
      5) Set **Sysroot** to `xilinx-versal-common-v2023.1/sysroots/cortexa72-cortexa53-xilinx-linux`.
      6) Click **Next**.
      7) Review the summary of your `vadd` system project and click **Finish**.
   4) After seconds the vadd system project, vadd host component and vadd kernel component will be ready in the component view.
2) Build the application
   1) Select the `vadd` component in the flow navigator.
   2) Click the **Build All** button under **Hardware** to build the application and create the boot image.
      1) Leave everything as default and click **OK**.
   3) If it fails to build, repeat the previous step (don't check any of the boxes) until it builds successfully.
3) The final SD card image (`sd_card.img`) can be found in `vadd/build/hw/package/package/`

# References
https://docs.xilinx.com/r/en-US/Vitis-Tutorials-Vitis-Platform-Creation/Create-a-Vitis-Platform-for-Custom-Versal-Boards

https://github.com/Xilinx/Vitis-Tutorials/tree/2022.2/Vitis_Platform_Creation/Design_Tutorials/03_Edge_VCK190