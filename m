Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3561ACCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 13:53:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F69A4067E;
	Wed,  5 Nov 2025 14:53:28 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0E5124021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 14:53:27 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D41C748A73; Wed,  5 Nov 2025 14:53:26 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1824] when setting promisc mode to off no packets
 arrive to testpmd
Date: Wed, 05 Nov 2025 13:53:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: pdamouny@nvidia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1824-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1824

            Bug ID: 1824
           Summary: when setting promisc mode to off no packets arrive to
                    testpmd
           Product: DPDK
           Version: 25.07
          Hardware: x86
                OS: Windows
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: pdamouny@nvidia.com
  Target Milestone: ---

Hi

using testpmd on TX side
dpdk-testpmd.exe -- --burst=3D64 --mbcache=3D512 -i --nb-cores=3D4 --txd=3D=
1024
--rxd=3D1024 --forward-mode=3Dmac --txq=3D2 --rxq=3D2 --auto-start --port-t=
opology=3Dloop
--disable-rss

when i send 100 packet from RX side, and do show port stats 0 on TX side
i see 100 packets received,=20

if i set promisc 0 off on testpmd, packets are not received=20

last working time upstream-2025-09-14
git checkout upstream-2025-09-14

--=20
You are receiving this mail because:
You are the assignee for the bug.=
