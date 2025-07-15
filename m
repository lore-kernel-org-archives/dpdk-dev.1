Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BFBC83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 03:05:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A24F4021E;
	Tue, 15 Jul 2025 05:05:20 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 815894013F
 for <dev@dpdk.org>; Tue, 15 Jul 2025 05:05:18 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 5CBE046B78; Tue, 15 Jul 2025 05:05:18 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1754] [dpdk-25.07-rc3]tso/test_tso_tunneling:
 Nvgre RX or TX packet number not correct
Date: Tue, 15 Jul 2025 03:05:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yex.chen@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1754-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17525487180.A37EE70.3184190
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugs.dpdk.org/
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


--17525487180.A37EE70.3184190
Date: Tue, 15 Jul 2025 05:05:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1754

            Bug ID: 1754
           Summary: [dpdk-25.07-rc3]tso/test_tso_tunneling: Nvgre RX or TX
                    packet number not correct
           Product: DPDK
           Version: 25.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: yex.chen@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DPDK version: 9fe9c0b231c8da5435bfccb1963121b4277f961c version: dpdk25.07-r=
c3
OS: Fedora42/6.14.5-300.fc42.x86_64
Compiler: gcc version 15.1.1 20250425
Hardware platform: Intel(R) Xeon(R) Gold 6252N CPU @ 2.30GHz
NIC hardware: Intel Corporation Ethernet Controller X710 for 10GbE SFP+ (rev
01)
NIC firmware:=20
  driver: vfio-pci
  kdriver: i40e-2.28.7
  firmware-version: 9.54 0x8000fb3f 1.3800.0

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. dut start testpmd
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:31:00.0 0000:31:00=
.1
x86_64-native-linuxapp-gcc/app/dpdk-testpmd  -l 1-2 -n 4 -a 0000:31:00.0 -a
0000:31:00.1  --file-prefix=3Ddpdk_268618_20250714132702=20=20=20=20
--force-max-simd-bitwidth=3D64   -- -i --rxd=3D512 --txd=3D512 --burst=3D32
--rxfreet=3D64 --mbcache=3D128 --portmask=3D0x3 --max-pkt-len=3D9000 --txpt=
=3D36 --txht=3D0
--txwt=3D0 --txfreet=3D32 --txrst=3D32

testpmd> set verbose 1
testpmd> port stop all
testpmd> csum set ip hw 0
testpmd> csum set udp hw 0
testpmd> csum set tcp hw 0
testpmd> csum set sctp hw 0
testpmd> csum set outer-ip hw 0
testpmd> csum parse-tunnel on 0
testpmd> csum set ip hw 1
testpmd> csum set udp hw 1
testpmd> csum set tcp hw 1
testpmd> csum set sctp hw 1
testpmd> csum set outer-ip hw 1
testpmd> csum parse-tunnel on 1
testpmd> tunnel_tso set 800 1
testpmd> rx_vxlan_port add 4789 0
testpmd> set fwd csum
testpmd> port start all
testpmd> set promisc all off
testpmd> start

2. start tester tcpdump to save the capture packet
tcpdump -w /tmp/tcpdump_ens9f1.pcap -i ens9f1 2>tcpdump_ens9f1.out &=20

3. start tester scapy send pkt
scapy
>>>
>>> sendp([Ether(dst=3D"3c:fd:fe:c0:e1:d8",src=3D"52:00:00:00:00:00")/IP(sr=
c=3D"192.168.1.1",dst=3D"192.168.1.2",proto=3D47)/GRE(key_present=3D1,proto=
=3D0x6558,key=3D0x00001000)/Ether(dst=3D"3c:fd:fe:c0:e1:d8",src=3D"52:00:00=
:00:00:00")/IP(src=3D"192.168.1.1",dst=3D"192.168.1.2")/TCP(sport=3D1021,dp=
ort=3D1021)/("X"*128)],
>>> iface=3D"ens9f0")

4. kill tester tcpdump
killall tcpdump

5. tester check packet number
tcpdump  -vv -r /tmp/tcpdump_ens9f1.pcap 2>/dev/null | grep "seq"  | grep
"length"

Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
length 10708

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
length 128

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit: a5854045c38865c44459446565dc749aa29dffba

Author: Dengdui Huang <huangdengdui@huawei.com>
Date:   Mon Jun 16 16:27:01 2025 +0800



    net: add tunnel length in UDP tunnel parsing

    Currently, the tunnel length info is not available when
    get the tunnel packet type with UDP port. This patch
    adds the parsing of the tunnel length info.

    Additionally, adding comments for the inner_l2_len field
    and the tunnel_len field would help in understanding their.

    Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
    Cc: stable@dpdk.org

    Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17525487180.A37EE70.3184190
Date: Tue, 15 Jul 2025 05:05:18 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
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
   title=3D"UNCONFIRMED - [dpdk-25.07-rc3]tso/test_tso_tunneling: Nvgre RX =
or TX packet number not correct"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1754">1754</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.07-rc3]tso/test_tso_tunneling: Nvgre RX or TX packet=
 number not correct
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
          <td>yex.chen&#64;intel.com
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
DPDK version: 9fe9c0b231c8da5435bfccb1963121b4277f961c version: dpdk25.07-r=
c3
OS: Fedora42/6.14.5-300.fc42.x86_64
Compiler: gcc version 15.1.1 20250425
Hardware platform: Intel(R) Xeon(R) Gold 6252N CPU &#64; 2.30GHz
NIC hardware: Intel Corporation Ethernet Controller X710 for 10GbE SFP+ (rev
01)
NIC firmware:=20
  driver: vfio-pci
  kdriver: i40e-2.28.7
  firmware-version: 9.54 0x8000fb3f 1.3800.0

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. dut start testpmd
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:31:00.0 0000:31:00=
.1
x86_64-native-linuxapp-gcc/app/dpdk-testpmd  -l 1-2 -n 4 -a 0000:31:00.0 -a
0000:31:00.1  --file-prefix=3Ddpdk_268618_20250714132702=20=20=20=20
--force-max-simd-bitwidth=3D64   -- -i --rxd=3D512 --txd=3D512 --burst=3D32
--rxfreet=3D64 --mbcache=3D128 --portmask=3D0x3 --max-pkt-len=3D9000 --txpt=
=3D36 --txht=3D0
--txwt=3D0 --txfreet=3D32 --txrst=3D32

testpmd&gt; set verbose 1
testpmd&gt; port stop all
testpmd&gt; csum set ip hw 0
testpmd&gt; csum set udp hw 0
testpmd&gt; csum set tcp hw 0
testpmd&gt; csum set sctp hw 0
testpmd&gt; csum set outer-ip hw 0
testpmd&gt; csum parse-tunnel on 0
testpmd&gt; csum set ip hw 1
testpmd&gt; csum set udp hw 1
testpmd&gt; csum set tcp hw 1
testpmd&gt; csum set sctp hw 1
testpmd&gt; csum set outer-ip hw 1
testpmd&gt; csum parse-tunnel on 1
testpmd&gt; tunnel_tso set 800 1
testpmd&gt; rx_vxlan_port add 4789 0
testpmd&gt; set fwd csum
testpmd&gt; port start all
testpmd&gt; set promisc all off
testpmd&gt; start

2. start tester tcpdump to save the capture packet
tcpdump -w /tmp/tcpdump_ens9f1.pcap -i ens9f1 2&gt;tcpdump_ens9f1.out &amp;=
=20

3. start tester scapy send pkt
scapy
<span class=3D"quote">&gt;&gt;&gt;
&gt;&gt;&gt; sendp([Ether(dst=3D&quot;3c:fd:fe:c0:e1:d8&quot;,src=3D&quot;5=
2:00:00:00:00:00&quot;)/IP(src=3D&quot;192.168.1.1&quot;,dst=3D&quot;192.16=
8.1.2&quot;,proto=3D47)/GRE(key_present=3D1,proto=3D0x6558,key=3D0x00001000=
)/Ether(dst=3D&quot;3c:fd:fe:c0:e1:d8&quot;,src=3D&quot;52:00:00:00:00:00&q=
uot;)/IP(src=3D&quot;192.168.1.1&quot;,dst=3D&quot;192.168.1.2&quot;)/TCP(s=
port=3D1021,dport=3D1021)/(&quot;X&quot;*128)],
&gt;&gt;&gt; iface=3D&quot;ens9f0&quot;)</span >

4. kill tester tcpdump
killall tcpdump

5. tester check packet number
tcpdump  -vv -r /tmp/tcpdump_ens9f1.pcap 2&gt;/dev/null | grep &quot;seq&qu=
ot;  | grep
&quot;length&quot;

Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
length 10708

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
length 128

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit: a5854045c38865c44459446565dc749aa29dffba

Author: Dengdui Huang &lt;<a href=3D"mailto:huangdengdui&#64;huawei.com">hu=
angdengdui&#64;huawei.com</a>&gt;
Date:   Mon Jun 16 16:27:01 2025 +0800



    net: add tunnel length in UDP tunnel parsing

    Currently, the tunnel length info is not available when
    get the tunnel packet type with UDP port. This patch
    adds the parsing of the tunnel length info.

    Additionally, adding comments for the inner_l2_len field
    and the tunnel_len field would help in understanding their.

    Fixes: 64ed7f854cf4 (&quot;net: add tunnel packet type parsing&quot;)
    Cc: <a href=3D"mailto:stable&#64;dpdk.org">stable&#64;dpdk.org</a>

    Signed-off-by: Dengdui Huang &lt;<a href=3D"mailto:huangdengdui&#64;hua=
wei.com">huangdengdui&#64;huawei.com</a>&gt;
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
?id=3D1754">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17525487180.A37EE70.3184190--
