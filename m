Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FBBD6AAEC
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 18:21:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E59864028E;
	Thu,  2 Apr 2026 20:21:48 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8F4064027A
 for <dev@dpdk.org>; Thu,  2 Apr 2026 20:21:47 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 621D84AE0D; Thu,  2 Apr 2026 20:21:47 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1922] VLAN pattern flow rules not matching packets
 on XL710
Date: Thu, 02 Apr 2026 18:21:47 +0000
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
Message-ID: <bug-1922-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1922

            Bug ID: 1922
           Summary: VLAN pattern flow rules not matching packets on XL710
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

VLAN flow rules not matching properly (packets not dropped, not redirected =
to
proper queue). Examples:

Pattern: eth / vlan pcp is 0 / ipv4 src is 192.168.1.1 / end actions drop /=
 end
Reason: Packet was not dropped
Sent Packet: Ether / Dot1Q / 192.168.1.1 > 127.0.0.1 hopopt / Raw

Pattern: eth / vlan pcp is 0 / ipv4 dst is 192.168.1.2 / end actions queue
index 2 / end
Reason: Packet not received on queue 2
Sent Packet: Ether / Dot1Q / 172.17.0.2 > 192.168.1.2 hopopt / Raw

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
