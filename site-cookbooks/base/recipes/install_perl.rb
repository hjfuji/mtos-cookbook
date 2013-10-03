bash "install perl" do
  user "root"
  group "root"
  code <<-EOC
    PERL_VER=`perl -e 'print $]'`
    if [ $PERL_VER != "5.016003" ]; then
      wget http://www.cpan.org/src/5.0/perl-5.16.3.tar.gz
      tar -xzf perl-5.16.3.tar.gz
      cd perl-5.16.3
      ./Configure -des -Dprefix=/usr
      make
      make test
      make install
      curl -L http://cpanmin.us | perl - --sudo App::cpanminus
      cd ..
      rm -r -f perl-5.16.3
      rm perl-5.16.3.tar.gz
    else
      echo "Already installed"
    fi
  EOC
end

bash "install imagemagick" do
  user "root"
  group "root"
  code <<-EOC
    if [ ! -e /usr/bin/convert ]; then
      wget http://www.imagemagick.org/download/ImageMagick-6.8.7-0.tar.gz
      tar -xzf ImageMagick-6.8.7-0.tar.gz
      cd ImageMagick-6.8.7-0
      ./configure --prefix=/usr --with-perl=/usr/bin/perl
      make
      make install
      rm -r -f ImageMagick-6.8.7-0
      rm ImageMagick-6.8.7-0.tar.gz
    else
      echo "Already installed"
    fi
  EOC
end
