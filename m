Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B998D730AD
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 18:44:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C0D840296;
	Fri,  3 Apr 2026 20:44:46 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 22F314028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 20:44:44 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 0DFC94AE1B; Fri,  3 Apr 2026 20:44:44 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1928] QinQ strip not working on E810
Date: Fri, 03 Apr 2026 18:44:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dmarx@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1928-3@http.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1928

            Bug ID: 1928
           Summary: QinQ strip not working on E810
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: dmarx@iol.unh.edu
  Target Milestone: ---

Double 8100 tag, Single 88a8 tag, QinQ (88a8 and 8100 tags) all not stripped
properly with combination of qinq/vlan strip enabled:

testpmd> vlan set qinq_strip on 0
testpmd> vlan set strip on 0

Sent double 8100: Ether(src=3D'10:70:fd:18:5a:54',
dst=3D'6c:fe:54:41:ad:d0')/Dot1Q(vlan=3D100)/Dot1Q(vlan=3D200)/IP(src=3D'19=
2.168.100.3',
dst=3D'192.168.101.3')/UDP(sport=3D4321, dport=3D1234)/Raw(load=3Db'xxxxx')

Received double 8100: Ether  dst=3D6c:fe:54:41:ad:d0 src=3D10:70:fd:18:5a:54
type=3DIPv4 |<IP  version=3D4 ihl=3D5 tos=3D0x0 len=3D33 id=3D1 flags=3D fr=
ag=3D0 ttl=3D64
proto=3Dudp chksum=3D0x3074 src=3D192.168.100.3 dst=3D192.168.101.3 |<UDP  =
sport=3D4321
dport=3D1234 len=3D13 chksum=3D0x36d8 |<Raw  load=3Db'xxxxx'

Sent single 88a8: Ether(src=3D'10:70:fd:18:5a:54',
dst=3D'6c:fe:54:41:ad:d0')/Dot1AD()/IP(src=3D'192.168.100.3',
dst=3D'192.168.101.3')/UDP(sport=3D4321, dport=3D1234)/Raw(load=3Db'xxxxx')

Received single 88a8: Ether  dst=3D6c:fe:54:41:ad:d0 src=3D10:70:fd:18:5a:54
type=3D802_1AD |<Dot1AD  prio=3D0 dei=3D0 vlan=3D1 type=3DIPv4 |<IP  versio=
n=3D4 ihl=3D5
tos=3D0x0 len=3D33 id=3D1 flags=3D frag=3D0 ttl=3D64 proto=3Dudp chksum=3D0=
x3074
src=3D192.168.100.3 dst=3D192.168.101.3 |<UDP  sport=3D4321 dport=3D1234 le=
n=3D13
chksum=3D0x36d8 |<Raw  load=3Db'xxxxx'

Sent qinq: Ether(src=3D'10:70:fd:18:5a:54',
dst=3D'6c:fe:54:41:ad:d0')/Dot1AD()/Dot1Q()/IP(src=3D'192.168.100.3',
dst=3D'192.168.101.3')/UDP(sport=3D4321, dport=3D1234)/Raw(load=3Db'xxxxx')

Received qinq: Ether  dst=3D6c:fe:54:41:ad:d0 src=3D10:70:fd:18:5a:54 type=
=3D802_1AD
|<Dot1AD  prio=3D0 dei=3D0 vlan=3D1 type=3DIPv4 |<IP  version=3D4 ihl=3D5 t=
os=3D0x0 len=3D33
id=3D1 flags=3D frag=3D0 ttl=3D64 proto=3Dudp chksum=3D0x3074 src=3D192.168=
.100.3
dst=3D192.168.101.3 |<UDP  sport=3D4321 dport=3D1234 len=3D13 chksum=3D0x36=
d8 |<Raw=20
load=3Db'xxxxx'

sudo ethtool -i enP4s4f0np0
driver: ice
version: 6.8.0-106-generic
firmware-version: 4.90 0x80020ef2 1.3863.0
expansion-rom-version:=20
bus-info: 0004:01:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

uname -m
aarch64

DPDK version: 26.03 rc2

--=20
You are receiving this mail because:
You are the assignee for the bug.=
