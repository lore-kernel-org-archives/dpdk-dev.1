Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3EDC5AD5A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 08:27:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 882CB402B8;
	Wed, 12 Aug 2026 10:27:04 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id D1F1D40279
 for <dev@dpdk.org>; Wed, 12 Aug 2026 10:27:03 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id AE3074BA3E; Wed, 12 Aug 2026 10:27:03 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1984] Increase memzone name size
Date: Wed, 12 Aug 2026 08:27:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
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
Message-ID: <bug-1984-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1984

            Bug ID: 1984
           Summary: Increase memzone name size
           Product: DPDK
           Version: 26.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: enhancement
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: mb@smartsharesystems.com
  Target Milestone: ---

"32 bytes ought to be enough for anybody."
Said nobody.

Many object types have names, and at object creation, they create sub-objec=
ts,
adding a prefix to the name of the sub-object. The sub-objects may create i=
ts
own sub-objects (with another prefix added to the name) etc..

E.g. when creating a mempool named "example", the mempool lib creates a mem=
zone
named "MP_example", and the mempool ring driver (a sub-object of the mempoo=
l)
creates a memzone named "RG_MP_example".

Assuming the FIB and RIB libs also added proper prefixes (which the current=
ly
don't), the names would go:
"example" (FIB name),
"FIB_example" (RIB name),
"RIB_FIB_example" (mempool name),
"MP_RIB_FIB_example" (memzone name created by the mempool),
"RG_MP_RIB_FIB_example" (memzone name created by the ring driver).

One of the FIB6 test cases creates a FIB with the name "test_drift_compress=
ion"
(22 chars). Adding prefixes, it should end up being
"RG_MP_RIB_FIB_test_drift_compression" (36 chars).

I suggest increasing RTE_MEMZONE_NAMESIZE from 32 to 64.
This seems simple on the surface, as it does no harm to the rte_memzone
structure itself.

However, it has a ripple effect into other object types, whose name sizes a=
re
derived by this, e.g. the rte_ring and the rte_mempool structures.
When the size of the name field in those structures is increased, other fie=
lds
in the structures will move down, and may end up in a different cache line.
So, all structures depending on RTE_MEMZONE_NAMESIZE must be carefully revi=
ewed
and adjusted, so their fields are grouped efficiently, considering cache li=
nes.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
