Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161A9FD9E29
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 02:00:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5152C4028E;
	Fri, 27 Feb 2026 02:59:52 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E5A4240677;
 Fri, 27 Feb 2026 02:59:44 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 5980320B6F02; Thu, 26 Feb 2026 17:59:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5980320B6F02
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v5 6/7] net/mlx5: fix fast-path ops setup in secondary process
Date: Thu, 26 Feb 2026 17:59:26 -0800
Message-ID: <20260227015928.14338-7-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260227015928.14338-1-longli@microsoft.com>
References: <20260227015928.14338-1-longli@microsoft.com>
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

On hotplug, the secondary process is not able to set rte_eth_fp_ops
because the primary process has not finished setting up the device
for datapath.

When the primary process re-attaches a VF during a hot-add event
(e.g. Accelerated Networking re-enabled on Azure), it sends
MLX5_MP_REQ_START_RXTX to the secondary process. The secondary
handler sets rx/tx burst functions and reinitializes UAR mappings,
but does not update the fast-path queue data pointers. The stale
rxq.data and txq.data in rte_eth_fp_ops cause a segfault when the
secondary resumes polling the re-added VF port.

Fix this by setting rte_eth_fp_ops rxq.data and txq.data to point
to the device's RX/TX queue arrays in the secondary process when
the primary requests to start datapath, before the memory barrier.

Also update rte_eth_fp_ops burst function pointers in the STOP_RXTX
handler. Without this, the secondary's rte_eth_fp_ops retains stale
burst function pointers after stop, since rte_eth_fp_ops is
process-local and eth_dev_fp_ops_reset() in rte_eth_dev_stop() only
affects the primary.

Without this fix, the secondary process crashes with SIGSEGV in
rte_eth_rx_burst() at qd = p->rxq.data[queue_id] when the VF is
hot-added back.

Fixes: 2aac5b5d119f ("net/mlx5: sync stop/start with secondary process")
Cc: stable@dpdk.org

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/mlx5/linux/mlx5_mp_os.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/mlx5/linux/mlx5_mp_os.c b/drivers/net/mlx5/linux/mlx5_mp_os.c
index f2e71c9bd4..ca7b1cfa97 100644
--- a/drivers/net/mlx5/linux/mlx5_mp_os.c
+++ b/drivers/net/mlx5/linux/mlx5_mp_os.c
@@ -189,6 +189,10 @@ struct rte_mp_msg mp_res;
 			}
 		}
 		close(mp_msg->fds[0]);
+		rte_eth_fp_ops[param->port_id].rx_pkt_burst = dev->rx_pkt_burst;
+		rte_eth_fp_ops[param->port_id].tx_pkt_burst = dev->tx_pkt_burst;
+		rte_eth_fp_ops[param->port_id].rxq.data = dev->data->rx_queues;
+		rte_eth_fp_ops[param->port_id].txq.data = dev->data->tx_queues;
 		rte_mb();
 		mp_init_msg(&priv->mp_id, &mp_res, param->type);
 		res->result = 0;
@@ -198,6 +202,8 @@ struct rte_mp_msg mp_res;
 		DRV_LOG(INFO, "port %u stopping datapath", dev->data->port_id);
 		dev->rx_pkt_burst = rte_eth_pkt_burst_dummy;
 		dev->tx_pkt_burst = rte_eth_pkt_burst_dummy;
+		rte_eth_fp_ops[param->port_id].rx_pkt_burst = rte_eth_pkt_burst_dummy;
+		rte_eth_fp_ops[param->port_id].tx_pkt_burst = rte_eth_pkt_burst_dummy;
 		rte_mb();
 		mp_init_msg(&priv->mp_id, &mp_res, param->type);
 		res->result = 0;
-- 
2.43.0

