Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE915C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 17:52:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1277E4026F;
	Fri, 28 Aug 2026 19:52:56 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id D4E5740151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:52:54 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D101E4CFE0; Fri, 28 Aug 2026 19:52:54 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2018] memif: zero copy design issues
Date: Fri, 28 Aug 2026 17:52:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone bug_group
Message-ID: <bug-2018-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2018

            Bug ID: 2018
           Summary: memif: zero copy design issues
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---
             Group: security

Both VPP and DPDK have this bug found by AI assisted review of memif.

In eth_memif_rx_zc() in drivers/net/memif/rte_eth_memif.c the peer's
descriptor length is written straight into the mbuf:

    rte_pktmbuf_data_len(mbuf) =3D d0->length;
    rte_pktmbuf_pkt_len(mbuf) =3D rte_pktmbuf_data_len(mbuf);

with no check against the mbuf data room. Chained segments accumulate
the same unchecked value into the head mbuf's pkt_len through
memif_pktmbuf_chain(). The copy-mode path has the same problem with the
same field, filed separately.

The mbufs here belong to the local side, so the driver itself does not
read out of bounds. The consequence is downstream: every consumer of
data_len and pkt_len treats them as valid. An application that does
rte_pktmbuf_mtod() and reads pkt_len bytes, or transmits the mbuf on a
real NIC that DMAs pkt_len bytes, reads past the end of the mbuf data
area and into adjacent objects in the same mempool. Those adjacent
objects hold other packets, so the result can be an information leak
onto the wire.

Zero-copy is client-role only, so the peer supplying these lengths is
the server. Under the memif trust model the client trusts the server,
so this is not a trust boundary violation in a correct deployment. It
is still worth fixing:

  - the trust model is not documented, so users cannot currently know
    which deployments are correct;
  - a zero-copy client exposes considerably more than its packet pool.
    memif_init_regions_and_queues() walks every memseg list and shares
    each one as a region ("Zero-copy exposes dpdk memory"), so the peer
    sees the whole of the local DPDK memory, not just the mbufs it is
    meant to fill. That raises the value of getting the receive path
    right even against a peer that is only buggy rather than hostile;
  - this path has a history of memory-safety defects, including a
    zero-copy Rx overflow fixed in 2024.

Suggested fix
-------------

Bound the length by rte_pktmbuf_data_room_size(mq->mempool) minus the
headroom before assigning it, taking the value from a private snapshot
of the descriptor so the peer cannot change it between check and use.

Prefer dropping the buffer chain and counting an xstat over silently
clamping. A clamp keeps a malformed packet in flight with a plausible
length, which is harder to diagnose than a counted drop, and it would
leave the zero-copy path behaving differently from the copy path for
the same peer. Whichever is chosen, the two paths should agree.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
