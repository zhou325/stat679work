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

`python scripts/hw2.py <filename of temperature data> <filename of energy data> <filename of output>`

or `python hw2.py <filename of temperature data> <filename of energy data>`

will get the merged data required in this homework.

Specifically, to reproduce the output file from the given data, run

`python scripts/hw2.py hw2-datamerge/waterTemperature.csv hw2-datamerge/energy.csv results/output.csv`

**Quick view of the output table (first 51 rows):**

|Index|Date Time           |Temperature|Energy (Wh/1000)|
|-----|--------------------|-----------|----------------|
|1    |07/29/16 10:26:34 AM|72.86      |,               |
|2    |07/29/16 11:26:34 AM|73.92      |,               |
|3    |07/29/16 12:26:34 PM|73.98      |,               |
|4    |07/29/16 01:26:34 PM|74.86      |,               |
|5    |07/29/16 02:26:34 PM|75.34      |,               |
|6    |07/29/16 03:26:34 PM|76.75      |,               |
|7    |07/29/16 04:26:34 PM|77.95      |,               |
|8    |07/29/16 05:26:34 PM|75.16      |,               |
|9    |07/29/16 06:26:34 PM|74.30      |,               |
|10   |07/29/16 07:26:34 PM|73.89      |,               |
|11   |07/29/16 08:26:34 PM|74.23      |,               |
|12   |07/29/16 09:26:34 PM|73.53      |,               |
|13   |07/29/16 10:26:34 PM|73.27      |,               |
|14   |07/29/16 11:26:34 PM|73.45      |9.468           |
|15   |07/30/16 12:26:34 AM|72.30      |,               |
|16   |07/30/16 01:26:34 AM|72.70      |,               |
|17   |07/30/16 02:26:34 AM|72.82      |,               |
|18   |07/30/16 03:26:34 AM|72.77      |,               |
|19   |07/30/16 04:26:34 AM|72.61      |,               |
|20   |07/30/16 05:26:34 AM|72.54      |,               |
|21   |07/30/16 06:26:34 AM|72.18      |,               |
|22   |07/30/16 07:26:34 AM|72.07      |,               |
|23   |07/30/16 08:26:34 AM|71.82      |,               |
|24   |07/30/16 09:26:34 AM|69.84      |,               |
|25   |07/30/16 10:26:34 AM|73.09      |,               |
|26   |07/30/16 11:26:34 AM|77.43      |,               |
|27   |07/30/16 12:26:34 PM|82.18      |,               |
|28   |07/30/16 01:26:34 PM|85.08      |,               |
|29   |07/30/16 02:26:34 PM|87.33      |,               |
|30   |07/30/16 03:26:34 PM|84.78      |,               |
|31   |07/30/16 04:26:34 PM|88.74      |,               |
|32   |07/30/16 05:26:34 PM|86.99      |,               |
|33   |07/30/16 06:26:34 PM|88.02      |,               |
|34   |07/30/16 07:26:34 PM|86.16      |,               |
|35   |07/30/16 08:26:34 PM|86.09      |,               |
|36   |07/30/16 09:26:34 PM|85.33      |,               |
|37   |07/30/16 10:26:34 PM|84.70      |,               |
|38   |07/30/16 11:26:34 PM|85.87      |12.062          |
|39   |07/31/16 12:26:34 AM|85.48      |,               |
|40   |07/31/16 01:26:34 AM|85.53      |,               |
|41   |07/31/16 02:26:34 AM|84.40      |,               |
|42   |07/31/16 03:26:34 AM|81.61      |,               |
|43   |07/31/16 04:26:34 AM|84.16      |,               |
|44   |07/31/16 05:26:34 AM|84.07      |,               |
|45   |07/31/16 06:26:34 AM|84.13      |,               |
|46   |07/31/16 07:26:34 AM|84.69      |,               |
|47   |07/31/16 08:26:34 AM|84.72      |,               |
|48   |07/31/16 09:26:34 AM|82.47      |,               |
|49   |07/31/16 10:26:34 AM|79.97      |,               |
|50   |07/31/16 11:26:34 AM|82.04      |,               |



**Code snapshoot:**
```python
import sys
import re

temperature= sys.argv[1]
energy = sys.argv[2]
if(len(sys.argv) == 4):
    output = open(sys.argv[3],"w")
elif(len(sys.argv) == 3):
    output = sys.stdout
else:
    raise IOError("The number of arguments must be 2 or 3.")

def check_time(list):
    """ This function is to check whether all dates are at 00:00:00
    (midnight, morning of the given day, Wisconsin time)
    """
    index = 0
    for time in list:
        if time != "00:00:00,-0500":
            index += 1
    if index != 0:
        return(False)
    else: return(True)


def is_sorted(list):
    """ This function is to check the time order
    """
    pairs = []
    for i in range(len(list)-1):
        pairs.append([list[i],list[i+1]])
    index = 0
    for pair in pairs:
        if pair[0] > pair[1]:
            index += 1
    if index == 0:
        return(True)
    else: return(False)

def merging_data(temp_file_name, energy_file_name, output_file_name):
    """This function is going to take 2 file names as arguments,
    and creates an output with the merged data, in 'csv' format."""

    #deal with the energy data
    with open(energy_file_name) as energy_csv:
        energy_date = []
        energy_value = []
        energy_time = []
        for line in energy_csv:
            if re.search(r'^(\d+)-(\d+)-(\d+).*',line):
                date = re.sub(r'^(\d+)-(\d+)-(\d+).*', r'\1-\2-\3', line)
                value = re.sub(r'.*,(\d+)', r'\1', line)
                # divide the energy values by 1000
                value_1 = str(int(value.rstrip())/1000)
                time = re.sub(r'.* (\d+:\d+:\d+).*(-\d+).*', r'\1,\2', line)
                energy_date.append(date.rstrip())
                energy_value.append(value_1)
                energy_time.append(time.rstrip())
    # check time form and order
    if(check_time(energy_time) == False):
        print("Error: all energy dates should be at 00:00:00, Wisconsin time")
        return
    elif(is_sorted(energy_date) == False):
        print("Error: energy dates should be sorted")
        return
    else:
        # deal with the temperature file
        import time
        # This function is to find the key when sort the temperature by time
        def getKey(item):
            return item[2]

        with open(temp_file_name) as temp_csv:
            temp_index = []
            temp_date = []
            temp_value = []
            temp_list = []
            for line in temp_csv:
                if re.search(r'^(\d+).*', line):
                    index = re.sub(r'(\d+),.*', r'\1', line)
                    date = re.sub(r'\d+,(.*),\d+.*', r'\1', line)
                    t_date = time.strptime(date.rstrip(), '%m/%d/%y %I:%M:%S %p')
                    value = re.sub(r'.*,(\d+.*)', r'\1', line)
                    temp_index.append(index.rstrip())
                    # To make it convenient to find the particular time which the energy value shold be matched with,
                    # I sort the temperature data by time first
                    temp_list.append([date.rstrip(),value.rstrip(), t_date])
                    temp_list = sorted(temp_list,key = getKey) #sorted by time
            for item in temp_list:
                temp_date.append(item[0])
                temp_value.append(item[1])

        # To make it convenient to match the date in two files, I make the time form of these two files consistent.
        energy_new_date = []
        temp_new_date = []
        for date in energy_date:
            new_date = re.sub(r'\d{2}(.*)', r'\1', date)
            energy_new_date.append(new_date)
        for date in temp_date:
            new_date = re.sub(r'(\d+)/(\d+)/(\d+)(.*)', r'\3-\1-\2', date)
            temp_new_date.append(new_date)

        # Match the energy value for a particular time with the temperature data logged just before that time.
        temp_energy_value = []
        n_energy = 1
        currentEnergyDay = energy_new_date[n_energy-1]
        for i in range(len(energy_new_date)): # will not have value for the last day in temp
            if n_energy < len(energy_new_date):
                for j in range(len(temp_new_date)):
                    if temp_new_date[j] == currentEnergyDay:
                        if temp_new_date[j+1] == currentEnergyDay:
                            temp_energy_value.append(",")
                        else:
                            temp_energy_value.append(energy_value[n_energy])
            n_energy += 1
            if n_energy <= len(energy_new_date):
                currentEnergyDay = energy_new_date[n_energy-1]
            else:
                # If there are dates in temperature file that cannot be matched with a value in energy file,
                # put an 'NA' in the place where there should be a energy value.
                for j in range(len(temp_new_date)):
                    if temp_new_date[j] >= currentEnergyDay:
                        if j != len(temp_new_date) -1:
                            if temp_new_date[j] == temp_new_date[j+1]:
                                temp_energy_value.append(",")
                            else: temp_energy_value.append("NA")
                        else: temp_energy_value.append("NA")

        #write the output to a csv table
        output.write(",".join(['"Index"','"Date Time"','"Temperature"','"Energy (Wh/1000)"']))
        output.write("\n")
        for i in range(len(temp_new_date)):
            output.write(",".join([temp_index[i],temp_date[i],temp_value[i],temp_energy_value[i]]))
            output.write("\n")
        return

if __name__=="__main__":
    merging_data(temperature, energy, output)

```
