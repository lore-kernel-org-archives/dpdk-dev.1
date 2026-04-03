Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDFBE8538B
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 18:00:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA25440296;
	Fri,  3 Apr 2026 20:00:49 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 44A8B4028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 20:00:49 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 377904AE1B; Fri,  3 Apr 2026 20:00:49 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1926] QinQ strip not working on XL710
Date: Fri, 03 Apr 2026 18:00:49 +0000
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
Message-ID: <bug-1926-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1926

            Bug ID: 1926
           Summary: QinQ strip not working on XL710
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

Packets with a single 88a8 tag, and packets with 88a8 and 8100 tags, are not
affected with qinq strip enabled:

testpmd> vlan set qinq_strip on 0
testpmd> vlan set strip on 0

Sent Dot1AD: Ether(src=3D'40:a6:b7:22:b0:18',
dst=3D'3c:fd:fe:c8:1a:a8')/Dot1AD()/IP(src=3D'192.168.100.3',
dst=3D'192.168.101.3')/UDP(sport=3D4321, dport=3D1234)/Raw(load=3Db'xxxxx')

Received: Ether / Dot1AD / IP / UDP 192.168.100.3:4321 > 192.168.101.3:1234=
 /
Raw / Padding

Sent QinQ: Ether(src=3D'40:a6:b7:22:b0:18',
dst=3D'3c:fd:fe:c8:1a:a8')/Dot1AD()/Dot1Q()/IP(src=3D'192.168.100.3',
dst=3D'192.168.101.3')/UDP(sport=3D4321, dport=3D1234)/Raw(load=3Db'xxxxx')

Received: Ether / Dot1AD / Dot1Q / IP / UDP 192.168.100.3:4321 >
192.168.101.3:1234 / Raw / Padding

It seems a previous ticket was closed a few years ago without resolution, w=
hich
outlined the same problem: https://bugs.dpdk.org/show_bug.cgi?id=3D1122

sudo ethtool -i enp181s0f0np0
driver: i40e
version: 6.8.0-106-generic
firmware-version: 9.55 0x8000fe31 1.3862.0
expansion-rom-version:=20
bus-info: 0000:b5:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

uname -m
x86_64

DPDK version: 26.03 rc2

--=20
You are receiving this mail because:
You are the assignee for the bug.=
