Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EDACD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 19:52:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12D9C4028F;
	Thu, 18 Jun 2026 21:52:49 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7FAB84028C
 for <dev@dpdk.org>; Thu, 18 Jun 2026 21:52:47 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6257E4B6EC; Thu, 18 Jun 2026 21:52:47 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1959] BPF JIT produces bad code
Date: Thu, 18 Jun 2026 19:52:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 22.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
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
Message-ID: <bug-1959-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1959

            Bug ID: 1959
           Summary: BPF JIT produces bad code
           Product: DPDK
           Version: 22.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

While testing bpf convert code for capture; discovered that the following B=
PF
instructions are JIT'd in a way that causes a SEGV when executed.

bpf convert for "ether[0] & 1 =3D 0 and ip[16] >=3D 224" produced:
cBPF program (8 insns)
(000) ldb      [0]
(001) jset     #0x1             jt 7    jf 2
(002) ldh      [12]
(003) jeq      #0x800           jt 4    jf 7
(004) ldb      [30]
(005) jge      #0xe0            jt 6    jf 7
(006) ret      #262144
(007) ret      #0

eBPF program (14 insns)
 L0:    xor r0, r0
 L1:    xor r7, r7
 L2:    mov r6, r1
 L3:    ldb r0, [0]
 L4:    jset r0, #0x1, L12
 L5:    ldh r0, [12]
 L6:    jne r0, #0x800, L12
 L7:    ldb r0, [30]
 L8:    jge r0, #0xe0, L10
 L9:    ja L12
 L10:   mov32 r0, #0x40000
 L11:   exit
 L12:   mov32 r0, #0x0
 L13:   exit
JIT code at [0x7fb6dbebf000], len=3D340
00000000: 48 83 EC 18 48 89 5C 24 00 4C 89 6C 24 08 48 89 | H...H.\$.L.l$.H.
00000010: 6C 24 10 48 89 E5 48 83 EC 08 48 83 E4 F0 48 31 | l$.H..H...H...H1
00000020: C0 4D 31 ED 48 89 FB 48 31 F6 48 0F B7 53 28 48 | .M1.H..H1.H..S(H
00000030: 29 F2 48 83 FA 01 7C 11 48 0F B7 53 10 48 8B 43 | ).H...|.H..S.H.C
00000040: 00 48 01 D0 48 01 F0 EB 26 48 C7 C2 01 00 00 00 | .H..H...&H......
00000050: 48 89 E9 48 83 E9 08 48 89 DF 48 B8 30 7E C6 A5 | H..H...H..H.0~..
00000060: 01 56 00 00 FF D0 48 85 C0 0F 84 CA 00 00 00 48 | .V....H........H
00000070: 0F B6 40 00 48 F7 C0 01 0F 85 D2 00 00 00 48 C7 | ..@.H.........H.
00000080: C6 0C 00 00 00 48 0F B7 53 28 48 29 F2 48 83 FA | .....H..S(H).H..
00000090: 02 7C 11 48 0F B7 53 10 48 8B 43 00 48 01 D0 48 | .|.H..S.H.C.H..H
000000A0: 01 F0 EB 22 48 C7 C2 02 00 00 00 48 89 E9 48 83 | ..."H......H..H.
000000B0: E9 08 48 89 DF 48 B8 30 7E C6 A5 01 56 00 00 FF | ..H..H.0~...V...
000000C0: D0 48 85 C0 74 73 48 0F B7 40 00 66 C1 C8 08 0F | .H..tsH..@.f....
000000D0: B7 C0 48 81 F8 00 08 00 00 75 75 48 C7 C6 1E 00 | ..H......uuH....
000000E0: 00 00 48 0F B7 53 28 48 29 F2 48 83 FA 01 7C 11 | ..H..S(H).H...|.
000000F0: 48 0F B7 53 10 48 8B 43 00 48 01 D0 48 01 F0 EB | H..S.H.C.H..H...
00000100: 22 48 C7 C2 01 00 00 00 48 89 E9 48 83 E9 08 48 | "H......H..H...H
00000110: 89 DF 48 B8 30 7E C6 A5 01 56 00 00 FF D0 48 85 | ..H.0~...V....H.
00000120: C0 74 16 48 0F B6 40 00 48 81 F8 E0 00 00 00 73 | .t.H..@.H......s
00000130: 02 EB 1D C7 C0 00 00 04 00 48 89 EC 48 8B 5C 24 | .........H..H.\$
00000140: 00 4C 8B 6C 24 08 48 8B 6C 24 10 48 83 C4 18 C3 | .L.l$.H.l$.H....
00000150: 31 C0 EB E5                                     | 1...
Segmentation fault         DPDK_TEST=3Dbpf_convert_autotest ./build/app/dpd=
k-test

--=20
You are receiving this mail because:
You are the assignee for the bug.=
