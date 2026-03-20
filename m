Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C15108B907
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 11:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50174402B2;
	Fri, 20 Mar 2026 12:57:23 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8761640272
 for <dev@dpdk.org>; Fri, 20 Mar 2026 12:57:21 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6B9184AD54; Fri, 20 Mar 2026 12:57:21 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [wishes/any Bug 1906] Use DPDK memory for lcore variables
Date: Fri, 20 Mar 2026 11:57:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: wishes
X-Bugzilla-Component: any
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mb@smartsharesystems.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone bug_group
Message-ID: <bug-1906-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1906

            Bug ID: 1906
           Summary: Use DPDK memory for lcore variables
           Product: wishes
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: any
          Assignee: dev@dpdk.org
          Reporter: mb@smartsharesystems.com
  Target Milestone: ---
             Group: wishes-managers

Goal: Use DPDK memory for lcore variables

Benefits:
1. lcore variables are stored in hugepages, with fewer TLB misses
2. lcore variables could be shared with secondary process

Means:
Compared to (RTE_CACHE_GUARD'ed) arrays indexed by lcore id, the main benef=
it
of lcore variables is that the variables can share the same CPU cache line,
which improves CPU cache efficiency.
The effect of cache line sharing depends on the size of the variable.
Multiple small variables can share the same CPU cache line.
Variables spanning multiple CPU cache lines have a smaller degree of overlap
within CPU cache lines.

Memory for lcore variables is allocated in chunks of RTE_MAX_LCORE_VAR *
RTE_MAX_LCORE bytes, where RTE_MAX_LCORE_VAR is the max size of an lcore
variable.

The default RTE_MAX_LCORE_VAR is 128 KB.
If using mlockall() to pin RAM to the DPDK application, the benefits of usi=
ng
the standard heap with normal 4 KB pages for lcore variables - not using mo=
re
RAM than actually used by lcore variables (regardless of the size of the me=
mory
chunks allocated for lcore variables) - disappears.

Since lcore variables' benefit of CPU cache line sharing decreases when the
lcore variables are large, it would be reasonable to reduce the max size of
lcore variables (RTE_MAX_LCORE_VAR) significantly, and recommend using other
methods for storing large per-lcore variables.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
