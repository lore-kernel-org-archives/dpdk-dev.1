Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1703C28B2E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 02:31:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D07840261;
	Tue, 11 Mar 2025 03:31:22 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B71FE400D7
 for <dev@dpdk.org>; Tue, 11 Mar 2025 03:31:20 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 72141463B0; Tue, 11 Mar 2025 03:31:20 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1672] [dpdk-25.03]
 vf_offload/checksum_offload_tunnel_enable: gtpu packet checksum error packet
Date: Tue, 11 Mar 2025 02:31:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
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
Message-ID: <bug-1672-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17416602800.CF1f.41625
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


--17416602800.CF1f.41625
Date: Tue, 11 Mar 2025 03:31:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1672

            Bug ID: 1672
           Summary: [dpdk-25.03]
                    vf_offload/checksum_offload_tunnel_enable: gtpu packet
                    checksum error packet
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: songx.jiale@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 5f37ee9c859f3ce08ca4364f1d8c0e70ec33ac83 version: 25.03.0-rc2
OS: Ubuntu24.04.1 LTS (Noble Numbat)/6.8.0-41-generic
Compiler:  gcc version 13.2.0
Hardware platform: Intel(R) Xeon(R) Platinum 8380 CPU @ 2.30GHz
NIC hardware: CVL(Intel Corporation Ethernet Controller E810-C for SFP
[8086:1593])
NIC firmware:=20
  driver: vfio-pci
  kdriver: ice-1.16.3
  firmware-version: 4.70 0x8001f79e 1.3755.0
  pkg: ice comms 1.3.53.0
scapy:2.4.4

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. create 1 vf and set vf=20
echo 1 > /sys/bus/pci/devices/0000\:18\:00.0/sriov_numvfs
ip link set enp24s0f0np0 vf 0 trust on
ip link set enp24s0f0np0 vf 0 spoofchk off
modprobe vfio-pci
./usertools/dpdk-devbind.py -b vfio-pci 0000:18:01.0

2. start testpmd=20
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-3 -n 4 -a 0000:18:01.0 -- =
-i
--enable-rx-cksum

3. set testpmd=20
set verbose 1
set promisc 0 on
set fwd csum
port stop all
csum set ip hw 0
csum set udp hw 0
csum set tcp hw 0
csum set sctp hw 0
csum set outer-ip hw 0
csum set outer-udp hw 0
csum parse-tunnel on 0
port start all
start

4. tcpdump captures packets forwarded by testpmd
tcpdump -ei ens8 -Q in -w 1.pcap

5. scapy send packets
from scapy.contrib.gtp import *
p=3DEther(dst=3D"76:D4:6B:F1:BF:7A", src=3D"52:00:00:00:00:00") / IP(src =3D
"10.0.0.1", chksum =3D 0xff) / UDP(dport =3D 2182, chksum =3D 0xff) /
GTP_U_Header(gtp_type=3D255, teid=3D0x123456) / IP(src =3D "10.0.0.1", chks=
um =3D 0xff)
/ UDP(sport =3D 29999, dport =3D 30000, chksum =3D 0xff) / Raw("x" * 100)=20
sendp(p, iface=3D'ens8', count=3D1)

6. ^C exit tcpdump and scapy or wireshark parsing data packets
scapy parsing data packets:
from scapy.contrib.gtp import *
pkt=3Drdpcap('1.pcap')
pkt[0].show2()


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
>>> pkt[0].show2()
###[ Ethernet ]###
  dst=3D 02:00:00:00:00:00
  src=3D 7e:45:ee:26:3a:23
  type=3D IPv4
###[ IP ]###
     version=3D 4
     ihl=3D 5
     tos=3D 0x0
     len=3D 164
     id=3D 1
     flags=3D
     frag=3D 0
     ttl=3D 64
     proto=3D udp
     chksum=3D 0xf146
     src=3D 10.0.0.1
     dst=3D 127.0.0.1
     \options\
###[ UDP ]###
        sport=3D 2152
        dport=3D 2182
        len=3D 144
        chksum=3D 0x7c10
###[ GTP-U Header ]###
           version=3D 1
           PT=3D 1
           reserved=3D 0
           E=3D 0
           S=3D 0
           PN=3D 0
           gtp_type=3D g_pdu
           length=3D 128
           teid=3D 1193046
###[ IP ]###
              version=3D 4
              ihl=3D 5
              tos=3D 0x0
              len=3D 128
              id=3D 1
              flags=3D
              frag=3D 0
              ttl=3D 64
              proto=3D udp
              chksum=3D 0xff
              src=3D 10.0.0.1
              dst=3D 127.0.0.1
              \options\
###[ UDP ]###
                 sport=3D 29999
                 dport=3D 30000
                 len=3D 108
                 chksum=3D 0xff
###[ Raw ]###
                    load=3D
'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxx'

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> pkt[0].show2()
###[ Ethernet ]###
  dst=3D 02:00:00:00:00:00
  src=3D 7e:45:ee:26:3a:23
  type=3D IPv4
###[ IP ]###
     version=3D 4
     ihl=3D 5
     tos=3D 0x0
     len=3D 164
     id=3D 1
     flags=3D
     frag=3D 0
     ttl=3D 64
     proto=3D udp
     chksum=3D 0xf146
     src=3D 10.0.0.1
     dst=3D 127.0.0.1
     \options\
###[ UDP ]###
        sport=3D 2152
        dport=3D 2182
        len=3D 144
        chksum=3D 0x8894
###[ GTP-U Header ]###
           version=3D 1
           PT=3D 1
           reserved=3D 0
           E=3D 0
           S=3D 0
           PN=3D 0
           gtp_type=3D g_pdu
           length=3D 128
           teid=3D 1193046
###[ IP ]###
              version=3D 4
              ihl=3D 5
              tos=3D 0x0
              len=3D 128
              id=3D 1
              flags=3D
              frag=3D 0
              ttl=3D 64
              proto=3D udp
              chksum=3D 0xf16a
              src=3D 10.0.0.1
              dst=3D 127.0.0.1
              \options\
###[ UDP ]###
                 sport=3D 29999
                 dport=3D 30000
                 len=3D 108
                 chksum=3D 0x42d
###[ Raw ]###
                    load=3D
'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxx'

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 76730c7b9b5a35d1a74d45a08153a03bdb1b26f8
Author: Jie Hai <haijie1@huawei.com>
Date:   Fri Feb 14 09:56:38 2025 +0800

    app/testpmd: use packet type parsing API

    1. Use rte_net_get_ptype() to parse packets instead.
    2. Support TSO for packets with IPv6 extension header.

    Signed-off-by: Jie Hai <haijie1@huawei.com>

 app/test-pmd/csumonly.c | 522 ++++++++++++--------------------------------=
----
 1 file changed, 128 insertions, 394 deletions

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17416602800.CF1f.41625
Date: Tue, 11 Mar 2025 03:31:20 +0100
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
   title=3D"UNCONFIRMED - [dpdk-25.03] vf_offload/checksum_offload_tunnel_e=
nable: gtpu packet checksum error packet"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1672">1672</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.03] vf_offload/checksum_offload_tunnel_enable: gtpu =
packet checksum error packet
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
          <td>testpmd
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
OS: Ubuntu24.04.1 LTS (Noble Numbat)/6.8.0-41-generic
Compiler:  gcc version 13.2.0
Hardware platform: Intel(R) Xeon(R) Platinum 8380 CPU &#64; 2.30GHz
NIC hardware: CVL(Intel Corporation Ethernet Controller E810-C for SFP
[8086:1593])
NIC firmware:=20
  driver: vfio-pci
  kdriver: ice-1.16.3
  firmware-version: 4.70 0x8001f79e 1.3755.0
  pkg: ice comms 1.3.53.0
scapy:2.4.4

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. create 1 vf and set vf=20
echo 1 &gt; /sys/bus/pci/devices/0000\:18\:00.0/sriov_numvfs
ip link set enp24s0f0np0 vf 0 trust on
ip link set enp24s0f0np0 vf 0 spoofchk off
modprobe vfio-pci
./usertools/dpdk-devbind.py -b vfio-pci 0000:18:01.0

2. start testpmd=20
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-3 -n 4 -a 0000:18:01.0 -- =
-i
--enable-rx-cksum

3. set testpmd=20
set verbose 1
set promisc 0 on
set fwd csum
port stop all
csum set ip hw 0
csum set udp hw 0
csum set tcp hw 0
csum set sctp hw 0
csum set outer-ip hw 0
csum set outer-udp hw 0
csum parse-tunnel on 0
port start all
start

4. tcpdump captures packets forwarded by testpmd
tcpdump -ei ens8 -Q in -w 1.pcap

5. scapy send packets
from scapy.contrib.gtp import *
p=3DEther(dst=3D&quot;76:D4:6B:F1:BF:7A&quot;, src=3D&quot;52:00:00:00:00:0=
0&quot;) / IP(src =3D
&quot;10.0.0.1&quot;, chksum =3D 0xff) / UDP(dport =3D 2182, chksum =3D 0xf=
f) /
GTP_U_Header(gtp_type=3D255, teid=3D0x123456) / IP(src =3D &quot;10.0.0.1&q=
uot;, chksum =3D 0xff)
/ UDP(sport =3D 29999, dport =3D 30000, chksum =3D 0xff) / Raw(&quot;x&quot=
; * 100)=20
sendp(p, iface=3D'ens8', count=3D1)

6. ^C exit tcpdump and scapy or wireshark parsing data packets
scapy parsing data packets:
from scapy.contrib.gtp import *
pkt=3Drdpcap('1.pcap')
pkt[0].show2()


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
<span class=3D"quote">&gt;&gt;&gt; pkt[0].show2()</span >
###[ Ethernet ]###
  dst=3D 02:00:00:00:00:00
  src=3D 7e:45:ee:26:3a:23
  type=3D IPv4
###[ IP ]###
     version=3D 4
     ihl=3D 5
     tos=3D 0x0
     len=3D 164
     id=3D 1
     flags=3D
     frag=3D 0
     ttl=3D 64
     proto=3D udp
     chksum=3D 0xf146
     src=3D 10.0.0.1
     dst=3D 127.0.0.1
     \options\
###[ UDP ]###
        sport=3D 2152
        dport=3D 2182
        len=3D 144
        chksum=3D 0x7c10
###[ GTP-U Header ]###
           version=3D 1
           PT=3D 1
           reserved=3D 0
           E=3D 0
           S=3D 0
           PN=3D 0
           gtp_type=3D g_pdu
           length=3D 128
           teid=3D 1193046
###[ IP ]###
              version=3D 4
              ihl=3D 5
              tos=3D 0x0
              len=3D 128
              id=3D 1
              flags=3D
              frag=3D 0
              ttl=3D 64
              proto=3D udp
              chksum=3D 0xff
              src=3D 10.0.0.1
              dst=3D 127.0.0.1
              \options\
###[ UDP ]###
                 sport=3D 29999
                 dport=3D 30000
                 len=3D 108
                 chksum=3D 0xff
###[ Raw ]###
                    load=3D
'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxx'

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<span class=3D"quote">&gt;&gt;&gt; pkt[0].show2()</span >
###[ Ethernet ]###
  dst=3D 02:00:00:00:00:00
  src=3D 7e:45:ee:26:3a:23
  type=3D IPv4
###[ IP ]###
     version=3D 4
     ihl=3D 5
     tos=3D 0x0
     len=3D 164
     id=3D 1
     flags=3D
     frag=3D 0
     ttl=3D 64
     proto=3D udp
     chksum=3D 0xf146
     src=3D 10.0.0.1
     dst=3D 127.0.0.1
     \options\
###[ UDP ]###
        sport=3D 2152
        dport=3D 2182
        len=3D 144
        chksum=3D 0x8894
###[ GTP-U Header ]###
           version=3D 1
           PT=3D 1
           reserved=3D 0
           E=3D 0
           S=3D 0
           PN=3D 0
           gtp_type=3D g_pdu
           length=3D 128
           teid=3D 1193046
###[ IP ]###
              version=3D 4
              ihl=3D 5
              tos=3D 0x0
              len=3D 128
              id=3D 1
              flags=3D
              frag=3D 0
              ttl=3D 64
              proto=3D udp
              chksum=3D 0xf16a
              src=3D 10.0.0.1
              dst=3D 127.0.0.1
              \options\
###[ UDP ]###
                 sport=3D 29999
                 dport=3D 30000
                 len=3D 108
                 chksum=3D 0x42d
###[ Raw ]###
                    load=3D
'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx=
xxxxxxxxxxxxxxxxxxxxxxxxxx'

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

 app/test-pmd/csumonly.c | 522 ++++++++++++--------------------------------=
----
 1 file changed, 128 insertions, 394 deletions
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
?id=3D1672">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17416602800.CF1f.41625--
