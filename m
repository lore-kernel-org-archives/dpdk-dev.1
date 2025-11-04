Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37E8CCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 06:52:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DE284028C;
	Tue,  4 Nov 2025 07:52:54 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6EB4740285
 for <dev@dpdk.org>; Tue,  4 Nov 2025 07:52:52 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 4F78948A9B; Tue,  4 Nov 2025 07:52:52 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1810] net/mlx: possible misuse of comma operator
Date: Tue, 04 Nov 2025 06:52:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 20.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: getelson@nvidia.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution cc bug_status
Message-ID: <bug-1810-3-39VvroDmRz@http.bugs.dpdk.org/>
In-Reply-To: <bug-1810-3@http.bugs.dpdk.org/>
References: <bug-1810-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1810

Gregory Etelson (getelson@nvidia.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |FIXED
                 CC|                            |getelson@nvidia.com
             Status|UNCONFIRMED                 |RESOLVED

--- Comment #1 from Gregory Etelson (getelson@nvidia.com) ---
Hello,

A fix will be merged into 25.11.

https://patches.dpdk.org/project/dpdk/patch/20251029095505.100582-1-getelso=
n@nvidia.com/

Regards,
Gregory

--=20
You are receiving this mail because:
You are the assignee for the bug.=
