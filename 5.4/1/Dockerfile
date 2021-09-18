FROM archlinux:latest

RUN pacman -Syu --noconfirm && \
    pacman -S ponysay --noconfirm &&\ 
    pacman -Syu --noconfirm

ENTRYPOINT ["/usr/bin/ponysay"]
CMD ["Hey, netology”]
