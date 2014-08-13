# Django AngularJS Authentication

Includes Way Generators (required git/nodejs/python2.7+)!
You're encouraged to setup a `virtualenv` to work in prior to configuring the dependencies.

Client and Dev:

    $ npm install -g bower grunt-cli
    $ bower install
    $ npm install
    $ grunt


Launching The Testing and Demonstration App
-------------------------------------------
This is a work in progress, but it gives some hints on usage in a real world scenario.

1. Create a Python virtualenv.
        cd server
        virtualenv env
        source env/bin/activate  # On Windows use `env\Scripts\activate`

2. Install the dependencies:

        pip install -r requirements.txt

3. Set up the database and fixtures (if first time use).

        chmod +x manage.py
        ./manage.py syncdb
        ./manage.py schemamigration --initial app
        ./manage.py migrate rest_framework.authtoken
        ./manage.py createsuperuser

4. Run the server:

        source env/bin/activate
        ./manage.py runserver

5. Point web browser to `http://localhost:8000/`.