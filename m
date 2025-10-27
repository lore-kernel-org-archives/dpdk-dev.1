Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E34CCF9E0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 08:28:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 399894021E;
	Mon, 27 Oct 2025 09:28:11 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id AF67E4003C
 for <dev@dpdk.org>; Mon, 27 Oct 2025 09:28:10 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A2F8048A01; Mon, 27 Oct 2025 09:28:10 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1533] testpmd performance drops with Mellanox
 ConnectX6  when using 8 cores 8 queues
Date: Mon, 27 Oct 2025 08:28:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 23.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mkashani@nvidia.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution cc
Message-ID: <bug-1533-3-gZcaifwzJR@http.bugs.dpdk.org/>
In-Reply-To: <bug-1533-3@http.bugs.dpdk.org/>
References: <bug-1533-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1533

mkashani@nvidia.com (mkashani@nvidia.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|UNCONFIRMED                 |RESOLVED
         Resolution|---                         |FIXED
                 CC|                            |mkashani@nvidia.com

--- Comment #4 from mkashani@nvidia.com (mkashani@nvidia.com) ---
Hi, wangliangxing,
Sorry for the late response,
In general, Performance adjustments can be found under Nvidia performance
reports:
https://core.dpdk.org/perf-reports/
The latest is from 24.11.
If needed further info please ask.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
