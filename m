Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BADFF8873
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 16:39:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C4564021F;
	Thu, 30 Apr 2026 18:39:57 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9ED01400D6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 18:39:55 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 8F9404B0FD; Thu, 30 Apr 2026 18:39:55 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1941] net/tap: wrong ptype leads to checksum failure
Date: Thu, 30 Apr 2026 16:39:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ktraynor@redhat.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1941-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1941

            Bug ID: 1941
           Summary: net/tap: wrong ptype leads to checksum failure
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: ktraynor@redhat.com
  Target Milestone: ---

Adding bugzilla for issue reported by Robin in [0], so we can link in relea=
se
notes:

Since commit 1f250674085a ("net: fix packet type for stacked VLAN"),
rte_net_get_ptype() uses |=3D to set the L2 ptype inside the VLAN
parsing loop. Since pkt_type is already initialized with
RTE_PTYPE_L2_ETHER (0x1), or-ing it with RTE_PTYPE_L2_ETHER_VLAN
(0x6) results in RTE_PTYPE_L2_ETHER_QINQ (0x7). This causes single
VLAN frames to be misidentified as QinQ.

This was detected while testing DPDK 25.11.1 in grout. The net/tap
driver calls rte_net_get_ptype() in tap_verify_csum() to determine
the L2 header length. With the wrong ptype, l2_len is set to 22
(ether + QinQ =3D 14 + 8) instead of 18 (ether + VLAN =3D 14 + 4),
shifting the IP header pointer by 4 bytes. The checksum is then
computed on garbage data, causing valid packets to be dropped.


[0] https://mails.dpdk.org/archives/dev/2026-April/336248.html

--=20
You are receiving this mail because:
You are the assignee for the bug.=
