Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A902ACD4F5E
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 08:03:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BD9040290;
	Thu, 21 May 2026 10:03:39 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B16F94028D
 for <dev@dpdk.org>; Thu, 21 May 2026 10:03:37 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A5D4F4B21B; Thu, 21 May 2026 10:03:37 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1948] bnxt: bnxt_hwrm_send_message timeout
Date: Thu, 21 May 2026 08:03:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 26.03
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: oleksandrn@interfacemasters.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1948-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1948

            Bug ID: 1948
           Summary: bnxt: bnxt_hwrm_send_message timeout
           Product: DPDK
           Version: 26.03
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: oleksandrn@interfacemasters.com
  Target Milestone: ---

Randomly, on rte_eth_dev_configure, see this error, it seems like after tha=
t,
traffic doesn't work on this port anymore(or at least returned counters are=
 0)
Happens somewhat rarely, like 1 out of 10. The problem is that dev_configure
doesn't return failure, so not sure if there is a way to detect this
automatically; maybe rte_eth_link_get can be used.

I also see that there is a similar old Bug 1214

BNXT: bnxt_hwrm_send_message(): Error(timeout) sending msg 0x002a, seq_id 5=
98
BNXT: bnxt_get_hwrm_link_config(): Get link config failed with rc -110
BNXT: bnxt_hwrm_send_message(): Error(timeout) sending msg 0x002a, seq_id 6=
21
BNXT: bnxt_get_hwrm_link_config(): Get link config failed with rc -110


Part Number                         : BCM957608-P2100GQF20
Chip Number                         : BCM57608
Chip Name                           : THOR2
Description                         : Broadcom BCM57608 2x100G PCIe Ethernet
NIC
Firmware Name                       : PRIMATE_FW
Firmware Version                    : 237.1.148.0
RoCE Firmware Version               : 237.1.148.0
HWRM Interface Spec                 : 1.10.3
Kong mailbox channel                : Not Applicable
Active Package Version              : 237.1.148.0
Package Version on NVM              : 237.1.148.0
Active NVM config version           : 236.0.2

--=20
You are receiving this mail because:
You are the assignee for the bug.=
