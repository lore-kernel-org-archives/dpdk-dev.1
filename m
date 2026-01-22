Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4067D3EE63
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 13:13:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D400402EE;
	Thu, 22 Jan 2026 14:13:22 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 621F3402CE
 for <dev@dpdk.org>; Thu, 22 Jan 2026 14:13:20 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 512B04A2AD; Thu, 22 Jan 2026 14:13:20 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1868] bnxt: RTE_MBUF_F_RX_VLAN_STRIPPED set but
 vlan_tci is 0
Date: Thu, 22 Jan 2026 13:13:20 +0000
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
Message-ID: <bug-1868-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1868

            Bug ID: 1868
           Summary: bnxt: RTE_MBUF_F_RX_VLAN_STRIPPED set but vlan_tci is
                    0
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

BCM957608-P2100GQF20 (235.1.157.0) with TruFlow disabled (via niccli) and
RTE_ETH_RX_OFFLOAD_VLAN_STRIP enabled doesn't set vlan_tci - it always rema=
ins
0, even though the VLAN itself is removed from the packet, and
RTE_MBUF_F_TX_VLAN and RTE_MBUF_F_RX_VLAN_STRIPPED flags are set.


- With testpmd, vlan_tci is 0 as well, type is 0x8000, so vlan is not there
anymore.

  src=3D00:C4:7A:4C:B0:F8 - dst=3D00:BE:BE:BE:BE:BE - pool=3Dmb_pool_1 - ty=
pe=3D0x0800
- length=3D70 - nb_segs=3D1 - RSS hash=3D0xd65b3fd5 - RSS queue=3D0x5 - VLA=
N tci=3D0x0 -
hw ptype: L2_ETHER_VLAN L3_IPV4_EXT_UNKNOWN L4_UDP  - sw ptype: L2_ETHER
L3_IPV4 L4_UDP  - l2_len=3D14 - l3_len=3D20 - l4_len=3D8 - Destination UDP =
port=3D53 -
Receive queue=3D0x5
  ol_flags: RTE_MBUF_F_RX_VLAN RTE_MBUF_F_RX_RSS_HASH
RTE_MBUF_F_RX_L4_CKSUM_GOOD RTE_MBUF_F_RX_IP_CKSUM_GOOD
RTE_MBUF_F_RX_VLAN_STRIPPED RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN

- If I do "port config 0 rx_offload vlan_strip off" RTE_MBUF_F_RX_VLAN_STRI=
PPED
added anyway, even though the type is 0x8100, so vlan wasn't stripped.

  src=3D00:C4:7A:4C:B0:F8 - dst=3D00:BE:BE:BE:BE:BE - pool=3Dmb_pool_1 - ty=
pe=3D0x8100
- length=3D1514 - nb_segs=3D1 - RSS hash=3D0xe3688ad3 - RSS queue=3D0x3 - V=
LAN tci=3D0x0
- hw ptype: L2_ETHER_VLAN L3_IPV4_EXT_UNKNOWN L4_UDP  - sw ptype: L2_ETHER_=
VLAN
L3_IPV4 L4_UDP  - l2_len=3D18 - l3_len=3D20 - l4_len=3D8 - Receive queue=3D=
0x3
  ol_flags: RTE_MBUF_F_RX_VLAN RTE_MBUF_F_RX_RSS_HASH
RTE_MBUF_F_RX_L4_CKSUM_GOOD RTE_MBUF_F_RX_IP_CKSUM_GOOD
RTE_MBUF_F_RX_VLAN_STRIPPED RTE_MBUF_F_RX_OUTER_L4_CKSUM_UNKNOWN

--=20
You are receiving this mail because:
You are the assignee for the bug.=
