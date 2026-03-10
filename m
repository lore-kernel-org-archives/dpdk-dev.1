Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEC8FCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:53:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D48940612;
	Tue, 10 Mar 2026 03:53:03 +0100 (CET)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id B87754014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:53:01 +0100 (CET)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id A19724AC29; Tue, 10 Mar 2026 03:53:01 +0100 (CET)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/ethdev Bug 1900] The DPDK bond driver does not support the
 secondary process.
Date: Tue, 10 Mar 2026 02:53:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: ethdev
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 916421004@qq.com
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone
Message-ID: <bug-1900-3@http.bugs.dpdk.org/>
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

http://bugs.dpdk.org/show_bug.cgi?id=3D1900

            Bug ID: 1900
           Summary: The DPDK bond driver does not support the secondary
                    process.
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: ethdev
          Assignee: dev@dpdk.org
          Reporter: 916421004@qq.com
  Target Milestone: ---

When I use the bond4 mode (dedicated_queues_enable), I find that DPDK does =
not
support the secondary mode.


1.bond_probe:
if (rte_eal_process_type() =3D=3D RTE_PROC_SECONDARY) {
        eth_dev =3D rte_eth_dev_attach_secondary(name);
        if (!eth_dev) {
                RTE_BOND_LOG(ERR, "Failed to probe %s", name);
                return -1;
        }
        /* TODO: request info from primary to set up Rx and Tx */
        eth_dev->dev_ops =3D &default_dev_ops;
        eth_dev->device =3D &dev->device;

        rte_eth_dev_probing_finish(eth_dev);
        return 0;
}


Here don`t set eth_dev->tx_pkt_burst and eth_dev->rx_pkt_burst.

2.struct port bond_mode_8023ad_ports[RTE_MAX_ETHPORTS];
This is a global variable, and the content of the primary is not synchroniz=
ed.

problem example:
rx_burst_8023ad:
...
collecting =3D ACTOR_STATE(&bond_mode_8023ad_ports[members[idx]],
                                         COLLECTING);
...=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
/* Remove packet from array if:
 * - it is slow packet but no dedicated rxq is present,
 * - member is not in collecting state,
 * - bonding interface is not in promiscuous mode and
 *   packet address isn't in mac_addrs array:
 *   - packet is unicast,
 *   - packet is multicast and bonding interface
 *     is not in allmulti,
 */
if (unlikely(
        (!dedicated_rxq &&
         is_lacp_packets(hdr->ether_type, subtype,
                         bufs[j])) ||
        !collecting ||
        (!promisc &&
         !is_bond_mac_addr(&hdr->dst_addr, bond_mac,
                           BOND_MAX_MAC_ADDRS) &&
         (rte_is_unicast_ether_addr(&hdr->dst_addr) ||
          !allmulti)))) {
          ...
          }

because the bond_mode_8023ad_ports is not synchronized to the primary proce=
ss.
As a result, the value of collecting is 0, and non-LACP packets are discard=
ed.


Why does the DPDK bond not support the secondary mode? When will the DPDK b=
ond
support the secondary mode?

--=20
You are receiving this mail because:
You are the assignee for the bug.=
