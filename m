Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91902CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 19:29:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 301DD4067D;
	Fri, 15 May 2026 21:29:00 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5F68B40615;
 Fri, 15 May 2026 21:28:54 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 3620820B7166; Fri, 15 May 2026 12:28:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3620820B7166
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH v3 5/7] net/netvsc: retry when no matching MAC found in net
 directory
Date: Fri, 15 May 2026 12:28:39 -0700
Message-ID: <20260515192843.552762-6-longli@microsoft.com>
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

On multi-NIC Azure VMs, a single MANA PCI device (7870:00:00.0) hosts
multiple VF interfaces. After PCI rescan, these interfaces register
at different times — the management NIC's VF appears first, followed
by the test NIC's VF.

Previously, when netvsc_hotplug_retry scanned the net/ directory and
found interfaces with non-matching MACs, it would exit the readdir
loop and free the hotadd context, permanently giving up. The matching
VF interface had not appeared yet.

Now, when the readdir loop ends without finding a matching MAC (dir
is NULL after loop), schedule another retry instead of giving up.
This uses a separate mac_retry counter (limit 120, ~2 minutes) so
the main retry loop remains unlimited.

Fixes: a2a23a794b3a ("net/netvsc: support VF device hot add/remove")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
v3: no change
v2:
- Fixed commit message (limit 120 not 30)
- Changed mac_retry log to DEBUG
- Explicit NULL comparisons

 drivers/net/netvsc/hn_ethdev.c | 36 +++++++++++++++++++++++++++++++++-
 drivers/net/netvsc/hn_var.h    |  1 +
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 16fb2b344d..72743872bb 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -92,6 +92,12 @@ struct netvsc_mp_param {
 /* Retry interval for hot-add VF device (microseconds) */
 #define NETVSC_HOTADD_RETRY_INTERVAL 1000000
 
+/* Max retries when net/ directory exists but no matching MAC found.
+ * On multi-NIC PCI devices, a second VF may register later.
+ * 120 retries = ~2 minutes.
+ */
+#define NETVSC_MAX_MAC_RETRY 120
+
 struct hn_xstats_name_off {
 	char name[RTE_ETH_XSTATS_NAME_SIZE];
 	unsigned int offset;
@@ -768,8 +774,36 @@ static void netvsc_hotplug_retry(void *args)
 			    RTE_ETHER_ADDR_BYTES(dev->data->mac_addrs));
 	}
 
+	/* If we opened the net directory but didn't find a matching MAC,
+	 * the VF interface may not have appeared yet (e.g. on a multi-NIC
+	 * PCI device, the second VF registers later). Retry.
+	 */
+	if (di != NULL) {
+		closedir(di);
+		di = NULL;
+		if (dir == NULL) {
+			/* readdir returned NULL — loop ended without match */
+			hot_ctx->mac_retry++;
+			if (hot_ctx->mac_retry < NETVSC_MAX_MAC_RETRY) {
+				PMD_DRV_LOG(DEBUG,
+					    "%s: no matching MAC found in %s, "
+					    "retrying in 1 second (mac_retry %d/%d)",
+					    __func__, buf,
+					    hot_ctx->mac_retry,
+					    NETVSC_MAX_MAC_RETRY);
+				rte_eal_alarm_set(NETVSC_HOTADD_RETRY_INTERVAL,
+						  netvsc_hotplug_retry,
+						  hot_ctx);
+				return;
+			}
+			PMD_DRV_LOG(NOTICE,
+				    "%s: no matching MAC found after %d retries, giving up",
+				    __func__, hot_ctx->mac_retry);
+		}
+	}
+
 free_hotadd_ctx:
-	if (di)
+	if (di != NULL)
 		closedir(di);
 
 	PMD_DRV_LOG(DEBUG, "%s: retry loop exiting for device %s (retry %d)",
diff --git a/drivers/net/netvsc/hn_var.h b/drivers/net/netvsc/hn_var.h
index ef55dee28e..574b909c82 100644
--- a/drivers/net/netvsc/hn_var.h
+++ b/drivers/net/netvsc/hn_var.h
@@ -127,6 +127,7 @@ struct hv_hotadd_context {
 	struct hn_data *hv;
 	struct rte_devargs da;
 	int eal_hot_plug_retry;
+	int mac_retry;
 };
 
 struct hn_data {
-- 
2.43.0

