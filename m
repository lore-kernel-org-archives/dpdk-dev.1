Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477B3CC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 12:56:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25649402DA;
	Thu, 15 Oct 2026 14:56:57 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C90CF400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 14:56:55 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B724B4BDCF; Thu, 15 Oct 2026 14:56:55 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [wishes/any Bug 2059] Resizable mbuf pool
Date: Thu, 15 Oct 2026 12:56:55 +0000
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
 target_milestone
Message-ID: <bug-2059-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2059

            Bug ID: 2059
           Summary: Resizable mbuf pool
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

Typically, the number of mbufs needed in a system scales with multiple
parameters, some are per-interface, and some are system wide.

If a system's number of interfaces is not known at system startup time, it =
is a
common design pattern to allocate one mbuf pool per interface at runtime, w=
hen
each interface is created.
Having one mbuf pool per interface means that the size of each pool needs t=
o be
big enough to serve not only the per-interface mbuf consumption, but also
system-wide mbuf consumption.
This is not memory efficient.

It would be memory efficient to share one (or one per CPU socket) big mbuf =
pool
across all interfaces (or groups of interfaces attached to each CPU socket)=
, so
the number of mbufs needed for system wide purposes only is allocated once,=
 and
not once per interface.

For this alternative design pattern, where one mbuf pool is shared by all
interfaces, and more interfaces can still be added at runtime, it "must" be
possible to add more mbufs to the mbuf pool at runtime, effectively increas=
ing
its size.

NB:
The ability to reduce the mbuf pool size at runtime too, e.g. when an inter=
face
is deleted, is considered "nice to have" in this context.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
