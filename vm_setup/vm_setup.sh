SERVER_HOST=projects.chadvoegele.com
scp ../docker_gen_certs.sh ${SERVER_HOST}:/tmp

ssh ${SERVER_HOST}
sudo -s
apt-get install -y linux-image-extra-$(uname -r) apt-transport-https ca-certificates
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get purge lxc-docker
apt-get install docker-engine
service docker start
pushd /tmp
bash docker_gen_certs.sh projects.chadvoegele.com
rm *srl
mkdir -p /etc/docker/certs
mv *pem /etc/docker/certs
popd
mkdir -p /etc/systemd/system/docker.service.d
cat << EOF > /etc/systemd/system/docker.service.d/docker.conf
[Service]
ExecStart=/usr/bin/docker daemon --tlsverify --tlscacert=/etc/docker/certs/ca.pem --tlscert=/etc/docker/certs/server-cert.pem --tlskey=/etc/docker/certs/server-key.pem -H=0.0.0.0:2376 -H unix:///var/run/docker.sock
EOF
mkdir -p /mnt/git
mount -o discard,defaults /dev/disk/by-id/google-git-persistent /mnt/git/
echo "/dev/disk/by-id/google-git-persistent /mnt/git/ ext4  defaults 0 0" >> /etc/fstab
exit

CERTS_TAR="/tmp/certs.tar"
CERTS_DEST="${HOME}/.docker/machine/machines/projects"
ssh ${SERVER_HOST} sudo tar cf ${CERTS_TAR} "/etc/docker/certs/{key.pem,cert.pem,ca.pem}"
scp ${SERVER_HOST}:${CERTS_TAR} ${CERTS_DEST}
ssh ${SERVER_HOST} sudo rm ${CERTS_TAR}
tar xf ${CERTS_DEST}/certs.tar --strip-components=3 -C ${CERTS_DEST}
rm ${CERTS_DEST}/certs.tar
chmod 400 ${CERTS_DEST}/key.pem
chmod 444 ${CERTS_DEST}/{cert.pem,ca.pem}

source env/projects.sh
docker-machine projects
bash init_certs.sh ${DOMAIN} ${GIT_DOMAIN}
docker-compose up --build -d
