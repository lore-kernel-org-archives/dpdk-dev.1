Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D48108B8F5
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 11:13:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C170402B2;
	Fri, 20 Mar 2026 12:13:30 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 04B2E40272
 for <dev@dpdk.org>; Fri, 20 Mar 2026 12:13:28 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id D075F4AD54; Fri, 20 Mar 2026 12:13:28 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [wishes/any Bug 1905] Reduce memory footprint by using rte_max_lcore
 instead of RTE_MAX_LCORE
Date: Fri, 20 Mar 2026 11:13:28 +0000
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
Message-ID: <bug-1905-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1905

            Bug ID: 1905
           Summary: Reduce memory footprint by using rte_max_lcore instead
                    of RTE_MAX_LCORE
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

Goal:
Reduce memory footprint of DPDK applications

Means:
Many arrays are sized to RTE_MAX_LCORE, which is set at build time.
This affects the memory footprint when RTE_MAX_LCORE is significantly higher
than the number of lcores used by the application.

Let's introduce an application startup-time configuration variable,
rte_max_lcore, to serve the same purposes RTE_MAX_LCORE does today.
It should be an optional EAL parameter, using RTE_MAX_LCORE as default.

By rightsizing the arrays scaling with the number of lcores, the application
memory footprint would be reduced, and allow building DPDK with a huge
RTE_MAX_LCORE.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
