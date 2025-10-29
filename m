Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E64CCF9E9
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 06:55:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A91A40288;
	Wed, 29 Oct 2025 07:55:30 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 790AB40281
 for <dev@dpdk.org>; Wed, 29 Oct 2025 07:55:28 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 58A8848A22; Wed, 29 Oct 2025 07:55:28 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/testpmd Bug 1815] [dpdk-25.11]
 cpfl_vf_representor_rte_flow/port_representor_probe_scan: port attach failed
Date: Wed, 29 Oct 2025 06:55:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: testpmd
X-Bugzilla-Version: 25.07
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: songx.jiale@intel.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1815-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1815

            Bug ID: 1815
           Summary: [dpdk-25.11]
                    cpfl_vf_representor_rte_flow/port_representor_probe_sc
                    an: port attach failed
           Product: DPDK
           Version: 25.07
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: testpmd
          Assignee: dev@dpdk.org
          Reporter: songx.jiale@intel.com
  Target Milestone: ---

Environment
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
dpdk-25.11.0-rc1: 39b54f2dcf44ad1f91eabc7080cd5dea763607fd
OS: Ubuntu 24.04.3 LTS/6.8.0-79-generic
Compiler:  gcc version 13.3.0
Hardware platform: Hardware platform: Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz
NIC hardware: mev
APF: Intel Corporation Device [8086:1452]
CPF: Intel Corporation Device [8086:1453]
NIC firmware:
ci-ts.release.2.0.0.11126
idpf-0.0.772

Test Setup
Steps to reproduce
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. create 2 vfs on apf
echo 2 > /sys/bus/pci/devices/0000\:15\:00.0/sriov_numvfs

2. unbind cpf
./usertools/dpdk-devbind.py -u 0000:15:00.6

3. start testpmd without any port
x86_64-native-linuxapp-gcc/app/dpdk-testpmd -l 1-3 -n 4 -- -i

4. bind cpf to vfio-pci
./usertools/dpdk-devbind.py -b 0000:15:00.6

5. testpmd attach port
testpmd> port attach
0000:15:00.6,vport=3D[0-1],representor=3Dvf[0,1],flow_parser=3D./refpkg.jso=
n=20


Results:=20
=3D=3D=3D=3D=3D=3D=3D=3D
Attaching a new port...
EAL: Using IOMMU type 1 (Type 1)
CPFL_INIT: cpfl_flow_init(): flow module is not initialized
Error during enabling promiscuous mode for port 0: Operation not supported -
ignore
Port 0 is attached. Now total ports is 1
Done

Expected Result:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Attaching a new port...
EAL: Using IOMMU type 1 (Type 1)
CPFL_DRIVER: cpfl_handle_cpchnl_event_msg():  unknown event received 6
CPFL_DRIVER: cpfl_handle_cpchnl_event_msg():  unknown event received 6
Error during enabling promiscuous mode for port 0: Operation not supported -
ignore
Port 0 is attached. Now total ports is 1
Done
Error during enabling promiscuous mode for port 1: Operation not supported -
ignore
Port 1 is attached. Now total ports is 2
Done
Error during enabling promiscuous mode for port 2: Operation not supported -
ignore
Port 2 is attached. Now total ports is 3
Done
Error during enabling promiscuous mode for port 3: Operation not supported -
ignore
Port 3 is attached. Now total ports is 4
Done

bad commit:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit 12c2405989f6fb002a1c45e892b82897d124d10a
Author: Shani Peretz <shperetz@nvidia.com>
Date:   Sun Jul 13 09:34:17 2025 +0300

    app/testpmd: canonicalize short PCI name format

    when providing short format PCI device names in devargs
    (e.g. "08:00:0") it is converted and stored as long format.
    however when attach_port is called from testpmd, the user might
    provide a short format, which will be passed to find_device with
    a comparison function that simply compare strings, which will
    cause find_device not to find any device.

    This fix canonicalize the user provided string before it is being
    passed to find_device.

    Signed-off-by: Shani Peretz <shperetz@nvidia.com>

 app/test-pmd/meson.build |  2 +-
 app/test-pmd/testpmd.c   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions, 1 deletion

--=20
You are receiving this mail because:
You are the assignee for the bug.=
