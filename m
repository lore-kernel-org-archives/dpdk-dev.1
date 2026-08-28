Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE01C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:09:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D50284060B;
	Fri, 28 Aug 2026 15:09:34 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5F83E4067C
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:09:34 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 492284CFA4; Fri, 28 Aug 2026 15:09:34 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 2003] vhost double-fetch leading to overflow
 in virtio_net_ctrl_pop
Date: Fri, 28 Aug 2026 13:09:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: thomas@monjalon.net
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone bug_group
Message-ID: <bug-2003-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2003

            Bug ID: 2003
           Summary: vhost double-fetch leading to overflow in
                    virtio_net_ctrl_pop
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: vhost/virtio
          Assignee: dev@dpdk.org
          Reporter: thomas@monjalon.net
  Target Milestone: ---
             Group: security

Report date: 2026-04-24
Reported by: Don Salvatore Nero <hemo40047@gmail.com>

Dear Thomas, Maxime, and the DPDK Security Team,

1. Executive Summary

A double-fetch vulnerability exists in virtio_net_ctrl_pop() in the DPDK
vhost library. The function reads descs[desc_idx].len twice from
guest-controlled shared memory =E2=80=94 once to calculate allocation size
(data_len), and once during the actual memcpy() loop =E2=80=94 with a mallo=
c() call
in between. A malicious guest can modify the descriptor length between the
two reads, causing memcpy() to write far beyond the allocated buffer,
resulting in a heap buffer overflow with attacker-controlled length and
content.


2. Vulnerability Analysis

Step 1 =E2=80=94 Guest-controlled shared memory

From vhost.c lines 482-488 (confirmed from real code):

vq->desc =3D (struct vring_desc *)(uintptr_t)vhost_iova_to_vva(dev, vq,
vq->ring_addrs.desc_user_addr, // =E2=86=90 address provided by guest &size,
VHOST_ACCESS_RO);

vq->desc is a direct pointer into guest-mapped shared memory. The guest
owns and can modify this memory at any time.

When VRING_DESC_F_INDIRECT is set, the indirect table also comes from guest
memory:

descs =3D (struct vring_desc *)(uintptr_t)vhost_iova_to_vva(dev, cvq,
desc_iova, &desc_len, VHOST_ACCESS_RO);

No local copy is made of the descriptor table. descs points directly to
guest memory throughout the entire function.

Step 2 =E2=80=94 Phase 2: First read of len to compute data_len

From virtio_net_ctrl.c lines 70-105 (confirmed from real code):

while (1) { desc_len =3D descs[desc_idx].len; // =E2=86=90 READ #1 from gue=
st memory
desc_iova =3D descs[desc_idx].addr; n_descs++; if (descs[desc_idx].flags &
VRING_DESC_F_WRITE) { // handle ack descriptor ... } else { if
(ctrl_elem->desc_ack) { goto err; } data_len +=3D desc_len; // =E2=86=90 ac=
cumulate
size using READ #1 } if (!(descs[desc_idx].flags & VRING_DESC_F_NEXT))
break; desc_idx =3D descs[desc_idx].next; }

At this point, data_len =3D sum of all readable descriptor lengths from READ
#1.

Step 3 =E2=80=94 malloc() using READ #1 value

From virtio_net_ctrl.c line 124 (confirmed from real code):

ctrl_elem->ctrl_req =3D malloc(data_len); // =E2=86=90 allocated based on R=
EAD #1 if
(!ctrl_elem->ctrl_req) { goto err; } ctrl_req =3D (uint8_t
*)ctrl_elem->ctrl_req;

The buffer is allocated with the size computed from READ #1.

malloc() is an external function call with side effects =E2=80=94 the compi=
ler
cannot cache descs[].len across this call. It must re-read from memory in
Phase 3.

Step 4 =E2=80=94 Phase 3: Second read of len with NO bounds check

From virtio_net_ctrl.c lines 144-168 (confirmed from real code):

while (!(descs[desc_idx].flags & VRING_DESC_F_WRITE)) { desc_len =3D
descs[desc_idx].len; // =E2=86=90 READ #2 from guest memory desc_iova =3D
descs[desc_idx].addr; desc_addr =3D vhost_iova_to_vva(dev, cvq, desc_iova,
&desc_len, VHOST_ACCESS_RO); if (!desc_addr || desc_len <
descs[desc_idx].len) { goto free_err; } memcpy(ctrl_req, (void
*)(uintptr_t)desc_addr, desc_len); // =E2=86=91 copies desc_len bytes =E2=
=80=94 from READ
#2, not READ #1 // NO check: copied_so_far + desc_len <=3D data_len ctrl_req
+=3D desc_len; // =E2=86=91 advances pointer by READ #2 value =E2=80=94 no =
upper bound if
(!(descs[desc_idx].flags & VRING_DESC_F_NEXT)) break; desc_idx =3D
descs[desc_idx].next; }

There is NO check of total bytes copied against data_len.

The only check present is:

if (!desc_addr || desc_len < descs[desc_idx].len)

This only verifies that the IOVA translation succeeded =E2=80=94 it does NO=
T check
that the copy stays within the allocated buffer.

Step 5 =E2=80=94 The Race Window

[Thread: DPDK host] [Thread: Malicious Guest] Phase 2: READ #1:
descs[0].len =3D 4 data_len =3D 4 malloc(4) =E2=86=90 buffer of 4 bytes all=
ocated
WRITE: descs[0].len =3D 65535 Phase 3: READ #2: descs[0].len =3D 65535
memcpy(ctrl_req, src, 65535) =E2=86=90 writes 65535 into 4-byte buffer ctrl=
_req +=3D
65535 =E2=86=90 pointer far past end of buffer

The race window is the time between data_len +=3D desc_len (Phase 2) and
memcpy(..., desc_len) (Phase 3), which is widened by the malloc() call
between them.

4. Why the Existing Locks Do NOT Prevent This

From virtio_net_ctrl_handle():

rte_rwlock_read_lock(&dev->cvq->access_lock);
vhost_user_iotlb_rd_lock(dev->cvq);

These locks are intra-process locks =E2=80=94 they only prevent concurrent =
access
between host threads. They provide zero protection against the guest
modifying the shared memory pages, because:

The guest runs in a separate address space (VM or VDUSE consumer process)

The shared memory is mapped via mmap(MAP_SHARED) =E2=80=94 the guest has di=
rect
write access

No lock can prevent the guest from writing to its own memory

5. Exploit Scenario

Prerequisites:

DPDK vhost enabled with VDUSE backend (rte_vduse_device_create())

VIRTIO_NET_F_CTRL_VQ enabled (default in VIRTIO_NET_SUPPORTED_FEATURES)

Guest has standard virtio-net driver

Steps:

1. Guest sets up descriptor chain with small len:

desc[0]: addr=3DX, len=3D4, flags=3DNEXT, next=3D1 desc[1]: addr=3DY, len=
=3D1,
flags=3DWRITE (ack descriptor)

2. Host enters Phase 2:

Reads desc[0].len =3D 4 =E2=86=92 data_len =3D 4

Calls malloc(4) =E2=86=92 allocates 4-byte buffer

3. Guest immediately overwrites desc[0].len:

desc[0].len =3D 0x10000; // 65536 bytes

4. Host enters Phase 3:

Reads desc[0].len =3D 65536

vhost_iova_to_vva() succeeds (guest controls the memory mapping)

memcpy(ctrl_req, src, 65536) =E2=80=94 writes 65536 bytes into 4-byte heap =
buffer

Heap corruption with attacker-controlled length and content

Impact of Heap Overflow:

Since the DPDK process typically runs with elevated privileges (direct NIC
access, hugepages, DMA), a successful heap overflow leads to:

ImpactDescriptionRCE in host processControl heap layout =E2=86=92 overwrite
function pointers or vtablesHost escapeDPDK process has privileged access =
=E2=80=94
compromise extends to host OSMemory corruptionCorrupt adjacent heap objects
affecting other guest connectionsPrivilege escalationDPDK process
capabilities grant access to hardware resources

6. Code Proof Summary

LocationCodeSignificancevhost.c:482vq->desc =3D vhost_iova_to_vva(...)descs
points to guest shared memoryvirtio_net_ctrl.c:~75desc_len =3D
descs[desc_idx].lenREAD #1 from guest memoryvirtio_net_ctrl.c:~80data_len
+=3D desc_lenAllocation size from READ
#1virtio_net_ctrl.c:~124malloc(data_len)Buffer allocated from READ
#1virtio_net_ctrl.c:~148desc_len =3D descs[desc_idx].lenREAD #2 from guest
memoryvirtio_net_ctrl.c:~154memcpy(ctrl_req, ..., desc_len)Copy using READ
#2 =E2=80=94 no bounds checkvirtio_net_ctrl.c:~156ctrl_req +=3D desc_lenPoi=
nter
advance =E2=80=94 no upper bound

7. Note on Proof of Concept

I was unable to produce a live PoC due to environment constraints =E2=80=94=
 my
analysis VPS (Ubuntu 22.04) encountered build issues when attempting to
configure a VDUSE server environment for live exploitation testing.
However, the vulnerability is demonstrated entirely through source code
analysis:

The double-fetch pattern is unambiguous in the code

The absence of a cumulative bounds check in Phase 3 is confirmed

The guest-controlled nature of descs[] memory is confirmed via
vhost_iova_to_vva() chain

The race window is real and is widened by the malloc() call between phases

8. Recommended Fix

Option 1 =E2=80=94 Copy descriptors locally before processing:

// Make a local copy of the entire descriptor chain ONCE struct vring_desc
local_descs[VIRTIO_MAX_INDIRECT_DESCS]; memcpy(local_descs, descs, n_descs
* sizeof(struct vring_desc)); // Use local_descs in BOTH Phase 2 and Phase
3

Option 2 =E2=80=94 Add cumulative bounds check in Phase 3:

uint64_t copied =3D 0; while (!(descs[desc_idx].flags & VRING_DESC_F_WRITE))
{ desc_len =3D descs[desc_idx].len; // ADD THIS CHECK: if (copied + desc_len
> data_len) { VHOST_CONFIG_LOG(dev->ifname, ERR, "Descriptor overflow
detected"); goto free_err; } desc_addr =3D vhost_iova_to_vva(...);
memcpy(ctrl_req, desc_addr, desc_len); ctrl_req +=3D desc_len; copied +=3D
desc_len; // track total ... }

Option 3 =E2=80=94 Use atomic reads:

// Read len once atomically and reuse uint32_t cached_len =3D
__atomic_load_n(&descs[desc_idx].len, __ATOMIC_ACQUIRE);

--=20
You are receiving this mail because:
You are the assignee for the bug.=
