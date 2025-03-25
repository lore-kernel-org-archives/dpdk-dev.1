Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11B3C36005
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 03:16:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C703A40E17;
	Tue, 25 Mar 2025 04:16:56 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 75A6240B9C
 for <dev@dpdk.org>; Tue, 25 Mar 2025 04:16:55 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 66F6546471; Tue, 25 Mar 2025 04:16:55 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 1682] [dpdk-25.03]
 vhost_virtio_fuzzing/tso_forward_pkt: testpmd cannot exit normally when test
 fuzz
Date: Tue, 25 Mar 2025 03:16:55 +0000
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
 target_milestone attachments.created
Message-ID: <bug-1682-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17428726150.83bf76c.174453
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


--17428726150.83bf76c.174453
Date: Tue, 25 Mar 2025 04:16:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1682

            Bug ID: 1682
           Summary: [dpdk-25.03] vhost_virtio_fuzzing/tso_forward_pkt:
                    testpmd cannot exit normally when test fuzz
           Product: DPDK
           Version: 25.03
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: vhost/virtio
          Assignee: dev@dpdk.org
          Reporter: songx.jiale@intel.com
  Target Milestone: ---

Created attachment 305
  --> https://bugs.dpdk.org/attachment.cgi?id=3D305&action=3Dedit
dpdk fuzz test file

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 5f37ee9c859f3ce08ca4364f1d8c0e70ec33ac83 version: 25.03.0-rc2
OS: Red Hat Enterprise Linux 9.4/5.14.0-427.13.1.el9_4.x86_64
Compiler: clang version 17.0.6
Hardware platform: Intel(R) Xeon(R) Gold 6139 CPU @ 2.30GHz
NIC hardware: N/A
NIC firmware: N/A

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. create packet file(If the environment already has these packets, can skip
this step)
mkdir -p /tmp/fuzz/vhost_pcap
python3 pkt.py

2. Compile dpdk and fuzz
tar zxf fuzz.tar.gz
cp -r fuzz /root/dpdk/app/=20
sed -i "s/'test-sad',/'test-sad',\n        'fuzz',/g" app/meson.build

rm -rf x86_64-native-linuxapp-clang
CC=3Dclang meson --werror -Denable_kmods=3DTrue -Dbuildtype=3Ddebug -Db_lun=
def=3Dfalse
-Db_sanitize=3Daddress x86_64-native-linuxapp-clang
ninja -C x86_64-native-linuxapp-clang

3. create vhost
rm -rf /tmp/sock0
x86_64-native-linuxapp-clang/app/dpdk-fuzz /tmp/fuzz/vhost_pcap/ --
-ignore_remaining_args=3D1 -l 1 -n 4  --file-prefix=3Dvhost --vdev
'net_vhost0,iface=3D/tmp/sock0,queues=3D4' -- --rxq=3D4 --txq=3D4 --txd=3D1=
024 --rxd=3D1024=20
RTE>>vhost_autotest

4. start testpmd with virtio device=20
x86_64-native-linuxapp-clang/app/dpdk-testpmd -l 1,2 -n 4
--file-prefix=3Dvirtio_26049_20250311133724 --no-pci
--vdev=3Dnet_virtio_user0,mac=3D00:01:02:03:04:05,path=3D/tmp/sock0,queues=
=3D4 -- -i
--rxq=3D4 --txq=3D4 --txd=3D1024 --rxd=3D1024

5. set csum fwd and start fwd
set fwd csum
start
show port stats all
note: Loop query the port status. when the bps of the port receiving and
transmitting packets is found to be 0, exit testpmd.

6. exit testpmd
quit

Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
Unable to exit testpmd, will get stuck.

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Testpmd receives and sends packets normally and exits normally.

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 76730c7b9b5a35d1a74d45a08153a03bdb1b26f8
Author: Jie Hai <haijie1@huawei.com>
Date:   Fri Feb 14 09:56:38 2025 +0800

    app/testpmd: use packet type parsing API

    1. Use rte_net_get_ptype() to parse packets instead.
    2. Support TSO for packets with IPv6 extension header.

    Signed-off-by: Jie Hai <haijie1@huawei.com>

 lib/vhost/fd_man.c | 439 +++++++++++++++++--------------------------------=
----
 lib/vhost/fd_man.h |   5 +-
 2 files changed, 144 insertions, 300 deletions

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17428726150.83bf76c.174453
Date: Tue, 25 Mar 2025 04:16:55 +0100
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
   title=3D"UNCONFIRMED - [dpdk-25.03] vhost_virtio_fuzzing/tso_forward_pkt=
: testpmd cannot exit normally when test fuzz"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1682">1682</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.03] vhost_virtio_fuzzing/tso_forward_pkt: testpmd ca=
nnot exit normally when test fuzz
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
          <td>x86
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Linux
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
          <pre class=3D"bz_comment_text">Created <span class=3D""><a href=
=3D"attachment.cgi?id=3D305" name=3D"attach_305" title=3D"dpdk fuzz test fi=
le">attachment 305</a> <a href=3D"attachment.cgi?id=3D305&amp;action=3Dedit=
" title=3D"dpdk fuzz test file">[details]</a></span>
dpdk fuzz test file

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 5f37ee9c859f3ce08ca4364f1d8c0e70ec33ac83 version: 25.03.0-rc2
OS: Red Hat Enterprise Linux 9.4/5.14.0-427.13.1.el9_4.x86_64
Compiler: clang version 17.0.6
Hardware platform: Intel(R) Xeon(R) Gold 6139 CPU &#64; 2.30GHz
NIC hardware: N/A
NIC firmware: N/A

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. create packet file(If the environment already has these packets, can skip
this step)
mkdir -p /tmp/fuzz/vhost_pcap
python3 pkt.py

2. Compile dpdk and fuzz
tar zxf fuzz.tar.gz
cp -r fuzz /root/dpdk/app/=20
sed -i &quot;s/'test-sad',/'test-sad',\n        'fuzz',/g&quot; app/meson.b=
uild

rm -rf x86_64-native-linuxapp-clang
CC=3Dclang meson --werror -Denable_kmods=3DTrue -Dbuildtype=3Ddebug -Db_lun=
def=3Dfalse
-Db_sanitize=3Daddress x86_64-native-linuxapp-clang
ninja -C x86_64-native-linuxapp-clang

3. create vhost
rm -rf /tmp/sock0
x86_64-native-linuxapp-clang/app/dpdk-fuzz /tmp/fuzz/vhost_pcap/ --
-ignore_remaining_args=3D1 -l 1 -n 4  --file-prefix=3Dvhost --vdev
'net_vhost0,iface=3D/tmp/sock0,queues=3D4' -- --rxq=3D4 --txq=3D4 --txd=3D1=
024 --rxd=3D1024=20
RTE&gt;&gt;vhost_autotest

4. start testpmd with virtio device=20
x86_64-native-linuxapp-clang/app/dpdk-testpmd -l 1,2 -n 4
--file-prefix=3Dvirtio_26049_20250311133724 --no-pci
--vdev=3Dnet_virtio_user0,mac=3D00:01:02:03:04:05,path=3D/tmp/sock0,queues=
=3D4 -- -i
--rxq=3D4 --txq=3D4 --txd=3D1024 --rxd=3D1024

5. set csum fwd and start fwd
set fwd csum
start
show port stats all
note: Loop query the port status. when the bps of the port receiving and
transmitting packets is found to be 0, exit testpmd.

6. exit testpmd
quit

Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
Unable to exit testpmd, will get stuck.

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Testpmd receives and sends packets normally and exits normally.

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 76730c7b9b5a35d1a74d45a08153a03bdb1b26f8
Author: Jie Hai &lt;<a href=3D"mailto:haijie1&#64;huawei.com">haijie1&#64;h=
uawei.com</a>&gt;
Date:   Fri Feb 14 09:56:38 2025 +0800

    app/testpmd: use packet type parsing API

    1. Use rte_net_get_ptype() to parse packets instead.
    2. Support TSO for packets with IPv6 extension header.

    Signed-off-by: Jie Hai &lt;<a href=3D"mailto:haijie1&#64;huawei.com">ha=
ijie1&#64;huawei.com</a>&gt;

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
?id=3D1682">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17428726150.83bf76c.174453--
