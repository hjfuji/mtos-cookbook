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
    fi
  EOC
end
