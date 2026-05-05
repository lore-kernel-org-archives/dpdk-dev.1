Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2AEFF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 20:45:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29D7340A79;
	Tue,  5 May 2026 22:45:21 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id EAE7640695
 for <dev@dpdk.org>; Tue,  5 May 2026 22:45:19 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 3CE8D20B7168; Tue,  5 May 2026 13:45:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CE8D20B7168
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 4/7] net/netvsc: add NOTICE-level debug logging for VF hotplug
 retry
Date: Tue,  5 May 2026 13:44:53 -0700
Message-ID: <20260505204457.267934-4-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260505204457.267934-1-longli@microsoft.com>
References: <20260505204457.267934-1-longli@microsoft.com>
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

Add detailed NOTICE-level logging at every decision point in the
netvsc_hotplug_retry function to diagnose VF re-attach failures:

- Log each interface found in the net/ directory
- Log when sa_family is not ARPHRD_ETHER
- Log MAC address comparison details on mismatch
- Log when the retry loop exits (with retry count)

These logs help correlate DPDK hotplug retry behavior with kernel
dmesg timestamps to identify timing issues during VF re-attach
after PCI rescan on Azure.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 5d1ef10eff..124af4f1a1 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -656,6 +656,11 @@ static void netvsc_hotplug_retry(void *args)
 		if (!strcmp(dir->d_name, ".") || !strcmp(dir->d_name, ".."))
 			continue;
 
+		PMD_DRV_LOG(NOTICE,
+			    "%s: checking interface %s in %s (retry %d)",
+			    __func__, dir->d_name, buf,
+			    hot_ctx->eal_hot_plug_retry);
+
 		/* trying to get mac address if this is a network device*/
 		s = socket(PF_INET, SOCK_DGRAM, IPPROTO_IP);
 		if (s == -1) {
@@ -679,8 +684,12 @@ static void netvsc_hotplug_retry(void *args)
 					  netvsc_hotplug_retry, hot_ctx);
 			return;
 		}
-		if (req.ifr_hwaddr.sa_family != ARPHRD_ETHER)
+		if (req.ifr_hwaddr.sa_family != ARPHRD_ETHER) {
+			PMD_DRV_LOG(NOTICE,
+				    "%s: device %s sa_family=%d not ARPHRD_ETHER, skipping",
+				    __func__, dir->d_name, req.ifr_hwaddr.sa_family);
 			continue;
+		}
 
 		memcpy(eth_addr.addr_bytes, req.ifr_hwaddr.sa_data,
 		       RTE_DIM(eth_addr.addr_bytes));
@@ -737,6 +746,20 @@ static void netvsc_hotplug_retry(void *args)
 			if (ret)
 				PMD_DRV_LOG(ERR, "Failed to add VF: %d", ret);
 			break;
+		} else {
+			PMD_DRV_LOG(NOTICE,
+				    "%s: MAC mismatch for %s: got %02x:%02x:%02x:%02x:%02x:%02x "
+				    "expected %02x:%02x:%02x:%02x:%02x:%02x",
+				    __func__, dir->d_name,
+				    eth_addr.addr_bytes[0], eth_addr.addr_bytes[1],
+				    eth_addr.addr_bytes[2], eth_addr.addr_bytes[3],
+				    eth_addr.addr_bytes[4], eth_addr.addr_bytes[5],
+				    dev->data->mac_addrs->addr_bytes[0],
+				    dev->data->mac_addrs->addr_bytes[1],
+				    dev->data->mac_addrs->addr_bytes[2],
+				    dev->data->mac_addrs->addr_bytes[3],
+				    dev->data->mac_addrs->addr_bytes[4],
+				    dev->data->mac_addrs->addr_bytes[5]);
 		}
 	}
 
@@ -744,6 +767,9 @@ static void netvsc_hotplug_retry(void *args)
 	if (di)
 		closedir(di);
 
+	PMD_DRV_LOG(NOTICE, "%s: retry loop exiting for device %s (retry %d)",
+		    __func__, d->name, hot_ctx->eal_hot_plug_retry);
+
 	rte_spinlock_lock(&hv->hotadd_lock);
 	LIST_REMOVE(hot_ctx, list);
 	rte_spinlock_unlock(&hv->hotadd_lock);
-- 
2.43.0

