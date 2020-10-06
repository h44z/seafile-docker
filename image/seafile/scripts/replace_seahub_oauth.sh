#!/bin/bash
echo Patching files...
sed -i "/{% block main_content %}/a <script type=\"text/javascript\">window.location.replace(\"{% url 'oauth_login' %}\");</script>" /opt/seafile/seafile-server-latest/seahub/seahub/templates/registration/login.html
sed -i '/<\/div>/a <script type="text/javascript">window.location.replace("https://account.sprinternet.at/ssologout?src=seafile");</script>' /opt/seafile/seafile-server-latest/seahub/seahub/templates/registration/logout.html
echo Patching completed...