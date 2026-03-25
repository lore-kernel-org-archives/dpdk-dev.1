Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0EC1093168
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:05:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7284402AA;
	Wed, 25 Mar 2026 03:05:39 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B44E74027A
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:05:38 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 7F96C4AD93; Wed, 25 Mar 2026 03:05:38 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1904] [dpdk-26.03]
 lib/librte_pipeline.a.p/pipeline_rte_table_action.c.o build failure with gcc
 13.3 on Ubuntu24.04.4/linux kernel 6.8.0-106-generic
Date: Wed, 25 Mar 2026 02:05:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yux.jiang@intel.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution bug_status
Message-ID: <bug-1904-3-qb7dz5KT96@http.bugs.dpdk.org/>
In-Reply-To: <bug-1904-3@http.bugs.dpdk.org/>
References: <bug-1904-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1904

jiang,yu (yux.jiang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |INVALID
             Status|CONFIRMED                   |RESOLVED

--- Comment #5 from jiang,yu (yux.jiang@intel.com) ---
Not a defect.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
