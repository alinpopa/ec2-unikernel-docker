FROM ocaml/opam:debian-9_ocaml-4.04.2

RUN opam install -y mirage
RUN sudo apt-get update
RUN sudo DEBIAN_FRONTEND=noninteractive CHARMAP=UTF-8 CODESET=guess apt-get install -q -y \
  vim cabal-install haskell-stack linux-image-amd64 zlib1g-dev libguestfs-tools
RUN git clone --branch 0.9.4 https://github.com/alinpopa/ec2-unikernel.git /home/opam/ec2-unikernel
WORKDIR /home/opam/ec2-unikernel
RUN cabal sandbox init && cabal update && cabal install
