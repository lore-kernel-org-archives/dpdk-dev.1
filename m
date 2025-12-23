Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFB1E6FE2B
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 20:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 385B940265;
	Tue, 23 Dec 2025 21:14:53 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 251FC4025A
 for <dev@dpdk.org>; Tue, 23 Dec 2025 21:14:52 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 09E98470CE; Tue, 23 Dec 2025 21:14:52 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/meson Bug 1858] [dpdk23.11.5] Meson build failed on Fedora 43
Date: Tue, 23 Dec 2025 20:14:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: meson
X-Bugzilla-Version: 23.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mlabrecque@iol.unh.edu
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1858-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1858

            Bug ID: 1858
           Summary: [dpdk23.11.5] Meson build failed on Fedora 43
           Product: DPDK
           Version: 23.11
          Hardware: All
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: meson
          Assignee: dev@dpdk.org
          Reporter: mlabrecque@iol.unh.edu
  Target Milestone: ---

[DPDK Version]
dpdk 23.11.5 LTS

[OS version]
Fedora Linux 43 (Container Image)/6.17.12-300.fc43.x86_64 run via Podman
GCC15.2.1

[Test Setup]
# meson setup build
# ninja
# meson install

[Error log]
09:10:22  FAILED: [code=3D1]
drivers/a715181@@tmp_rte_net_dpaa2@sta/net_dpaa2_dpaa2_flow.c.o=20
09:10:22  ccache cc -Idrivers/a715181@@tmp_rte_net_dpaa2@sta -Idrivers
-I../drivers -Idrivers/net/dpaa2 -I../drivers/net/dpaa2
-I../drivers/net/dpaa2/base -I../drivers/net/dpaa2/mc -Ilib/ethdev
-I../lib/ethdev -I. -I../ -Iconfig -I../config -Ilib/eal/include
-I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include
-Ilib/eal/x86/include -I../lib/eal/x86/include -Ilib/eal/common
-I../lib/eal/common -Ilib/eal -I../lib/eal -Ilib/kvargs -I../lib/kvargs
-Ilib/log -I../lib/log -Ilib/telemetry/../metrics -I../lib/telemetry/../met=
rics
-Ilib/telemetry -I../lib/telemetry -Ilib/net -I../lib/net -Ilib/mbuf
-I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring -I../lib/ring
-Ilib/meter -I../lib/meter -Idrivers/bus/pci -I../drivers/bus/pci
-I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci -Idrivers/bus/vdev
-I../drivers/bus/vdev -Idrivers/mempool/dpaa2 -I../drivers/mempool/dpaa2
-Idrivers/bus/fslmc -I../drivers/bus/fslmc -I../drivers/bus/fslmc/mc
-I../drivers/bus/fslmc/qbman/include -I../drivers/bus/fslmc/portal
-Idrivers/common/dpaax -I../drivers/common/dpaax
-I../drivers/common/dpaax/caamflib -Ilib/eventdev -I../lib/eventdev -Ilib/h=
ash
-I../lib/hash -Ilib/rcu -I../lib/rcu -Ilib/timer -I../lib/timer -Ilib/crypt=
odev
-I../lib/cryptodev -Ilib/dmadev -I../lib/dmadev -fdiagnostics-color=3Dalways
-pipe -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Werror -std=3Dc=
11 -O3
-include rte_config.h -Wcast-qual -Wdeprecated -Wformat -Wformat-nonliteral
-Wformat-security -Wmissing-declarations -Wmissing-prototypes -Wnested-exte=
rns
-Wold-style-definition -Wpointer-arith -Wsign-compare -Wstrict-prototypes
-Wundef -Wwrite-strings -Wno-address-of-packed-member -Wno-packed-not-align=
ed
-Wno-missing-field-initializers -fzero-init-padding-bits=3Dall
-Wno-zero-length-bounds -D_GNU_SOURCE -fPIC -march=3Dnative -mrtm
-DALLOW_EXPERIMENTAL_API -DALLOW_INTERNAL_API -Wno-format-truncation
-DRTE_LOG_DEFAULT_LOGTYPE=3Dpmd.net.dpaa2 -MD -MQ
'drivers/a715181@@tmp_rte_net_dpaa2@sta/net_dpaa2_dpaa2_flow.c.o' -MF
'drivers/a715181@@tmp_rte_net_dpaa2@sta/net_dpaa2_dpaa2_flow.c.o.d' -o
'drivers/a715181@@tmp_rte_net_dpaa2@sta/net_dpaa2_dpaa2_flow.c.o' -c
../drivers/net/dpaa2/dpaa2_flow.c
09:10:22  ../drivers/net/dpaa2/dpaa2_flow.c:103:36: error: initializer-stri=
ng
for array of 'unsigned char' truncates NUL terminator but destination lacks
'nonstring' attribute (7 chars into 6 available)
[-Werror=3Dunterminated-string-initialization]
09:10:22    103 |         .hdr.dst_addr.addr_bytes =3D
"\xff\xff\xff\xff\xff\xff",
09:10:22        |                                    ^~~~~~~~~~~~~~~~~~~~~~=
~~~~
09:10:22  ../drivers/net/dpaa2/dpaa2_flow.c:104:36: error: initializer-stri=
ng
for array of 'unsigned char' truncates NUL terminator but destination lacks
'nonstring' attribute (7 chars into 6 available)
[-Werror=3Dunterminated-string-initialization]
09:10:22    104 |         .hdr.src_addr.addr_bytes =3D
"\xff\xff\xff\xff\xff\xff",
09:10:22        |                                    ^~~~~~~~~~~~~~~~~~~~~~=
~~~~
09:10:22  ../drivers/net/dpaa2/dpaa2_flow.c:121:25: error: initializer-stri=
ng
for array of 'unsigned char' truncates NUL terminator but destination lacks
'nonstring' attribute (17 chars into 16 available)
[-Werror=3Dunterminated-string-initialization]
09:10:22    121 |                         "\xff\xff\xff\xff\xff\xff\xff\xff"
09:10:22        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
09:10:22  ../drivers/net/dpaa2/dpaa2_flow.c:124:25: error: initializer-stri=
ng
for array of 'unsigned char' truncates NUL terminator but destination lacks
'nonstring' attribute (17 chars into 16 available)
[-Werror=3Dunterminated-string-initialization]
09:10:22    124 |                         "\xff\xff\xff\xff\xff\xff\xff\xff"
09:10:22        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--=20
You are receiving this mail because:
You are the assignee for the bug.=
