===========================
Vagrant script provisioning
===========================

Shell script based provisioning for Vagrant machines

Tricks
======

Debian: Capturing Config and Preconfiguration
---------------------------------------------

By the example of postfix.

Capturing config:

.. code-block:: sh

   PACKAGE=postfix
   apt-get install $PACKAGE
   # now make your selections
   debconf-get-selections | grep $PACKAGE >> $PACKAGE.debconf
   apt-get purge $PACKAGE
 
Preconfiguration:

.. code-block:: sh

   # in the provision script
   PACKAGE=postfix
   debconf-set-selections < `dirname $0`/$PACKAGE.debconf
   apt-get install -y $PACKAGE
