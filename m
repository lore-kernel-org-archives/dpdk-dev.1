Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34898CD343F
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 19:29:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0D31406B4;
	Fri, 15 May 2026 21:29:01 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4375040652;
 Fri, 15 May 2026 21:28:55 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id B635B20B7167; Fri, 15 May 2026 12:28:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B635B20B7167
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH v3 6/7] net/netvsc: forward per-queue stats from VF device
Date: Fri, 15 May 2026 12:28:40 -0700
Message-ID: <20260515192843.552762-7-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260515192843.552762-1-longli@microsoft.com>
References: <20260506020529.281654-1-longli@microsoft.com>
 <20260515192843.552762-1-longli@microsoft.com>
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
v3:
- Removed dead -ENOTSUP fallback to rte_eth_stats_get,
  replaced with direct -ENOTSUP return
- Documented caller contract for zeroed buffers
v2:
- Added comment for direct dev_ops call
- Added -ENOTSUP fallback

 drivers/net/netvsc/hn_vf.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 1fcc65a712..c83cc973fd 100644
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
@@ -757,8 +757,19 @@ int hn_vf_stats_get(struct rte_eth_dev *dev,
 
 	rte_rwlock_read_lock(&hv->vf_lock);
 	vf_dev = hn_get_vf_dev(hv);
-	if (vf_dev)
-		ret = rte_eth_stats_get(vf_dev->data->port_id, stats);
+	if (vf_dev) {
+		/* Call dev_ops->stats_get directly instead of the public
+		 * rte_eth_stats_get API because we need to forward the
+		 * per-queue stats (qstats) which the public API does not
+		 * support.  The caller (eth_stats_qstats_get) has already
+		 * zeroed stats and qstats before invoking this callback.
+		 */
+		if (vf_dev->dev_ops->stats_get != NULL)
+			ret = vf_dev->dev_ops->stats_get(vf_dev, stats,
+							 qstats);
+		else
+			ret = -ENOTSUP;
+	}
 	rte_rwlock_read_unlock(&hv->vf_lock);
 	return ret;
 }
-- 
2.43.0

