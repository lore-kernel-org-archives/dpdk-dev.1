Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3879C36002
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 02:40:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC27040B9C;
	Tue, 25 Mar 2025 03:40:16 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 31B47402E2
 for <dev@dpdk.org>; Tue, 25 Mar 2025 03:40:15 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1F8AF46470; Tue, 25 Mar 2025 03:40:15 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 1681] [dpdk-25.03]
 loopback_multi_paths_port_restart: core dumped occurred when exiting testpmd
Date: Tue, 25 Mar 2025 02:40:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: songx.jiale@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1681-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17428704140.a92aaAf.138103
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org


--17428704140.a92aaAf.138103
Date: Tue, 25 Mar 2025 03:40:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1681

            Bug ID: 1681
           Summary: [dpdk-25.03] loopback_multi_paths_port_restart: core
                    dumped occurred when exiting testpmd
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: vhost/virtio
          Assignee: dev@dpdk.org
          Reporter: songx.jiale@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 5f37ee9c859f3ce08ca4364f1d8c0e70ec33ac83 version: 25.03.0-rc2
OS: Anolis OS 8.9/5.10.134-16.2.an8.x86_64
Compiler: gcc version 8.5.0 20210514
Hardware platform: Intel(R) Xeon(R) Gold 6139 CPU @ 2.30GHz
NIC hardware: N/A
NIC firmware: N/A

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. start testpmd with vhost-net
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 3-5 -n 4 --no-pci --vdev
'net_vhost0,iface=3Dvhost-net,queues=3D1,client=3D0' -- -i --nb-cores=3D1 -=
-txd=3D1024
--rxd=3D1024

2. exit testpmd
note: Currently only reproduced on Anolis OS.
testpmd> quit

Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
testpmd> quitStopping port 0...
Stopping ports...
DoneShutting down port 0...
Closing ports...
Port 0 is closed
DoneBye...
Segmentation fault (core dumped)

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Testpmd exits normally without core dumped.

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 0e38b42bf61c03b9350f3c96fa421c2c28e815cc
Author: David Marchand <david.marchand@redhat.com>
Date:   Tue Jun 11 15:39:57 2024 +0200

    vhost: manage FD with epoll

    Switch to epoll so that the concern over the poll() fd array
    is removed.
    Add a simple list of used entries and track the next free entry.

    epoll() is thread safe, we no more need a synchronization
    mechanism and so can remove the notification pipe.

    Signed-off-by: David Marchand <david.marchand@redhat.com>
    Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
    Acked-by: David Marchand <david.marchand@redhat.com>

 lib/vhost/fd_man.c | 439 +++++++++++++++++--------------------------------=
----
 lib/vhost/fd_man.h |   5 +-
 2 files changed, 144 insertions, 300 deletions

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17428704140.a92aaAf.138103
Date: Tue, 25 Mar 2025 03:40:14 +0100
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - [dpdk-25.03] loopback_multi_paths_port_restart: c=
ore dumped occurred when exiting testpmd"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1681">1681</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.03] loopback_multi_paths_port_restart: core dumped o=
ccurred when exiting testpmd
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.03
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>vhost/virtio
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>songx.jiale&#64;intel.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 5f37ee9c859f3ce08ca4364f1d8c0e70ec33ac83 version: 25.03.0-rc2
OS: Anolis OS 8.9/5.10.134-16.2.an8.x86_64
Compiler: gcc version 8.5.0 20210514
Hardware platform: Intel(R) Xeon(R) Gold 6139 CPU &#64; 2.30GHz
NIC hardware: N/A
NIC firmware: N/A

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. start testpmd with vhost-net
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 3-5 -n 4 --no-pci --vdev
'net_vhost0,iface=3Dvhost-net,queues=3D1,client=3D0' -- -i --nb-cores=3D1 -=
-txd=3D1024
--rxd=3D1024

2. exit testpmd
note: Currently only reproduced on Anolis OS.
testpmd&gt; quit

Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
testpmd&gt; quitStopping port 0...
Stopping ports...
DoneShutting down port 0...
Closing ports...
Port 0 is closed
DoneBye...
Segmentation fault (core dumped)

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Testpmd exits normally without core dumped.

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 0e38b42bf61c03b9350f3c96fa421c2c28e815cc
Author: David Marchand &lt;<a href=3D"mailto:david.marchand&#64;redhat.com"=
>david.marchand&#64;redhat.com</a>&gt;
Date:   Tue Jun 11 15:39:57 2024 +0200

    vhost: manage FD with epoll

    Switch to epoll so that the concern over the poll() fd array
    is removed.
    Add a simple list of used entries and track the next free entry.

    epoll() is thread safe, we no more need a synchronization
    mechanism and so can remove the notification pipe.

    Signed-off-by: David Marchand &lt;<a href=3D"mailto:david.marchand&#64;=
redhat.com">david.marchand&#64;redhat.com</a>&gt;
    Signed-off-by: Maxime Coquelin &lt;<a href=3D"mailto:maxime.coquelin&#6=
4;redhat.com">maxime.coquelin&#64;redhat.com</a>&gt;
    Acked-by: David Marchand &lt;<a href=3D"mailto:david.marchand&#64;redha=
t.com">david.marchand&#64;redhat.com</a>&gt;

 lib/vhost/fd_man.c | 439 +++++++++++++++++--------------------------------=
----
 lib/vhost/fd_man.h |   5 +-
 2 files changed, 144 insertions, 300 deletions
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1681">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17428704140.a92aaAf.138103--
