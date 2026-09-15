Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E97CC88E53
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 03:18:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7C4D40290;
	Tue, 15 Sep 2026 05:18:43 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9B89D40278
 for <dev@dpdk.org>; Tue, 15 Sep 2026 05:18:42 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 75CA14C93B; Tue, 15 Sep 2026 05:18:42 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2037] net/intel/ice: parse_bool clobbers adjacent
 devargs fields
Date: Tue, 15 Sep 2026 03:18:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: anurag.mandal@intel.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution assigned_to bug_status
Message-ID: <bug-2037-3-czSLgLkwzm@https.bugs.dpdk.org/>
In-Reply-To: <bug-2037-3@https.bugs.dpdk.org/>
References: <bug-2037-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2037

Anurag Mandal (anurag.mandal@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |FIXED
           Assignee|anurag.mandal@intel.com     |dev@dpdk.org
             Status|UNCONFIRMED                 |RESOLVED

--- Comment #1 from Anurag Mandal (anurag.mandal@intel.com) ---
Addressed in Patch:
https://patches.dpdk.org/project/dpdk/patch/20260914153019.4034539-1-bruce.=
richardson@intel.com/

--=20
You are receiving this mail because:
You are the assignee for the bug.=
