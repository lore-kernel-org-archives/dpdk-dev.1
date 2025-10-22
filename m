Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDFACCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 02:57:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B853040151;
	Wed, 22 Oct 2025 04:57:48 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 554AF400D6
 for <dev@dpdk.org>; Wed, 22 Oct 2025 04:57:47 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4347E4899E; Wed, 22 Oct 2025 04:57:47 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1805] Outdated CQE consumer index in
 rxq_burst_mprq_v()
Date: Wed, 22 Oct 2025 02:57:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 22.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: canary.overflow@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1805-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1805

            Bug ID: 1805
           Summary: Outdated CQE consumer index in rxq_burst_mprq_v()
           Product: DPDK
           Version: 22.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: canary.overflow@gmail.com
  Target Milestone: ---

In function rxq_burst_mprq_v() [drivers/net/mlx5/mlx5_rxtx_vec.c line 470]:

unsigned int cq_idx =3D rxq->cq_ci & q_mask;
...
cq =3D &(*rxq->cqes)[cq_idx];
rte_prefetch0(cq);
rte_prefetch0(cq + 1);
rte_prefetch0(cq + 2);
rte_prefetch0(cq + 3);
...
if (rcvd_pkt > 0) {
    rcvd_pkt =3D RTE_MIN(rcvd_pkt, pkts_n);
    cp_pkt =3D rxq_copy_mprq_mbuf_v(rxq, pkts, rcvd_pkt); // rxq->cq_ci
incremented here
    rxq->decompressed -=3D rcvd_pkt;
    pkts +=3D cp_pkt;
}
...
/* Not to overflow pkts array. */
pkts_n =3D RTE_ALIGN_FLOOR(pkts_n - cp_pkt, MLX5_VPMD_DESCS_PER_LOOP);
/* Not to cross queue end. */
pkts_n =3D RTE_MIN(pkts_n, elts_n - elts_idx);
pkts_n =3D RTE_MIN(pkts_n, q_n - cq_idx); // (1)=20
...
/* At this point, there shouldn't be any remaining packets. */
MLX5_ASSERT(rxq->decompressed =3D=3D 0);
/* Process all the CQEs */
nocmp_n =3D rxq_cq_process_v(rxq, cq, elts, pkts, pkts_n, err, &comp_idx); =
(2)

The cq pointer may be using an outdated rxq->cq_ci value if rcvd_pkt > 0 and
rxq->cq_ci gets incremented in rxq_copy_mprq_mbuf_v(). This may have the
following issues:
- pkts_n computed in (1) may be more than what it should be
- the cq pointer retrieved using the outdated cq_idx is being passed into
rxq_cq_process_v() again (2).


For the fix, I think the value of cq_idx needs to be updated again after the
processing the decompressed packets and cq pointer be retrieved after.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
