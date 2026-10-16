Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43598CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 06:51:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0373540297;
	Fri, 16 Oct 2026 08:51:41 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 4DAEE40291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:51:40 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 2A10B4D359; Fri, 16 Oct 2026 08:51:40 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 2060] RCU ackec_token wrong value
Date: Fri, 16 Oct 2026 06:51:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: kipi@servers.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-2060-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2060

            Bug ID: 2060
           Summary: RCU ackec_token wrong value
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: kipi@servers.com
  Target Milestone: ---

Created attachment 408
  --> https://bugs.dpdk.org/attachment.cgi?id=3D408&action=3Dedit
a minimal example demonstrating the problem

__rte_rcu_qsbr_check_all() and __rte_rcu_qsbr_check_selective() compute
acked_token as the minimum of the counters of the threads that were online =
when
read, and store it into v->acked_token. rte_rcu_qsbr_check(v, t) then retur=
ns 1
without walking whenever t <=3D v->acked_token. But a walk for token t only
proves that grace periods up to t are over. The minimum of the counters it =
has
seen can be larger than t, and for the tokens in between the proof does not
hold: a thread read as __RTE_QSBR_CNT_THR_OFFLINE may have come online duri=
ng
the walk, at a token below those, holding a pointer that a later period
unpublished. A second writer whose token falls into that range then frees t=
he
pointer from the cached fast path while the first reader still uses it.

Interleaving (two writers A and B, reader R toggling offline/online, reader=
 Q
reporting steadily, current token 5)

A calls rte_rcu_qsbr_check(v, 5). The walk reads R's counter: OFFLINE, skip=
ped.
R calls rte_rcu_qsbr_thread_online() (counter =3D 5) and loads head, gettin=
g Y.
B unpublishes Y (head =3D Z) and calls rte_rcu_qsbr_start(), which returns =
6.
Q calls rte_rcu_qsbr_quiescent(), its counter becomes 6.
A's walk reads Q's counter: 6 >=3D 5, fine. The walk ends, acked_token =3D =
min =3D 6,
stored into v->acked_token.
B calls rte_rcu_qsbr_check(v, 6): 6 <=3D v->acked_token, returns 1 without a
walk. B frees Y.
R is online with counter 5 and still dereferences Y.
Step 1 is correct for token 5: Y was unpublished after A's
rte_rcu_qsbr_start(), so the proof for 5 is not affected. Step 5 is the def=
ect:
the walk never saw R online, yet the cache now claims period 6 is over. Any
user with two writers (for example two rte_rcu_qsbr_dq instances) and reade=
rs
that use rte_rcu_qsbr_thread_offline()/_online() is exposed.

Reproduction

A single-file C program with direct rte_rcu_qsbr_* calls, no EAL, is attach=
ed
(dpdk-qsbr-repro.c). It registers 512 threads with the toggling reader at i=
d 0,
the steady reporter at id 511 and every id between them registered and offl=
ine,
so that a walk takes about a microsecond. Two writers swap the head, call
rte_rcu_qsbr_start(), spin on rte_rcu_qsbr_check(t, false) and poison the o=
ld
node instead of freeing it. The reader counts poisoned reads.


$ ./dpdk-qsbr-repro
cached: reads 203668, violations 136
$ ./dpdk-qsbr-repro --no-cache     # writers call __rte_rcu_qsbr_check_all()
directly
no cache: reads 200204, violations 0
Three runs each: 136 / 32 / 136 violations with the fast path, 0 / 0 / 0
without it. Each run takes about 0.3 s on a 22-thread desktop CPU.

Suggested fix

Store the checked token, not the minimum of the counters. Every counter that
passed the walk is >=3D t, so t is exactly what the walk proves, and the "n=
obody
online" and "only move forward" conditions can stay as they are:

        /* All readers are checked: every counter seen is >=3D t, and the w=
alk
         * proves nothing beyond t, a thread read as offline may be online =
by
         * now at a lower token. Cache t, not the minimum of the counters.
         */
        if (acked_token !=3D __RTE_QSBR_CNT_MAX)
                rte_atomic_store_explicit(&v->acked_token, t,
                        rte_memory_order_relaxed);

with the acked_token > c updates in the loops reduced to a flag that some
thread was online. The cost is more walks when tokens are checked out of or=
der,
the semantics of rte_rcu_qsbr_check() do not change.

A related, smaller issue: v->acked_token is stored and loaded with
rte_memory_order_relaxed. A writer that takes the fast path therefore has no
happens-before relation with the readers' critical sections that the other
writer's walk observed with acquire loads. On x86 this is harmless, on weak=
ly
ordered CPUs it is not. Store release / load acquire fixes it at no cost on
x86.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
