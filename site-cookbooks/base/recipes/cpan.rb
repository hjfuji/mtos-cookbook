%w{
  CGI Image::Size File::Spec CGI::Cookie DBI DBD::mysql
  HTML::Entities XML::Parser XML::Atom Mail::Sendmail GD
  Archive::Tar Archive::Zip IPC::Run Imager Cache::Memcached
  Authen::SASL Net::SMTP::TLS Net::SMTP::SSL
  Crypt::DSA Cache::File Crypt::SSLeay
}.each do |pkg|
  cpan_module pkg
end

cpan_module "http://search.cpan.org/CPAN/authors/id/M/ML/MLEHMANN/common-sense-3.6.tar.gz"

%w{Net::Server DIME::Tools SOAP::Lite}.each do |pkg|
  cpan_module pkg do
    force true
  end
end

%w{
  Task::Plack CGI::Parse::PSGI CGI::Compile
  XMLRPC::Transport::HTTP::Plack Starman
}.each do |pkg|
  cpan_module pkg
end
