Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE116C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 09:35:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B243540289;
	Tue, 14 Jul 2026 11:35:01 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 7EB5F4026E
 for <dev@dpdk.org>; Tue, 14 Jul 2026 11:35:00 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 50A2F4B890; Tue, 14 Jul 2026 11:35:00 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1967] [dpdk-26.07] ABI testing dpdk26.07+dpdk25.11
 meson_tests/test_fasts vdev_autotest and devargs_autotest both failed
Date: Tue, 14 Jul 2026 09:35:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 26.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: yux.jiang@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1967-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1967

            Bug ID: 1967
           Summary: [dpdk-26.07] ABI testing dpdk26.07+dpdk25.11
                    meson_tests/test_fasts vdev_autotest and
                    devargs_autotest both failed
           Product: DPDK
           Version: 26.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: yux.jiang@intel.com
  Target Milestone: ---

Environment
-----------
DPDK version:=20=20
[DPDK 26.07rc3]=20


Steps to reproduce
------------------

1, Build latest dpdk(dpdk26.07rc3)
cd dpdk
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Dlibdir=3Dlib -Dc_args=3D-DRTE_BUILD_SHARED_LIB
--default-library=3Dshared x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc
rm -rf /root/tmp/dpdk_share_lib /root/shared_lib_dpdk
DESTDIR=3D/root/tmp/dpdk_share_lib ninja -C x86_64-native-linuxapp-gcc -j 1=
10
install
mv /root/tmp/dpdk_share_lib/usr/local/lib /root/shared_lib_dpdk
cat /root/.bashrc | grep LD_LIBRARY_PATH
sed -i 's#export LD_LIBRARY_PATH=3D.*#export
LD_LIBRARY_PATH=3D/root/shared_lib_dpdk#g' /root/.bashrc

2, copy LTS(dpdk25.11) dpdk_abi.tar.gz and build LTS dpdk
tar zxf /tmp/dpdk_abi.tar.gz -C ~
cd ~/dpdk/
rm -rf x86_64-native-linuxapp-gcc
CC=3Dgcc meson -Dlibdir=3Dlib -Dc_args=3D-DRTE_BUILD_SHARED_LIB
--default-library=3Dshared x86_64-native-linuxapp-gcc
ninja -C x86_64-native-linuxapp-gcc
rm -rf x86_64-native-linuxapp-gcc/lib
rm -rf x86_64-native-linuxapp-gcc/drivers

3, do meson test
meson test -C x86_64-native-linuxapp-gcc --suite DPDK:fast-tests
devargs_autotest vdev_autotest -t 24 --num-processes 20  --test-args '-l 1-=
8 -d
/root/shared_lib_dpdk'=20

Show the output from the previous commands.
-------------------------------------------
FAIL
root@icx-jy-abi-d81:~/dpdk# MALLOC_PERTURB_=3D132
LD_LIBRARY_PATH=3D/root/dpdk/x86_64-native-linuxapp-gcc/lib:/root/dpdk/x86_=
64-native-linuxapp-gcc/drivers:/root/shared_lib_dpdk
MESON_TEST_ITERATION=3D1 DPDK_TEST=3Dvdev_autotest
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stacktrace=3D1
MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print=
_stacktrace=3D1
ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1
/root/dpdk/x86_64-native-linuxapp-gcc/app/dpdk-test --no-huge -m 2048 -d
/root/dpdk/x86_64-native-linuxapp-gcc/drivers -l 1-8 -d /root/shared_lib_dp=
dk
EAL: Detected CPU lcores: 160
EAL: Detected NUMA nodes: 2
EAL: Detected shared linkage of DPDK
EAL: Multi-process socket /var/run/dpdk/rte/mp_socket
EAL: Selected IOVA mode 'VA'
EAL: VFIO support initialized
APP: HPET is not enabled, using TSC as default timer
RTE>>vdev_autotest
=3D=3D test vdev bus =3D=3D
Segmentation fault (core dumped)


Expected Result
---------------
Test OK


Is this issue a regression: Y
-----------------------------
devargs_autotest bad commit: d03dbd4003 bus: support multiple probe
vdev_autotest bad commit: 89127f66f5 bus: consolidate device lookup


Need fix or not? pls confirm
----------------------------

--=20
You are receiving this mail because:
You are the assignee for the bug.=
