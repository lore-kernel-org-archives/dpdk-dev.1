Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B47D116E2
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 05:59:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B11540275;
	Mon,  1 Dec 2025 06:59:49 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9C26F4021F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 06:59:47 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6610048BF5; Mon,  1 Dec 2025 06:59:47 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1845] DPDK 20 guest with X710 SR-IOV: VF MAC
 changes randomly on reboot (host i40e 2.22.18)
Date: Mon, 01 Dec 2025 05:59:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 20.11
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: gownivalla.susmitha@wipro.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1845-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1845

            Bug ID: 1845
           Summary: DPDK 20 guest with X710 SR-IOV: VF MAC changes
                    randomly on reboot (host i40e 2.22.18)
           Product: DPDK
           Version: 20.11
          Hardware: x86
                OS: Linux
            Status: UNCONFIRMED
          Severity: critical
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: gownivalla.susmitha@wipro.com
  Target Milestone: ---

Hello DPDK Community,

We are seeing an intermittent issue where the VF MAC address on the host (PF
side) changes unexpectedly after VM reboot when using Intel X710 NICs.

Environment
NIC: Intel X710 (SR-IOV)
Host driver (problematic): i40e 2.22.18
Host firmware/NVM tested: 6.00 and 9.10

Host driver (working): i40e 2.14.x
Working firmware/NVM: 7.10

Hypervisor: OpenStack (Neutron sets MAC during orchestration)
MAC is explicitly assigned in orchestration YAML

Issue
The assigned VF MAC is correctly programmed at initial VM creation.
However, on some VM reboots (not every time), the MAC on the host VF change=
s to
a random, different MAC.

Expected
VF MAC programmed by orchestration should remain persistent across reboots.

Observed Only With
i40e 2.22.18
Firmware 6.00 and 9.10

Not Observed With
i40e 2.14.13
Firmware 7.10

Request/Clarification required:
Is this a known issue in i40e 2.22.18 or DPDK 20.11?
Any recommended fix, patch, or firmware/driver combination?
Any debug flags or traces we can enable to capture VF MAC programming failu=
res?

Please let me know if additional logs are needed.

Thanks,
Susmitha

--=20
You are receiving this mail because:
You are the assignee for the bug.=
