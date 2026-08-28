Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E0EC61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 17:56:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4491A4025A;
	Fri, 28 Aug 2026 19:56:21 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 0A98B40151
 for <dev@dpdk.org>; Fri, 28 Aug 2026 19:56:20 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id DFE5F4C771; Fri, 28 Aug 2026 19:56:19 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2019] memif: sealed region issues
Date: Fri, 28 Aug 2026 17:56:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
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
 target_milestone bug_group
Message-ID: <bug-2019-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2019

            Bug ID: 2019
           Summary: memif: sealed region issues
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---
             Group: security

This is related to bug 2013, and was found by AI review.
Fixing it to be fully secure would break some uses.


Sealing: warn, do not reject
----------------------------

A server cannot require F_SEAL_SHRINK today. libmemif seals region 0,
but VPP's hugepage-backed and zero-copy buffer regions use MFD_HUGETLB
or hugetlbfs and are not sealed, so requiring a seal would disconnect
conforming clients.

A narrower rule does not work either. The obvious refinement is to
reject when the fd supports sealing but is not sealed, and warn only
when the fd type has no seals at all. That cannot be implemented
cleanly: F_GET_SEALS returns F_SEAL_SEAL for a memfd created without
MFD_ALLOW_SEALING, so a successful F_GET_SEALS does not mean the client
could have sealed and chose not to. Under that rule DPDK would reject
peers that had no way to comply, which is the unilateral hardening this
work is trying to avoid.

So the proposed fix checks the size with fstat and only logs when the fd
is unsealed. Two review points on the logging:

  - the log fires for legitimate VPP hugepage clients, which is the
    common deployment, so at NOTICE it is noise in exactly the normal
    case and trains operators to ignore it. DEBUG, or once per device,
    is more defensible;
  - it is emitted per region per connection, so a peer that reconnects
    in a loop can flood the log. That is a small denial of service
    introduced by the fix itself.

The real fix for the residual exposure is a protocol requirement that
clients seal shrinkable regions, negotiated in the hello so that both
sides know whether it applies. That cannot be decided by DPDK alone; it
is a wire-contract item for DPDK, VPP and libmemif together.

Until then, this bug reduces the exposure to a client that lies about
the size at connect time. It does not close the class, and neither the
commit message nor the documentation should claim that it does.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
