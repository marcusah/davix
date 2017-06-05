#!/bin/bash

####################################################
## DAVIX 2014 Application Installation Script     ##
## DAVIX 2014 Core Applications                   ##
##                                                ##
## DEVELOPMENT V1.5  6 JULY 2015                  ##
####################################################

# init
function pause(){
    read -p "$*"
}

# Setup
export DH="/opt/davix"
export DPMI="/home/davix/davix-packages-manual-install"
export LibMagic_LIBRARY="/usr/lib/i386-linux-gnu/"
export LibMagic_INCLUDE_DIR="/usr/lib/i386-linux-gnu/"

# Build the directory structure
cd $DPMI
mkdir gephi p0f argus pulledpork BroIDS jquery-sparklines nsm-console eventlog TreeMap Cytoscape Mondrian TNV Parvis Timesearcher1 walrus PerlPackages GUESS InetVis processing PyInline Rumint gltail FlowTag INAV Netgrok SeedsOfContempt RTGraph3D parsers maltego picviz ipsumdump passivedns graphviz tulip tcp-reduce 

## Afterglow
git clone https://github.com/zrlram/afterglow $DH/afterglow
git clone https://github.com/zrlram/parsers $DH/parsers

## SiLK 
echo "Installing SiLK"
cd $DPMI/silk
wget -c https://tools.netsa.cert.org/releases/silk-3.9.0.tar.gz
tar -xzpf silk-3.9.0.tar.gz
cd silk-3.9.0
./configure
make
make install

## Argus Server
echo "Installing Argus Server"
cd $DPMI/argus
wget -c http://qosient.com/argus/src/argus-latest.tar.gz
wget -c http://qosient.com/argus/src/argus-clients-latest.tar.gz
tar -xvpf argus-latest.tar.gz 
tar -xvpf argus-clients-latest.tar.gz 
cd argus-latest/
./configure
make
make install

## Argus Client
echo "Installing Argus Client"
cd $DPMI/argus-clients-latest/
./configure 
make
make install

# tcp-reduce
echo "Installing tcp-reduce"
cd $DPMI/tcp-reduce
#wget -c ftp://ita.ee.lbl.gov/software/tcp-reduce-1.0.tar.Z
wget -c https://packetstormsecurity.com/files/download/13104/tcp-reduce-1.0.tar.Z
tar -xzf tcp-reduce-1.0.tar.Z
mv tcp-reduce* /opt/davix
ln -s /opt/davix/tcp-reduce-1.0/tcp-reduce /opt/davix/scripts/tcp-reduce
ln -s /opt/davix/tcp-reduce-1.0/tcp-conn /opt/davix/scripts/tcp-conn
ln -s /opt/davix/tcp-reduce-1.0/tcp-summary /opt/davix/scripts/tcp-summary

## GraphViz New Version
echo "Installing GraphViz"
cd $DPMI/graphviz
wget -c http://www.graphviz.org/pub/graphviz/stable/SOURCES/graphviz-2.40.1.tar.gz
tar -xzf graphviz-*.tar.gz
cd graphviz*
./configure --prefix=/usr --datadir=/usr/share --infodir=/usr/share/info --mandir=/usr/share/man
make
make install
cp $DPMI/davix/install/config/graphviz.conf /etc/ld.so.conf.d/
ldconfig
dot -c

## Tulip
echo "Installing Tulip"
cd $DPMI/tulip
wget -c 'https://sourceforge.net/projects/auber/files/tulip/tulip-4.10.0/tulip-4.10.0_src.tar.gz/download' -O tulip-4.10.0_src.tar.gz
tar -xzf tulip-4.10.0_src.tar.gz
cd tulip
cmake . 
make
make install

## BroIDS (requires CMake)
echo "Installing BroIDS"
cd $DPMI/BroIDS
wget -c https://www.bro.org/downloads/release/bro-2.4.1.tar.gz
tar -xvpf bro-2.4.1.tar.gz
cd bro-2.4.1
./configure --prefix=$DH/broids
make
make install
$DH/broids/bin/broctl install

## Perl Chart Director
echo "Installing ChartDirector"
cd $DPMI/PerlPackages
wget -c download2.advsofteng.com/chartdir_perl_linux_64.tar.gz 
tar -xvpf chartdir_perl_linux.tar.gz
# Add to perl @INC Path
mv ChartDirector /usr/lib/perl5/
yes '' | cpan -i Crypt::SSLeay
cpan -i IP::Anonymous
cpan -i Crypt::Rijndael
cpan -i Test::Manifest

## Cytoscape
echo "Installing Cytoscape"
cd $DPMI/Cytoscape
wget -c http://chianti.ucsd.edu/cytoscape-3.5.1/Cytoscape_3_5_1_unix.sh
chmod +x ./Cytoscape_3_5_1_unix.sh
mkdir -p $DH/Cytoscape
./Cytoscape_3_5_1_unix.sh -q -dir /opt/davix/Cytoscape/
rm Cytoscape_3_5_1_unix.sh      # remove the installer file. It's huge

# EVENTLOG
echo "Installing Eventlog"
cd $DPMI/eventlog
wget -c https://www.balabit.com/downloads/files/eventlog/0.2/eventlog-0.2.4.tar.gz
tar -xvpf eventlog-0.2.4.tar.gz
mkdir -p $DH/eventlog
cd eventlog-0.2.4
 ./configure --prefix=$DH/eventlog
 make
 make install


## FlowTag
echo "Installing FlowTag"
cd $DPMI/FlowTag
git clone https://github.com/chrislee35/flowtag.git
#wget -c https://chrislee.dhs.org/projects/flowtag/flowtag-2.0.5.tgz #insecure
#tar -xvpf flowtag-2.0.5.tgz

cd flowtag
gem install flowtag
#ruby setup.rb


## Gephi
cd $DPMI/gephi
wget -c https://github.com/gephi/gephi/releases/download/v0.9.1/gephi-0.9.1-linux.tar.gz
tar -xzf gephi-0.9.1-linux.tar.gz
mv gephi-0.9.1 $DH/gephi
echo '#!/bin/bash' > /opt/davix/scripts/gephi
echo "sudo /opt/davix/gephi/bin/gephi --jdkhome /usr/lib/jvm/java-8-openjdk-amd64/jre" >> /opt/davix/scripts/gephi
chmod +x /opt/davix/scripts/gephi

## glTail
echo "Installing glTail"
git clone https://github.com/Fudge/gltail $DH/gltail


## GUESS
echo "Installing GUESS"
cd $DPMI/GUESS
wget -c https://downloads.sourceforge.net/project/guess/guess/guess-1.0.3-beta/guess-20070813.zip
unzip guess-20070813.zip
mv guess $DH/guess

 echo "#!/bin/sh" >> $DH/guess/guess.sh
 echo "" >> $DH/guess/guess.sh
 echo "export GUESS_HOME=$DH/guess">> $DH/guess/guess.sh
 echo "" >> $DH/guess/guess.sh
 echo "export GUESS_LIB\"$GUESS_HOME/lib\" ">> $DH/guess/guess.sh
 echo "">> $DH/guess/guess.sh
 echo "export GCLASSPATH=\"$GUESS_LIB/guess.jar:$GUESS_LIB/piccolo.jar:$GUESS_LIB/piccolox.jar:$GUESS_LIB/jung.jar:$GUESS_LIB/commons-collections.jar:$GUESS_LIB/hsqldb.jar:$GUESS_LIB/freehep-all.jar:$GUESS_LIB/colt.jar:$GUESS_LIB/prefuse.jar:$GUESS_LIB/TGGraphLayout.jar:$GUESS_LIB/looks.jar:$GUESS_LIB/mascoptLib.jar:$GUESS_LIB/jfreechart.jar:$GUESS_LIB/jide-components.jar:$GUESS_LIB/jide-common.jar:$GUESS_LIB/forms.jar:$GUESS_LIB/jcommon.jar " >> $DH/guess/guess.sh
 echo "echo $GCLASSPATH">> $DH/guess/guess.sh
 echo "" >> $DH/guess/guess.sh
 echo "java -DgHome=$GUESS_HOME -classpath $GCLASSPATH \"-Dpython.home=$GUESS_HOME/src\" com.hp.hpl.guess.Guess $@ " >> $DH/guess/guess.sh
 echo "echo $?">> $DH/guess/guess.sh
chmod +x $DH/guess/guess.sh

## INAV
echo "Installing INAV"
cd $DPMI/davix/tools/inav
tar -xvpf INAV-Server.tar.gz
mkdir $DH/INAV
mv $DPMI/davix/tools/inav/INAV-0.13.jar $DH/INAV
cd $DPMI/davix/tools/inav/INAV-Server-0.3.7/server
# TODO Location of makefile?
cp $XXX/makefile .
make 


## InetVis
echo "Installing InetVis"
cd $DPMI/InetVis
wget -c http://www.cs.ru.ac.za/research/g02v2468/inetvis/0.9.3/inetvis-0.9.3.1.tar.gz
tar -xvpf inetvis-0.9.3.1.tar.gz
# Dependency
wget https://mirrors.kernel.org/ubuntu/pool/main/q/qt-x11-free/libqt3-mt_3.3.8-b-8ubuntu3_i386.deb
dpkg -i libqt3-mt_3.3.8-b-6ubuntu2_i386.deb
mv inetvis-0.9.3.1 $DH


# Logstash
echo "Installing ElasticSearch LogStash Kibana"
cd /tmp
wget -c https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.0.deb
wget -c https://artifacts.elastic.co/downloads/logstash/logstash-5.4.0.deb
dpkg -i elasticsearch-5.4.0.deb
dpkg -i logstash-5.4.0.deb

echo "LS_GROUP=adm" >> /etc/default/logstash

echo '#!/bin/bash' > /opt/davix/scripts/logstash
echo "sudo /opt/logstash/bin/logstash --path.settings=/etc/logstash $@" >> /opt/davix/scripts/logstash
chmod +x /opt/davix/scripts/logstash

# Build the base configuration file
cat << EOF > /etc/logstash/conf.d/logstash.conf
input {
  file {
    type => "syslog"
    path => [ "/var/log/syslog" ]
  }
}
output {
  stdout { }
  elasticsearch { hosts => ["localhost:9200"] }
}
EOF
# Kibana
wget -c https://artifacts.elastic.co/downloads/kibana/kibana-5.4.0-amd64.deb
dpkb -i kibana*.deb

## Python ElasticSearch
pip install elasticsearch

## Maltego
cd $DPMI/maltego
wget -c 'https://www.paterva.com/web7/downloads.php#tab-3' -O MaltegoCE.v4.0.11.9358.deb #broken. Downloads, but needs registration?
dpkg -i MaltegoCE*.deb


## Mondrian
echo "Installing Mondrian"
cd $DPMI/Mondrian
wget -c https://sourceforge.net/projects/mondrian/files/latest/download/mondrian-13.0.0-25.jar.sum # fixed
mkdir -p $DH/Mondrian
mv Mondrian*.jar $DH/Mondrian/Mondrian.jar

## Netgrok
echo "Installing Netgrok"
cd $DPMI/Netgrok
#wget -c https://netgrok.googlecode.com/files/netgrok20080928.zip
codydunne
git clone https://github.com/codydunne/netgrok.git
#unzip netgrok*.zip
# TODO Resolve Netgrok issues
# Fix ini file
#mv -f $DPMI/davix/install/fixes/netgrok/groups.ini Netgrok/ 
# Get jpcap
#wget -c https://sourceforge.net/projects/jpcap/files/jpcap/v0.01.16/jpcap-0.01.16.tar.gz
#tar -xvpf jpcap-0.01.16.tar.gz
#cp Netgrok/lib/linux/jpcap.jar /usr/lib/jvm/default-java/jre/lib/ext
mv Netgrok $DH


# nsm-console
echo "Installing nsm-console"
cd $DPMI/nsm-console
wget -c https://writequit.org/projects/nsm-console/files/nsm-console-0.7.tar.gz
tar -xvpf nsm-console-0.7.tar.gz
# Patch 
mv -f $DPMI/davix/install/fixes/nsm/nsm nsm-console/ 
mv nsm-console $DH


## p0f
echo "Installing p0f"
cd $DPMI/p0f/
wget -c lcamtuf.coredump.cx/p0f3/releases/p0f-3.09b.tgz 
tar -xvpf p0f-3.09b.tgz
cd p0f-3.09b
./build.sh
mkdir -p $DH/p0f/bin
mv docs $DH/p0f
mv p0f* $DH/p0f/bin
cd tools/
make p0f-sendsyn
make p0f-sendsyn6 
make p0f-client
mv p0f-sendsyn $DH/p0f/bin
mv p0f-sendsyn6 $DH/p0f/bin
mv p0f-client $DH/p0f/bin


## Parvis
echo "Installing Parvis"
cd $DPMI/Parvis
#wget -c https://github.com/eagereyes/ParVis/archive/master.zip
#unzip parvis-0.3.1.zip
git clone https://github.com/eagereyes/ParVis.git
#cd ParVis
#cp parvis.bat parvish.sh
#chmod +x parvish.sh
#cd ..
mv ParVis $DH


## Processing
echo "Installing Processing"
cd $DPMI/processing
wget -c download.processing.org/processing-3.3-linux64.tgz
tar -xvpf processing-2.1-linux32.tgz
mv processing-2.1 $DH


## pulledpork: snort rules updater
echo "Installing PulledPork"
cd $DPMI/pulledpork/
wget -c https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/pulledpork/pulledpork-0.7.0.tar.gz
tar -xvpf pulledpork-0.7.0.tar.gz
mv pulledpork-0.7.0 $DH
cd $DH/pulledpork-0.7.0
chmod +x pulledpork.pl


## RT Graph 3D
echo "Installing RT Graph 3D"
cd $DPMI/RTGraph3D
wget -c www.secdev.org/projects/rtgraph3d/files/rtgraph3d-0.1.tgz 
tar -xvpf rtgraph3d-0.1.tgz
# Dependencies - povexport
wget -c www.vpython.org/contents/contributed/povexport-2015-09-04.zip 
unzip povexport*.zip
mv povexport-2015-09-04/* rtgraph3d-0.1/
# Dependencies - PyInline
wget -c https://sourceforge.net/projects/pyinline/files/pyinline/0.03/PyInline-0.03.tar.gz
tar -xvpf PyInline-0.03.tar.gz
chmod -R 755 PyInline-0.03
mv PyInline-0.03/PyInline/*.py rtgraph3d-0.1/
mv rtgraph3d-0.1 $DH


## rumint
echo "Installing rumint"
cd $DPMI/Rumint
wget -c www.rumint.org/software/rumint/rumint_v.214.zip #fixed
unzip rumint_v.214.zip
cd rumint_2.14_distro
wine ./setup.exe


## Sagan Fix - configuration file error so copy correct one
cp -f $DPMI/davix/install/fixes/sagan/sagan.conf /etc


## Seeds of Contempt
echo "Installing Seeds of Contempt"
cd $DPMI/SeedsOfContempt
svn checkout http://seedsofcontempt.googlecode.com/svn/trunk/ seedsofcontempt-read-only
mv seedsofcontempt-read-only $DH/seedsofcontempt


## Timesearcher 1
echo "Installing Timesearcher 1"
cd $DPMI/Timesearcher1
wget -c https://www.cs.umd.edu/hcil/timesearcher/dist/ts1.3.7.tar.gz
tar -xvpf ts1.3.7.tar.gz
wget -c https://www.cs.umd.edu/hcil/timesearcher/dist2/demos_4Gf5x/ts-2.4.zip
unzip ts-2.4.zip
mv ts1.3.7 $DH
mv ts-2.4 $DH/ts1.3.7/demos


## TNV
echo "Installing TNV"
cd $DPMI/TNV
wget -c https://sourceforge.net/projects/tnv/files/tnv/0.3.9/tnv_java_0.3.9.zip
unzip tnv_java_0.3.9.zip
mv tnv-0.3.9 $DH


## TreeMap
echo "Installing TreeMap"
cd $DPMI/TreeMap
wget -c https://www.cs.umd.edu/hcil/treemap/demos/Treemap-4.1.2.zip
unzip Treemap-4.1.2.zip
mv Treemap-4.1.2 $DH


## Walrus
echo "Installing Walrus"
## build java3d environment
cd $DPMI/walrus
wget ftp://www.daba.lv/pub/Programmeeshana/java/3D_java/java3d-1_5_2-linux-i586.bin
sh java3d-1_5_1-linux-i586.bin
mv lib/ext/* /usr/lib/jvm/java-1.6.0-openjdk-i386/jre/lib/ext/
mv lib/i386/* /usr/lib/jvm/java-1.6.0-openjdk-i386/jre/lib/i386/
# Get Walrus Test Data
mkdir tmp
cd tmp
wget -c www.soa-world.de/dev/walruscsv/walruscsv.zip 
unzip walruscsv.zip
g++ wlink.cpp main.cpp wtree.cpp -o walruscsv
wget -c www.soa-world.de/dev/walruscsv/testdata.zip 
unzip testdata.zip
# Get Walrus
wget -c https://www.caida.org/tools/visualization/walrus/download/walrus-0.6.3.tar.gz
tar -xvpf walrus-0.6.3.tar.gz
mv walrus-0.6.3 $DH/walrus-0.6.3
mv tmp/walruscsv $DH/walrus-0.6.3
rm -r tmp



## PicViz GUI
cd $DPMI/picviz
wget -c https://www.picviz.com/downloads/picviz-latest.tar.bz2
bunzip2 picviz-latest.tar.bz2
tar -xvf picviz-latest.tar
cd libpicviz
find -iname '*cmake*' -not -name CMakeLists.txt -exec rm -rf {} \;
apt-get install libevent-dev libcairo2-dev
make
cd picviz-latest
cd picviz-gui
python setup.py install

# ipsumdump
cd $DMPI/ipsumdump
wget -c www.read.seas.harvard.edu/~kohler/ipsumdump/ipsumdump-1.84.tar.gz 
tar -xzf ipsumdump-1.84.tar.gz
cd ipsumdump-1.84
./configure
make
make install

# passivedns
cd $DMPI/passivedns
git clone https://github.com/gamelinux/passivedns.git
#tar -xzf 1.0.tar.gz
cd passivedns/src
make
mkdir -p $DH/passivedns
mv passivedns $DH/passivedns
ln -s $DH/passivedns/passivedns $DH/scripts/passivedns

# liblognorm
#cd $DMPI/liblognorm
#wget -c https://www.liblognorm.com/files/download/liblognorm-1.0.1.tar.gz
#tar -xzf liblognorm-1.0.1.tar.gz
#cd liblognorm-1.0.1
#./confiugre --disable-docs
#make
#make install


## Copy over Run Scripts
mkdir $DH/scripts
cp $DPMI/davix/install/scripts/* $DH/scripts
ln -s /opt/davix/afterglow/afterglow.pl $DH/scripts/afterglow
ln -s /opt/davix/broids/bin/bro $DH/scripts/bro





