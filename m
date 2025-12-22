Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6E8D711D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Dec 2025 07:25:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C60A40265;
	Mon, 22 Dec 2025 08:25:54 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 4C00440264
 for <dev@dpdk.org>; Mon, 22 Dec 2025 08:25:53 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 2D445470B3; Mon, 22 Dec 2025 08:25:53 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/core Bug 1857] DPDK applications inside kubernetes pods  are
 failing to come up when CPU and hugepage memory are from different NUMA nodes
Date: Mon, 22 Dec 2025 07:25:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: core
X-Bugzilla-Version: 25.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: sahithi.singam@oracle.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1857-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1857

            Bug ID: 1857
           Summary: DPDK applications inside kubernetes pods  are failing
                    to come up when CPU and hugepage memory are from
                    different NUMA nodes
           Product: DPDK
           Version: 25.11
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: major
          Priority: Normal
         Component: core
          Assignee: dev@dpdk.org
          Reporter: sahithi.singam@oracle.com
  Target Milestone: ---

DPDK sample applications like l2fwd, l3fwd are not coming up and failing wi=
th
below error when they are run with cores assigned from  NUMA-1  , but hugep=
ages
are allocated on NUMA-0.=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
EAL: set_mempolicy failed: Invalid argument][N/A][N/A]
 EAL: Using IOMMU type 1 (Type 1)][N/A][N/A]
 EAL: set_mempolicy failed: Invalid argument][N/A][N/A]
 PCI_BUS: Probe PCI driver: net_iavf (8086:154c) device: 0000:31:04.6 (sock=
et
0)][N/A][N/A]
 EAL: set_mempolicy failed: Invalid argument][N/A][N/A]
 ETHDEV: Cannot allocate ethdev shared data][N/A][N/A]
 PCI_BUS: Releasing PCI mapped resource for 0000:31:04.6][N/A][N/A]
 PCI_BUS: Calling pci_unmap_resource for 0000:31:04.6 at
0x312000400000][N/A][N/A]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

When a kubernetes pod is launched , cores and memory/hugepages are allocate=
d to
the pod from containerd and we dont have much control of the numa nodes from
where they are allocated (we are using best-effort in the topology manager
configuration of the kubelet).=20
In this scenario, we are allocated cpus from NUMA 1 and hugepages from NUMA=
 0 .
DPDK application is trying to allocated memory from the same numa node on w=
hich
core is present and it is failing as there are no hugepages available on th=
at
particular NUMA node (Node 1).=20

As of now DPDK application design works only when both CPU and hugepages are
from same NUMA node , but with increase in DPDK application usage inside
kubernetes pods, this problem should be addressed where users do not have m=
uch
control of resource reservation from same NUMA nodes.=20

So DPDK applications should work when cores and hugepages are from different
NUMA nodes.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
