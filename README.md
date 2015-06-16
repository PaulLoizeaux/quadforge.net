# QuadForge Website using Jekyll

## Install Git

#### Debian/Ubuntu

`sudo apt-get install git`

#### Mac OS

`Placeholder`

#### Windows

`Placeholder`

## Download the web site files to your computer

Fork the official copy and substitute your repo name below.

`git clone repo@github.com`

## Install Jekyll

Go into the folder for the website and run the below series of commands. 

### Required software before Jekyll install

ruby, ruby-dev - Programming language for Jekyll

bundler - Ruby utility to install ruby gems

imagemagick, libmagickcore-dev, libmagickwand-dev - Image generator for PDFs

ghostscript - PDF image creator

build-essential - Compile and build software from source

#### Debian/Ubuntu

`sudo apt-get install ruby ruby-dev bundler imagemagick libmagickcore-dev libmagickwand-dev ghostscript build-essential`

#### Mac OS

`Placeholder`

#### Windows

`Placeholder`

### Run bundler to install Jekyll and all required Ruby gems

While in the website folder run the below to install jekyll once all dependencies are installed.

#### Debian/Ubuntu

`sudo bundle install`

#### Mac OS

`Placeholder`

#### Windows

`Placeholder`

## Generate new site after updates

`jekyll build`

## Upload new files to webserver

Go into the `_site` folder and copy all contents to the web server under `/home4/quadforg/public_html/jekyll`. All of the files and folders in there are from the jekyll generated site except for cgi-bin, that comes from the web server.
