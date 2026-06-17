Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC1DCD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 14:51:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB5D840276;
	Wed, 17 Jun 2026 16:51:43 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id CB0A040268
 for <dev@dpdk.org>; Wed, 17 Jun 2026 16:51:42 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B67824B6C8; Wed, 17 Jun 2026 16:51:42 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1958] Broadcom bnxt
 RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE always on
Date: Wed, 17 Jun 2026 14:51:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: riaan.wiid@vastech.co.za
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1958-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1958

            Bug ID: 1958
           Summary: Broadcom bnxt RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE always
                    on
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: riaan.wiid@vastech.co.za
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

dpdk-26.03 (tag v26.03)
OS: Rocky Linux (9.3 (Blue Onyx))
HW: Broadcom BCM57414 NetXtreme-E 10Gb/25Gb
Compiler: gcc 14.2.1 20240801 (Red Hat 14.2.1-1)

Description of Problem
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE is always enabled if not enabling PTP sup=
port
on a NIC port. In our case we are not enabling PTP support which means
RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE is enabled by default on all queues, whic=
h is
undesired behaviour when making use of Mbuf refcnt in our designs.

This behaviour seems to have started after this commit
https://github.com/DPDK/dpdk/commit/5722ed1aafd2fc5ad44e432a4f6c7bd337c673d8

RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE cannot be disabled through the offloads
specified in either rte_eth_dev_configure() or rte_eth_tx_queue_setup()

--=20
You are receiving this mail because:
You are the assignee for the bug.=
