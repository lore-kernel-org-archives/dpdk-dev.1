Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D908F94CBC
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 02:23:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F40AE40272;
	Wed, 22 Apr 2026 04:23:52 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 381BE40144
 for <dev@dpdk.org>; Wed, 22 Apr 2026 04:23:52 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 1B2754B060; Wed, 22 Apr 2026 04:23:52 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1937] [dpdk23.11.7-rc1] DPDK build failed with
 clang21.1.8 on Fedora43
Date: Wed, 22 Apr 2026 02:23:51 +0000
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
Message-ID: <bug-1937-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1937

            Bug ID: 1937
           Summary: [dpdk23.11.7-rc1] DPDK build failed with clang21.1.8
                    on Fedora43
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

[Environment]
DPDK version:=20
commit f919fadc148d11f2ef68def4b7638503323515b2 (HEAD, tag: v23.11.7-rc1,
origin/23.11)
Author: Shani Peretz <shperetz@nvidia.com>
Date:   Tue Apr 21 09:24:45 2026 +0300

    version: 23.11.7-rc1

    Signed-off-by: Shani Peretz <shperetz@nvidia.com>

OS:  Fedora43-64/6.17.1-300.fc43.x86_64
Compiler: clang 21.1.8 (Fedora 21.1.8-4.fc43)

[Test Setup]
# build cmd:=20
CC=3Dclang meson --werror -Dlibdir=3Dlib -Dexamples=3Dall --default-library=
=3Dstatic
x86_64-native-linuxapp-clang

ninja  -C x86_64-native-linuxapp-clang/

[Output]
FAILED: app/dpdk-test.p/test_test_event_dma_adapter.c.o=20
clang -Iapp/dpdk-test.p -Iapp -I../app -Ilib/cmdline -I../lib/cmdline -I. -=
I..
-Iconfig -I../config -Ilib/eal/include -I../lib/eal/include
-Ilib/eal/linux/include -I../lib/eal/linux/include -Ilib/eal/x86/include
-I../lib/eal/x86/include -Ilib/eal/common -I../lib/eal/common -Ilib/eal
-I../lib/eal -Ilib/kvargs -I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metr=
ics
-I../lib/metrics -Ilib/telemetry -I../lib/telemetry -Ilib/net -I../lib/net
-Ilib/mbuf -I../lib/mbuf -Ilib/mempool -I../lib/mempool -Ilib/ring
-I../lib/ring -Idrivers/net/ring -I../drivers/net/ring -Ilib/ethdev
-I../lib/ethdev -Ilib/meter -I../lib/meter -Idrivers/bus/pci
-I../drivers/bus/pci -I../drivers/bus/pci/linux -Ilib/pci -I../lib/pci
-Idrivers/bus/vdev -I../drivers/bus/vdev -Ilib/acl -I../lib/acl -Ilib/hash
-I../lib/hash -Ilib/rcu -I../lib/rcu -Ilib/bitratestats -I../lib/bitratesta=
ts
-Ilib/bpf -I../lib/bpf -Ilib/compressdev -I../lib/compressdev -Ilib/cryptod=
ev
-I../lib/cryptodev -Ilib/security -I../lib/security -Ilib/dispatcher
-I../lib/dispatcher -Ilib/eventdev -I../lib/eventdev -Ilib/timer -I../lib/t=
imer
-Ilib/dmadev -I../lib/dmadev -Ilib/distributor -I../lib/distributor -Ilib/e=
fd
-I../lib/efd -Ilib/fib -I../lib/fib -Ilib/rib -I../lib/rib -Ilib/table
-I../lib/table -Ilib/port -I../lib/port -Ilib/sched -I../lib/sched
-Ilib/ip_frag -I../lib/ip_frag -Ilib/lpm -I../lib/lpm -Ilib/graph
-I../lib/graph -Ilib/pcapng -I../lib/pcapng -Ilib/ipsec -I../lib/ipsec
-Ilib/latencystats -I../lib/latencystats -Idrivers/net/bonding
-I../drivers/net/bonding -Idrivers/net/null -I../drivers/net/null -Ilib/mem=
ber
-I../lib/member -Ilib/pdcp -I../lib/pdcp -Ilib/reorder -I../lib/reorder
-Ilib/pdump -I../lib/pdump -Ilib/power -I../lib/power -Ilib/rawdev
-I../lib/rawdev -Ilib/stack -I../lib/stack -Ilib/pipeline -I../lib/pipeline
-Idrivers/crypto/scheduler -I../drivers/crypto/scheduler
-fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -=
Wextra
-Werror -std=3Dc11 -O3 -include rte_config.h -Wcast-qual -Wdeprecated -Wfor=
mat
-Wformat-nonliteral -Wformat-security -Wmissing-declarations
-Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith
-Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings
-Wno-address-of-packed-member -Wno-missing-field-initializers -D_GNU_SOURCE
-DWITH_GZFILEOP -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API
-Wno-format-truncation -fno-strict-aliasing -DALLOW_INTERNAL_API -MD -MQ
app/dpdk-test.p/test_test_event_dma_adapter.c.o -MF
app/dpdk-test.p/test_test_event_dma_adapter.c.o.d -o
app/dpdk-test.p/test_test_event_dma_adapter.c.o -c
../app/test/test_event_dma_adapter.c
../app/test/test_event_dma_adapter.c:594:32: error: variable 'event' is
uninitialized when passed as a const pointer argument here
[-Werror,-Wuninitialized-const-pointer]
  594 |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
TEST_DMA_VCHAN_ID, &event);
      |=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
        ^~~~~
1 error generated.
[2526/2823] Compiling C object app/dpdk-test.p/test_test_efd_perf.c.o
[2527/2823] Compiling C object app/dpdk-test.p/test_test_ethdev_link.c.o
[2528/2823] Compiling C object app/dpdk-test.p/test_test_distributor.c.o
[2529/2823] Compiling C object
app/dpdk-test.p/test_test_event_crypto_adapter.c.o
[2530/2823] Compiling C object
app/dpdk-test.p/test_test_event_eth_tx_adapter.c.o
[2531/2823] Compiling C object app/dpdk-test.p/test_test_event_ring.c.o
[2532/2823] Compiling C object
app/dpdk-test.p/test_test_event_eth_rx_adapter.c.o
[2533/2823] Compiling C object app/dpdk-test.p/test_test_cryptodev.c.o
[2534/2823] Compiling C object
app/dpdk-test.p/test_test_event_timer_adapter.c.o

[Expected Result]
Build Passed

[Regression]
Is this issue a regression: (Y/N)N
This is a new issue discovered on Fedora 43 OS; it was not found on Fedora =
42
OS.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
