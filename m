Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5D6C5DF87
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 12:33:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EE1540150;
	Thu, 20 Aug 2026 14:33:34 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8131F400EF
 for <dev@dpdk.org>; Thu, 20 Aug 2026 14:33:32 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6E22B4CD23; Thu, 20 Aug 2026 14:33:32 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/meson Bug 1985] chkincs fails to build with stdatomic
Date: Thu, 20 Aug 2026 12:33:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: meson
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
Message-ID: <bug-1985-3@https.bugs.dpdk.org/>
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

https://bugs.dpdk.org/show_bug.cgi?id=3D1985

            Bug ID: 1985
           Summary: chkincs fails to build with stdatomic
           Product: DPDK
           Version: 26.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: meson
          Assignee: dev@dpdk.org
          Reporter: mb@smartsharesystems.com
  Target Milestone: ---

How to reproduce:
meson setup --reconfigure -Dcheck_includes=3Dtrue -Ddeveloper_mode=3Denabled
-Denable_docs=3Dtrue -Denable_stdatomic=3Dtrue build
ninja -C build

Output (truncated):
[4292/5310] Compiling C++ object
buildtools/chkincs/chkincs-cpp.p/meson-generated_rte_atomic.cpp.o
FAILED: buildtools/chkincs/chkincs-cpp.p/meson-generated_rte_atomic.cpp.o
ccache c++ -Ibuildtools/chkincs/chkincs-cpp.p -Ibuildtools/chkincs
-I../buildtools/chkincs -I. -I.. -Iconfig -I../config
-Ibuildtools/chkincs/staging -I../buildtools/chkincs/staging
-fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -=
Wextra
-O3 -include rte_config.h -march=3Dnative -mrtm -Wno-missing-field-initiali=
zers
-Wno-vla -MD -MQ
buildtools/chkincs/chkincs-cpp.p/meson-generated_rte_atomic.cpp.o -MF
buildtools/chkincs/chkincs-cpp.p/meson-generated_rte_atomic.cpp.o.d -o
buildtools/chkincs/chkincs-cpp.p/meson-generated_rte_atomic.cpp.o -c
buildtools/chkincs/chkincs-cpp.p/rte_atomic.cpp
In file included from buildtools/chkincs/staging/generic/rte_atomic.h:18,
                 from
/home/morten/upstreaming/dpdk-stack-std/lib/eal/x86/include/rte_atomic.h:12,
                 from buildtools/chkincs/chkincs-cpp.p/rte_atomic.cpp:1:
buildtools/chkincs/staging/rte_stdatomic.h:30:9: error: =E2=80=98memory_ord=
er=E2=80=99 does not
name a type
   30 | typedef memory_order rte_memory_order;
      |         ^~~~~~~~~~~~

Building on Ubuntu 24.04.01, DPDK version 26.11-rc0.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
