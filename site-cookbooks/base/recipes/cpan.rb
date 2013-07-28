%w{
  CGI Image::Size File::Spec CGI::Cookie DBI DBD::mysql
  HTML::Entities XML::Parser XML::Atom Mail::Sendmail GD
  Archive::Tar Archive::Zip IPC::Run Imager Cache::Memcached
  Authen::SASL Net::SMTP::TLS Net::SMTP::SSL
  Crypt::DSA Cache::File Crypt::SSLeay
}.each do |pkg|
  cpan_module pkg
end

%w{Net::Server DIME::Tools}.each do |pkg|
  cpan_module pkg do
    force true
  end
end

%w{
  Task::Plack CGI::Parse::PSGI CGI::Compile
  SOAP::Lite XMLRPC::Transport::HTTP::Plack Starman
}.each do |pkg|
  cpan_module pkg
end
