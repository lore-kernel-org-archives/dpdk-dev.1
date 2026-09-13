Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB84C88E5C
	for <dpdk-dev@archiver.kernel.org>; Sun, 13 Sep 2026 17:38:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D74F4027A;
	Sun, 13 Sep 2026 19:38:39 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id BCBA54026E
 for <dev@dpdk.org>; Sun, 13 Sep 2026 19:38:37 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id B87674D0FD; Sun, 13 Sep 2026 19:38:37 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 2042] net/intel/idpf and net/intel/cpfl: four byte
 store into a bool
Date: Sun, 13 Sep 2026 17:38:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2042-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2042

            Bug ID: 2042
           Summary: net/intel/idpf and net/intel/cpfl: four byte store
                    into a bool
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

drivers/net/intel/idpf/idpf_ethdev.c:1248
drivers/net/intel/cpfl/cpfl_ethdev.c (same handler, copied)

parse_bool() stores an int:

        int *i =3D args;
        ...
        *i =3D num;

Both callers in each driver pass the address of a bool:

        drivers/net/intel/idpf/idpf_common_device.h:104
                bool is_tx_singleq;
                bool is_rx_singleq;

so "tx_single=3D1" or "rx_single=3D1" writes four bytes into a one byte fie=
ld.

Fixes: 549343c25db8 ("net/idpf: support device initialization")
Fixes: 2d823ecd671c ("net/cpfl: support device initialization")

--=20
You are receiving this mail because:
You are the assignee for the bug.=
