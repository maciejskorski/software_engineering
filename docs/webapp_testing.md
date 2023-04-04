# Class 6: Testing Web Pages

Install Selenium with `pip install selenium`, and execute interactively (IPython) this code snippet
```python
from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import requests

# access chromedriver, may need to set its binary as trusted - remove quarantine attribute on MacOS
driver = webdriver.Chrome()

# provide website url here
driver.get("http://demo.guru99.com/test/newtours/")

# get all links
all_links = driver.find_elements(By.CSS_SELECTOR,"a")

# check each link if it is broken or not
for link in all_links:
    # extract url from href attribute
    url = link.get_attribute('href')

    # end request to the url and get the result
    result = requests.head(url)

    #if status code is not 200 then print the url (customize the if condition according to the need)
    if result.status_code != 200:
        print(url, result.status_code)

driver.quit()
```
Note: the code adapted from [this Python tutorial on Selenium](https://www.educative.io/answers/how-to-find-all-broken-links-using-selenium-webdriver-in-python).
See also [this Java tutorial](https://www.guru99.com/find-broken-links-selenium-webdriver.html).

driver.get("https://maciejskorski.github.io/software_engineering")
driver.find_elements(By.NAME,"search-button__wrapper show")
