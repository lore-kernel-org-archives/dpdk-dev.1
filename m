Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B441C021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 18:58:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 211AE4060A;
	Thu, 13 Feb 2025 19:58:36 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 4F924402E7;
 Thu, 13 Feb 2025 19:58:34 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 9BF95203F3E4; Thu, 13 Feb 2025 10:58:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BF95203F3E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1739473113;
 bh=l06wyMMaWAaAYr2DdfDoFnxRas0sLblImLaanlmFk40=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Cmux6k8ZxdGZef2OsKStEtiSMQSwFms2FGkODtoGXaOJK/8GcDxrvwq7z7EtHBkuI
 ac/+kjtpHcL7+SO/Rgc4FfJh489OABI31EZKYLxdL88rhF41OLZxm5pLiunYLvuB0D
 EdSoOVXcp9rcSxDm6gEm3HtzSVEJU9NqEMnzeGgI=
From: longli@linuxonhyperv.com
To: Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [Patch v2 1/3] net/netvsc: scan all net devices under the PCI device
Date: Thu, 13 Feb 2025 10:58:23 -0800
Message-Id: <1739473105-17797-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739473105-17797-1-git-send-email-longli@linuxonhyperv.com>
References: <1739473105-17797-1-git-send-email-longli@linuxonhyperv.com>
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

The current code has the wrong assumption that a PCI device can have only
one Ethernet device. This is not correct as a PCI device can be multi
functional and have multiple Ethernet devices.

Fix this by scanning all the devices under a PCI device.

Fixes: a2a23a794b3a ("net/netvsc: support VF device hot add/remove")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 1736cb5d07..f848157b49 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -570,7 +570,7 @@ static void netvsc_hotplug_retry(void *args)
 	struct rte_devargs *d = &hot_ctx->da;
 	char buf[256];
 
-	DIR *di;
+	DIR *di = NULL;
 	struct dirent *dir;
 	struct ifreq req;
 	struct rte_ether_addr eth_addr;
@@ -590,7 +590,9 @@ static void netvsc_hotplug_retry(void *args)
 	if (!di) {
 		PMD_DRV_LOG(DEBUG, "%s: can't open directory %s, "
 			    "retrying in 1 second", __func__, buf);
-		goto retry;
+		/* The device is still being initialized, retry after 1 second */
+		rte_eal_alarm_set(1000000, netvsc_hotplug_retry, hot_ctx);
+		return;
 	}
 
 	while ((dir = readdir(di))) {
@@ -614,10 +616,9 @@ static void netvsc_hotplug_retry(void *args)
 				    dir->d_name);
 			break;
 		}
-		if (req.ifr_hwaddr.sa_family != ARPHRD_ETHER) {
-			closedir(di);
-			goto free_hotadd_ctx;
-		}
+		if (req.ifr_hwaddr.sa_family != ARPHRD_ETHER)
+			continue;
+
 		memcpy(eth_addr.addr_bytes, req.ifr_hwaddr.sa_data,
 		       RTE_DIM(eth_addr.addr_bytes));
 
@@ -636,22 +637,16 @@ static void netvsc_hotplug_retry(void *args)
 				PMD_DRV_LOG(ERR,
 					    "Failed to add PCI device %s",
 					    d->name);
-				break;
 			}
+
+			break;
 		}
-		/* When the code reaches here, we either have already added
-		 * the device, or its MAC address did not match.
-		 */
-		closedir(di);
-		goto free_hotadd_ctx;
 	}
-	closedir(di);
-retry:
-	/* The device is still being initialized, retry after 1 second */
-	rte_eal_alarm_set(1000000, netvsc_hotplug_retry, hot_ctx);
-	return;
 
 free_hotadd_ctx:
+	if (di)
+		closedir(di);
+
 	rte_spinlock_lock(&hv->hotadd_lock);
 	LIST_REMOVE(hot_ctx, list);
 	rte_spinlock_unlock(&hv->hotadd_lock);
-- 
2.34.1

