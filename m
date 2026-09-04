Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484FFC79F82
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 19:14:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CAC9427E6;
	Fri,  4 Sep 2026 21:14:04 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 4B2B7427D1
 for <dev@dpdk.org>; Fri,  4 Sep 2026 21:14:03 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 2E4C34C7A1; Fri,  4 Sep 2026 21:14:03 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2031] cn10k: NPA_POOL_ERR_INT_RANGE on Pool 1
 during mbuf pool creation in testpmd
Date: Fri, 04 Sep 2026 19:14:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: amiyaranjan.mohakud@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone attachments.created
Message-ID: <bug-2031-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2031

            Bug ID: 2031
           Summary: cn10k: NPA_POOL_ERR_INT_RANGE on Pool 1 during mbuf
                    pool creation in testpmd
           Product: DPDK
           Version: 24.11
          Hardware: ARM
                OS: Linux
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: amiyaranjan.mohakud@gmail.com
  Target Milestone: ---

Created attachment 390
  --> https://bugs.dpdk.org/attachment.cgi?id=3D390&action=3Dedit
testpmd-cn10k-mempool-issue.txt

Environment:
------------

  - SoC: Marvell Octeon CN10K (cn10kb_a0)
  - Kernel: 6.12.68
  - DPDK: 24.11.2
  - IOVA mode: PA
  - VFIO: no-iommu mode
  - Hugepages: 1024 x 2MB (2048 MB total)
  - Mempool ops: cn10k_mempool_ops

Description:
--------------
testpmd creates mbuf pool mb_pool_0 (n=3D203456, size=3D2304) using
cn10k_mempool_ops. During pool populate, Pool 1 triggers NPA_POOL_ERR_INT_R=
ANGE
repeatedly, followed by Err_intr=3D0x1000:

  testpmd: create a new mbuf pool <mb_pool_0>: n=3D203456, size=3D2304, soc=
ket=3D0
  testpmd: preferred mempool ops selected: cn10k_mempool_ops

  CNXK: npa_q_irq():150 queue_intr=3D0x1 qintx=3D1
  CNXK: npa_q_irq():165 Pool=3D1 NPA_POOL_ERR_INT_RANGE
    (repeats 4 times during mbuf pool populate)

  Configuring Port 0 (socket 0)
  CNXK: npa_err_irq():18 Err_intr=3D0x1000
  CNXK: npa_err_irq():18 Err_intr=3D0x1000

  Pool 1 context at time of error:
  ptr_start:    0x24808d200
  ptr_end:      0x267200000
  buf_size:     20 (units of 128 bytes =3D 2560 bytes)
  buf_offset:   1
  count:        decreasing across dumps (0x31aa6 =E2=86=92 0x31a91 =E2=86=
=92 0x31a79 =E2=86=92 0)
  op_pc:        increasing (0x1a =E2=86=92 0x2f =E2=86=92 0x47 =E2=86=92 0x=
31ac0)
  stack_pages:  0 (remains zero across all dumps)

Notable observations:
----------------------
  - stack_pages remains 0 throughout, even as op_pc increases =E2=80=94 sug=
gesting
buffers are being freed but the stack is not being updated
  - count decreases to 0 by the final dump, indicating the pool is fully
drained
  - The address range [0x24808d200, 0x267200000) spans ~512 MB, but the mem=
pool
requests ~203K buffers of 2304 bytes (~447 MB)


Expected Result
-------------------
No NPA pool range errors. Pool 1 should initialize and populate without
triggering NPA_POOL_ERR_INT_RANGE or npa_err_irq interrupts.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
