# WordPress Docker Compose

Local WordPress development made easy.

Images used:

- [WordPress + wp-cli](https://hub.docker.com/_/wordpress/)
- [phpMyAdmin](https://hub.docker.com/r/phpmyadmin/phpmyadmin/)
- [MySQL](https://hub.docker.com/_/mysql/)

## Usage

```
sudo apt install docker docker-compose
sudo usermod -G docker mitch
git clone http://github.com/mitchweaver/wordpress-docker-compose
cd $_
docker-compose up -d
```

To later shut down containers:

```
docker-compose down
```

## Configuration

Edit the `.env` to access your database if necessary.  
If creating a new project, just use the defaults.

## That's it!

You should be able to access the WordPress installation in your browser.  
By default it is `http://localhost`.

You can also visit `http://localhost:8080` to access phpMyAdmin.  
The default creds are `root`/`password`.
The login creds are specified in the `.env` file, default: `root`/`password`.

## Tools

A few tools are located in the `./bin` directory.

| Tool | Function |
| ---- | ---- |
| `export.sh` | dump a backup of the sql database |
| `setup_docker_network.sh` | create a virtual network to access docker, if needed |
| `wp-cli.sh` | wrapper to easily access wp-cli within the container |

## Credit

This repo is originally a fork from [nezhar's](https://github.com/nezhar/wordpress-docker-compose) wordpress-docker-compose.
