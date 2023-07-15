***Settings***
Variables       ../../localisation/web/${lang}.yaml
Variables       ../../localisation/web/${lang}_additional.yaml

*** Variables ***
${forgot_makroproweb.txt_reset_password_title}      xpath=//p[text()="${web['resetPassword']['title']['resetPassword']}"]
${forgot_makroproweb.txt_reset_instruction}         xpath=//p[text()="${web['resetPassword']['message']['emailWithInstruction']}"]