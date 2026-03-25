Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6271A109C057
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 18:57:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B65DD42708;
	Wed, 25 Mar 2026 19:57:55 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id D5929402CE;
 Wed, 25 Mar 2026 19:57:54 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 7033B20B710C; Wed, 25 Mar 2026 11:57:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7033B20B710C
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org
Cc: longli@microsoft.com, weh@microsoft.com, stephen@networkplumber.org,
 stable@dpdk.org
Subject: [PATCH v3] net/netvsc: switch data path to synthetic on device stop
Date: Wed, 25 Mar 2026 11:57:50 -0700
Message-ID: <20260325185750.1926356-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
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
v3:
- Preserve datapath switch error in hn_vf_stop() by using a
  separate variable for rte_eth_dev_stop() return value;
  return the first error encountered.

v2:
- In hn_vf_stop(), only clear vf_vsc_switched on successful
  datapath switch (not unconditionally).
- In hn_vf_start(), stop the VF device if datapath switch to
  VF fails after successful VF start.

 drivers/net/netvsc/hn_vf.c | 65 ++++++++++++++++++++++++++++++++------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netvsc/hn_vf.c b/drivers/net/netvsc/hn_vf.c
index 99e8086afa..1fcc65a712 100644
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
 
@@ -534,16 +562,33 @@ int hn_vf_stop(struct rte_eth_dev *dev)
 	struct hn_data *hv = dev->data->dev_private;
 	struct rte_eth_dev *vf_dev;
 	int ret = 0;
+	int err;
 
-	rte_rwlock_read_lock(&hv->vf_lock);
+	rte_rwlock_write_lock(&hv->vf_lock);
 	vf_dev = hn_get_vf_dev(hv);
 	if (vf_dev) {
-		ret = rte_eth_dev_stop(vf_dev->data->port_id);
-		if (ret != 0)
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
+		err = rte_eth_dev_stop(vf_dev->data->port_id);
+		if (err != 0)
 			PMD_DRV_LOG(ERR, "Failed to stop device on port %u",
 				    vf_dev->data->port_id);
+		if (ret == 0)
+			ret = err;
 	}
-	rte_rwlock_read_unlock(&hv->vf_lock);
+	rte_rwlock_write_unlock(&hv->vf_lock);
 
 	return ret;
 }
-- 
2.43.0

