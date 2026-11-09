Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A6606A320
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 03:15:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23375402BC;
	Mon,  9 Nov 2026 04:15:54 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTPS id 07A7D40272
 for <dev@dpdk.org>; Mon,  9 Nov 2026 04:15:52 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id BA7AF4D2CE; Mon,  9 Nov 2026 04:15:51 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 2099] [dpdk26.11-rc2] /drivers/net/xsc meson build
 failed with EXTRA_CFLAGS='-O1' on Ubuntu26.04
Date: Mon, 09 Nov 2026 03:15:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.11
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
Message-ID: <bug-2099-3@https.bugs.dpdk.org/>
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
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

https://bugs.dpdk.org/show_bug.cgi?id=3D2099

            Bug ID: 2099
           Summary: [dpdk26.11-rc2] /drivers/net/xsc meson build failed
                    with EXTRA_CFLAGS=3D'-O1' on Ubuntu26.04
           Product: DPDK
           Version: 26.11
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
DPDK version:  dpdk26.11-rc2 (a13c1053360)
OS: 26.04.1 LTS/Linux 7.0.0-38-generic
Compiler: gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0

[Test Setup]
# build cmd:=20
CC=3Dgcc meson --optimization=3D1 --werror  -Dlibdir=3Dlib  --default-libra=
ry=3Dstatic
x86_64-native-linuxapp-gcc=20
ninja -C x86_64-native-linuxapp-gcc

[Output]
# ninja -C x86_64-native-linuxapp-gcc
[1541/3514] Compiling C object
drivers/libtmp_rte_net_xsc.a.p/net_xsc_xsc_vfio.c.o
FAILED: [code=3D1] drivers/libtmp_rte_net_xsc.a.p/net_xsc_xsc_vfio.c.o
gcc -Idrivers/libtmp_rte_net_xsc.a.p -Idrivers -I../drivers -Idrivers/net/x=
sc
-I../drivers/net/xsc -Ilib/ethdev -I../lib/ethdev -Ilib/eal/common
-I../lib/eal/common -I. -I.. -Iconfig -I../config -Ilib/eal/include
-I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include
-Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux -Ilib/eal
-I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metr=
ics
-I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/argparse
-I../lib/argparse -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mem=
pool
-I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter -I../lib/meter
-Idrivers/bus/pci -I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci
-I../lib/pci -Idrivers/bus/vdev -I../drivers/bus/vdev
-fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -=
Wextra
-Werror -std=3Dc11 -O1 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated
-Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations
-Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith
-Wshadow -Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings
-Wno-packed-not-aligned -Wno-missing-field-initializers
-fzero-init-padding-bits=3Dall -D_GNU_SOURCE -fPIC -march=3Dnative -mrtm
-DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
-Wno-address-of-packed-member -Wno-vla -DRTE_COMPONENT_CLASS=3Dpmd_net
-DRTE_COMPONENT_NAME=3Dxsc -DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.xsc -MD -MQ
drivers/libtmp_rte_net_xsc.a.p/net_xsc_xsc_vfio.c.o -MF
drivers/libtmp_rte_net_xsc.a.p/net_xsc_xsc_vfio.c.o.d -o
drivers/libtmp_rte_net_xsc.a.p/net_xsc_xsc_vfio.c.o -c
../drivers/net/xsc/xsc_vfio.c
../drivers/net/xsc/xsc_vfio.c: In function =E2=80=98xsc_vfio_modify_qp_stat=
us=E2=80=99:
../drivers/net/xsc/xsc_vfio.c:491:16: error: =E2=80=98ret=E2=80=99 may be u=
sed uninitialized
[-Werror=3Dmaybe-uninitialized]
  491 |         return ret;
      |                ^~~
../drivers/net/xsc/xsc_vfio.c:452:16: note: =E2=80=98ret=E2=80=99 was decla=
red here
  452 |         int i, ret;
      |                ^~~
cc1: all warnings being treated as errors
[1654/3514] Compiling C object
drivers/libtmp_rte_net_mlx5.a.p/net_mlx5_mlx5_flow_hw.c.o
ninja: build stopped: subcommand failed.

[Regression]
Is this issue a regression: (Y/N)Y

[First bad commit]
commit b247199927a13dc964453c992caecddb5922dca4 (HEAD)
Author: Stephen Hemminger <stephen@networkplumber.org>
Date:   Thu Jul 23 10:59:05 2026 -0700

    net/hinic3: fix return value of FDIR enabling

    The code to enable fdir filter assumes entry is present.
    If not found it would return uninitialized value.

    Bugzilla ID: 1964
    Fixes: efa3b9b36fc7 ("net/hinic3: add flow control and filters")
    Cc: stable@dpdk.org

    Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
