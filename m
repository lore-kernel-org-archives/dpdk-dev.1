Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BA5CCD183
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Oct 2025 08:07:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 547B9402C2;
	Sat, 11 Oct 2025 10:07:09 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id ED2F64021F
 for <dev@dpdk.org>; Sat, 11 Oct 2025 10:07:07 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id DA6014890C; Sat, 11 Oct 2025 10:07:07 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: =?UTF-8?B?W0RQREsvZXRoZGV2IEJ1ZyAxODAxXSBpeGdiZSBWRjogYnVmZmVy?=
 =?UTF-8?B?IG92ZXJydW4gcmlzayBpbiBpeGdiZXZmX2dldF9wZl9saW5rX3N0YXRlKCkg?=
 =?UTF-8?B?4oCUIG1zZ2J1ZiBzaXplZCAzIGR3b3JkcyBidXQgc2l6ZSBwYXNzZWQgYXMg?=
 =?UTF-8?B?Ng==?=
Date: Sat, 11 Oct 2025 08:07:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fenghua.lyn@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1801-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1801

            Bug ID: 1801
           Summary: ixgbe VF: buffer overrun risk in
                    ixgbevf_get_pf_link_state() =E2=80=94 msgbuf sized 3 dw=
ords
                    but size passed as 6
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: fenghua.lyn@gmail.com
  Target Milestone: ---

Component: ixgbe VF mailbox (file: /drivers/net/intel/ixgbe/base/ixgbe_vf.c)

Function: ixgbevf_get_pf_link_state

Issue: The function allocates a 3-DWORD buffer msgbuf[3] but calls the mail=
box
helper with a size of 6:

ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, 6);

In this API, the size argument is the number of DWORDs (u32), not bytes.
Passing 6 causes the mailbox code to read/write beyond the 3-element buffer,
which is a buffer overrun.

Symptoms/Impact:

Potential stack/adjacent memory corruption.

Spurious link speed/state results.

Intermittent crashes or undefined behavior, especially under mailbox activi=
ty.

Root Cause:

Size/count mismatch: the mailbox APIs in this codebase consistently use =E2=
=80=9Cnumber
of u32 words=E2=80=9D as the size unit (e.g., elsewhere we pass 2, 3, 5). T=
his one call
site incorrectly passes 6 while the buffer is only 3 u32.

Fix:

Pass the correct DWORD count for the buffer, i.e., change 6 to 3.

Prefer a future-proof pattern using ARRAY_SIZE(msgbuf) to avoid similar
mistakes.

Corrected code snippet:

err =3D ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, 3);
  // or
  err =3D ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, ARRAY_SIZE(msgbuf)=
);=20
Risk Assessment:

Low risk; this change aligns with the mailbox interface semantics used
throughout the file.

Reduces risk of memory corruption and improves stability when retrieving PF
link state.

How to Reproduce:

Build with stack protection and run a VF that frequently queries PF link st=
ate.

Observe potential stack canary trips or sanitizer complaints around
ixgbevf_get_pf_link_state.

Alternatively, instrument ixgbevf_write_msg_read_ack to assert the size does
not exceed the buffer=E2=80=99s capacity.

Affected Versions:

Any version containing this exact implementation of ixgbevf_get_pf_link_sta=
te
where msgbuf is 3 u32 elements and the call passes size 6.

Additional Notes:

Other call sites in this file consistently use correct sizes (e.g., 2, 3, 5=
).
This appears to be a one-off typo.

Status: I reviewed the provided file content and pinpointed the size/count
mismatch in ixgbevf_get_pf_link_state. If you want, I can submit a minimal
patch changing 6 to 3 or to ARRAY_SIZE(msgbuf).

Proposed change in ixgbevf_get_pf_link_state:

Replace ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, 6); with
ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, 3);

Impact:

Prevents out-of-bounds mailbox read/write on the VF stack buffer.

Aligns with mailbox usage elsewhere, improving correctness and stability.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
