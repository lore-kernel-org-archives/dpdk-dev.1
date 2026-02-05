Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC69EC1EB2
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 14:03:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A2DF40E5A;
	Thu,  5 Feb 2026 15:03:37 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 89AA340E09
 for <dev@dpdk.org>; Thu,  5 Feb 2026 15:03:36 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 785C14A5AC; Thu,  5 Feb 2026 15:03:36 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1878] format-truncation warnings in eal_memalloc
 compiling find_numasocket and secondary_msl_create_walk
Date: Thu, 05 Feb 2026 14:03:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marat.khalili@huawei.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 target_milestone
Message-ID: <bug-1878-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1878

            Bug ID: 1878
           Summary: format-truncation warnings in eal_memalloc compiling
                    find_numasocket and secondary_msl_create_walk
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: marat.khalili@huawei.com
                CC: stephen@networkplumber.org
  Target Milestone: ---

When configured with:
```bash
CC=3Dgcc-13 meson setup --werror
'-Ddisable_drivers=3Dgpu/*,net/bnx2x,net/cnxk,net/qede' -Denable_docs=3Dfal=
se
-Dbuildtype=3Ddebug -Db_sanitize=3Daddress,undefined -Ddeveloper_mode=3Dena=
bled
-Dc_args=3D-DRTE_ENABLE_ASSERT
```
the following warnings are produced during compilation of branch main
(de2604d55cb7098a941db696248c4d4d00abff43):
```
FAILED: lib/librte_eal.a.p/eal_linux_eal_memory.c.o=20
gcc-13 -Ilib/librte_eal.a.p -Ilib -I../../src/lib -Ilib/eal/common
-I../../src/lib/eal/common -I. -I../../src -Iconfig -I../../src/config
-Ilib/eal/include -I../../src/lib/eal/include -Ilib/eal/linux/include
-I../../src/lib/eal/linux/include -Ilib/eal/x86/include
-I../../src/lib/eal/x86/include -I../../src/kernel/linux -Ilib/eal
-I../../src/lib/eal -Ilib/kvargs -I../../src/lib/kvargs -Ilib/log
-I../../src/lib/log -Ilib/metrics -I../../src/lib/metrics -Ilib/telemetry
-I../../src/lib/telemetry -Ilib/argparse -I../../src/lib/argparse
-fdiagnostics-color=3Dalways -fsanitize=3Daddress,undefined -fno-omit-frame=
-pointer
-D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O0=
 -g
-include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat
-Wformat-nonliteral -Wformat-security -Wmissing-declarations
-Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith
-Wshadow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings
-Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE
-DRTE_ENABLE_ASSERT -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API
-DALLOW_INTERNAL_API '-DABI_VERSION=3D"26.1"'
-DRTE_EAL_PTHREAD_ATTR_SETAFFINITY_NP -DRTE_LOG_DEFAULT_LOGTYPE=3Dlib.eal -=
MD -MQ
lib/librte_eal.a.p/eal_linux_eal_memory.c.o -MF
lib/librte_eal.a.p/eal_linux_eal_memory.c.o.d -o
lib/librte_eal.a.p/eal_linux_eal_memory.c.o -c
../../src/lib/eal/linux/eal_memory.c
../../src/lib/eal/linux/eal_memory.c: In function 'find_numasocket':
../../src/lib/eal/linux/eal_memory.c:450:31: error: 'snprintf' output may be
truncated before the last format character [-Werror=3Dformat-truncation=3D]
  450 |                         "%s/%s", hpi->hugedir,
eal_get_hugefile_prefix());
      |                               ^
../../src/lib/eal/linux/eal_memory.c:449:9: note: 'snprintf' output 2 or mo=
re
bytes (assuming 4097) into a destination of size 4096
  449 |         snprintf(hugedir_str, sizeof(hugedir_str),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  450 |                         "%s/%s", hpi->hugedir,
eal_get_hugefile_prefix());
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```
and
```
FAILED: lib/librte_eal.a.p/eal_linux_eal_memalloc.c.o=20
gcc-13 -Ilib/librte_eal.a.p -Ilib -I../../src/lib -Ilib/eal/common
-I../../src/lib/eal/common -I. -I../../src -Iconfig -I../../src/config
-Ilib/eal/include -I../../src/lib/eal/include -Ilib/eal/linux/include
-I../../src/lib/eal/linux/include -Ilib/eal/x86/include
-I../../src/lib/eal/x86/include -I../../src/kernel/linux -Ilib/eal
-I../../src/lib/eal -Ilib/kvargs -I../../src/lib/kvargs -Ilib/log
-I../../src/lib/log -Ilib/metrics -I../../src/lib/metrics -Ilib/telemetry
-I../../src/lib/telemetry -Ilib/argparse -I../../src/lib/argparse
-fdiagnostics-color=3Dalways -fsanitize=3Daddress,undefined -fno-omit-frame=
-pointer
-D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc11 -O0=
 -g
-include rte_config.h -Wvla -Wcast-qual -Wdeprecated -Wformat
-Wformat-nonliteral -Wformat-security -Wmissing-declarations
-Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith
-Wshadow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings
-Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE
-DRTE_ENABLE_ASSERT -fPIC -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API
-DALLOW_INTERNAL_API '-DABI_VERSION=3D"26.1"'
-DRTE_EAL_PTHREAD_ATTR_SETAFFINITY_NP -DRTE_LOG_DEFAULT_LOGTYPE=3Dlib.eal -=
MD -MQ
lib/librte_eal.a.p/eal_linux_eal_memalloc.c.o -MF
lib/librte_eal.a.p/eal_linux_eal_memalloc.c.o.d -o
lib/librte_eal.a.p/eal_linux_eal_memalloc.c.o -c
../../src/lib/eal/linux/eal_memalloc.c
../../src/lib/eal/linux/eal_memalloc.c: In function
'secondary_msl_create_walk':
../../src/lib/eal/linux/eal_memalloc.c:1401:50: error: '%i' directive output
may be truncated writing between 1 and 11 bytes into a region of size betwe=
en 0
and 63 [-Werror=3Dformat-truncation=3D]
 1401 |         snprintf(name, RTE_FBARRAY_NAME_LEN, "%s_%i",
      |                                                  ^~
../../src/lib/eal/linux/eal_memalloc.c:1401:9: note: 'snprintf' output betw=
een
3 and 76 bytes into a destination of size 64
 1401 |         snprintf(name, RTE_FBARRAY_NAME_LEN, "%s_%i",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1402 |                 primary_msl->memseg_arr.name, getpid());
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```

--=20
You are receiving this mail because:
You are the assignee for the bug.=
