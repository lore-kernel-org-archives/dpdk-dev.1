Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F42C43458
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Jul 2026 09:43:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4081940289;
	Tue, 14 Jul 2026 11:43:32 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 2EBBF4026E
 for <dev@dpdk.org>; Tue, 14 Jul 2026 11:43:31 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 009644B890; Tue, 14 Jul 2026 11:43:30 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1968] [dpdk-26.07] ABI testing dpdk26.07+dpdk25.11
 meson_tests/power_kvm_vm_autotest: TEST FAILED
Date: Tue, 14 Jul 2026 09:43:30 +0000
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
Message-ID: <bug-1968-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1968

            Bug ID: 1968
           Summary: [dpdk-26.07] ABI testing dpdk26.07+dpdk25.11
                    meson_tests/power_kvm_vm_autotest: TEST FAILED
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
meson test -C x86_64-native-linuxapp-gcc power_kvm_vm_autotest -t 24
--num-processes 20 --test-args '-l 1-8 -d /root/shared_lib_dpdk'=20

Show the output from the previous commands.
-------------------------------------------
FAIL


Expected Result
---------------
Test OK


Is this issue a regression: Y
-----------------------------
0cec08732d (3-0cec08732d-f) power: validate lcore ID in cpufreq framework


Need fix or not? pls confirm
----------------------------

--=20
You are receiving this mail because:
You are the assignee for the bug.=
