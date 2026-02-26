Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A81FC5910
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 10:17:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 975FE40668;
	Thu, 26 Feb 2026 11:16:44 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2EBB34021F;
 Thu, 26 Feb 2026 03:39:54 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id B2C7320B6F02; Wed, 25 Feb 2026 18:39:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2C7320B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1772073593;
 bh=BpoTudAyRXFfq5cOg6yOtmutGKgWLS7/WJUju3A/N9w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OorQHB8lZHF74O5fwRhEojLs9xd9zmBCgDNagKi7a22rIES71wmBW+anu0hUI4Lkg
 t/uh3JsU4g+HOLXRg+ENk8fPC827FBJ/mfLa6U7+b05W4hWKafOxni3lqeieSLn6XN
 4cgHhODNSvAXwq83sUdfRkPKr++feFtUkc6TGJf8=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v4 6/7] net/mlx5: fix fast-path ops setup in secondary process
Date: Wed, 25 Feb 2026 18:39:37 -0800
Message-ID: <20260226023940.961844-7-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260226023940.961844-1-longli@linux.microsoft.com>
References: <20260226023940.961844-1-longli@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Feb 2026 11:16:38 +0100
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
 drivers/net/mlx5/linux/mlx5_mp_os.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/mlx5/linux/mlx5_mp_os.c b/drivers/net/mlx5/linux/mlx5_mp_os.c
index f2e71c9bd4..955a990a39 100644
--- a/drivers/net/mlx5/linux/mlx5_mp_os.c
+++ b/drivers/net/mlx5/linux/mlx5_mp_os.c
@@ -189,6 +189,8 @@ struct rte_mp_msg mp_res;
 			}
 		}
 		close(mp_msg->fds[0]);
+		rte_eth_fp_ops[param->port_id].rxq.data = dev->data->rx_queues;
+		rte_eth_fp_ops[param->port_id].txq.data = dev->data->tx_queues;
 		rte_mb();
 		mp_init_msg(&priv->mp_id, &mp_res, param->type);
 		res->result = 0;
@@ -198,6 +200,8 @@ struct rte_mp_msg mp_res;
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

