import os
from bs4 import BeautifulSoup
from robot.libraries.BuiltIn import BuiltIn
from datetime import datetime, date
from imap_tools import MailBox, A, AND, OR, NOT

class email_utils():
    def extract_file_html(self, html_string):
        soup = BeautifulSoup(html_string, "html.parser")
        html_text = soup.get_text()
        return    html_text
