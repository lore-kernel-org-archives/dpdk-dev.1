Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2C3FD374E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 13:59:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E96C40659;
	Wed, 25 Feb 2026 14:58:36 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 0D177400D6;
 Wed, 25 Feb 2026 03:03:01 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 9150C20B6F02; Tue, 24 Feb 2026 18:03:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9150C20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771984980;
 bh=2GBwX7YnE3bX5P5s28DesJ6PHXeRZCXzGaxN2djrIqo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iLQ9BuWJLcheF7exFhkGCmlv7fVm8GEA6K5KIRoNlAV4fkl0/AtjppoGq2G+8SYSt
 cs6HkMlKU0a6Hq8Ptey4cUyplux1VZdioZnd0X8JTQJ3h1TC1YZs5dqQcB2NE1JeNg
 J8kQs7I1YFC48yJdRbUhbQrvwU0ilydFdPIamdWE=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v3 5/7] net/mana: fix fast-path ops setup in secondary process
Date: Tue, 24 Feb 2026 18:02:37 -0800
Message-ID: <20260225020246.890306-6-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260225020246.890306-1-longli@linux.microsoft.com>
References: <20260225020246.890306-1-longli@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:58:29 +0100
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

From: Long Li <longli@microsoft.com>

On hotplug, the secondary process is not able to set rte_eth_fp_ops
because the primary process has not finished setting up the device
for datapath.

Fix this by properly setting up rte_eth_fp_ops in the secondary
process when the primary requests to start datapath. Set both
rxq.data and txq.data to point to the device's RX/TX queue arrays,
enabling the fast-path operations to access queues correctly.

Also update rte_eth_fp_ops burst function pointers in the STOP_RXTX
handler. Without this, the secondary's rte_eth_fp_ops retains stale
burst function pointers after stop, since rte_eth_fp_ops is
process-local and eth_dev_fp_ops_reset() in rte_eth_dev_stop() only
affects the primary.

Without this fix, the secondary process cannot transmit or receive
packets because the fast-path queue data pointers are NULL.

Fixes: 62724d1a3981 ("net/mana: start/stop device")
Cc: stable@dpdk.org

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/mana/mp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/mana/mp.c b/drivers/net/mana/mp.c
index 5467d385ce..7c5c0fa88f 100644
--- a/drivers/net/mana/mp.c
+++ b/drivers/net/mana/mp.c
@@ -145,6 +145,9 @@ mana_mp_secondary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 		dev->tx_pkt_burst = mana_tx_burst;
 		dev->rx_pkt_burst = mana_rx_burst;
 
+		rte_eth_fp_ops[param->port_id].rxq.data = dev->data->rx_queues;
+		rte_eth_fp_ops[param->port_id].txq.data = dev->data->tx_queues;
+
 		rte_mb();
 
 		res->result = 0;
@@ -154,6 +157,9 @@ mana_mp_secondary_handle(const struct rte_mp_msg *mp_msg, const void *peer)
 	case MANA_MP_REQ_STOP_RXTX:
 		DRV_LOG(INFO, "Port %u stopping datapath", dev->data->port_id);
 
+		rte_eth_fp_ops[param->port_id].rx_pkt_burst = mana_rx_burst_removed;
+		rte_eth_fp_ops[param->port_id].tx_pkt_burst = mana_tx_burst_removed;
+
 		dev->tx_pkt_burst = mana_tx_burst_removed;
 		dev->rx_pkt_burst = mana_rx_burst_removed;
 
-- 
2.43.0

