(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-baseimage:x86_64-0.1.0
docker tag hyperledger/fabric-baseimage:x86_64-0.1.0 hyperledger/fabric-baseimage:latest

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Open the playground in a web browser.
case "$(uname)" in 
"Darwin")   open http://localhost:8080
            ;;
"Linux")    if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                 xdg-open http://localhost:8080
	        elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
                       #elif other types bla bla
	        else   
		            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
            ;;
*)          echo "Playground not launched - this OS is currently not supported "
            ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� �[-Y �]o�0���ᦐ� �21�BJ�AI`�U<�%�eS���ABºJզI~$���׎}αq{q��0�`k繵w�'�z�
W]>�RDQ�k�(b��mD'tH���_J�$�-@-�V������))�
|	������0�. �">�ڴ �5��fB�Bg1�`�0��9��u��u�|���!�)����0�q�2 Mи��>��)�A?>����F�tm94�s@~�lp�ȣ~���H�z��H��{�9��i�<]-�(�j��6���6�����t�j�9�e��F��냅��dCǽ��)	�h�NfF?�ѓ�q\ja'>�dǹ��8HQ���ll*�RV�#�f1���d�'��p�?OL�d`N��e�����x�^��l�.�ĸ/�C�DS��+�Ql�6w�#]M6�����ӵoI�22���m� 
Ֆ��h�6hD.�!�~�ʀ8�K&~��4p�f�J�t&��{���_�f�Z�5ߩ,�k����Q��|�N6[Q�Cu:Wu�š:���%�i� ������>�cr��q��\ե��h6��	-y�Ϸ<H�G����QH?A�w����lH�i/���p?sٹ�����q�3�	<x�3�:D���!QA��'�Gq�B}�.4�N�ơMN�I��'��TB�9z��0%�KV�z�*l��X(6Pb��K"��D�s��|Y�{.0oJ��x(K��?��Ň�ޭ������_��2��`0��`0��`0��7�	� (  