Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911ABCD4F3C
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 19:28:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B72E40655;
	Fri, 15 May 2026 21:28:55 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B268A40269;
 Fri, 15 May 2026 21:28:52 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 0978120B7166; Fri, 15 May 2026 12:28:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0978120B7166
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH v3 1/7] net/netvsc: retry VF hotplug indefinitely until PCI
 device disappears
Date: Fri, 15 May 2026 12:28:35 -0700
Message-ID: <20260515192843.552762-2-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260515192843.552762-1-longli@microsoft.com>
References: <20260506020529.281654-1-longli@microsoft.com>
 <20260515192843.552762-1-longli@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

After PCI rescan on Azure, the MANA kernel driver can take over 100
seconds to probe and create the /sys/bus/pci/devices/<dev>/net directory.
The previous fixed retry limit (NETVSC_MAX_HOTADD_RETRY=10, ~12 seconds)
was insufficient, causing VF re-attach to fail with 'Failed to parse PCI
device' on systems with slow MANA driver initialization.

Replace the fixed retry limit with an indefinite retry that only gives up
when the PCI device itself disappears from sysfs. This is safe because:

- The retry uses rte_eal_alarm callbacks which are serialized on the EAL
  interrupt thread, preventing races with VF remove or device close paths.
- Device close (eth_hn_dev_uninit) explicitly cancels all pending hotplug
  alarms via rte_eal_alarm_cancel and frees the context.
- If the PCI device is removed while retrying, access() detects the
  missing sysfs path and stops immediately.

A periodic NOTICE log every 30 retries (~30s) provides visibility into
long waits without flooding the log at DEBUG level.

Fixes: a2a23a794b3a ("net/netvsc: support VF device hot add/remove")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
v3:
- Wrapped rte_eal_alarm_set lines to stay within 100 columns
  (checkpatch line-length warning)
v2:
- Added detailed comment explaining why indefinite retry is
  safe (PCI sysfs disappearance is the termination condition)

 drivers/net/netvsc/hn_ethdev.c | 41 +++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index b8880edb4c..85e500c178 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -89,8 +89,8 @@ struct netvsc_mp_param {
 #define NETVSC_ARG_TXBREAK "tx_copybreak"
 #define NETVSC_ARG_RX_EXTMBUF_ENABLE "rx_extmbuf_enable"
 
-/* The max number of retry when hot adding a VF device */
-#define NETVSC_MAX_HOTADD_RETRY 10
+/* Retry interval for hot-add VF device (microseconds) */
+#define NETVSC_HOTADD_RETRY_INTERVAL 1000000
 
 struct hn_xstats_name_off {
 	char name[RTE_ETH_XSTATS_NAME_SIZE];
@@ -622,19 +622,39 @@ static void netvsc_hotplug_retry(void *args)
 	PMD_DRV_LOG(DEBUG, "%s: retry count %d",
 		    __func__, hot_ctx->eal_hot_plug_retry);
 
-	if (hot_ctx->eal_hot_plug_retry++ > NETVSC_MAX_HOTADD_RETRY) {
-		PMD_DRV_LOG(NOTICE, "Failed to parse PCI device retry=%d",
-			    hot_ctx->eal_hot_plug_retry);
+	hot_ctx->eal_hot_plug_retry++;
+
+	/* Check if PCI device still exists — if it disappeared, give up.
+	 * Otherwise keep retrying indefinitely until the net directory
+	 * appears.  This is safe because:
+	 * - MANA driver probe can take >100s after PCI rescan
+	 * - The retry uses rte_eal_alarm callbacks serialized on the
+	 *   EAL interrupt thread, preventing races with device close
+	 * - Device close cancels pending alarms and frees the context
+	 * - If the PCI device is removed, the access() check below
+	 *   detects the missing sysfs path and stops immediately
+	 */
+	snprintf(buf, sizeof(buf), "/sys/bus/pci/devices/%s", d->name);
+	if (access(buf, F_OK) != 0) {
+		PMD_DRV_LOG(NOTICE,
+			    "PCI device %s no longer exists, giving up after %d retries",
+			    d->name, hot_ctx->eal_hot_plug_retry);
 		goto free_hotadd_ctx;
 	}
 
 	snprintf(buf, sizeof(buf), "/sys/bus/pci/devices/%s/net", d->name);
 	di = opendir(buf);
 	if (!di) {
-		PMD_DRV_LOG(DEBUG, "%s: can't open directory %s, "
-			    "retrying in 1 second", __func__, buf);
-		/* The device is still being initialized, retry after 1 second */
-		rte_eal_alarm_set(1000000, netvsc_hotplug_retry, hot_ctx);
+		if (hot_ctx->eal_hot_plug_retry % 30 == 0)
+			PMD_DRV_LOG(NOTICE,
+				    "%s: waiting for %s (retry %d, %ds elapsed)",
+				    __func__, buf, hot_ctx->eal_hot_plug_retry,
+				    hot_ctx->eal_hot_plug_retry);
+		else
+			PMD_DRV_LOG(DEBUG, "%s: can't open directory %s, "
+				    "retrying in 1 second", __func__, buf);
+		rte_eal_alarm_set(NETVSC_HOTADD_RETRY_INTERVAL,
+				  netvsc_hotplug_retry, hot_ctx);
 		return;
 	}
 
@@ -758,7 +778,8 @@ netvsc_hotadd_callback(const char *device_name, enum rte_dev_event_type type,
 			rte_spinlock_lock(&hv->hotadd_lock);
 			LIST_INSERT_HEAD(&hv->hotadd_list, hot_ctx, list);
 			rte_spinlock_unlock(&hv->hotadd_lock);
-			rte_eal_alarm_set(1000000, netvsc_hotplug_retry, hot_ctx);
+			rte_eal_alarm_set(NETVSC_HOTADD_RETRY_INTERVAL,
+					  netvsc_hotplug_retry, hot_ctx);
 			return;
 		}
 
-- 
2.43.0

