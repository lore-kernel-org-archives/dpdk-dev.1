Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD58EC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 14:10:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B25BD402CA;
	Mon, 12 May 2025 16:10:41 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B081A402C9
 for <dev@dpdk.org>; Mon, 12 May 2025 16:10:40 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A1AF34672A; Mon, 12 May 2025 16:10:40 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/eventdev Bug 1705] DPDK fails to compile on Ubuntu 24.04 with
 BullseyeCoverage
Date: Mon, 12 May 2025 14:10:40 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: eventdev
X-Bugzilla-Version: 25.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: alaaduh@nvidia.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1705-3@http.bugs.dpdk.org/>
Content-Type: multipart/alternative; boundary=17470590400.bF1CA57.25635
Content-Transfer-Encoding: 7bit
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


--17470590400.bF1CA57.25635
Date: Mon, 12 May 2025 16:10:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All

https://bugs.dpdk.org/show_bug.cgi?id=3D1705

            Bug ID: 1705
           Summary: DPDK fails to compile on Ubuntu 24.04 with
                    BullseyeCoverage
           Product: DPDK
           Version: 25.03
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: eventdev
          Assignee: dev@dpdk.org
          Reporter: alaaduh@nvidia.com
  Target Milestone: ---

$ export PATH=3D/auto/sw_tools/Bullseye/linux/linux64/9.11.7/amd64/bin:$PATH
$ cov01 -1
$ meson build-meson --werror
-Dexamples=3Dethtool,ip_fragmentation,l2fwd-crypto,l3fwd-power,link_status_=
interrupt,multi_process/client_server_mp/mp_client,multi_process/client_ser=
ver_mp/mp_server,multi_process/simple_mp,multi_process/symmetric_mp,vdpa
-Dprefix=3D/download/dpdk/install -Dlibdir=3Dlib64
-Denable_drivers=3D*/mlx5,mempool/bucket,mempool/ring,mempool/stack,net/fai=
lsafe,net/mlx4,net/netvsc,bus/vmbus,net/tap,net/vdev_netvsc,crypto/openssl,=
*/virtio*,bus/auxiliary
-Dc_args=3D'-Wimplicit-fallthrough=3D0' && ninja -C build-meson install


Results=20

[880/1180] Compiling C object
app/dpdk-test-eventdev.p/test-eventdev_test_pipeline_queue.c.o
FAILED: app/dpdk-test-eventdev.p/test-eventdev_test_pipeline_queue.c.o=20
ccache cc -Iapp/dpdk-test-eventdev.p -Iapp -I../app -Ilib/eventdev
-I../lib/eventdev -I. -I.. -Iconfig -I../config -Ilib/eal/include
-I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include
-Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux
-Ilib/eal/common -I../lib/eal/common -Ilib/eal -I../lib/eal -Ilib/kvargs
-I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics
-Ilib/telemetry -I../lib/telemetry -Ilib/ring -I../lib/ring -Ilib/ethdev
-I../lib/ethdev -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempo=
ol
-I../lib/mempool -Ilib/meter -I../lib/meter -Ilib/hash -I../lib/hash -Ilib/=
rcu
-I../lib/rcu -Ilib/timer -I../lib/timer -Ilib/cryptodev -I../lib/cryptodev
-Ilib/dmadev -I../lib/dmadev -I/usr/include/x86_64-linux-gnu
-fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -=
Wextra
-Werror -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated
-Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations
-Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith
-Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings
-Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE
-Wimplicit-fallthrough=3D0 -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -=
Wno-vla
-MD -MQ app/dpdk-test-eventdev.p/test-eventdev_test_pipeline_queue.c.o -MF
app/dpdk-test-eventdev.p/test-eventdev_test_pipeline_queue.c.o.d -o
app/dpdk-test-eventdev.p/test-eventdev_test_pipeline_queue.c.o -c
../app/test-eventdev/test_pipeline_queue.c
BullseyeCoverage Compile 9.6.10 Linux-x64 License 30120=20
Copyright (c) Bullseye Testing Technology
../app/test-eventdev/test_pipeline_queue.c: In function
=E2=80=98pipeline_queue_worker_single_stage_burst_fwd_vector=E2=80=99:
../app/test-eventdev/test_pipeline_queue.c:250:38: error: writing 1 byte in=
to a
region of size 0 [-Werror=3Dstringop-overflow=3D]
  250 |                         ev[i].queue_id =3D tx_queue[ev[i].vec->port=
];
      |                         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
../app/test-eventdev/test_pipeline_queue.c:235:30: note: at offset 277 into
destination object =E2=80=98ev=E2=80=99 of size 272
  235 |         PIPELINE_WORKER_SINGLE_STAGE_BURST_INIT;
      |                              ^~

--=20
You are receiving this mail because:
You are the assignee for the bug.=

--17470590400.bF1CA57.25635
Date: Mon, 12 May 2025 16:10:40 +0200
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: http://bugs.dpdk.org/
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
   title=3D"UNCONFIRMED - DPDK fails to compile on Ubuntu 24.04 with Bullse=
yeCoverage"
   href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1705">1705</a>
          </td>
        </tr>

        <tr>
          <th>Summary</th>
          <td>DPDK fails to compile on Ubuntu 24.04 with BullseyeCoverage
          </td>
        </tr>

        <tr>
          <th>Product</th>
          <td>DPDK
          </td>
        </tr>

        <tr>
          <th>Version</th>
          <td>25.03
          </td>
        </tr>

        <tr>
          <th>Hardware</th>
          <td>x86
          </td>
        </tr>

        <tr>
          <th>OS</th>
          <td>Linux
          </td>
        </tr>

        <tr>
          <th>Status</th>
          <td>UNCONFIRMED
          </td>
        </tr>

        <tr>
          <th>Severity</th>
          <td>critical
          </td>
        </tr>

        <tr>
          <th>Priority</th>
          <td>Normal
          </td>
        </tr>

        <tr>
          <th>Component</th>
          <td>eventdev
          </td>
        </tr>

        <tr>
          <th>Assignee</th>
          <td>dev&#64;dpdk.org
          </td>
        </tr>

        <tr>
          <th>Reporter</th>
          <td>alaaduh&#64;nvidia.com
          </td>
        </tr>

        <tr>
          <th>Target Milestone</th>
          <td>---
          </td>
        </tr></table>
      <p>
        <div class=3D"bz_comment_block">
          <pre class=3D"bz_comment_text">$ export PATH=3D/auto/sw_tools/Bul=
lseye/linux/linux64/9.11.7/amd64/bin:$PATH
$ cov01 -1
$ meson build-meson --werror
-Dexamples=3Dethtool,ip_fragmentation,l2fwd-crypto,l3fwd-power,link_status_=
interrupt,multi_process/client_server_mp/mp_client,multi_process/client_ser=
ver_mp/mp_server,multi_process/simple_mp,multi_process/symmetric_mp,vdpa
-Dprefix=3D/download/dpdk/install -Dlibdir=3Dlib64
-Denable_drivers=3D*/mlx5,mempool/bucket,mempool/ring,mempool/stack,net/fai=
lsafe,net/mlx4,net/netvsc,bus/vmbus,net/tap,net/vdev_netvsc,crypto/openssl,=
*/virtio*,bus/auxiliary
-Dc_args=3D'-Wimplicit-fallthrough=3D0' &amp;&amp; ninja -C build-meson ins=
tall


Results=20

[880/1180] Compiling C object
app/dpdk-test-eventdev.p/test-eventdev_test_pipeline_queue.c.o
FAILED: app/dpdk-test-eventdev.p/test-eventdev_test_pipeline_queue.c.o=20
ccache cc -Iapp/dpdk-test-eventdev.p -Iapp -I../app -Ilib/eventdev
-I../lib/eventdev -I. -I.. -Iconfig -I../config -Ilib/eal/include
-I../lib/eal/include -Ilib/eal/linux/include -I../lib/eal/linux/include
-Ilib/eal/x86/include -I../lib/eal/x86/include -I../kernel/linux
-Ilib/eal/common -I../lib/eal/common -Ilib/eal -I../lib/eal -Ilib/kvargs
-I../lib/kvargs -Ilib/log -I../lib/log -Ilib/metrics -I../lib/metrics
-Ilib/telemetry -I../lib/telemetry -Ilib/ring -I../lib/ring -Ilib/ethdev
-I../lib/ethdev -Ilib/net -I../lib/net -Ilib/mbuf -I../lib/mbuf -Ilib/mempo=
ol
-I../lib/mempool -Ilib/meter -I../lib/meter -Ilib/hash -I../lib/hash -Ilib/=
rcu
-I../lib/rcu -Ilib/timer -I../lib/timer -Ilib/cryptodev -I../lib/cryptodev
-Ilib/dmadev -I../lib/dmadev -I/usr/include/x86_64-linux-gnu
-fdiagnostics-color=3Dalways -D_FILE_OFFSET_BITS=3D64 -Wall -Winvalid-pch -=
Wextra
-Werror -std=3Dc11 -O3 -include rte_config.h -Wvla -Wcast-qual -Wdeprecated
-Wformat -Wformat-nonliteral -Wformat-security -Wmissing-declarations
-Wmissing-prototypes -Wnested-externs -Wold-style-definition -Wpointer-arith
-Wsign-compare -Wstrict-prototypes -Wundef -Wwrite-strings
-Wno-packed-not-aligned -Wno-missing-field-initializers -D_GNU_SOURCE
-Wimplicit-fallthrough=3D0 -march=3Dnative -mrtm -DALLOW_EXPERIMENTAL_API -=
Wno-vla
-MD -MQ app/dpdk-test-eventdev.p/test-eventdev_test_pipeline_queue.c.o -MF
app/dpdk-test-eventdev.p/test-eventdev_test_pipeline_queue.c.o.d -o
app/dpdk-test-eventdev.p/test-eventdev_test_pipeline_queue.c.o -c
../app/test-eventdev/test_pipeline_queue.c
BullseyeCoverage Compile 9.6.10 Linux-x64 License 30120=20
Copyright (c) Bullseye Testing Technology
../app/test-eventdev/test_pipeline_queue.c: In function
=E2=80=98pipeline_queue_worker_single_stage_burst_fwd_vector=E2=80=99:
../app/test-eventdev/test_pipeline_queue.c:250:38: error: writing 1 byte in=
to a
region of size 0 [-Werror=3Dstringop-overflow=3D]
  250 |                         ev[i].queue_id =3D tx_queue[ev[i].vec-&gt;p=
ort];
      |                         ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
../app/test-eventdev/test_pipeline_queue.c:235:30: note: at offset 277 into
destination object =E2=80=98ev=E2=80=99 of size 272
  235 |         PIPELINE_WORKER_SINGLE_STAGE_BURST_INIT;
      |                              ^~
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
?id=3D1705">
          <meta itemprop=3D"name" content=3D"View bug">
        </div>
        <meta itemprop=3D"description" content=3D"Bugzilla bug update notif=
ication">
      </div>
    </body>
</html>=

--17470590400.bF1CA57.25635--
