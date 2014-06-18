node 'puppetnode1.fastechnicalservices.net' {
	file { '/etc/passwd':
		ensure => file,
		owner => 'root',
		group => 'root',
		mode => '0600',
	}
	package {'ntp':
        ensure      => installed,
        #provider    => yum,
        #require     => Package['apt'];
	}
	service {'ntpd':
		ensure => running,
	}
#---------HOSTS---------
	host {'puppetmaster.fastechnicalservices.net':
        ensure       => present,
        ip           => '172.16.4.50',
        host_aliases => ['puppetmaster'],
        target       => '/etc/hosts',
        comment      => 'Puppet master running in vlan 4 on XenServer cluster';
	}
	host {'cephdeploy.fastechnicalservices.net':
        ensure       => present,
        ip           => '172.16.4.60',
        host_aliases => ['cephdeploy'],
        target       => '/etc/hosts',
        comment      => 'Cephdeploy server';
	}
#---------SSH Keys--------
	ssh_authorized_key { 'Mainkey':
	    ensure   => present,
	    key      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDKGZd89H9Q1QiQBMPw4C1uvAVtuR5NAIwM69dy64ICpxfmAt1/jUC+zpokNAHZDDGJvYcpT9JiPNuTfB3WvPJoUxjP044/gFM1C0MuAzpzsYsyGPeH14K1aMwv5I6aSJ4Q8ZDy4r92Izgu1bdhpB3swyWlU/jKFJZOEj8tZmKGMXK0eBOxDII9tST0v2oab3gRcj03kCyt35W6G5onSwnPqBpF0Vgn3tstQ8fp9p9zlww5hFceV3r2b3iFOlxQ8m1JXgnG57oEWvqIka+tp6OsSwZKVBEdhB9F6hXR0GMGNiwx3I2zjaKCB6ImO/mkophouMOBttVG0HwFbe5rEvI9',
	    options  => 'no-X11-forwarding',
	    type     => ssh-rsa,
	    user     => 'root';
	}
	network_config { 'eth0':
		ensure => 'present',
		family => 'inet',
		onboot => 'true',
		ipaddress => '192.168.8.46',
		netmask => '255.255.255.0',
		method => 'static',
	}
}
node 'cephdeploy' {
	network_config { 'eth0':
		ensure => 'present',
		family => 'inet',
		onboot => 'true',
		ipaddress => '172.16.4.60',
		netmask => '255.255.255.0',
		method => 'static',
	}
	ssh_authorized_key { 'Mainkey':
	    ensure   => present,
	    key      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDKGZd89H9Q1QiQBMPw4C1uvAVtuR5NAIwM69dy64ICpxfmAt1/jUC+zpokNAHZDDGJvYcpT9JiPNuTfB3WvPJoUxjP044/gFM1C0MuAzpzsYsyGPeH14K1aMwv5I6aSJ4Q8ZDy4r92Izgu1bdhpB3swyWlU/jKFJZOEj8tZmKGMXK0eBOxDII9tST0v2oab3gRcj03kCyt35W6G5onSwnPqBpF0Vgn3tstQ8fp9p9zlww5hFceV3r2b3iFOlxQ8m1JXgnG57oEWvqIka+tp6OsSwZKVBEdhB9F6hXR0GMGNiwx3I2zjaKCB6ImO/mkophouMOBttVG0HwFbe5rEvI9',
	    options  => 'no-X11-forwarding',
	    type     => ssh-rsa,
	    user     => 'root';
	}
	ssh_authorized_key {'cephdeployKey':
	        ensure   => present,
	        key      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDGkA8i1H02UEWxPnXYwN8nZ1MGoeE0fcty/pUFUf+YQoRguJQG6OO3w4gj3pww7mWlvrqiGun8MOLUJScz+i0LZ3KiM7MvLW4cI/MaRxRK2SxnvfEG2tD+trFsyBrAJuLd/ri6d11D+z4QFf1smsOVcQgHaa207EpfmduteLpI/rlkDziLvKOXxat0TuBFsUBlWMibY5JawRmaVNenS4tTaQoN7RV/MshH7Fkq8tAhXSutrHrWXZ3ly3qeJaKV85hNp875wl7Bg+REVdq2KHxWNtK3/4MrcDDJXY7adqNy3y53Fu658V9ayKvOFOek57teEKmnS2roj6zY14672/e1',
	        options  => 'no-X11-forwarding',
	        type     => ssh-rsa,
	        user     => 'root';
	}
	user {'cephdeploy':
	        ensure  => present,
	        comment => 'Ceph User',
	        home    => '/home/name',
	        shell   => '/bin/bash',
	        uid     => '502',
	        gid     => '21',
	}
	host {'cephdeploy.fastechnicalservices.net':
	        ensure       => present,
	        ip           => '172.16.4.60',
	        host_aliases => [ 'cephdeploy', 'ceph' ],
	        #target       => '/etc/hosts',
	        #comment      => 'comment';
	}
}
node 'stor1' {
	network_config { 'eth0':
		ensure => 'present',
		family => 'inet',
		onboot => 'true',
		ipaddress => '172.16.8.10',
		netmask => '255.255.255.0',
		method => 'static',
	}
	ssh_authorized_key { 'Mainkey':
	    ensure   => present,
	    key      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDKGZd89H9Q1QiQBMPw4C1uvAVtuR5NAIwM69dy64ICpxfmAt1/jUC+zpokNAHZDDGJvYcpT9JiPNuTfB3WvPJoUxjP044/gFM1C0MuAzpzsYsyGPeH14K1aMwv5I6aSJ4Q8ZDy4r92Izgu1bdhpB3swyWlU/jKFJZOEj8tZmKGMXK0eBOxDII9tST0v2oab3gRcj03kCyt35W6G5onSwnPqBpF0Vgn3tstQ8fp9p9zlww5hFceV3r2b3iFOlxQ8m1JXgnG57oEWvqIka+tp6OsSwZKVBEdhB9F6hXR0GMGNiwx3I2zjaKCB6ImO/mkophouMOBttVG0HwFbe5rEvI9',
	    options  => 'no-X11-forwarding',
	    type     => ssh-rsa,
	    user     => 'root';
	}
	ssh_authorized_key {'cephdeployKey':
	        ensure   => present,
	        key      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDGkA8i1H02UEWxPnXYwN8nZ1MGoeE0fcty/pUFUf+YQoRguJQG6OO3w4gj3pww7mWlvrqiGun8MOLUJScz+i0LZ3KiM7MvLW4cI/MaRxRK2SxnvfEG2tD+trFsyBrAJuLd/ri6d11D+z4QFf1smsOVcQgHaa207EpfmduteLpI/rlkDziLvKOXxat0TuBFsUBlWMibY5JawRmaVNenS4tTaQoN7RV/MshH7Fkq8tAhXSutrHrWXZ3ly3qeJaKV85hNp875wl7Bg+REVdq2KHxWNtK3/4MrcDDJXY7adqNy3y53Fu658V9ayKvOFOek57teEKmnS2roj6zY14672/e1',
	        options  => 'no-X11-forwarding',
	        type     => ssh-rsa,
	        user     => 'root';
	}
	host {'cephdeploy.fastechnicalservices.net':
	        ensure       => present,
	        ip           => '172.16.4.60',
	        host_aliases => [ 'cephdeploy', 'ceph' ],
	        #target       => '/etc/hosts',
	        #comment      => 'comment';
	}
}
node 'stor2' {
	network_config { 'eth0':
		ensure => 'present',
		family => 'inet',
		onboot => 'true',
		ipaddress => '172.16.8.20',
		netmask => '255.255.255.0',
		method => 'static',
	}
	ssh_authorized_key { 'Mainkey':
	    ensure   => present,
	    key      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDKGZd89H9Q1QiQBMPw4C1uvAVtuR5NAIwM69dy64ICpxfmAt1/jUC+zpokNAHZDDGJvYcpT9JiPNuTfB3WvPJoUxjP044/gFM1C0MuAzpzsYsyGPeH14K1aMwv5I6aSJ4Q8ZDy4r92Izgu1bdhpB3swyWlU/jKFJZOEj8tZmKGMXK0eBOxDII9tST0v2oab3gRcj03kCyt35W6G5onSwnPqBpF0Vgn3tstQ8fp9p9zlww5hFceV3r2b3iFOlxQ8m1JXgnG57oEWvqIka+tp6OsSwZKVBEdhB9F6hXR0GMGNiwx3I2zjaKCB6ImO/mkophouMOBttVG0HwFbe5rEvI9',
	    options  => 'no-X11-forwarding',
	    type     => ssh-rsa,
	    user     => 'root';
	}
	ssh_authorized_key {'cephdeployKey':
	        ensure   => present,
	        key      => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDGkA8i1H02UEWxPnXYwN8nZ1MGoeE0fcty/pUFUf+YQoRguJQG6OO3w4gj3pww7mWlvrqiGun8MOLUJScz+i0LZ3KiM7MvLW4cI/MaRxRK2SxnvfEG2tD+trFsyBrAJuLd/ri6d11D+z4QFf1smsOVcQgHaa207EpfmduteLpI/rlkDziLvKOXxat0TuBFsUBlWMibY5JawRmaVNenS4tTaQoN7RV/MshH7Fkq8tAhXSutrHrWXZ3ly3qeJaKV85hNp875wl7Bg+REVdq2KHxWNtK3/4MrcDDJXY7adqNy3y53Fu658V9ayKvOFOek57teEKmnS2roj6zY14672/e1',
	        options  => 'no-X11-forwarding',
	        type     => ssh-rsa,
	        user     => 'root';
	}
	host {'cephdeploy.fastechnicalservices.net':
	        ensure       => present,
	        ip           => '172.16.4.60',
	        host_aliases => [ 'cephdeploy', 'ceph' ],
	        #target       => '/etc/hosts',
	        #comment      => 'comment';
	}
}