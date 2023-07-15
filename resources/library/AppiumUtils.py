from robot.libraries.BuiltIn import BuiltIn
from AppiumLibrary import AppiumLibrary
from selenium.webdriver import ActionChains
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By


class AppiumUtils():
    def get_driver_instance(self):
        return BuiltIn().get_library_instance('AppiumLibrary')._current_application()

    def input_letter_by_letter(self,element,text,clear=True):
        driver = self.get_driver_instance()
        for i in range(4):
            # Wait for initialize, in seconds
            wait = WebDriverWait(driver, 10)
            elm_to_click = wait.until(EC.visibility_of_element_located((By.XPATH, element)))
            elm_to_click.click()
            if clear:
                elm_to_clear = wait.until(EC.visibility_of_element_located((By.XPATH, element)))
                elm_to_clear.clear()
            action_chains = ActionChains(driver)
            action_chains.send_keys(str(text))
            action_chains.perform()
            #cached element is not linked to the same object in DOM anymore
            elm_new = wait.until(EC.visibility_of_element_located((By.XPATH, element)))
            text_entered = elm_new.text
            if text_entered:
                break;
