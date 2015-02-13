<?php

return array(
		'default-connection' => 'concrete',
		'connections' => array(
				'concrete' => array(
						'driver' => 'c5_pdo_mysql',
						'server' => '@DB_SERVER@',
						'database' => '@DB_NAME@',
						'username' => '@DB_USER@',
						'password' => '@DB_PASSWD@',
						'charset' => 'utf8'
				)
		)
);
