import requests
import tarfile
import os

# Set url to download link
url = "https://covid19.infn.it/iss/csv_part/iss.tar.gz"
# Download the file
response = requests.get(url, stream=True)
# Extract and save the datasets to folder 0_archive
file = tarfile.open(fileobj=response.raw, mode="r|gz")
file.extractall(path=os.path.join(os.getcwd(),"0_archive"))


