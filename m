Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FE1D6CFA2
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 18:03:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B325C4027A;
	Thu, 22 Jan 2026 19:03:48 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 799F040274
 for <dev@dpdk.org>; Thu, 22 Jan 2026 19:03:47 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 507AF4A2AF; Thu, 22 Jan 2026 19:03:47 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1869] incorrect get_tsc_freq_arch() due to integer
 truncation
Date: Thu, 22 Jan 2026 18:03:47 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rizzo.unipi@gmail.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1869-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1869

            Bug ID: 1869
           Summary: incorrect get_tsc_freq_arch() due to integer
                    truncation
           Product: DPDK
           Version: unspecified
          Hardware: x86
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: rizzo.unipi@gmail.com
  Target Milestone: ---

There is a bug in
https://github.com/DPDK/dpdk/blob/main/lib/eal/x86/rte_cycles.c#L148


143           __cpuid(0x15, a, b, c, d);=20=20
...
146           /* EBX : TSC/Crystal ratio, ECX : Crystal Hz */
147           if (b && c)
148               return c * (b / a);

On one machine, line 143 returns a 10 b 23 c 1000000000 d 0,
the division (b / a) returns 2 hence leading to
an incorrect value (2 GHz instead of 2.3 GHz)


The trivial fix is to replace line 148 with

    return (uint64_t)c * b / a;

--=20
You are receiving this mail because:
You are the assignee for the bug.=
