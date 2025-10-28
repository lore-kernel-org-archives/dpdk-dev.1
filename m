Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA6DCCF9EA
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 07:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F78140291;
	Tue, 28 Oct 2025 08:37:22 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 82DB640262
 for <dev@dpdk.org>; Tue, 28 Oct 2025 08:37:21 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 7D905489FC; Tue, 28 Oct 2025 08:37:21 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/meson Bug 1005] Build failure with gcc11 in When Using
 Environment Modules
Date: Tue, 28 Oct 2025 07:37:21 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: meson
X-Bugzilla-Version: 22.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mkashani@nvidia.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc resolution bug_status
Message-ID: <bug-1005-3-HaUOpGcfkt@http.bugs.dpdk.org/>
In-Reply-To: <bug-1005-3@http.bugs.dpdk.org/>
References: <bug-1005-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1005

mkashani@nvidia.com (mkashani@nvidia.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mkashani@nvidia.com
         Resolution|---                         |FIXED
             Status|CONFIRMED                   |RESOLVED

--- Comment #3 from mkashani@nvidia.com (mkashani@nvidia.com) ---
issue resolved,closing

--=20
You are receiving this mail because:
You are the assignee for the bug.=
