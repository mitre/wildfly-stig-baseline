control 'V-62239' do
  title "Wildfly must be configured to produce log records containing information
to establish what type of events occurred."
  desc  "
    Information system logging capability is critical for accurate forensic
analysis.  Without being able to establish what type of event occurred, it
would be difficult to establish, correlate, and investigate the events relating
to an incident or identify those responsible.

    Log record content that may be necessary to satisfy the requirement of this
control includes time stamps, source and destination addresses, user/process
identifiers, event descriptions, success/fail indications, filenames involved,
and access control or flow control rules invoked.

    Application servers must log all relevant log data that pertains to the
application server.  Examples of relevant data include, but are not limited to,
Java Virtual Machine (JVM) activity, HTTPD/Web server activity, and application
server-related system process activity.
  "
  impact 0.5
  tag "gtitle": 'SRG-APP-000095-AS-000056'
  tag "gid": 'V-62239'
  tag "rid": 'SV-76729r1_rule'
  tag "stig_id": 'JBOS-AS-000110'
  tag "cci": ['CCI-000130']
  tag "documentable": false
  tag "nist": ['AU-3', 'Rev_4']
  tag "check": "Log on to the OS of the Wildfly server with OS permissions that
allow access to Wildfly.

The $JBOSS_HOME default is /opt/bin/widfly
Using the relevant OS commands and syntax, cd to the $JBOSS_HOME;/bin/ folder.
Run the jboss-cli script to start the Command Line Interface (CLI).
Connect to the server and authenticate.
Run the command:

For a Managed Domain configuration:
\"ls
host=master/server/<SERVERNAME>/core-service=management/access=audit/logger=audit-log:write-attribute(name=enabled,value=true)\"

For a Standalone configuration:
\"ls
/core-service=management/access=audit/logger=audit-log:write-attribute(name=enabled,value=true)\"

If \"enabled\" = false, this is a finding."
  tag "fix": "Launch the jboss-cli management interface.
Connect to the server by typing \"connect\", authenticate as a user in the
Superuser role, and run the following command:

For a Managed Domain configuration:
\"host=master/server/<SERVERNAME>/core-service=management/access=audit/logger=audit-log:write-attribute(name=enabled,value=true)\"

For a Standalone configuration:
\"/core-service=management/access=audit/logger=audit-log:write-attribute(name=enabled,value=true)\""
  tag "fix_id": 'F-68159r1_fix'

  connect = input('connection')

  describe 'The wildfly server setting: produce log records containing information to establish what type of events occurred' do
    subject { command("/bin/sh #{ input('jboss_home') }/bin/jboss-cli.sh #{connect} --commands=ls\\ /core-service=management/access=audit/logger=audit-log").stdout }
    it { should_not match(%r{enabled=false}) }
  end
end
