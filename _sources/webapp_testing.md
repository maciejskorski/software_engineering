# Class 6: Testing Web Pages

Install Selenium with `pip install selenium`, and look at this code snippet
```python
from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import requests

# valid on MacOS: use brew install chromedriver
WEBDRIVER_PATH=r"/usr/local/bin/chromedriver"

# access chromedriver, may need to set its binary as trusted - remove quarantine attribute on MacOS
driver = webdriver.Chrome(WEBDRIVER_PATH)

#provide website url here
driver.get("http://demo.guru99.com/test/newtours/")

#get all links
all_links = driver.find_elements(By.CSS_SELECTOR,"a")

#check each link if it is broken or not
for link in all_links:
    #extract url from href attribute
    url = link.get_attribute('href')

    #send request to the url and get the result
    result = requests.head(url)

    #if status code is not 200 then print the url (customize the if condition according to the need)
    if result.status_code != 200:
        print(url, result.status_code)

driver.quit()
```
Note: the code adapted from [this Selenium tutorial[(https://www.educative.io/answers/how-to-find-all-broken-links-using-selenium-webdriver-in-python)
