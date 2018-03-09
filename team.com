
server {
	listen 80;
	listen [::]:80;

	root /home/triplei/web_team;

	index index.html index.htm index.nginx-debian.html;

	server_name team.com www.team.com;

	location / {
		try_files $uri $uri/ =404;
	}


	location ~ \.php$ {
	include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        fastcgi_connect_timeout 60;
        fastcgi_send_timeout 180;
        fastcgi_read_timeout 180;
        fastcgi_buffer_size 128k;
        fastcgi_buffers 4 256k;
        fastcgi_busy_buffers_size 256k;
        fastcgi_temp_file_write_size 256k;
    }


	location ~ /\.ht {
		deny all;
	}
}

