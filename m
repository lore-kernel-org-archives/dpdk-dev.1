Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1D7C44514
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 20:24:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1A674028C;
	Thu, 16 Jul 2026 22:24:03 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8446A4028B
 for <dev@dpdk.org>; Thu, 16 Jul 2026 22:24:02 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6818E4B8BB; Thu, 16 Jul 2026 22:24:02 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/DTS Bug 1969] dts: fix variance in single core forward
 performance test
Date: Thu, 16 Jul 2026 20:24:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: DTS
X-Bugzilla-Version: 26.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: abailey@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 target_milestone
Message-ID: <bug-1969-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1969

            Bug ID: 1969
           Summary: dts: fix variance in single core forward performance
                    test
           Product: DPDK
           Version: 26.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: DTS
          Assignee: dev@dpdk.org
          Reporter: abailey@iol.unh.edu
                CC: juraj.linkes@pantheon.tech, probb@iol.unh.edu
  Target Milestone: ---

Currently, multiple performance runs yield varying results with a standard
deviation of about 10Mpps. This is on the same testbed that has consistent
performance results when running old DTS with a standard deviation of about
1Mpps. There was a commit sent to old DTS specifically addressing this vari=
ance
issue by limiting the transmission duration to 5 seconds and averaging resu=
lts
over a couple of runs instead of one. Testing this 5 second gap instead of =
30
has shown consistent results when testing new DTS locally, however, averagi=
ng
over a few runs may be beneficial to implement as well with new DTS.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
