Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E382DCFD376
	for <dpdk-dev@archiver.kernel.org>; Sun, 30 Nov 2025 18:27:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D48774029A;
	Sun, 30 Nov 2025 19:27:16 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C50A640275
 for <dev@dpdk.org>; Sun, 30 Nov 2025 19:26:59 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9E62948BEF; Sun, 30 Nov 2025 19:26:59 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1844] BPF elf test failing on RHEL8
Date: Sun, 30 Nov 2025 18:26:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.07
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
Message-ID: <bug-1844-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1844

            Bug ID: 1844
           Summary: BPF elf test failing on RHEL8
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Testing 25.11 with RHEL 8.8 VM.

EAL: Detected CPU lcores: 4
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
VIRTIO_INIT: eth_virtio_pci_init(): Failed to init PCI device
PCI_BUS: Requested device 0000:01:00.0 cannot be used
APP: HPET is not enabled, using TSC as default timer
BPF: bpf_exec(0x7ff5b6355000): division by 0 at pc: 0x68;
---------------------------------------------------------------------------=
---

10/86 DPDK:fast-tests / bpf_elf_autotest            FAIL            0.12s=
=20=20
(exit status 255 or signal 127 SIGinvalid)
18:21:23 MALLOC_PERTURB_=3D40 DPDK_TEST=3Dbpf_elf_autotest
/home/shemminger/DPDK/main/build/app/dpdk-test --no-huge -m 2048
----------------------------------- output --------------------------------=
---
stdout:
RTE>>bpf_elf_autotest^M
test_bpf_elf_load: ELF load test passed
test_bpf_elf_tx_load start
bpf_tx_test@3541: failed to load BPF filter from file=3D/tmp/dpdk_bpf_tx_gl=
71ik.o
error=3D22:(Invalid argument)
Test Failed

--=20
You are receiving this mail because:
You are the assignee for the bug.=
