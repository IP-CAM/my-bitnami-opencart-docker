FROM docker.io/bitnami/opencart:3

RUN sed -i 's/;\[XDebug\]/\[XDebug\]/'						/opt/bitnami/php/etc/php.ini
RUN sed -i 's/;zend_extension = xdebug/zend_extension = xdebug/'		/opt/bitnami/php/etc/php.ini
RUN sed -i 's/;xdebug.mode = debug/xdebug.mode = debug/'			/opt/bitnami/php/etc/php.ini
RUN sed -i 's/;xdebug.client_host = 127.0.0.1/xdebug.client_host = 127.0.0.1/'	/opt/bitnami/php/etc/php.ini
RUN sed -i 's/;xdebug.client_port = 9000/xdebug.client_port = 9000/'		/opt/bitnami/php/etc/php.ini
RUN sed -i 's/;xdebug.output_dir = \/tmp/xdebug.output_dir = \/tmp/'		/opt/bitnami/php/etc/php.ini
RUN sed -i 's/;xdebug.remote_handler = dbgp/xdebug.remote_handler = dbgp/'	/opt/bitnami/php/etc/php.ini
RUN echo 'xdebug.start_with_request = yes'					>> /opt/bitnami/php/etc/php.ini
RUN echo 'xdebug.idekey = VSCODE'						>> /opt/bitnami/php/etc/php.ini
RUN echo 'xdebug.remote_enable = 1'						>> /opt/bitnami/php/etc/php.ini

USER 0
RUN mkdir /.vscode-server
RUN chmod 777 /.vscode-server

ENV SCRIPT_FOLDER=/docker-entrypoint-init.d
RUN mkdir $SCRIPT_FOLDER

ENV SCRIPT_FILE=update-config.sh
COPY ./$SCRIPT_FILE $SCRIPT_FOLDER
RUN chmod 777 $SCRIPT_FOLDER/$SCRIPT_FILE

ENV SCRIPT_FILE=update-admin-config.sh
COPY ./$SCRIPT_FILE $SCRIPT_FOLDER
RUN chmod 777 $SCRIPT_FOLDER/$SCRIPT_FILE

USER 1001

