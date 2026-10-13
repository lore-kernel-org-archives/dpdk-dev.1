Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D07CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 19:51:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8573440272;
	Tue, 13 Oct 2026 21:51:42 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8E5BD40269
 for <dev@dpdk.org>; Tue, 13 Oct 2026 21:51:41 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6A7F84C7E4; Tue, 13 Oct 2026 21:51:41 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2055] bpf: missing acquire barrier in
 bpf_eth_cbi_wait() allows use-after-free on unload
Date: Tue, 13 Oct 2026 19:51:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: qm2k21@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2055-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2055

            Bug ID: 2055
           Summary: bpf: missing acquire barrier in bpf_eth_cbi_wait()
                    allows use-after-free on unload
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: qm2k21@gmail.com
  Target Milestone: ---

In bpf_pkt.c:103-117, bpf_eth_cbi_unload() synchronizes with datapath threa=
ds
before destroying the BPF program:
```
static void=20=20=20=20=20
bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
{=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
        /* mark this cbi as empty */
        bc->cb =3D NULL;
        rte_smp_mb();

        /* make sure datapath doesn't use bpf anymore, then destroy bpf */
        bpf_eth_cbi_wait(bc);
        rte_bpf_destroy(bc->bpf);
        bpf_eth_cbi_cleanup(bc);=20
}=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
```

The synchronization in bpf_eth_cbi_wait() polls cbi->use:
```
static void
bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
{
        uint32_t puse;

        /* make sure all previous loads and stores are completed */
        rte_smp_mb();

        puse =3D cbi->use;

        /* in use, busy wait till current RX/TX iteration is finished */
        if ((puse & BPF_ETH_CBI_INUSE) !=3D 0) {
                RTE_WAIT_UNTIL_MASKED((__rte_atomic uint32_t
*)(uintptr_t)&cbi->use,
                        UINT32_MAX, !=3D, puse, rte_memory_order_relaxed);
        }
}=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
```

While bpf_eth_cbi_wait() begins with a full barrier (rte_smp_mb()), that
barrier precedes reading cbi->use. Its sole purpose is to ensure the store
bc->cb =3D NULL is visible before reading cbi->use.=20=20=20=20=20
When waiting for an in-flight callback to finish, RTE_WAIT_UNTIL_MASKED pol=
ls
cbi->use with rte_memory_order_relaxed.
When the condition is met and the loop terminates, bpf_eth_cbi_wait() retur=
ns
without any acquire barrier (neither an acquire load nor an acquire/read
fence).
Control plane execution immediately proceeds to rte_bpf_destroy(bc->bpf), w=
hich
frees the memory of the BPF program (rte_free(), munmap()).
On weakly ordered architectures (ARM64, PowerPC, RISC-V), without an acquire
barrier observing the datapath's completion, the CPU can speculatively exec=
ute
or reorder rte_bpf_destroy() ahead of the datapath completing its memory
accesses into the BPF filter code/context. This produces a race condition a=
nd a
use-after-free.

One might assume that because RTE_WAIT_UNTIL_MASKED invokes rte_pause() ins=
ide
its spin loop, it might provide memory ordering. This assumption is incorre=
ct
for several reasons:
* semantics of rte_pause() is not explicitly documented, and on some
architectures it does not provide a sufficient barrier (e.g. on arm32 it is=
 an
empty function);
* semantics of RTE_WAIT_UNTIL_MASKED is documented, and explicitly warns th=
at
"With a relaxed memory ordering model, the loads around this helper can be
reordered";
* last but not least, rte_pause() is only executed between the failed
iterations, but not after the last (successful) one -- even with rte_pause()
forming the memory barrier a small gap for reordering still exists.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
