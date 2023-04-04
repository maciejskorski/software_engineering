

def test_webpage_search():
    from selenium import webdriver
    from selenium.webdriver.common.keys import Keys 
    from selenium.webdriver.common.by import By

    # test if the class page is searchable
    driver = webdriver.Chrome()
    driver.get("https://maciejskorski.github.io/software_engineering")
    elem = driver.find_element(By.CLASS_NAME,"search-button")
    elem.click()
    elem = driver.find_element(By.NAME,"q")
    elem.send_keys("UML")
    elem.send_keys(Keys.RETURN)

    assert "Modelling with UML diagrams" in driver.page_source
    driver.quit()
