***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${login_makroproweb.txt_forgot_password}           xpath=//a[text()="${web['login']['label']['forgotPassword']}"]
${login_makroproweb.btn_email_tab}                 xpath=//button[text()="${web['global']['email']}"]
${login_makroproweb.txt_email_input}               xpath=//input[@name="email"]
${login_makroproweb.txt_password_input}            xpath=//input[@name="password"]
${login_makroproweb.btn_login}                     xpath=//button[text()="${web['login']['label']['login']}"]
