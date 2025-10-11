Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B040CCD183
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Oct 2025 03:25:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1834E4021E;
	Sat, 11 Oct 2025 05:25:25 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8B4E84003C
 for <dev@dpdk.org>; Sat, 11 Oct 2025 05:25:23 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6CB4648909; Sat, 11 Oct 2025 05:25:23 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/examples Bug 1799] [dpdk-25.11-rc0]
 ipv4_reassembly/test_send_2K_frames_split_in_4_and_1K_maxflows: Cannot
 configure device
Date: Sat, 11 Oct 2025 03:25:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: examples
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yux.jiang@intel.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution cc
Message-ID: <bug-1799-3-89G2v4DAep@http.bugs.dpdk.org/>
In-Reply-To: <bug-1799-3@http.bugs.dpdk.org/>
References: <bug-1799-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1799

jiang,yu (yux.jiang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|UNCONFIRMED                 |RESOLVED
         Resolution|---                         |DUPLICATE
                 CC|                            |yux.jiang@intel.com

--- Comment #1 from jiang,yu (yux.jiang@intel.com) ---
Duplicated with https://bugs.dpdk.org/show_bug.cgi?id=3D1785

*** This bug has been marked as a duplicate of bug 1785 ***

--=20
You are receiving this mail because:
You are the assignee for the bug.=
