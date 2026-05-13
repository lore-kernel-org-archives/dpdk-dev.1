Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC55CD4F21
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 May 2026 17:23:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A596402D0;
	Wed, 13 May 2026 19:23:17 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 1AC90402B6
 for <dev@dpdk.org>; Wed, 13 May 2026 19:23:16 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 0023B4B1AF; Wed, 13 May 2026 19:23:15 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1944] Crash due to corruption from data race in page
 prefault in alloc_seg()
Date: Wed, 13 May 2026 17:23:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 24.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: michal.sieron@nokia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1944-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1944

            Bug ID: 1944
           Summary: Crash due to corruption from data race in page
                    prefault in alloc_seg()
           Product: DPDK
           Version: 24.11
          Hardware: All
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: michal.sieron@nokia.com
  Target Milestone: ---

Hi, recently we caught a data corruption seemingly caused by a page prefaul=
t in
`alloc_seg()` function from `lib/eal/linux/eal_memalloc.c`:
> *(volatile int *)addr =3D *(volatile int *)addr;

Internal investigation showed that `rte_eal_init()` from a secondary process
was indirectly calling this function, which in rare cases led to data
corruption.
In our case it resulted in a scheduler crash:
> EAL: PANIC in eth_event_queue_callback():
> Cannot restart RxQ(p:1,q:0) after max trying times 4, abort!

The issue is reported for v24.11, but I don't think it is tied to this spec=
ific
version and is a general problem since that prefault was added in v18.05.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
