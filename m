Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34A3C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:13:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 107EE40291;
	Fri, 28 Aug 2026 15:13:44 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id DAB7240151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:13:42 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D12524CFFA; Fri, 28 Aug 2026 15:13:42 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 2004] vhost log mapping double offset
Date: Fri, 28 Aug 2026 13:13:42 +0000
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
Message-ID: <bug-2004-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2004

            Bug ID: 2004
           Summary: vhost log mapping double offset
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

Report date: 2026-04-29
Reported by: Don Salvatore Nero <hemo40047@gmail.com>

Dear Thomas, Maxime, and the DPDK Security Team,

1. Executive Summary

An out-of-bounds write vulnerability has been identified in the DPDK vhost
library, specifically within the vhost_user_set_log_base() function in
lib/vhost/vhost_user.c. The vulnerability arises from a double-application
of the guest-controlled mmap_offset value: once as a file offset in the
mmap() system call, and a second time as an arithmetic addition to the
resulting virtual address when computing log_base. This causes log_base to
point beyond the boundaries of the mapped memory region, enabling a
malicious guest virtual machine to trigger out-of-bounds memory writes on
the host.

This report also demonstrates that the fix applied for CVE-2020-10722 was
incomplete. The root cause of the offset double-application pattern was not
fully remediated, and the vulnerable logic remains present in the stable
25.11.0 release.

2. Affected Component

FieldDetailsFilelib/vhost/vhost_user.cFunctionvhost_user_set_log_base()Prim=
ary
Lines2401, 2416=E2=80=932418, 2419Secondary Filelib/vhost/vhost.cSecondary
Functions__vhost_log_write(), __vhost_log_cache_sync()Secondary
Lines141=E2=80=93159, 197=E2=80=93204DPDK Version25.11.0 Stable

3. Background and Relationship to CVE-2020-10722

CVE-2020-10722 was a buffer overflow vulnerability in DPDK's vhost library
related to improper handling of guest-supplied values. The official fix
addressed specific integer overflow and boundary check issues. However, the
fix was incomplete:

It prevented arithmetic overflow of off + size via the guard at line 2386.

It did not correct the fundamental logical error of applying mmap_offset
twice =E2=80=94 once as an mmap() file offset and again as pointer arithmet=
ic on
the returned address.

It did not align vhost_user_set_log_base() with the correct pattern already
established in vhost_user_mmap_region().

The memory corruption primitive described in this report therefore remains
present and reachable in DPDK 25.11.0.

4. Vulnerability Description

4.1 Root Cause

The function vhost_user_set_log_base() processes a VHOST_USER_SET_LOG_BASE
message from a guest VM. The message payload contains two
attacker-controlled values:

mmap_size =E2=80=94 size of the log memory region.

mmap_offset =E2=80=94 offset into the shared log file.

The function maps the log file into host memory using mmap(), passing
mmap_offset as the file offset. It then adds mmap_offset a second time to
the returned virtual address when storing log_base. This positions log_base
exactly off bytes past the start of the mapped region, while the mapped
region only covers size bytes starting at addr. Any indexed write beyond
size - off bytes from log_base is therefore an out-of-bounds write.

4.2 Vulnerability Path =E2=80=94 Step by Step

Step 1 =E2=80=94 Guest sends VHOST_USER_SET_LOG_BASE (lines 2382=E2=80=9323=
83):

size =3D ctx->msg.payload.log.mmap_size; // attacker-controlled off =3D
ctx->msg.payload.log.mmap_offset; // attacker-controlled

Step 2 =E2=80=94 mmap() with off as file offset (line 2401):

addr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, off);

This maps exactly size bytes from file position off. Valid host virtual
address range: [addr, addr + size).

Step 3 =E2=80=94 off added a second time to compute log_base (lines 2416=E2=
=80=932418):

dev->log_addr =3D (uint64_t)(uintptr_t)addr; dev->log_base =3D dev->log_add=
r +
off; // BUG: addr + off exceeds the mapped region dev->log_size =3D size;

log_base now points to addr + off. The mapped region ends at addr + size.
If off > 0, only max(0, size - off) bytes of valid mapped memory exist
ahead of log_base.

Step 4 =E2=80=94 Out-of-bounds write during dirty page logging (lib/vhost/v=
host.c,
lines 141=E2=80=93159):

void __vhost_log_write(struct virtio_net *dev, uint64_t addr, uint64_t len)
{ // bounds check uses log_size (=3D size), does NOT account for the offset
if (unlikely(dev->log_size <=3D ((addr + len - 1) / VHOST_LOG_PAGE / 8)))
return; page =3D addr / VHOST_LOG_PAGE; while (page * VHOST_LOG_PAGE < addr=
 +
len) { // writes to log_base[page/8] =3D (addr + off) + page/8
vhost_log_page((uint8_t *)(uintptr_t)dev->log_base, page); page +=3D 1; } }

The bounds check validates page/8 < size but the actual write occurs at
log_base + page/8 =3D addr + off + page/8. The maximum offset from the start
of the mapping reached by this write is off + size - 1, while the mapping
only covers size bytes. Writes exceed the mapped region by up to off bytes.

The same vulnerable pattern exists in __vhost_log_cache_sync() at lines
197=E2=80=93204.

Step 5 =E2=80=94 Additional out-of-bounds madvise() call (line 2419):

mem_set_dump(dev, addr, size + off, false, alignment);

This calls madvise() on addr for size + off bytes, but only size bytes are
mapped.

4.3 The Correct Pattern =E2=80=94 Comparative Evidence

In vhost_user_mmap_region() (lines 1306, 1336, 1346), the same underlying
operation is implemented correctly:

mmap_size =3D region->size + mmap_offset; mmap_addr =3D mmap(NULL, mmap_siz=
e,
..., region->fd, 0); // file offset =3D 0 region->host_user_addr =3D
(uint64_t)(uintptr_t)mmap_addr + mmap_offset; // safe: within bounds

Here the total mapping covers size + offset bytes with file offset 0, so
adding mmap_offset to the returned address safely falls within the mapped
region. The vhost_user_set_log_base() function should follow this same
pattern.

Additionally, the comment at line 2397 states "mmap from 0 to workaround a
hugepage mmap bug", yet the code passes off as the file offset rather than
0. This discrepancy indicates the developer intended to replicate the
correct pattern but introduced a logical error.

5. Why Existing Checks Are Insufficient

CheckLocationWhat It PreventsWhat It Missesif (off >=3D -size)Line
2386Integer overflow of off + sizeDoes not fix the double-application of
offBounds check on log_sizevhost.c line 149Ensures page/8 < sizeDoes not
account for log_base being off bytes past mapping start

6. Exploitation Conditions

All conditions required to reach the vulnerable code path are satisfied by
default DPDK configurations:

ConditionEvidenceVHOST_F_LOG_ALL enabledDefault in
VHOST_USER_NET_SUPPORTED_FEATURES (vhost_user.h, line
20)VHOST_USER_PROTOCOL_F_LOG_SHMFD enabledDefault in
VHOST_USER_PROTOCOL_FEATURES (vhost_user.h, line 26)Attacker controls
mmap_offsetVia VHOST_USER_SET_LOG_BASE message in the vhost-user
protocolWrite triggerAny virtio ring activity (packet send/receive)
activates vhost_log_write()

7. Impact

Memory Corruption: The write primitive performs a bitwise OR operation on
memory at a controlled offset beyond the mapped region boundary. Depending
on memory layout, this can corrupt adjacent mmap() regions, heap
allocations, or internal DPDK data structures.

Attacker Control: The attacker controls the offset (off), the mapping size
(size), and which bits are written via control over guest physical memory
addresses used by virtio rings.

Potential Code Execution: If memory adjacent to the overwrite region
contains function pointers such as notify_ops, backend_ops, or extern_ops
within the vhost device structure, bit manipulation via OR operations may
redirect execution flow.

Attack Vector: The attack originates entirely from within a guest VM and
requires no host-level privileges.

8. Proof of Concept

Due to restrictions in my working environment (Ubuntu 22.04 VPS), I was
unable to build or execute a proof-of-concept for this vulnerability. The
environment does not permit establishing the vhost-user socket
infrastructure and guest-host shared memory configuration required to
exercise the full exploitation path.

9. Proposed Fix

Align vhost_user_set_log_base() with the correct pattern from
vhost_user_mmap_region():

// BEFORE (vulnerable): addr =3D mmap(0, size, PROT_READ | PROT_WRITE,
MAP_SHARED, fd, off); dev->log_base =3D dev->log_addr + off;
mem_set_dump(dev, addr, size + off, false, alignment); // AFTER
(corrected): addr =3D mmap(0, size + off, PROT_READ | PROT_WRITE, MAP_SHARE=
D,
fd, 0); dev->log_base =3D dev->log_addr + off; // now safe: within mapped
region mem_set_dump(dev, addr, size + off, false, alignment);

Additionally, dev->log_size should reflect only the writable log region
(size, not size + off), and the bounds check in __vhost_log_write() should
be reviewed to account for the offset between log_addr and log_base.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
