control 'V-62223' do
  title "Silent Authentication must be removed from the Default Management
Security Realm."
  desc  "Silent Authentication is a configuration setting that allows local OS
users access to the Wildfly server and a wide range of operations without
specifically authenticating on an individual user basis.  By default $localuser
is a Superuser. This introduces an integrity and availability vulnerability and
violates best practice requirements regarding accountability."
  impact 0.7
  tag "gtitle": 'SRG-APP-000033-AS-000024'
  tag "gid": 'V-62223'
  tag "rid": 'SV-76713r1_rule'
  tag "stig_id": 'JBOS-AS-000050'
  tag "cci": ['CCI-000213']
  tag "documentable": false
  tag "nist": ['AC-3', 'Rev_4']
  tag "check": "Log on to the OS of the Wildfly server with OS permissions that
allow access to Wildfly.
Using the relevant OS commands and syntax, cd to the $JBOSS_HOME;/bin/ folder.

The $JBOSS_HOME default is /opt/bin/widfly
Run the jboss-cli script.
Connect to the server and authenticate.

Verify that Silent Authentication has been removed from the default Management
security realm.
Run the following command.

For standalone servers run the following command:
\"ls /core-service=management/securityrealm=ManagementRealm/authentication\"

For managed domain installations run the following command:
\"ls
/host=HOST_NAME/core-service=management/securityrealm=ManagementRealm/authentication\"

If \"local\" is returned, this is a finding."
  tag "fix": "Log on to the OS of the Wildfly server with OS permissions that
allow access to Wildfly.
Using the relevant OS commands and syntax, cd to the $JBOSS_HOME;/bin/ folder.
Run the jboss-cli script.
Connect to the server and authenticate.

Remove the local element from the Management Realm.
For standalone servers run the following command:
/core-service=management/securityrealm=
ManagementRealm/authentication=local:remove

For managed domain installations run the following command:
/host=HOST_NAME/core-service=management/securityrealm=
ManagementRealm/authentication=local:remove"
  tag "fix_id": 'F-68143r1_fix'

  connect = input('connection')

  describe 'The wildfly default management security realm silent authentication' do
    subject { command("/bin/sh #{ input('jboss_home') }/bin/jboss-cli.sh #{connect} --commands=ls\\ /core-service=management/security-realm=ManagementRealm/authentication").stdout }
    it { should_not match(%r{local}) }
  end
end
