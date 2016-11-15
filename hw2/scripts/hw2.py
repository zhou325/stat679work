import sys
import re

#deal with the energy data
with open(sys.argv[2]) as energy_csv:
    energy_date = []
    energy_value = []
    energy_time = []
    for line in energy_csv:
        if re.search(r'^(\d+)-(\d+)-(\d+).*',line):
            date = re.sub(r'^(\d+)-(\d+)-(\d+).*', r'\1-\2-\3', line)
            value = re.sub(r'.*,(\d+)', r'\1', line)
            value_1 = str(int(value.rstrip())/1000)
            time = re.sub(r'.* (\d+:\d+:\d+).*(-\d+).*', r'\1,\2', line)
            energy_date.append(date.rstrip())
            energy_value.append(value_1)
            energy_time.append(time.rstrip())
            
# check whether all dates are at 00:00:00 (midnight, morning of the given day, Wisconsin time)
def check_time(list):
    index = 0
    for time in list:
        if time != "00:00:00,-0500":
            index += 1
    if index != 0:
        print("Error: all dates should be at 00:00:00, Wisconsin time")
        return(False)
    else: return(True)
check_time(energy_time)
# check the time order
def pairs(list):
    pair = []
    for i in range(len(list)-1):
        pair.append([list[i],list[i+1]])
    return(pair)
def is_sorted(list):
    check = pairs(list)
    index = 0
    for pair in check:
        if pair[0] > pair[1]:
            index += 1
    if index == 0:
        return(True)
    else: return(False)
is_sorted(energy_date)

# deal with the temperature file
import time
def getKey(item):
    return item[2]

with open(sys.argv[1]) as temp_csv:
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
            temp_list.append([date.rstrip(),value.rstrip(), t_date])
            temp_list = sorted(temp_list,key = getKey) #sorted by time
    for item in temp_list:
        temp_date.append(item[0])
        temp_value.append(item[1])

# for comparing the date
energy_new_date = []
temp_new_date = []
for date in energy_date:
    new_date = re.sub(r'\d{2}(.*)', r'\1', date)
    energy_new_date.append(new_date)
for date in temp_date:
    new_date = re.sub(r'(\d+)/(\d+)/(\d+)(.*)', r'\3-\1-\2', date)
    temp_new_date.append(new_date)

# create temp_energy_value
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
        for j in range(len(temp_new_date)):
            if temp_new_date[j] >= currentEnergyDay:
                if j != len(temp_new_date) -1:
                    if temp_new_date[j] == temp_new_date[j+1]:
                        temp_energy_value.append(",")
                    else: temp_energy_value.append("NA")
                else: temp_energy_value.append("NA")

if(len(sys.argv) == 4):
    output = open(sys.argv[3],"w")
elif(len(sys.argv) == 3):
    output = sys.stdout
else:
    raise IOError("The number of arguments must be 2 or 3.")

output.write(",".join(['"Index"','"Date Time"','"Temperature"','"Energy (Wh/1000)"']))
output.write("\n")
for i in range(len(temp_new_date)):
    output.write(",".join([temp_index[i],temp_date[i],temp_value[i],temp_energy_value[i]]))
    output.write("\n")
