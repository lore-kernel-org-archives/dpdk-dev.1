Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD14FC5CFC1
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 09:28:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86F2640E39;
	Tue, 11 Aug 2026 11:28:04 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id AAEB74027F
 for <dev@dpdk.org>; Tue, 11 Aug 2026 11:28:03 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 9CEFC4BA30; Tue, 11 Aug 2026 11:28:03 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1980] mempool name size assumes ring driver
Date: Tue, 11 Aug 2026 09:28:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mb@smartsharesystems.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1980-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1980

            Bug ID: 1980
           Summary: mempool name size assumes ring driver
           Product: DPDK
           Version: 26.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: mb@smartsharesystems.com
  Target Milestone: ---

When creating a mempool, the length of its name is checked.
RTE_MEMPOOL_NAMESIZE defines the max allowed length, and is derived from the
names of the memzones created for the mempool.
The mempool itself creates a memzone named "MP_name".
When using the Ring driver, the driver creates a memzone named "RG_MP_name".
This is what RTE_MEMPOOL_NAMESIZE is based on:
Max memzone name - strlen("RG_") - strlen("MP_").

Now, when using the Stack driver, the driver creates a memzone named
"STK_MP_name".
In this case, the RTE_MEMPOOL_NAMESIZE should be one byte less.
With a long name, creating the mempool will succeed, but populating it will
fail when the mempool driver tries to allocate the memzone for the mempool
entries.

Reducing RTE_MEMPOOL_NAMESIZE (by one) to consider the memzone name created=
 by
the Stack driver would be an API change, and would not consider other drive=
rs
possibly using even longer memzone names.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
