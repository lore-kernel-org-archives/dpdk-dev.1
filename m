Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD326CD3427
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 02:06:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8397940A76;
	Wed,  6 May 2026 04:05:48 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 36B3B40695;
 Wed,  6 May 2026 04:05:46 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 65A1220B7168; Tue,  5 May 2026 19:05:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65A1220B7168
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH v2 6/7] net/netvsc: forward per-queue stats from VF device
Date: Tue,  5 May 2026 19:05:27 -0700
Message-ID: <20260506020529.281654-6-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260506020529.281654-1-longli@microsoft.com>
References: <20260506020529.281654-1-longli@microsoft.com>
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

hn_vf_stats_get was ignoring the qstats parameter (__rte_unused),
calling rte_eth_stats_get which only collects aggregate stats. This
meant per-queue stats (rx_q0_good_packets, tx_q0_good_packets, etc.)
were always zero when VF datapath was active, even though the
underlying MANA driver populates them in its stats_get callback.

Call the VF device's stats_get op directly with the qstats pointer
so per-queue counters are forwarded through netvsc to the xstats
telemetry output.

Fixes: dc7680e8597c ("net/netvsc: support integrated VF")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
v2:
- Added comment explaining why dev_ops->stats_get is called
  directly (per-queue stats not available via public API)
- Added -ENOTSUP fallback to rte_eth_stats_get for VF drivers
  that do not support per-queue stats
- Changed implicit NULL check to explicit (stats_get != NULL)

 drivers/net/netvsc/hn_vf.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 1fcc65a712..49e6a5b283 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -749,7 +749,7 @@ void hn_vf_rx_queue_release(struct hn_data *hv, uint16_t queue_id)
 
 int hn_vf_stats_get(struct rte_eth_dev *dev,
 		    struct rte_eth_stats *stats,
-		    struct eth_queue_stats *qstats __rte_unused)
+		    struct eth_queue_stats *qstats)
 {
 	struct hn_data *hv = dev->data->dev_private;
 	struct rte_eth_dev *vf_dev;
@@ -757,8 +757,22 @@ int hn_vf_stats_get(struct rte_eth_dev *dev,
 
 	rte_rwlock_read_lock(&hv->vf_lock);
 	vf_dev = hn_get_vf_dev(hv);
-	if (vf_dev)
-		ret = rte_eth_stats_get(vf_dev->data->port_id, stats);
+	if (vf_dev) {
+		/* Call dev_ops->stats_get directly instead of the public
+		 * rte_eth_stats_get API because we need to forward the
+		 * per-queue stats (qstats) which the public API does not
+		 * support.  Fall back to the public API if the VF driver
+		 * does not implement stats_get or returns -ENOTSUP.
+		 */
+		if (vf_dev->dev_ops->stats_get != NULL) {
+			ret = vf_dev->dev_ops->stats_get(vf_dev, stats, qstats);
+			if (ret == -ENOTSUP)
+				ret = rte_eth_stats_get(vf_dev->data->port_id,
+							stats);
+		} else {
+			ret = rte_eth_stats_get(vf_dev->data->port_id, stats);
+		}
+	}
 	rte_rwlock_read_unlock(&hv->vf_lock);
 	return ret;
 }
-- 
2.43.0

