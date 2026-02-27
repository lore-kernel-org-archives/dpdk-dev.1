Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC56FFD9E29
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 02:00:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 510DD40693;
	Fri, 27 Feb 2026 02:59:49 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 58EA240668;
 Fri, 27 Feb 2026 02:59:43 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 06A3B20B6F02; Thu, 26 Feb 2026 17:59:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06A3B20B6F02
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v5 4/7] net/netvsc: fix devargs memory leak on hotplug
Date: Thu, 26 Feb 2026 17:59:24 -0800
Message-ID: <20260227015928.14338-5-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260227015928.14338-1-longli@microsoft.com>
References: <20260227015928.14338-1-longli@microsoft.com>
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

Device arguments (devargs) allocated during VF hotplug were not being
freed when the hotplug context was cleaned up, causing a memory leak.

The devargs are allocated in netvsc_hotadd_callback() via
rte_devargs_parse() and stored in the hotadd context structure. They
must be freed with rte_devargs_reset() before freeing the context.

Free devargs in both cleanup paths:
- netvsc_hotplug_retry() after hotplug attempt completes
- hn_dev_close() when canceling pending hotplug operations

Fixes: 7fc4c0997b04 ("net/netvsc: fix hot adding multiple VF PCI devices")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index d22595ce95..791e832d5d 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -712,6 +712,7 @@ static void netvsc_hotplug_retry(void *args)
 	LIST_REMOVE(hot_ctx, list);
 	rte_spinlock_unlock(&hv->hotadd_lock);
 
+	rte_devargs_reset(d);
 	free(hot_ctx);
 }
 
@@ -1127,6 +1128,7 @@ hn_dev_close(struct rte_eth_dev *dev)
 		hot_ctx = LIST_FIRST(&hv->hotadd_list);
 		rte_eal_alarm_cancel(netvsc_hotplug_retry, hot_ctx);
 		LIST_REMOVE(hot_ctx, list);
+		rte_devargs_reset(&hot_ctx->da);
 		free(hot_ctx);
 	}
 	rte_spinlock_unlock(&hv->hotadd_lock);
-- 
2.43.0

