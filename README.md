# Continuous Integration Auto Merge
A small script allowing you to auto merge a development branch into a stable branch (given the push passes all the tests). This script was created for use with Travis CI.

## Setup
Add your version control username and password to your ``.travis.yml`` file using the ``travis`` ruby gem:
```
$ travis encrypt USERNAME=<username> --add env.global
$ travis encrypt PASSWORD=$(cat <password_file.txt>) --add env.global
```

Now add the ``merge.sh`` to execute after a successful travis build by adding the following to your ``.travis.yml``:
```
after_success: ./merge.sh $USERNAME $PASSWORD
```
