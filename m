Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A2CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:10:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A72E40272;
	Wed, 14 Oct 2026 00:10:34 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C941F40269
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:10:32 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B46124D43F; Wed, 14 Oct 2026 00:10:32 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/cryptodev Bug 2056] Unsafe RCU usage in cryptodev
Date: Tue, 13 Oct 2026 22:10:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: cryptodev
X-Bugzilla-Version: 26.11
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
Message-ID: <bug-2056-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2056

            Bug ID: 2056
           Summary: Unsafe RCU usage in cryptodev
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: cryptodev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Summary: cryptodev: callback removal does not wait for readers, RCU reader =
is
never registered

Component: cryptodev
Version: main (d129414711aa, 2026-09-24); the code dates from the
introduction of enqueue/dequeue callbacks, so all releases since are affect=
ed
Severity: normal
Found by: code reading, not reproduced

Description

rte_cryptodev_remove_enq_callback() and rte_cryptodev_remove_deq_callback()
unlink the callback, call rte_rcu_qsbr_synchronize(list->qsbr,
RTE_QSBR_THRID_INVALID) and then rte_free(cb). The synchronize is meant to
wait until no data path thread is still inside the callback chain, but it
returns immediately.

cryptodev_cb_init() creates one rte_rcu_qsbr variable per queue pair and
direction with max_threads =3D 1. The data path brackets the callback walk =
in
rte_cryptodev_enqueue_burst() and rte_cryptodev_dequeue_burst() with
rte_rcu_qsbr_thread_online(qsbr, 0) and rte_rcu_qsbr_thread_offline(qsbr, 0=
).
Nothing ever calls rte_rcu_qsbr_thread_register(qsbr, 0): not lib/cryptodev,
not drivers/crypto, not app/test or examples.

rte_rcu_qsbr_check() takes the __rte_rcu_qsbr_check_all() path only when
num_threads =3D=3D max_threads. Here num_threads is 0, so it takes
__rte_rcu_qsbr_check_selective(), which iterates the registered-thread bitm=
ap,
finds no bits set and returns 1 without looking at any reader counter.

Result: remove frees the callback while a data path thread can still be
executing it or reading cb->next from it. The online/offline calls on the
data path cost a full barrier per burst and protect nothing.

Expected behaviour

Remove returns only after any in-progress enqueue or dequeue burst on that
queue pair has left the callback chain.

Fix

Register the one reader slot when the variable is created, in
cryptodev_cb_init(), after rte_rcu_qsbr_init():

        rte_rcu_qsbr_thread_register(qsbr, 0);

for both the enq and deq variables. With one registered thread the check
takes the check_all path and waits on the counter the data path updates.

Reproduce

Not done. Suggested: one lcore looping rte_cryptodev_enqueue_burst() on a
queue pair with a callback that spins for a few microseconds, and a control
thread looping add/remove of that callback. Build with ASan; a read of the
freed cb in the burst loop should be reported within seconds.

Related, same code

- Once the wait is real, rte_cryptodev_callback_lock, a global spinlock, is
  held across the synchronize in both remove functions, so add and remove on
  every device stall behind one removal.
- rte_cryptodev_remove_deq_callback() tests dev->enq_cbs =3D=3D NULL where =
it
  means deq_cbs. Harmless, both are allocated together.
- rte_cryptodev_close() does not call cryptodev_cb_cleanup(); the lists, qs=
br
  variables and callbacks stay allocated until the next configure.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
