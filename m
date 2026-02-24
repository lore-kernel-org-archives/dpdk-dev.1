Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C6E9B25A
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:14:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF1F64027F;
	Tue, 24 Feb 2026 13:14:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id B73A7400D5;
 Tue, 24 Feb 2026 13:14:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771935259; x=1803471259;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bS8DtnFghBREoD955OBpPosRR0vRr/qiGUevIOBAC+o=;
 b=dWrg9e4wIbbs/zQbRofgpPLIsAXbaEVRTL9xIS8ki8HcmZU1zshtiqCu
 zOQ/YI+7x6U5G4gn0IG7he6a3jWUgYuETEqod4vg7lqFWHuMLYV2QoQHq
 i6WzCq9Ee4K/3U1+To1mj/iTdSHRjZaSwWCd+ir4WHc6ay6YdAfsjfdtb
 NeaWmtlGUZ8qabF/Gsztpvfh0TxN2LU8PT28Dn4d1+1bRacFNLmU0AXdc
 GYWIAxhFe4m63q8HUYuO3nScV5R7q3oKJKlQq7m9Ix6q0Ln9bhpcx4xfv
 BNgGCREjIvmPmz96FJFewj0iJQrFRGYLQdrAqTUID0tT5jNwLTLfNWpK4 A==;
X-CSE-ConnectionGUID: Bruri72sT0ye9DVmUmSSyA==
X-CSE-MsgGUID: f8oBbMMoRu2lKwboj4/l4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="90359008"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="90359008"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 04:14:18 -0800
X-CSE-ConnectionGUID: xtIolfUjTQySYOWapjPquw==
X-CSE-MsgGUID: 25ys086nQnCAJk1Lt2w9vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220876885"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 24 Feb 2026 04:14:16 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Chaoyong He <chaoyong.he@corigine.com>, Long Wu <long.wu@corigine.com>
Subject: [PATCH] net/bonding: clamp Rx free threshold for small rings
Date: Tue, 24 Feb 2026 12:13:58 +0000
Message-ID: <20260224121358.3102740-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The bonding driver creates a minimal-sized Rx ring as part of the setup,
using the driver default parameters as it does so. However, for some
cases the default values need adjustment for absolute minimal sized
rings which can cause failures - for example, having an free threshold
of 32 is too large for a ring of size 64.

Unfortunately, the drivers themselves cannot properly handle this by
adjusting their defaults because:
a) the defaults are returned from info_get which gets called before the
desired ring-size is known
b) the replacement of the NULL rxconf value, which indicates use of
defaults, happens at the ethdev level, so the driver is unaware of the
source of the requested parameters - whether they are explicitly set by
the user or substituted by ethdev layer.

Therefore, we modify the bonding PMD to clamp the free thresh value to
ring_size / 4 which should work in all cases.

Fixes: 4da0705bf896 ("net/bonding: fix dedicated queue setup")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index b7bab6bc99..96725071da 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -1701,11 +1701,18 @@ member_configure_slow_queue(struct rte_eth_dev *bonding_eth_dev,
 		if (member_info.rx_desc_lim.nb_min != 0)
 			nb_rx_desc = member_info.rx_desc_lim.nb_min;
 
-		/* Configure slow Rx queue */
+		/* Configure slow Rx queue.
+		 * Use explicit conf rather than NULL so we can clamp rx_free_thresh:
+		 * with a minimum-sized ring the default rx_free_thresh may be too large
+		 * for some drivers to work correctly, so clamp it to ring_size / 4.
+		 */
+		struct rte_eth_rxconf slow_rx_conf = member_info.default_rxconf;
+		if (slow_rx_conf.rx_free_thresh > nb_rx_desc / 4)
+			slow_rx_conf.rx_free_thresh = nb_rx_desc / 4;
 		errval = rte_eth_rx_queue_setup(member_eth_dev->data->port_id,
 				internals->mode4.dedicated_queues.rx_qid, nb_rx_desc,
 				rte_eth_dev_socket_id(member_eth_dev->data->port_id),
-				NULL, port->slow_pool);
+				&slow_rx_conf, port->slow_pool);
 		if (errval != 0) {
 			RTE_BOND_LOG(ERR,
 					"rte_eth_rx_queue_setup: port=%d queue_id %d, err (%d)",
-- 
2.51.0

