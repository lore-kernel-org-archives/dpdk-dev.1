Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE86E9A03B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 22:03:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA46740261;
	Tue, 17 Feb 2026 23:03:11 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B6E48400EF
 for <dev@dpdk.org>; Tue, 17 Feb 2026 23:03:10 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 987A24A658; Tue, 17 Feb 2026 23:03:10 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1522] RTE_LIBRTE_ prefix should be replaced by RTE_
 prefix
Date: Tue, 17 Feb 2026 22:03:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 24.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: thomas@monjalon.net
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-1522-3-s9rXnVMfRe@http.bugs.dpdk.org/>
In-Reply-To: <bug-1522-3@http.bugs.dpdk.org/>
References: <bug-1522-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1522

Thomas Monjalon (thomas@monjalon.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|UNCONFIRMED                 |RESOLVED
         Resolution|---                         |FIXED

--- Comment #3 from Thomas Monjalon (thomas@monjalon.net) ---
Resolved in http://git.dpdk.org/dpdk/commit/?id=3Dce319a5add

--=20
You are receiving this mail because:
You are the assignee for the bug.=
