Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE05C44515
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:27:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D762B402A7;
	Mon, 20 Jul 2026 11:27:49 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C016E4028C
 for <dev@dpdk.org>; Mon, 20 Jul 2026 11:27:48 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B0B944B8EE; Mon, 20 Jul 2026 11:27:48 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1970] fib: trie leaks a tbl8 group and can corrupt
 the dataplane  when a tbl8 allocation fails during insert
Date: Mon, 20 Jul 2026 09:27:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: maxime@leroys.fr
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-1970-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1970

            Bug ID: 1970
           Summary: fib: trie leaks a tbl8 group and can corrupt the
                    dataplane  when a tbl8 allocation fails during insert
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: maxime@leroys.fr
  Target Milestone: ---

Created attachment 356
  --> http://bugs.dpdk.org/attachment.cgi?id=3D356&action=3Dedit
Patch to reproduce the bug

On a full or tight tbl8 pool, an add whose install runs out of tbl8 groups
mid-way
is not rolled back: the group(s) already taken are leaked and the tbl24 ent=
ry
already written is left dangling.
trie_modify() undoes only the RIB node (rte_rib6_remove), never the datapla=
ne
or the tbl8 pool. A later, valid add is then wrongly refused with -ENOSPC, =
and
a multi-interval update can leave the dataplane inconsistent.


Steps to reproduce (fixed pool, no RCU)
---------------------------------------

IPv6 trie, 2-byte next hop, config.trie.num_tbl8 =3D 1:

    rte_fib6_add(fib, 2001:db8::, 32, nh);   ->  -ENOSPC
    rte_fib6_add(fib, fc00::,     25, nh);   ->  -ENOSPC   (WRONG)

Expected: the /25 needs a single tbl8 group and the pool has capacity
1, so it must succeed. It is refused because the failed /32 leaked the
only group.

Instrumenting tbl8_pool_pos at the modify_dp() call confirms the leak:

    add /32: ret=3D-ENOSPC, tbl8_pool_pos 0 -> 1  (group taken, not returne=
d)
    add /25: ret=3D-ENOSPC, tbl8_pool_pos 1 -> 1  (no free group left)

QSBR defer mode (pool of 2, a reader kept non-quiescent):

    add /25 ; delete /25    (group deferred; rsvd_tbl8s back to 0)
    add /32                 ->  passes the reservation check, then leaks
    add /25 (other prefix)  ->  -ENOSPC (WRONG: a group was leaked)

A reproducer is attached (test/fib6). Both new cases fail on current
main:
    0001-test-fib6-reproduce-tbl8-leak-on-failed-trie-insert.patch


Root cause
----------

install_to_dp() (build_common_root()/write_edge()) allocates and
publishes tbl8 groups incrementally and has no failure path: on
tbl8_alloc() failure it returns an error, leaving the partial writes
and the taken groups in place. trie_modify() only removes the RIB node.

Two reasons the pre-check does not prevent it:

1. Transient peak. trie_modify() checks the steady-state footprint:

       if (dp->rsvd_tbl8s + count_empty_levels(node) > dp->number_tbl8s)

   but install_to_dp() transiently needs footprint + 1 for a
   byte-aligned prefix: build_common_root() descends one byte level
   past the prefix and allocates a group there; recycle_root_path()
   frees it only at the end. So the check passes with a pool of one,
   the install takes the first group, then tbl8_alloc() for the
   transient group fails.

2. Logical vs physical, under QSBR defer. rsvd_tbl8s tracks the
   logical reservation, not physical occupancy. In
   RTE_FIB6_QSBR_MODE_DQ a recycled group stays out of the pool until
   a grace period elapses, so rsvd_tbl8s drops while the group is
   still allocated, and the check accepts an add that then fails.

modify_dp() also calls install_to_dp() once per gap around covering
more-specifics; under defer mode each interval's transient group
accumulates, so the peak can exceed footprint + 1, and a failure on a
late interval leaves earlier intervals already written (a lookup in
one range returns the new next hop while another returns the old one).

--=20
You are receiving this mail because:
You are the assignee for the bug.=
