import os
from glob import glob

# Print out the current directory:
CURRDIR = os.getcwd()
print(f"Current directory: {CURRDIR}")

# Store all subdirs:
all_subdirs = glob(f"{CURRDIR}/*/", recursive=True)
# print(f"All subdirectories: {all_subdirs}")

# Check if there are .json files in each:
for subdir in all_subdirs:
    all_json = glob(f"{subdir}*.json", recursive=True)
    # print(subdir)
 
    folderName = subdir.split("/")[-2]
    
    if len(all_json) == 0:
        print(f">> {folderName} does not contain .json files")
    else:
        print(f"{folderName} ok")

