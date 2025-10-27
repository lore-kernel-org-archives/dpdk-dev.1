Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E3CCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 09:17:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B39F14028B;
	Mon, 27 Oct 2025 10:17:37 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id C1DCE4026F
 for <dev@dpdk.org>; Mon, 27 Oct 2025 10:17:36 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B312648A01; Mon, 27 Oct 2025 10:17:36 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1479] mlx5: Not able to create rte_flows to match
 head fragments and sub fragments
Date: Mon, 27 Oct 2025 09:17:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 21.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: mkashani@nvidia.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc bug_status resolution
Message-ID: <bug-1479-3-Nwhz585GCD@http.bugs.dpdk.org/>
In-Reply-To: <bug-1479-3@http.bugs.dpdk.org/>
References: <bug-1479-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1479

mkashani@nvidia.com (mkashani@nvidia.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mkashani@nvidia.com
             Status|CONFIRMED                   |RESOLVED
         Resolution|---                         |FIXED

--- Comment #1 from mkashani@nvidia.com (mkashani@nvidia.com) ---
Hi, Siva,
Sorry for the late response,

You're correct that the mlx5 driver explicitly blocks the fragment matching
patterns you're trying to use.

For your use case (computing different RSS based on 5-tuple vs 3-tuple):
Create two flow rules:
One for ANY fragmented packets =E2=86=92 RSS with 3-tuple (ipv4-frag)
One for non-fragmented packets =E2=86=92 RSS with 5-tuple (ipv4-tcp, ipv4-u=
dp)
The NIC will automatically:
Use 3-tuple for fragments (only IP src/dst/protocol available)
Use 5-tuple for non-fragments (full 5-tuple available)
You cannot differentiate between first, middle, and last fragments in flow
rules on ConnectX-6 DX.
The hardware RSS engine already handles this correctly by design - fragment=
ed
packets can only use 3-tuple because port information is only in the first
fragment, and may not be available to all fragments.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
