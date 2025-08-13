Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF108CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 02:49:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 196A44025D;
	Wed, 13 Aug 2025 04:49:29 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id AE281400EF
 for <dev@dpdk.org>; Wed, 13 Aug 2025 04:49:27 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A203E46D12; Wed, 13 Aug 2025 04:49:27 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1771] [dpdk 23.11.5-rc1] drivers/net/cxgbe meson
 build failed on Fedora42 with gcc15.0.1
Date: Wed, 13 Aug 2025 02:49:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 23.11
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
Message-ID: <bug-1771-3@https.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17550533670.DE985c4.4141203
Content-Transfer-Encoding: 7bit
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


--17550533670.DE985c4.4141203
Date: Wed, 13 Aug 2025 04:49:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1771

            Bug ID: 1771
           Summary: [dpdk 23.11.5-rc1] drivers/net/cxgbe meson build
                    failed on Fedora42 with gcc15.0.1
           Product: DPDK
           Version: 23.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: daxuex.gao@intel.com
  Target Milestone: ---

The issue occurs on the new Fedora 42 OS, while there is no problem on the =
old
Fedora 41 OS.

[DPDK version]
commit 96ae1d570472620165484776205fe957294b9597 (HEAD, tag: v23.11.5-rc1,
origin/23.11)
Author: Xueming Li <xuemingl@nvidia.com>
Date: =C2=A0 Mon Aug 11 21:33:43 2025 +0800=C2=A0 =C2=A0=20
version: 23.11.5-rc1=C2=A0 =C2=A0=20
Signed-off-by: Xueming Li <xuemingl@nvidia.com>

[OS version]
OS: Fedora Linux 42 (Server Edition)/Linux 6.14.0-63.fc42.x86_64
Compiler: gcc (GCC) 15.0.1 20250329 (Red Hat 15.0.1-0)

[Test Setup]
# CC=3Dgcc meson --werror -Denable_kmods=3DTrue -Dlibdir=3Dlib -Dexamples=
=3Dall
--default-library=3Dstatic x86_64-native-linuxapp-gcc
# ninja -j 10 -C x86_64-native-linuxapp-gcc

[Log]
Found ninja-1.10.2.git.kitware.jobserver-1 at /usr/local/bin/ninja
Cleaning... 0 files.
[1242/3040] Compiling C object
drivers/libtmp_rte_net_cxgbe.a.p/net_cxgbe_cxgbe_flow.c.o
FAILED: drivers/libtmp_rte_net_cxgbe.a.p/net_cxgbe_cxgbe_flow.c.o
cc -Idrivers/libtmp_rte_net_cxgbe.a.p -Idrivers -I../drivers
-Idrivers/net/cxgbe -I../drivers/net/cxgbe -I../drivers/net/cxgbe/base
-Ilib/ethdev -I../lib/ethdev -I. -I.. -Iconfig -I../config -Ilib/eal/include
-I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include
-Ilib/eal/x86/include -I../lib/eal/x86/include -Ilib/eal/common
-I../lib/eal/common -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs
-Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry
-I../lib/telemetry -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf
-Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter
-I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci
-I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev
-I../drivers/bus/vdev -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64=
 -Wall
-Winvalid-pch -Wextra -Werror -std=3Dc11 -O3 -include rte_config.h -Wcast-q=
ual
-Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security
-Wmissing-declarations -Wmissing-prototypes -Wnested-externs
-Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes
-Wundef -Wwrite-strings -Wno-address-of-packed-member -Wno-packed-not-align=
ed
-Wno-missing-field-initializers -fzero-init-padding-bits=3Dall
-Wno-zero-length-bounds -D_GNU_SOURCE -fPIC -march=3Dnative -mrtm
-DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
-DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.cxgbe -MD -MQ
drivers/libtmp_rte_net_cxgbe.a.p/net_cxgbe_cxgbe_flow.c.o -MF
drivers/libtmp_rte_net_cxgbe.a.p/net_cxgbe_cxgbe_flow.c.o.d -o
drivers/libtmp_rte_net_cxgbe.a.p/net_cxgbe_cxgbe_flow.c.o -c
../drivers/net/cxgbe/cxgbe_flow.c
../drivers/net/cxgbe/cxgbe_flow.c:892:52: error: initializer-string for arr=
ay
of =E2=80=98unsigned char=E2=80=99 truncates NUL terminator but destination=
 lacks =E2=80=98nonstring=E2=80=99
attribute (7 chars into 6 available)
[-Werror=3Dunterminated-string-initialization]
=C2=A0 892 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 .hdr.dst_addr.addr_bytes =3D
"\xff\xff\xff\xff\xff\xff",
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
^~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/cxgbe/cxgbe_flow.c:893:52: error: initializer-string for arr=
ay
of =E2=80=98unsigned char=E2=80=99 truncates NUL terminator but destination=
 lacks =E2=80=98nonstring=E2=80=99
attribute (7 chars into 6 available)
[-Werror=3Dunterminated-string-initialization]
=C2=A0 893 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 .hdr.src_addr.addr_bytes =3D
"\x00\x00\x00\x00\x00\x00",
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
^~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/cxgbe/cxgbe_flow.c:922:41: error: initializer-string for arr=
ay
of =E2=80=98unsigned char=E2=80=99 truncates NUL terminator but destination=
 lacks =E2=80=98nonstring=E2=80=99
attribute (17 chars into 16 available)
[-Werror=3Dunterminated-string-initialization]
=C2=A0 922 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0
"\xff\xff\xff\xff\xff\xff\xff\xff"
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/cxgbe/cxgbe_flow.c:925:41: error: initializer-string for arr=
ay
of =E2=80=98unsigned char=E2=80=99 truncates NUL terminator but destination=
 lacks =E2=80=98nonstring=E2=80=99
attribute (17 chars into 16 available)
[-Werror=3Dunterminated-string-initialization]
=C2=A0 925 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0
"\xff\xff\xff\xff\xff\xff\xff\xff"
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
[1259/3040] Compiling C object
drivers/libtmp_rte_net_dpaa.a.p/net_dpaa_dpaa_rxtx.c.o
ninja: build stopped: subcommand failed.

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17550533670.DE985c4.4141203
Date: Wed, 13 Aug 2025 04:49:27 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

<html>
    <head>
      <base href=3D"https://bugs.dpdk.org/">
    </head>
    <body><table border=3D"1" cellspacing=3D"0" cellpadding=3D"8" class=3D"=
bz_new_table">
        <tr>
          <th>Bug ID</th>
          <td><a class=3D"bz_bug_link=20
          bz_status_UNCONFIRMED "
   title=3D"UNCONFIRMED - [dpdk 23.11.5-rc1] drivers/net/cxgbe meson build =
failed on Fedora42 with gcc15.0.1"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1771">1771</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>[dpdk 23.11.5-rc1] drivers/net/cxgbe meson build failed on Fe=
dora42 with gcc15.0.1
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>23.11
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>All
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>normal
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>core
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>daxuex.gao&#64;intel.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">The issue occurs on the new Fedora=
 42 OS, while there is no problem on the old
Fedora 41 OS.

[DPDK version]
commit 96ae1d570472620165484776205fe957294b9597 (HEAD, tag: v23.11.5-rc1,
origin/23.11)
Author: Xueming Li &lt;<a href=3D"mailto:xuemingl&#64;nvidia.com">xuemingl&=
#64;nvidia.com</a>&gt;
Date: =C2=A0 Mon Aug 11 21:33:43 2025 +0800=C2=A0 =C2=A0=20
version: 23.11.5-rc1=C2=A0 =C2=A0=20
Signed-off-by: Xueming Li &lt;<a href=3D"mailto:xuemingl&#64;nvidia.com">xu=
emingl&#64;nvidia.com</a>&gt;

[OS version]
OS: Fedora Linux 42 (Server Edition)/Linux 6.14.0-63.fc42.x86_64
Compiler: gcc (GCC) 15.0.1 20250329 (Red Hat 15.0.1-0)

[Test Setup]
# CC=3Dgcc meson --werror -Denable_kmods=3DTrue -Dlibdir=3Dlib -Dexamples=
=3Dall
--default-library=3Dstatic x86_64-native-linuxapp-gcc
# ninja -j 10 -C x86_64-native-linuxapp-gcc

[Log]
Found ninja-1.10.2.git.kitware.jobserver-1 at /usr/local/bin/ninja
Cleaning... 0 files.
[1242/3040] Compiling C object
drivers/libtmp_rte_net_cxgbe.a.p/net_cxgbe_cxgbe_flow.c.o
FAILED: drivers/libtmp_rte_net_cxgbe.a.p/net_cxgbe_cxgbe_flow.c.o
cc -Idrivers/libtmp_rte_net_cxgbe.a.p -Idrivers -I../drivers
-Idrivers/net/cxgbe -I../drivers/net/cxgbe -I../drivers/net/cxgbe/base
-Ilib/ethdev -I../lib/ethdev -I. -I.. -Iconfig -I../config -Ilib/eal/include
-I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include
-Ilib/eal/x86/include -I../lib/eal/x86/include -Ilib/eal/common
-I../lib/eal/common -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs
-Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics -Ilib/telemetry
-I../lib/telemetry -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf
-Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring -Ilib/meter
-I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci
-I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev
-I../drivers/bus/vdev -fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64=
 -Wall
-Winvalid-pch -Wextra -Werror -std=3Dc11 -O3 -include rte_config.h -Wcast-q=
ual
-Wdeprecated -Wformat -Wformat-nonliteral -Wformat-security
-Wmissing-declarations -Wmissing-prototypes -Wnested-externs
-Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes
-Wundef -Wwrite-strings -Wno-address-of-packed-member -Wno-packed-not-align=
ed
-Wno-missing-field-initializers -fzero-init-padding-bits=3Dall
-Wno-zero-length-bounds -D_GNU_SOURCE -fPIC -march=3Dnative -mrtm
-DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
-DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.cxgbe -MD -MQ
drivers/libtmp_rte_net_cxgbe.a.p/net_cxgbe_cxgbe_flow.c.o -MF
drivers/libtmp_rte_net_cxgbe.a.p/net_cxgbe_cxgbe_flow.c.o.d -o
drivers/libtmp_rte_net_cxgbe.a.p/net_cxgbe_cxgbe_flow.c.o -c
../drivers/net/cxgbe/cxgbe_flow.c
../drivers/net/cxgbe/cxgbe_flow.c:892:52: error: initializer-string for arr=
ay
of =E2=80=98unsigned char=E2=80=99 truncates NUL terminator but destination=
 lacks =E2=80=98nonstring=E2=80=99
attribute (7 chars into 6 available)
[-Werror=3Dunterminated-string-initialization]
=C2=A0 892 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 .hdr.dst_addr.addr_bytes =3D
&quot;\xff\xff\xff\xff\xff\xff&quot;,
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
^~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/cxgbe/cxgbe_flow.c:893:52: error: initializer-string for arr=
ay
of =E2=80=98unsigned char=E2=80=99 truncates NUL terminator but destination=
 lacks =E2=80=98nonstring=E2=80=99
attribute (7 chars into 6 available)
[-Werror=3Dunterminated-string-initialization]
=C2=A0 893 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 .hdr.src_addr.addr_bytes =3D
&quot;\x00\x00\x00\x00\x00\x00&quot;,
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=20
^~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/cxgbe/cxgbe_flow.c:922:41: error: initializer-string for arr=
ay
of =E2=80=98unsigned char=E2=80=99 truncates NUL terminator but destination=
 lacks =E2=80=98nonstring=E2=80=99
attribute (17 chars into 16 available)
[-Werror=3Dunterminated-string-initialization]
=C2=A0 922 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0
&quot;\xff\xff\xff\xff\xff\xff\xff\xff&quot;
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/cxgbe/cxgbe_flow.c:925:41: error: initializer-string for arr=
ay
of =E2=80=98unsigned char=E2=80=99 truncates NUL terminator but destination=
 lacks =E2=80=98nonstring=E2=80=99
attribute (17 chars into 16 available)
[-Werror=3Dunterminated-string-initialization]
=C2=A0 925 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0
&quot;\xff\xff\xff\xff\xff\xff\xff\xff&quot;
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
[1259/3040] Compiling C object
drivers/libtmp_rte_net_dpaa.a.p/net_dpaa_dpaa_rxtx.c.o
ninja: build stopped: subcommand failed.
          </pre>
        </div>
      </p>


      <hr>
      <span>You are receiving this mail because:</span>

      <ul>
          <li>You are the assignee for the bug.</li>
      </ul>
      <div itemscope itemtype=3D"http://schema.org/EmailMessage">
        <div itemprop=3D"action" itemscope itemtype=3D"http://schema.org/Vi=
ewAction">
=20=20=20=20=20=20=20=20=20=20
          <link itemprop=3D"url" href=3D"https://bugs.dpdk.org/show_bug.cgi=
?id=3D1771">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17550533670.DE985c4.4141203--
