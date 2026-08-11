Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD53C5AC67
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 09:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5626740EDF;
	Tue, 11 Aug 2026 11:37:29 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8178040E39
 for <dev@dpdk.org>; Tue, 11 Aug 2026 11:37:27 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 72C0C4BA30; Tue, 11 Aug 2026 11:37:27 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1982] FIB underlying RIB name prefix missing
Date: Tue, 11 Aug 2026 09:37:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 26.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: mb@smartsharesystems.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1982-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1982

            Bug ID: 1982
           Summary: FIB underlying RIB name prefix missing
           Product: DPDK
           Version: 26.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: enhancement
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: mb@smartsharesystems.com
  Target Milestone: ---

When the FIB library creates an underlying RIB, it does not add a prefix to=
 the
RIB name.
It should be prefixed by "FIB_" (or "FIB6_").

https://elixir.bootlin.com/dpdk/v26.07/source/lib/fib/rte_fib.c#L176
https://elixir.bootlin.com/dpdk/v26.07/source/lib/fib/rte_fib6.c#L175

--=20
You are receiving this mail because:
You are the assignee for the bug.=
