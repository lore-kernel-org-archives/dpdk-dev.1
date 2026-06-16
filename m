Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F076CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 02:18:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A880940285;
	Tue, 16 Jun 2026 04:18:30 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 154A14013F
 for <dev@dpdk.org>; Tue, 16 Jun 2026 04:18:29 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id F35094B6A3; Tue, 16 Jun 2026 04:18:28 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1957] [dpdk-26.07] ABI testing
 dpdk26.07rc1+dpdk25.11 shows error: "undefined symbol:
 rte_flow_dynf_metadata_offs, version EXPERIMENTAL"
Date: Tue, 16 Jun 2026 02:18:29 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
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
Message-ID: <bug-1957-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1957

            Bug ID: 1957
           Summary: [dpdk-26.07] ABI testing dpdk26.07rc1+dpdk25.11 shows
                    error: "undefined symbol: rte_flow_dynf_metadata_offs,
                    version EXPERIMENTAL"
           Product: DPDK
           Version: 26.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: yux.jiang@intel.com
  Target Milestone: ---

Environment
-----------
DPDK version:=20=20
[DPDK 26.07rc1]=20
commit c429b06df56788795f886eca748420e2248da784 (HEAD -> main, origin/main,
origin/HEAD)
Author: Thomas Monjalon <thomas@monjalon.net>
Date:   Thu Jun 11 04:27:32 2026 +0200=20=20=20=20
version: 26.07-rc1=20=20=20=20
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>

Steps to reproduce
------------------

1, Build latest dpdk(dpdk26.07rc1)
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

3, start testpmd
root@icx-jy-abi-d81:~/dpdk# x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l =
1-4
-n 4 -a 0000:31:00.0 --file-prefix=3Ddpdk_14651_20260325102153  -d
/root/shared_lib_dpdk   -- -i

Show the output from the previous commands.
-------------------------------------------
root@icx-jy-abi-d81:~/jaccy/dpdk_25.11#
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-4 -n 4 -a 0000:31:00.0
--file-prefix=3Ddpdk_14651_20260325102153  -d /root/shared_lib_dpdk   -- -i
x86_64-native-linuxapp-gcc/app/dpdk-testpmd: symbol lookup error:
x86_64-native-linuxapp-gcc/app/dpdk-testpmd: undefined symbol:
rte_flow_dynf_metadata_offs, version EXPERIMENTAL

Expected Result
---------------
launch ok


Is this issue a regression: Y
-----------------------------

Version the regression was introduced:  commit 4ee2f5c1ced

commit 4ee2f5c1cedf9ee7f39afa667f71b07f4004ba5c (HEAD ->
4ee2f5c1ce-flowmetadata)
Author: Dariusz Sosnowski <dsosnowski@nvidia.com>
Date:   Fri May 29 09:28:53 2026 +0200

    ethdev: promote flow metadata API to stable

    Following experimental symbols related to flow metadata
    were added in v19.11:

    - rte_flow_dynf_metadata_register
    - rte_flow_dynf_metadata_offs
    - rte_flow_dynf_metadata_mask

    Type of rte_flow_dynf_metadata_offs was changed from int to int32_t
    in v20.05 release.
    There were no changes to these symbols since then.

    This patch promotes these symbols and removes __rte_experimental
    from the following inline functions:

    - rte_flow_dynf_metadata_avail
    - rte_flow_dynf_metadata_get
    - rte_flow_dynf_metadata_set

    All these symbols and functions will be used by netdev-doca
    backend in Open vSwitch [1].
    Stabilizing these symbols is required by current OVS policy
    to remove the need for ALLOW_EXPERIMENTAL_API [2].

    [1]:
https://patchwork.ozlabs.org/project/openvswitch/list/?series=3D504726&stat=
e=3D%2A&archive=3Dboth
    [2]: https://mail.openvswitch.org/pipermail/ovs-dev/2026-May/432066.html

    Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

--=20
You are receiving this mail because:
You are the assignee for the bug.=
