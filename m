Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139CBC83F17
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Jul 2025 02:35:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C34B34021E;
	Tue, 15 Jul 2025 04:35:10 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 79D6E4013F
 for <dev@dpdk.org>; Tue, 15 Jul 2025 04:35:09 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4D4EF46B78; Tue, 15 Jul 2025 04:35:09 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1753]
 [dpdk-25.07-rc3]nvgre/test_nvgre_ipv4_checksum_offload: checksum fail
Date: Tue, 15 Jul 2025 02:35:08 +0000
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
Message-ID: <bug-1753-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17525469090.7de1bB.3166157
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


--17525469090.7de1bB.3166157
Date: Tue, 15 Jul 2025 04:35:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1753

            Bug ID: 1753
           Summary: [dpdk-25.07-rc3]nvgre/test_nvgre_ipv4_checksum_offload
                    : checksum fail
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
1.dut start testpmd
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:31:00.0 0000:31:00=
.1
x86_64-native-linuxapp-gcc/app/dpdk-testpmd  -l 1-5 -n 4 -a 0000:31:00.0 -a
0000:31:00.1  --file-prefix=3Ddpdk_187982_20250711151456=20=20=20=20
--force-max-simd-bitwidth=3D64   -- -i --disable-rss --rxq=3D4 --txq=3D4 --=
nb-cores=3D4
--portmask=3D0x3 --enable-rx-cksum

testpmd> vlan set filter off 0
testpmd> set verbose 1
testpmd> set fwd csum
testpmd> port stop all
testpmd> csum set ip hw 1
testpmd> csum set udp hw 1
testpmd> csum set tcp hw 1
testpmd> csum set sctp hw 1
testpmd> csum set outer-ip hw 1
testpmd> csum parse-tunnel on 1
testpmd> port start all
testpmd> start

2. start tester scapy_0 to save the capture packet
scapy
>>> p=3Dsniff(iface=3D"ens9f1",filter=3D"ether[12:2]!=3D0x88cc",timeout=3D1=
0)

3. start tester scapy_1 send pkt with error ip.checksum 0x1234
scapy
>>> p =3D Ether(dst=3D'3c:fd:fe:c0:e1:d8', src=3D'00:00:10:00:00:00')/IP(fr=
ag=3D0,
>>> src=3D'192.168.1.1', dst=3D'192.168.1.2')/GRE(key_present=3D1,
>>> key=3D0x100)/Ether(dst=3D'90:e2:ba:4a:34:89', src=3D'90:e2:ba:4a:34:88',
>>> type=3D0x0800)/IP(frag=3D0, chksum=3D0x1234, src=3D'192.168.2.1',
>>> dst=3D'192.168.2.2')/UDP(sport=3D1021,
>>> dport=3D1021)/Raw(load=3Db'XXXXXXXXXXXXXXXXXX')
>>> sendp(p, iface=3D"ens9f0")

4. save the capture packet into pcap format in tester scapy_0
>>> wrpcap("/root/capture.pcap", p)

5. check ip.checksum in tester
tshark -r /root/capture.pcap -T fields -e ip.checksum

Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
0x1234 is in output.

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0xf56a is in output.

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit a738c43ffaee9ba5d8eccb0e881e7c816d3c6415
Author: Dengdui Huang <huangdengdui@huawei.com>
Date:   Mon Jun 16 16:27:02 2025 +0800



    app/testpmd: fix tunnel inner info

    The l2_len field of tunnel packets already includes the tunnel_len fiel=
d.
    Additionally, the current offset used for the internal Ethernet header =
is
    incorrect. This patch fixes these issues.

    Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
    Cc: stable@dpdk.org

    Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17525469090.7de1bB.3166157
Date: Tue, 15 Jul 2025 04:35:09 +0200
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
   title=3D"UNCONFIRMED - [dpdk-25.07-rc3]nvgre/test_nvgre_ipv4_checksum_of=
fload: checksum fail"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1753">1753</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk-25.07-rc3]nvgre/test_nvgre_ipv4_checksum_offload: check=
sum fail
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
1.dut start testpmd
usertools/dpdk-devbind.py --force --bind=3Dvfio-pci 0000:31:00.0 0000:31:00=
.1
x86_64-native-linuxapp-gcc/app/dpdk-testpmd  -l 1-5 -n 4 -a 0000:31:00.0 -a
0000:31:00.1  --file-prefix=3Ddpdk_187982_20250711151456=20=20=20=20
--force-max-simd-bitwidth=3D64   -- -i --disable-rss --rxq=3D4 --txq=3D4 --=
nb-cores=3D4
--portmask=3D0x3 --enable-rx-cksum

testpmd&gt; vlan set filter off 0
testpmd&gt; set verbose 1
testpmd&gt; set fwd csum
testpmd&gt; port stop all
testpmd&gt; csum set ip hw 1
testpmd&gt; csum set udp hw 1
testpmd&gt; csum set tcp hw 1
testpmd&gt; csum set sctp hw 1
testpmd&gt; csum set outer-ip hw 1
testpmd&gt; csum parse-tunnel on 1
testpmd&gt; port start all
testpmd&gt; start

2. start tester scapy_0 to save the capture packet
scapy
<span class=3D"quote">&gt;&gt;&gt; p=3Dsniff(iface=3D&quot;ens9f1&quot;,fil=
ter=3D&quot;ether[12:2]!=3D0x88cc&quot;,timeout=3D10)</span >

3. start tester scapy_1 send pkt with error ip.checksum 0x1234
scapy
<span class=3D"quote">&gt;&gt;&gt; p =3D Ether(dst=3D'3c:fd:fe:c0:e1:d8', s=
rc=3D'00:00:10:00:00:00')/IP(frag=3D0,
&gt;&gt;&gt; src=3D'192.168.1.1', dst=3D'192.168.1.2')/GRE(key_present=3D1,
&gt;&gt;&gt; key=3D0x100)/Ether(dst=3D'90:e2:ba:4a:34:89', src=3D'90:e2:ba:=
4a:34:88',
&gt;&gt;&gt; type=3D0x0800)/IP(frag=3D0, chksum=3D0x1234, src=3D'192.168.2.=
1',
&gt;&gt;&gt; dst=3D'192.168.2.2')/UDP(sport=3D1021,
&gt;&gt;&gt; dport=3D1021)/Raw(load=3Db'XXXXXXXXXXXXXXXXXX')
&gt;&gt;&gt; sendp(p, iface=3D&quot;ens9f0&quot;)</span >

4. save the capture packet into pcap format in tester scapy_0
<span class=3D"quote">&gt;&gt;&gt; wrpcap(&quot;/root/capture.pcap&quot;, p=
)</span >

5. check ip.checksum in tester
tshark -r /root/capture.pcap -T fields -e ip.checksum

Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
0x1234 is in output.

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
0xf56a is in output.

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit a738c43ffaee9ba5d8eccb0e881e7c816d3c6415
Author: Dengdui Huang &lt;<a href=3D"mailto:huangdengdui&#64;huawei.com">hu=
angdengdui&#64;huawei.com</a>&gt;
Date:   Mon Jun 16 16:27:02 2025 +0800



    app/testpmd: fix tunnel inner info

    The l2_len field of tunnel packets already includes the tunnel_len fiel=
d.
    Additionally, the current offset used for the internal Ethernet header =
is
    incorrect. This patch fixes these issues.

    Fixes: 76730c7b9b5a (&quot;app/testpmd: use packet type parsing API&quo=
t;)
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
?id=3D1753">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17525469090.7de1bB.3166157--
