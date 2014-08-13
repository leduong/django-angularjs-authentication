
DEBUG = True
TEMPLATE_DEBUG = DEBUG

ADMINS = (
    # ('Your Name', 'leduongcom@example.com'),
)

MANAGERS = ADMINS

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',  # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
        'NAME': 'db.sqlite',                      # Or path to database file if using sqlite3.
        'USER': '',
        'PASSWORD': '',
        'HOST': '',                      # Empty for localhost through domain sockets or '127.0.0.1' for localhost through TCP.
        'PORT': '',                      # Set to empty string for default.
    }
}

# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.
# In a Windows environment this must be set to your system time zone.
TIME_ZONE = 'America/Denver'


# Make this unique, and don't share it with anybody.
SECRET_KEY = '4444444444444444444'

DEBUG_APPS = ()

CORS_ORIGIN_WHITELIST = (
    'localhost:8000',
    'localhost/',
    '127.0.0.1:8080',
    '127.0.0.1:9000',
    'localhost:9000/',
    'localhost:9000'
)
