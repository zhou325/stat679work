# Homework 2

## Document

This directory contains the following document:

* `hw2-datamerge`:
    There are two data files that we will use in hw2.  On the same roof, two different solar collector systems are installed, one to heat water and the other to provide electricity.  Data are collected every month from each system:
    * `energy.csv`: contains daily data on the energy produced by a photovoltaic system.
    * `waterTemperature.csv`: contains hourly data on the hot water temperature.
    * `readme.md`: a detailed description of our data files.
* `scripts`: contains a python script for hw2
    * `hw2.py`: This python script takes 3 file names as arguments, one for the file name of energy data, one for the file name of the water temperature data, and one for the file name of our output data.  If the third argument is missing, the script will return the output to the STDOUT stream.
* `results`: contains the output file
    * `output.csv`: This output file is created by `hw2.py` and contains the merged data.

* `README.md`: gives higher-level explanations and all the tools (commands) to reproduce my results

working directory: `hw2`

## Instructions

To change the working directory to `hw2` and run the following code:
`python scripts/hw2.py <filename of temperature data> <filename of energy data> <filename of output>` or `python hw2.py <filename of temperature data> <filename of energy data>`
will get the merged data required in this homework.

Specifically, to reproduce the output file from the given data, run

`python scripts/hw2.py hw2-datamerge/waterTemperature.csv hw2-datamerge/energy.csv results/output.csv`

**Quick view of the output table (first 51 rows):**

|Index|Date Time           |Temperature|Energy (Wh/1000)|
|-----|--------------------|-----------|----------------|----|
|1    |07/29/16 10:26:34 AM|72.86      |                |    |
|2    |07/29/16 11:26:34 AM|73.92      |                |    |
|3    |07/29/16 12:26:34 PM|73.98      |                |    |
|4    |07/29/16 01:26:34 PM|74.86      |                |    |
|5    |07/29/16 02:26:34 PM|75.34      |                |    |
|6    |07/29/16 03:26:34 PM|76.75      |                |    |
|7    |07/29/16 04:26:34 PM|77.95      |                |    |
|8    |07/29/16 05:26:34 PM|75.16      |                |    |
|9    |07/29/16 06:26:34 PM|74.30      |                |    |
|10   |07/29/16 07:26:34 PM|73.89      |                |    |
|11   |07/29/16 08:26:34 PM|74.23      |                |    |
|12   |07/29/16 09:26:34 PM|73.53      |                |    |
|13   |07/29/16 10:26:34 PM|73.27      |                |    |
|14   |07/29/16 11:26:34 PM|73.45      |9.468           |
|15   |07/30/16 12:26:34 AM|72.30      |                |    |
|16   |07/30/16 01:26:34 AM|72.70      |                |    |
|17   |07/30/16 02:26:34 AM|72.82      |                |    |
|18   |07/30/16 03:26:34 AM|72.77      |                |    |
|19   |07/30/16 04:26:34 AM|72.61      |                |    |
|20   |07/30/16 05:26:34 AM|72.54      |                |    |
|21   |07/30/16 06:26:34 AM|72.18      |                |    |
|22   |07/30/16 07:26:34 AM|72.07      |                |    |
|23   |07/30/16 08:26:34 AM|71.82      |                |    |
|24   |07/30/16 09:26:34 AM|69.84      |                |    |
|25   |07/30/16 10:26:34 AM|73.09      |                |    |
|26   |07/30/16 11:26:34 AM|77.43      |                |    |
|27   |07/30/16 12:26:34 PM|82.18      |                |    |
|28   |07/30/16 01:26:34 PM|85.08      |                |    |
|29   |07/30/16 02:26:34 PM|87.33      |                |    |
|30   |07/30/16 03:26:34 PM|84.78      |                |    |
|31   |07/30/16 04:26:34 PM|88.74      |                |    |
|32   |07/30/16 05:26:34 PM|86.99      |                |    |
|33   |07/30/16 06:26:34 PM|88.02      |                |    |
|34   |07/30/16 07:26:34 PM|86.16      |                |    |
|35   |07/30/16 08:26:34 PM|86.09      |                |    |
|36   |07/30/16 09:26:34 PM|85.33      |                |    |
|37   |07/30/16 10:26:34 PM|84.70      |                |    |
|38   |07/30/16 11:26:34 PM|85.87      |12.062          |
|39   |07/31/16 12:26:34 AM|85.48      |                |    |
|40   |07/31/16 01:26:34 AM|85.53      |                |    |
|41   |07/31/16 02:26:34 AM|84.40      |                |    |
|42   |07/31/16 03:26:34 AM|81.61      |                |    |
|43   |07/31/16 04:26:34 AM|84.16      |                |    |
|44   |07/31/16 05:26:34 AM|84.07      |                |    |
|45   |07/31/16 06:26:34 AM|84.13      |                |    |
|46   |07/31/16 07:26:34 AM|84.69      |                |    |
|47   |07/31/16 08:26:34 AM|84.72      |                |    |
|48   |07/31/16 09:26:34 AM|82.47      |                |    |
|49   |07/31/16 10:26:34 AM|79.97      |                |    |
|50   |07/31/16 11:26:34 AM|82.04      |                |    |
