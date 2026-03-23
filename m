Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC4AF532C5
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 23:58:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C102B402D6;
	Tue, 24 Mar 2026 00:58:57 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id BD6DC4027C;
 Tue, 24 Mar 2026 00:58:56 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 4134720B712B; Mon, 23 Mar 2026 16:58:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4134720B712B
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v2] net/netvsc: switch data path to synthetic on device stop
Date: Mon, 23 Mar 2026 16:58:48 -0700
Message-ID: <20260323235848.1780798-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260321004337.1608222-1-longli@microsoft.com>
References: <20260321004337.1608222-1-longli@microsoft.com>
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

When DPDK stops a netvsc device (e.g. on testpmd quit), the data path
was left pointing to the VF/MANA device. If the kernel netvsc driver
subsequently reloads the MANA device and opens it, incoming traffic
arrives on the MANA device immediately, before the queues are fully
initialized. This causes bogus RX completion events to appear on the
TX completion queue, triggering a kernel WARNING in mana_poll_tx_cq().

Fix this by switching the data path back to synthetic (via
NVS_DATAPATH_SYNTHETIC) in hn_vf_stop() before stopping the VF device.
This tells the host to route traffic through the synthetic path, so
that when the MANA driver recreates its queues, no unexpected traffic
arrives until netvsc explicitly switches back to VF.

Also update hn_vf_start() to switch the data path back to VF after the
VF device is started, enabling correct stop/start cycling.

Both functions now use write locks instead of read locks since they
modify vf_vsc_switched state.

Fixes: dc7680e8597c ("net/netvsc: support integrated VF")
Cc: stable@dpdk.org

Signed-off-by: Long Li <longli@microsoft.com>
---

v2:
- hn_vf_stop(): only clear vf_vsc_switched on successful datapath switch
- hn_vf_start(): stop VF device if datapath switch to VF fails

 drivers/net/netvsc/hn_vf.c | 58 ++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 99e8086afa..c3f024b378 100644
--- a/drivers/net/netvsc/hn_vf.c
+++ b/drivers/net/netvsc/hn_vf.c
@@ -314,9 +314,17 @@ int hn_vf_add_unlocked(struct rte_eth_dev *dev, struct hn_data *hv)
 	}
 
 switch_data_path:
-	ret = hn_nvs_set_datapath(hv, NVS_DATAPATH_VF);
-	if (ret == 0)
-		hv->vf_ctx.vf_vsc_switched = true;
+	/* Only switch data path to VF if the device is started.
+	 * Otherwise defer to hn_vf_start() to avoid routing traffic
+	 * to the VF before queues are set up.
+	 */
+	if (dev->data->dev_started) {
+		ret = hn_nvs_set_datapath(hv, NVS_DATAPATH_VF);
+		if (ret)
+			PMD_DRV_LOG(ERR, "Failed to switch to VF: %d", ret);
+		else
+			hv->vf_ctx.vf_vsc_switched = true;
+	}
 
 exit:
 	return ret;
@@ -521,11 +529,31 @@ int hn_vf_start(struct rte_eth_dev *dev)
 	struct rte_eth_dev *vf_dev;
 	int ret = 0;
 
-	rte_rwlock_read_lock(&hv->vf_lock);
+	rte_rwlock_write_lock(&hv->vf_lock);
 	vf_dev = hn_get_vf_dev(hv);
-	if (vf_dev)
+	if (vf_dev) {
 		ret = rte_eth_dev_start(vf_dev->data->port_id);
-	rte_rwlock_read_unlock(&hv->vf_lock);
+		if (ret == 0) {
+			/* Re-switch data path to VF if VSP has reported
+			 * VF is present and we haven't switched yet
+			 * (e.g. after a stop/start cycle).
+			 */
+			if (hv->vf_ctx.vf_vsp_reported &&
+			    !hv->vf_ctx.vf_vsc_switched) {
+				ret = hn_nvs_set_datapath(hv,
+							  NVS_DATAPATH_VF);
+				if (ret) {
+					PMD_DRV_LOG(ERR,
+						    "Failed to switch to VF: %d",
+						    ret);
+					rte_eth_dev_stop(vf_dev->data->port_id);
+				} else {
+					hv->vf_ctx.vf_vsc_switched = true;
+				}
+			}
+		}
+	}
+	rte_rwlock_write_unlock(&hv->vf_lock);
 	return ret;
 }
 
@@ -535,15 +563,29 @@ int hn_vf_stop(struct rte_eth_dev *dev)
 	struct rte_eth_dev *vf_dev;
 	int ret = 0;
 
-	rte_rwlock_read_lock(&hv->vf_lock);
+	rte_rwlock_write_lock(&hv->vf_lock);
 	vf_dev = hn_get_vf_dev(hv);
 	if (vf_dev) {
+		/* Switch data path back to synthetic before stopping VF,
+		 * so the host stops routing traffic to the VF device.
+		 */
+		if (hv->vf_ctx.vf_vsc_switched) {
+			ret = hn_nvs_set_datapath(hv, NVS_DATAPATH_SYNTHETIC);
+			if (ret) {
+				PMD_DRV_LOG(ERR,
+					    "Failed to switch to synthetic: %d",
+					    ret);
+			} else {
+				hv->vf_ctx.vf_vsc_switched = false;
+			}
+		}
+
 		ret = rte_eth_dev_stop(vf_dev->data->port_id);
 		if (ret != 0)
 			PMD_DRV_LOG(ERR, "Failed to stop device on port %u",
 				    vf_dev->data->port_id);
 	}
-	rte_rwlock_read_unlock(&hv->vf_lock);
+	rte_rwlock_write_unlock(&hv->vf_lock);
 
 	return ret;
 }
-- 
2.43.0

