Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C347E9A777
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 11:54:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E084402BE;
	Tue, 24 Mar 2026 12:54:10 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 1BAEC4025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 12:54:09 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id E5F024AD8C; Tue, 24 Mar 2026 12:54:08 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1910] bnxt: RTE_ETH_TX_OFFLOAD_VLAN_INSERT doesn't
 insert vlan
Date: Tue, 24 Mar 2026 11:54:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: 25.07
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
Message-ID: <bug-1910-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1910

            Bug ID: 1910
           Summary: bnxt: RTE_ETH_TX_OFFLOAD_VLAN_INSERT doesn't insert
                    vlan
           Product: DPDK
           Version: 25.07
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: oleksandrn@interfacemasters.com
  Target Milestone: ---

On 57608, RTE_ETH_TX_OFFLOAD_VLAN_INSERT doesn't seem to be working; it is
reported as a supported capability, but the VLAN is not actually added. The
same codebase works with other nics.=20

I also tried testpmd

port stop 0
port config 0 tx_offload vlan_insert on
tx_vlan set 0 133
port start 0
start tx_first 1

 I don't see VLAN on the other side.

As far as I remember, when TruFlow is enabled, 57608 doesn't support VLAN
stripping, so maybe it is the same case for VLAN insertion as well, but then
RTE_ETH_TX_OFFLOAD_VLAN_INSERT shouldn't be reported as supported by pmd,
haven't tried without TruFlow.

--=20
You are receiving this mail because:
You are the assignee for the bug.=
