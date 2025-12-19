Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD7CD767D8
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 11:07:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA9364026A;
	Fri, 19 Dec 2025 12:07:28 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 355E340150
 for <dev@dpdk.org>; Fri, 19 Dec 2025 12:07:27 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id C32214708F; Fri, 19 Dec 2025 12:07:26 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/eventdev Bug 1855] E610 vfs can't forward packets
Date: Fri, 19 Dec 2025 11:07:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: eventdev
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ktraynor@redhat.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1855-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1855

            Bug ID: 1855
           Summary: E610 vfs can't forward packets
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: eventdev
          Assignee: dev@dpdk.org
          Reporter: ktraynor@redhat.com
  Target Milestone: ---

Intel validation team reported during testing for 24.11.4 that E610 vf could
not forward packets.
https://mails.dpdk.org/archives/stable/2025-December/055158.html

They report that this is because not all patches in series here are backpor=
ted.
https://patches.dpdk.org/project/dpdk/list/?series=3D34939&archive=3Dboth&s=
tate=3D*


1/3
78d6854e0e39 ("net/ixgbe: use function to check for VF")
https://git.dpdk.org/dpdk/commit/?id=3D78d6854e0e3941e9b37e7f5c104c2ea7576d=
0f45
This is just a small clean up and not really needed.

2/3
8364a0f276eb ("net/ixgbe: fix VF registers for E610")
https://git.dpdk.org/dpdk/commit/?id=3D8364a0f276ebc6ecb6dad1874ce0097966a7=
4f09
This is backported to 24.11 already.

3/3
85b7d47d564f ("net/ixgbe: support MDD on VF Tx path")
https://git.dpdk.org/dpdk/commit/?id=3D85b7d47d564ffbe206a7d17bf5a0ed9dff17=
b555
This does not apply and would need rebase from Author due to conflicts.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
