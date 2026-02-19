Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85A7E9A02C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 01:05:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADECF402C6;
	Thu, 19 Feb 2026 02:05:05 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0E8E0402BD
 for <dev@dpdk.org>; Thu, 19 Feb 2026 02:05:04 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id F32464A667; Thu, 19 Feb 2026 02:05:03 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 1884] vhost: fix tx_burst return value after
 VLAN insertion failure
Date: Thu, 19 Feb 2026 01:05:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1884-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1884

            Bug ID: 1884
           Summary: vhost: fix tx_burst return value after VLAN insertion
                    failure
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: vhost/virtio
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Found while auditing tx_burst semantics of drivers.

The eth_vhost_tx() function violates the rte_eth_tx_burst() ownership
contract when VLAN insertion fails for some packets.

The VLAN pre-processing loop compacts surviving packets into bufs[]
starting at index 0:

    for (i =3D 0; i < nb_bufs; i++) {
        struct rte_mbuf *m =3D bufs[i];

        if (m->ol_flags & RTE_MBUF_F_TX_VLAN) {
            int error =3D rte_vlan_insert(&m);
            if (unlikely(error)) {
                rte_pktmbuf_free(m);
                continue;           /* <-- skip, don't store */
            }
        }
        bufs[nb_send] =3D m;          /* <-- compacts in-place */
        ++nb_send;
    }

When VLAN insertion fails, the packet is freed and skipped, so
nb_send < nb_bufs and the bufs[] array is rewritten as a compacted
version. After rte_vhost_enqueue_burst() the function returns nb_tx
(the number enqueued to the guest).

This causes two problems:

1. The return value does not correspond to a prefix of the original
   array. The caller expects bufs[0..n-1] to be consumed and
   bufs[n..nb_bufs-1] to be untouched. But the compaction has
   shuffled entries so bufs[n..nb_bufs-1] now contains stale
   pointers from before compaction.

   For example, with nb_bufs=3D4 where bufs[1] fails VLAN insertion:

     Original: bufs[] =3D {A, B, C, D}
     After compaction: bufs[] =3D {A, C, D, D}
                                          ^
                                    stale duplicate

   If vhost enqueues 2 (nb_tx=3D2), the driver frees A and C (which
   the driver enqueued - those are freed at line 515-516). The
   caller sees nb_tx=3D2, then tries to free bufs[2] and bufs[3],
   which are D and D -- double free.

2. Packets that passed VLAN pre-processing but were not enqueued
   by rte_vhost_enqueue_burst() are not freed by the driver.
   The caller cannot reliably free them either because the array
   has been rewritten.

The missed_pkts statistic (nb_bufs - nb_tx) is also inflated
because it counts VLAN failures (already freed) as missed.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
