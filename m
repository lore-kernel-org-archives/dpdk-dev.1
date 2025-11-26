Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E250DD1039B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 17:05:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E40DC40B9F;
	Wed, 26 Nov 2025 18:05:37 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C3703402D1
 for <dev@dpdk.org>; Wed, 26 Nov 2025 18:05:36 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B4C6848BB9; Wed, 26 Nov 2025 18:05:36 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1836] bnxt underreporting stats when queue count >
 RTE_ETHDEV_QUEUE_STAT_CNTRS
Date: Wed, 26 Nov 2025 17:05:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oleksandrn@interfacemasters.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1836-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1836

            Bug ID: 1836
           Summary: bnxt underreporting stats when queue count >
                    RTE_ETHDEV_QUEUE_STAT_CNTRS
           Product: DPDK
           Version: 24.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: oleksandrn@interfacemasters.com
  Target Milestone: ---

Basically, if you have more than RTE_ETHDEV_QUEUE_STAT_CNTRS queues, it will
underreport counters, specifically, ipacket, ibytes, and so on, so like tot=
al
port stats, not per queue ones.


I did a little bit of investigation:

bnxt_stats_get_op/bnxt_stats_get_ext both have this line

num_q_stats =3D RTE_MIN(bp->rx_cp_nr_rings,
              (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);

Then, in the loop, bnxt_hwrm_ring_stats is called to retrieve stats for the
queue, and bnxt_fill_rte_eth_stats is used to aggregate results and actually
add values to ipacket/ibytes; however, if rx_cp_nr_rings >
RTE_ETHDEV_QUEUE_STAT_CNTRS, it means that some queues are never checked.

Maybe there are hardware limitations I'm not aware of, but it seems like a =
bug
to me.


Originally saw this on 24.07, and now we are moving to 25, but just from the
code, it seems like 25 will have the same problem, but I haven't tried with
traffic yet on 25.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
