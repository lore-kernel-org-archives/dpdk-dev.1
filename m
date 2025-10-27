Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816BACCF9EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 14:07:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 576EB4028B;
	Mon, 27 Oct 2025 15:07:18 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 25DE44026F
 for <dev@dpdk.org>; Mon, 27 Oct 2025 15:07:17 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1D54048A08; Mon, 27 Oct 2025 15:07:17 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1266] net/mlx5: cannot create rte_flow rule
 matching ethernet multicast with jump action on bond mode 4
Date: Mon, 27 Oct 2025 14:07:17 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mkashani@nvidia.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WONTFIX
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution cc bug_status
Message-ID: <bug-1266-3-1xT2p2f45L@http.bugs.dpdk.org/>
In-Reply-To: <bug-1266-3@http.bugs.dpdk.org/>
References: <bug-1266-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1266

mkashani@nvidia.com (mkashani@nvidia.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |WONTFIX
                 CC|                            |mkashani@nvidia.com
             Status|UNCONFIRMED                 |RESOLVED

--- Comment #1 from mkashani@nvidia.com (mkashani@nvidia.com) ---
Hi,=20
Sorry for the late response,

**Root Cause**: MLX5 hardware/firmware steering on root table (group 0) has
limited support for jump actions combined with partial MAC address masks. T=
he
bonding PMD directly passes the flow to slave ports without adaptation.

## Immediate Workarounds

### Workaround 1: Use Group 1 (Recommended)
Instead of group 0, use group 1:

```bash
flow create 2 group 1 priority 0 ingress pattern eth dst spec 01:00:00:00:0=
0:00
dst mask 01:00:00:00:00:00 / end actions jump group 2 / end
```

First, create a catch-all rule in group 0 to reach group 1:
```bash
flow create 2 group 0 priority 1 ingress pattern eth / end actions jump gro=
up 1
/ end
```

--=20
You are receiving this mail because:
You are the assignee for the bug.=
