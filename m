Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95F606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:07:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5419402BF;
	Tue, 17 Nov 2026 18:07:56 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id AC6A8402A4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 18:07:54 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 988E64D4E9; Tue, 17 Nov 2026 18:07:54 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 2135] eal: unreachable code warning
Date: Tue, 17 Nov 2026 17:07:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: stephen@networkplumber.org
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Low
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-2135-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2135

            Bug ID: 2135
           Summary: eal: unreachable code warning
           Product: DPDK
           Version: 26.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: minor
          Priority: Low
         Component: core
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Building with clang and -Wunreachable-code finds this:

[18/3982] Compiling C object lib/librte_eal.a.p/eal_common_rte_version.c.o
../lib/eal/common/rte_version.c:40:3: warning: code will never be executed
[-Wunreachable-code]
   40 |                 snprintf(version, sizeof(version), "%s %d.%02d.%d",
      |                 ^~~~~~~~
../lib/eal/common/rte_version.c:39:32: note: silence by adding parentheses =
to
mark code as explicitly dead
   39 |         if (strlen(RTE_VER_SUFFIX) =3D=3D 0)
      |                                       ^
      |                                       /* DISABLES CODE */ ( )
1 warning generated.

It can be fixed by adding parens, using sizeof, or useing RTE_VERSION which=
 is
already built by meson.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
