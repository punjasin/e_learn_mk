from robotframework_reportportal import logger
import os

def send_attachment_to_report_portal(screenshot_file_path):
    try:
        with open(screenshot_file_path, "rb") as image_file:
            image_data = image_file.read()
            logger.error("error screenshot",
                        attachment={"name": os.path.basename(screenshot_file_path),
                                    "data": image_data,
                                    "mime": "image/png"})
    except:
        pass