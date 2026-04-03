Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C809E8538D
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Apr 2026 18:30:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A62940296;
	Fri,  3 Apr 2026 20:30:29 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 3FFFD4028B
 for <dev@dpdk.org>; Fri,  3 Apr 2026 20:30:28 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 362B94AE1C; Fri,  3 Apr 2026 20:30:28 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1927] MTU test suite failing on all environments
Date: Fri, 03 Apr 2026 18:30:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
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
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 target_milestone
Message-ID: <bug-1927-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1927

            Bug ID: 1927
           Summary: MTU test suite failing on all environments
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: DTS
          Assignee: dev@dpdk.org
          Reporter: dmarx@iol.unh.edu
                CC: juraj.linkes@pantheon.tech, probb@iol.unh.edu
  Target Milestone: ---

Running the MTU test suite on an XL710, E810, and CX6 all produce failures =
for
each test case:

mtu: FAIL
    cli_jumbo_forwarding_for_jumbo_mtu: FAIL
      reason: Did not receive packet.
    cli_mtu_forwarding_for_std_packets: FAIL
      reason: Did not receive packet.
    cli_mtu_std_packets_for_jumbo_mtu: FAIL
      reason: Did not receive packet.
    runtime_mtu_updating_and_forwarding: FAIL
      reason: Did not receive packet.

DPDK version: 26.03 rc2

XL710:

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

E810:

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

CX6:

sudo ethtool -i enp129s0f0np0
driver: mlx5_core
version: 24.07-0.6.1
firmware-version: 26.42.1000 (MT_0000000531)
expansion-rom-version:=20
bus-info: 0000:81:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: yes

uname -m
x86_64

--=20
You are receiving this mail because:
You are the assignee for the bug.=
