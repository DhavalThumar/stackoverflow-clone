# stackoverflow-clone
Follow the below steps to setup project

Clone ther directory using below command:

    git clone https://github.com/dhavalp7/stackoverflow-clone.git

    cd stackoverflow-clone

Create virtualenv using bellow command (to download virtualenv):

    python3 -m virtualenv env

To activate virtualenv:

    source env/bin/activate         (for Ubantu)

    or

    env/Script/activate             (for Windows)

    cd stackoverflow-clone

To install dependencies:

    pip install requirements.txt

If the above command fails try:

    pip install Django==1.11.20

    pip install django-crispy-forms==1.7.2

    pip install PyMySQL==0.9.3

To apply migrations of app's datamodels:

    python manage.py makemigrations app

    python manage.py migrate

To start development server:
    python manage.py runserver 8000

Open the browser:

    localhost:8000

Bingo!!!
