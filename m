Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CBAC4453C
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 17:58:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E014D40270;
	Wed, 22 Jul 2026 19:58:26 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id AF7CC4014F
 for <dev@dpdk.org>; Wed, 22 Jul 2026 19:58:25 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6FEC34B923; Wed, 22 Jul 2026 19:58:25 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/other Bug 1972] telemetry_all test times out
Date: Wed, 22 Jul 2026 17:58:25 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: other
X-Bugzilla-Version: 26.07
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
Message-ID: <bug-1972-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1972

            Bug ID: 1972
           Summary: telemetry_all test times out
           Product: DPDK
           Version: 26.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: other
          Assignee: dev@dpdk.org
          Reporter: stephen@networkplumber.org
  Target Milestone: ---

Running fast-tests on 26.07 has one failure.
Running test standalone, and it regularly takes over 10 seconds.

114/114 fast-tests - DPDK:telemetry_all=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
TIMEOUT        10.01s   killed by signal 15 SIGTERM
>>>
>>> UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:=
print_stacktrace=3D1
>>> ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1
>>> MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:p=
rint_stacktrace=3D1
>>> MESON_TEST_ITERATION=3D1 MALLOC_PERTURB_=3D247
>>> /home/shemminger/DPDK/bpf/app/test/suites/test_telemetry.sh app/dpdk-te=
st
>>> --no-huge -m 2048 --vdev=3Dcrypto_null0 --vdev=3Ddma_skeleton0
>>> --vdev=3Devent_skeleton0 --vdev=3Dnet_null0 --vdev=3Drawdev_skeleton0 -a
>>> 0000:00:00.0


Ok:                110=20
Fail:              0=20=20=20
Skipped:           3=20=20=20
Timeout:           1=20=20=20

testlog.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D 151/151 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
test:         fast-tests - DPDK:telemetry_all
start time:   17:56:44
duration:     10.01s
result:       killed by signal 15 SIGTERM
command:=20=20=20=20=20
MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print=
_stacktrace=3D1
ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1
MALLOC_PERTURB_=3D175
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stacktrace=3D1
MESON_TEST_ITERATION=3D1
/home/shemminger/DPDK/main/app/test/suites/test_telemetry.sh app/dpdk-test
--no-huge -m 2048 --vdev=3Dcrypto_null0 --vdev=3Ddma_skeleton0
--vdev=3Devent_skeleton0 --vdev=3Dnet_null0 --vdev=3Drawdev_skeleton0 -a 00=
00:00:00.0
----------------------------------- stdout --------------------------------=
---
/usr/bin/jq
RTE>>
----------------------------------- stderr --------------------------------=
---
EAL: Detected CPU lcores: 32
EAL: Detected NUMA nodes: 1
EAL: Detected static linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
CRYPTODEV: Creating cryptodev crypto_null0
CRYPTODEV: Initialisation parameters - name: crypto_null0,socket id: 0, max
queue pairs: 8
SKELDMA: skeldma_probe(): Create dma_skeleton0 dmadev with lcore-id -1
SKELETON_PMD: skeleton_rawdev_probe(): Init rawdev_skeleton0 on NUMA node 0
APP: HPET is not enabled, using TSC as default timer
ETHDEV: Failed to get dcb info, ret =3D -95
ETHDEV: Failed to get flow ctrl info, ret =3D -95
ETHDEV: Operation not supported by device
ETHDEV: Failed to get device reg info: -95
ETHDEV: Rx queue 0 of device with port_id=3D0 has not been setup
ETHDEV: error: Function not implemented, error type: 1
ETHDEV: Tx queue 0 of device with port_id=3D0 has not been setup
EVENTDEV: handle_rxa_get_queue_conf() line 3846: Invalid eth Rx adapter tok=
en
EVENTDEV: handle_rxa_get_queue_stats() line 3917: Invalid eth Rx adapter to=
ken
EVENTDEV: handle_rxa_queue_stats_reset() line 3986: Invalid eth Rx adapter
token
EVENTDEV: handle_rxa_instance_get() line 4048: Invalid eth Rx adapter token
EVENTDEV: handle_rxa_stats() line 3777: Failed to get Rx adapter stats
EVENTDEV: handle_rxa_stats_reset() line 3816: Failed to reset Rx adapter st=
ats
EVTIM: EVTIMER: handle_ta_info() line 1413: Invalid timer adapter id 0
EVTIM: EVTIMER: handle_ta_stats() line 1458: Invalid timer adapter id 0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

--=20
You are receiving this mail because:
You are the assignee for the bug.=
