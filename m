Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D74BFF885A
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 02:28:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4128A4027A;
	Wed, 29 Apr 2026 04:28:09 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id AB5F140272
 for <dev@dpdk.org>; Wed, 29 Apr 2026 04:28:07 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9AB2A4B0E7; Wed, 29 Apr 2026 04:28:07 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1937] [dpdk23.11.7-rc1] DPDK build failed with
 clang21.1.8 on Fedora43
Date: Wed, 29 Apr 2026 02:28:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 23.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: daxuex.gao@intel.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution bug_status
Message-ID: <bug-1937-3-DSU5Nq5fuy@http.bugs.dpdk.org/>
In-Reply-To: <bug-1937-3@http.bugs.dpdk.org/>
References: <bug-1937-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1937

gaodaxue (daxuex.gao@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |FIXED
             Status|IN_PROGRESS                 |RESOLVED

--- Comment #3 from gaodaxue (daxuex.gao@intel.com) ---
Verified commit
https://git.dpdk.org/dpdk-stable/commit/?h=3D23.11-staging&id=3D3e44b968b8d=
f9299bf4fc31c5a8c2bfe4d6ce0cd
on baseline f919fadc148d11f2ef(version: v23.11.7-rc1) Tested pass.
OS: Fedora43-64/6.17.1-300.fc43.x86_64
Compiler: clang 21.1.8 (Fedora 21.1.8-4.fc43)

--=20
You are receiving this mail because:
You are the assignee for the bug.=
