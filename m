Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA85CD98D2
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:09:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27AF542F51;
	Thu, 11 Jun 2026 11:09:04 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 069AA4026A
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:09:03 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id EB4A94B646; Thu, 11 Jun 2026 11:09:02 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1954] [dpdk26.07-rc1] DPDK build failed with
 EXTRA_CFLAGS='-O1' on Redhat9.6 and Ubuntu26.04
Date: Thu, 11 Jun 2026 09:09:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: daxuex.gao@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1954-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1954

            Bug ID: 1954
           Summary: [dpdk26.07-rc1] DPDK build failed with
                    EXTRA_CFLAGS=3D'-O1' on Redhat9.6 and Ubuntu26.04
           Product: DPDK
           Version: 26.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: daxuex.gao@intel.com
  Target Milestone: ---

[Environment]
DPDK version:=20
commit c429b06df56788795f886eca748420e2248da784 (HEAD -> main, tag: v26.07-=
rc1,
origin/main, origin/HEAD)
OS: (RHEL9.6/5.14.0-570.12.1.el9_6.x86_64)/(Ubuntu26.04/7.0.0-14-generic)
Compiler: gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)/gcc (Ubuntu
15.2.0-16ubuntu1) 15.2.0

[Test Setup]
# build cmd:=20
CC=3Dgcc meson --optimization=3D1 --werror  -Dlibdir=3Dlib  --default-libra=
ry=3Dstatic
x86_64-native-linuxapp-gcc=20
ninja -C x86_64-native-linuxapp-gcc

[Output]
Found ninja-1.10.2.git.kitware.jobserver-1 at /usr/local/bin/ninja
Cleaning... 0 files.
[11/3422] Compiling C object
lib/librte_eal.a.p/eal_common_eal_common_tailqs.c.o
FAILED: lib/librte_eal.a.p/eal_common_eal_common_tailqs.c.o
gcc -Ilib/librte_eal.a.p -Ilib -I../lib -Ilib/eal/common -I../lib/eal/common
-I. -I.. -Iconfig -I../config -Ilib/eal/include -I../lib/eal/include
-Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include
-I../lib/eal/x86/include -I../kernel/linux -Ilib/eal -I../lib/eal -Ilib/kva=
rgs
-I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics
-Ilib/telemetry -I../lib/telemetry -Ilib/argparse -I../lib/argparse
-fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -=
Wextra
-Werror -std=3Dc11 -O1 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated
-Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations
-Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith
-Wshadow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings
-Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE -fPIC
-march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API
'-DABI_VERSION=3D"26.1"' -DRTE_EAL_PTHREAD_ATTR_SETAFFINITY_NP
-DRTE_LOG_DEFAULT_LOGTYPE=3Dlib.eal -MD -MQ
lib/librte_eal.a.p/eal_common_eal_common_tailqs.c.o -MF
lib/librte_eal.a.p/eal_common_eal_common_tailqs.c.o.d -o
lib/librte_eal.a.p/eal_common_eal_common_tailqs.c.o -c
../lib/eal/common/eal_common_tailqs.c
In file included from ../lib/eal/common/eal_common_tailqs.c:13:
../lib/eal/common/eal_common_tailqs.c: In function =E2=80=98rte_eal_tailq_u=
pdate=E2=80=99:
../lib/eal/include/rte_string_fns.h:63:24: error: =E2=80=98snprintf=E2=80=
=99 output may be
truncated before the last format character [-Werror=3Dformat-truncation=3D]
   63 |         return (size_t)snprintf(dst, size, "%s", src);
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/eal/include/rte_string_fns.h:63:24: note: =E2=80=98snprintf=E2=80=99=
 output between 1
and 32 bytes into a destination of size 31
cc1: all warnings being treated as errors
[22/3422] Compiling C object lib/librte_eal.a.p/eal_common_rte_service.c.o
ninja: build stopped: subcommand failed.


[Expected Result]
Build Passed

[Regression]
Is this issue a regression: (Y/N)N

First bad commit:
de2604d55cb7098a941db696248c4d4d00abff43 is the first bad commit
commit de2604d55cb7098a941db696248c4d4d00abff43 (HEAD)
Author: Stephen Hemminger <stephen@networkplumber.org>
Date:   Wed Jan 28 17:41:20 2026 -0800

    lib: enable format overflow warnings

    Enable compiler checking of format overflow.

    Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

 lib/meson.build | 4 ----
 1 file changed, 4 deletions(-)

--=20
You are receiving this mail because:
You are the assignee for the bug.=
