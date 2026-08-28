Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88989C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 10:36:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A0B040151;
	Fri, 28 Aug 2026 12:36:06 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 5283840150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 12:36:05 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4A0F04C987; Fri, 28 Aug 2026 12:36:05 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 2001] vhost-crypto TOCTOU out-of-bounds write
Date: Fri, 28 Aug 2026 10:36:05 +0000
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
Message-ID: <bug-2001-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2001

            Bug ID: 2001
           Summary: vhost-crypto TOCTOU out-of-bounds write
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

Report date: 2026-03-11
Reported by: Adiel Sol <adiel@dreamgroup.com>

Hi DPDK Security Team,
I would like to report a security vulnerability in DPDK vhost-crypto.
Summary
The vhost-crypto code has a time-of-check to time-of-use (TOCTOU) bug in the
path that finalizes a crypto request. When the host finishes a request, it
writes the result into the virtio used ring. The descriptor index for that
write is read again from the guest-writable available ring at finalization
time, and the code does not check that this index is within the virtqueue s=
ize.
Between the initial fetch and finalization, a malicious guest can change th=
at
value in shared memory. The host then uses the guest-controlled value as an
index and writes to vq->used->ring[desc_idx], causing an out-of-bounds write
(up to about 524 KB past the used ring when the index is 0xFFFF). The used =
ring
has only 256 entries. A malicious guest with a vhost-crypto device can trig=
ger
this to corrupt host DPDK process memory. In practice this can lead to host
crash or arbitrary code execution on the host (guest escape). Because the D=
PDK
process usually runs as root, a successful exploit can mean full control of=
 the
host.
Affected Component

  *   lib/vhost/vhost_crypto.c (finalize path; function
vhost_crypto_finalize_one_request() and the code that re-reads desc_idx from
vq->avail->ring[used_idx] and writes to vq->used->ring[desc_idx] without
validation).
  *   Versions: DPDK 26.03.0-rc1 and earlier versions that include the
vhost-crypto finalize path. Any product that uses DPDK vhost-crypto in the =
same
way may be affected.

Root Cause
At fetch time the host correctly masks used_idx and reads desc_idx from the
available ring. At finalize time the code reads desc_idx again from
vq->avail->ring[used_idx] (guest-writable shared memory) and then writes
vq->used->ring[desc_idx].id and .len with no check that desc_idx < vq->size.
The available ring is writable by the guest at any time. Between fetch and
finalize the host is busy with the crypto operation (enqueue to cryptodev, =
wait
for completion), so the guest has a long race window (microseconds to
milliseconds) to overwrite vq->avail->ring[used_idx] with any 16-bit value
(e.g. 0xFFFF). The host then uses that value as an index. The used ring has
only vq->size entries (e.g. 256), so indexing with 0xFFFF causes a write at
65535 * 8 bytes past the start of the ring, i.e. an out-of-bounds write into
host process memory. The attacker controls the write offset and partially t=
he
written data (the .id value comes from another guest-controlled slot; the .=
len
from the request). So the bug is a TOCTOU with missing input validation
(CWE-367, CWE-787, CWE-20).
Impact

  *   CVSS 3.1: High (e.g. AV:L/AC:L/PR:L/UI:N/S:C/C:H/I:H/A:H or similar;
guest-to-host escape, host RCE in scope).
  *   CWE-787 (Out-of-bounds Write), CWE-367 (TOCTOU Race Condition), CWE-20
(Improper Input Validation).
  *   A malicious guest VM with a vhost-crypto device can trigger the overf=
low
by submitting a valid crypto request and then overwriting the available ring
slot during the crypto operation. No special guest setup is required; the r=
ace
window is the duration of the crypto operation.
  *   Successful exploitation can lead to memory corruption in the host DPDK
process, then to arbitrary code execution on the host (guest escape) and fu=
ll
compromise of the host (backdoors, pivot, etc.), often as root.

Proof of Concept

  1.  We provide two proof-of-concept programs that simulate the vulnerable
pattern (shared virtqueue, host thread, guest thread). They do not run agai=
nst
a full DPDK build but demonstrate the TOCTOU and the resulting out-of-bounds
access and control-flow hijack.
  2.
OOB detection: In the PoC directory, run ./run_poc.sh. The code is built wi=
th
AddressSanitizer. The host thread fetches a request (reads desc_idx =3D 0),=
 then
the guest thread overwrites the available ring slot to 0xFFFF. When the host
thread finalizes, it re-reads desc_idx and writes to used_ring[0xFFFF].
AddressSanitizer reports a SEGV (or heap-buffer-overflow) in the host threa=
d at
the finalize line, proving the out-of-bounds access.
  3.
Control-flow hijack (guest escape / RCE): Run make run-rce in the same
directory. The layout is set so that used_ring[256] (one past the end)
overwrites a function pointer. The guest sets desc_idx =3D 256 and the two =
32-bit
halves of the payload address. When the host calls the completion callback
after finalize, it runs the attacker-supplied function. The program prints
"PWNED: guest escape - host is now running attacker code!" This shows that =
the
same primitive can redirect execution and is sufficient to demonstrate the
guest-escape / RCE impact in concept.
  4.
The PoC sources, build instructions, and a captured ASan run are in the
disclosure package (e.g. poc-dpdk-vhost-crypto-toctou/ with
vhost_crypto_toctou_poc.c, vhost_toctou_rce_poc.c, run_poc.sh,
PROOF-OUTPUT.txt).

Credit Request
We kindly request that the following researchers be credited for this
discovery:
Adiel Sol, Arad Inbar, Erez Cohen, Nir Somech, Ben Grinberg, Daniel Lubel =
=E2=80=93
DREAM Security Research Team

--=20
You are receiving this mail because:
You are the assignee for the bug.=
