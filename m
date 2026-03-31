Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C35109B493
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 16:03:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58A9D40A72;
	Tue, 31 Mar 2026 18:03:53 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6793540A6D
 for <dev@dpdk.org>; Tue, 31 Mar 2026 18:03:52 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 584514ADF0; Tue, 31 Mar 2026 18:03:52 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1919] Packets with mismatched address received with
 promiscuous mode disabled on CX6 NIC
Date: Tue, 31 Mar 2026 16:03:52 +0000
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
Message-ID: <bug-1919-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1919

            Bug ID: 1919
           Summary: Packets with mismatched address received with
                    promiscuous mode disabled on CX6 NIC
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

Packets with mismatched address received with promiscuous mode disabled

testpmd> set promisc 0 off
testpmd> show port info 0

********************* Infos for port 0  *********************
MAC address: B8:3F:D2:52:B7:24

sent packet: Ether(dst=3D'00:00:00:00:00:01',
src=3D'a0:88:c2:95:79:c4')/IP(src=3D'192.168.100.3',
dst=3D'192.168.101.3')/Raw(load=3Db'xxxxx')

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

DPDK version: 26.03 rc2

--=20
You are receiving this mail because:
You are the assignee for the bug.=
