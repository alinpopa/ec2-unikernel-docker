FROM ocaml/opam:debian-9_ocaml-4.04.2

RUN opam install -y mirage
RUN sudo apt-get update
RUN sudo DEBIAN_FRONTEND=noninteractive CHARMAP=UTF-8 CODESET=guess apt-get install -q -y \
  vim cabal-install haskell-stack \
  linux-image-amd64 zlib1g-dev libguestfs-tools \
  curl jq python python-pip
RUN sudo pip install awscli
RUN git clone https://github.com/GaloisInc/ec2-unikernel.git /home/opam/ec2-unikernel
WORKDIR /home/opam/ec2-unikernel
RUN cabal update && cabal install
WORKDIR /home/opam/
