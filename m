Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C0CA6017
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 22:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC4054021F;
	Fri,  9 Oct 2026 00:15:02 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8670540144
 for <dev@dpdk.org>; Fri,  9 Oct 2026 00:15:01 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 194244BCC0; Fri,  9 Oct 2026 00:15:00 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2051] BPF inuse counter is not safe when using
 lockfree transmit
Date: Thu, 08 Oct 2026 22:14:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
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
Message-ID: <bug-2051-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2051

            Bug ID: 2051
           Summary: BPF inuse counter is not safe when using lockfree
                    transmit
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

The BPF ethdev callbacks (lib/bpf/bpf_pkt.c) guard cbi->bpf and cbi->jit
with a seqcount: bpf_eth_cbi_inuse() makes cbi->use odd,
bpf_eth_cbi_unuse() makes it even, and bpf_eth_cbi_wait() treats even as
"no thread is inside the callback". This is only valid with one thread
at a time in the callback for a given port/queue.

With RTE_ETH_TX_OFFLOAD_MT_LOCKFREE, multiple threads may call
rte_eth_tx_burst() on the same queue concurrently, so the tx callbacks
(bpf_tx_callback_vm/jit/mb_vm/mb_jit) run concurrently on the same cbi.

1. Parity. Two threads pass bpf_eth_cbi_inuse() and see cb !=3D NULL; the
   count is even. rte_bpf_eth_tx_unload() clears cb, bpf_eth_cbi_wait()
   samples an even count and returns, and rte_bpf_destroy() frees the
   program and JIT code while both threads are executing it.
   Use after free.

2. Lost update. In the default build (enable_stdatomic=3Dfalse) cbi->use++
   is a non-atomic read-modify-write. Concurrent increments can lose
   one, which inverts the parity permanently. An idle queue then reads
   odd, so bpf_eth_cbi_wait() spins until the next burst (forever if
   there is none), and afterwards even means in use, which leads back
   to case 1 with a single thread.

Rx is not affected; rx burst on a queue is never MT safe.

Nothing in rte_bpf_eth_tx_install() or rte_bpf_eth_tx_elf_load() checks
for the offload, and the restriction is not documented.

lib/pdump has the same pattern (pdump_cb_hold/pdump_cb_release/
pdump_cb_wait on use_count, used by pdump_tx) and the same problem.

Found by inspection while reviewing the conversion of rte_smp_mb() to
C11 fences. Not reproduced.

Possible fixes:
 - Fail tx install with -ENOTSUP when MT_LOCKFREE is enabled on the
   port or queue, and document it.
 - Replace the seqcount with a real reference count (atomic add/sub,
   wait for zero, keep the cb check). Costs two locked operations per
   burst.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
