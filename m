Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B1CD342F
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 02:06:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BE18406B7;
	Wed,  6 May 2026 04:05:46 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8939240679
 for <dev@dpdk.org>; Wed,  6 May 2026 04:05:44 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id AFAD120B716A; Tue,  5 May 2026 19:05:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFAD120B716A
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v2 4/7] net/netvsc: add debug logging for VF hotplug retry
Date: Tue,  5 May 2026 19:05:25 -0700
Message-ID: <20260506020529.281654-4-longli@microsoft.com>
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

Add detailed DEBUG-level logging at every decision point in the
netvsc_hotplug_retry function to diagnose VF re-attach failures:

- Log each interface found in the net/ directory
- Log when sa_family is not ARPHRD_ETHER
- Log MAC address comparison details on mismatch using
  RTE_ETHER_ADDR_PRT_FMT for consistency with the rest of DPDK
- Log when the retry loop exits (with retry count)

Per-iteration trace uses DEBUG level to avoid flooding the log on
multi-NIC VMs with indefinite retries; NOTICE is reserved for
one-shot state transitions.

These logs help correlate DPDK hotplug retry behavior with kernel
dmesg timestamps to identify timing issues during VF re-attach
after PCI rescan on Azure.

Signed-off-by: Long Li <longli@microsoft.com>
---
v2:
- Changed all per-iteration log calls from NOTICE to DEBUG to
  avoid flooding logs on multi-NIC VMs with indefinite retries
- Replaced manual MAC format with RTE_ETHER_ADDR_PRT_FMT and
  RTE_ETHER_ADDR_BYTES macros
- Removed redundant else after break in MAC match block
- Renamed patch from "NOTICE-level" to "debug logging"

 drivers/net/netvsc/hn_ethdev.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 130fea38ab..d1c12ca9d5 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -662,6 +662,11 @@ static void netvsc_hotplug_retry(void *args)
 		if (!strcmp(dir->d_name, ".") || !strcmp(dir->d_name, ".."))
 			continue;
 
+		PMD_DRV_LOG(DEBUG,
+			    "%s: checking interface %s in %s (retry %d)",
+			    __func__, dir->d_name, buf,
+			    hot_ctx->eal_hot_plug_retry);
+
 		/* trying to get mac address if this is a network device*/
 		s = socket(PF_INET, SOCK_DGRAM, IPPROTO_IP);
 		if (s == -1) {
@@ -686,8 +691,12 @@ static void netvsc_hotplug_retry(void *args)
 					  netvsc_hotplug_retry, hot_ctx);
 			return;
 		}
-		if (req.ifr_hwaddr.sa_family != ARPHRD_ETHER)
+		if (req.ifr_hwaddr.sa_family != ARPHRD_ETHER) {
+			PMD_DRV_LOG(DEBUG,
+				    "%s: device %s sa_family=%d not ARPHRD_ETHER, skipping",
+				    __func__, dir->d_name, req.ifr_hwaddr.sa_family);
 			continue;
+		}
 
 		memcpy(eth_addr.addr_bytes, req.ifr_hwaddr.sa_data,
 		       RTE_DIM(eth_addr.addr_bytes));
@@ -748,12 +757,23 @@ static void netvsc_hotplug_retry(void *args)
 				PMD_DRV_LOG(ERR, "Failed to add VF: %d", ret);
 			break;
 		}
+
+		PMD_DRV_LOG(DEBUG,
+			    "%s: MAC mismatch for %s: got "
+			    RTE_ETHER_ADDR_PRT_FMT
+			    " expected " RTE_ETHER_ADDR_PRT_FMT,
+			    __func__, dir->d_name,
+			    RTE_ETHER_ADDR_BYTES(&eth_addr),
+			    RTE_ETHER_ADDR_BYTES(dev->data->mac_addrs));
 	}
 
 free_hotadd_ctx:
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

