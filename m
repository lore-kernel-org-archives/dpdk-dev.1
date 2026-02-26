Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA90FC5910
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 10:17:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC06540659;
	Thu, 26 Feb 2026 11:16:42 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8D0FD400D6;
 Thu, 26 Feb 2026 03:39:52 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 21D8C20B6F03; Wed, 25 Feb 2026 18:39:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 21D8C20B6F03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1772073592;
 bh=67WdlJxO+O3vdG/++IoQEIZk0fdAWxds5dkk0RH93Fs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l3FfCHQLE4XTm4/EHUEAhWqMrDiwCMikZvTNfc8bswcUt5+ym6BmfJhjDRw6ZsvbT
 rJCidcIKGjFlGIyOlVMt7/XdaonzGQLeZPnRI+NejmyDOGKZgtKaO7P0uhSOCJZzdi
 PNRvXX2Ir2e7mqB2Nu87MsR9nb/NDg4vP7A9PiK8=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v4 4/7] net/netvsc: fix devargs memory leak on hotplug
Date: Wed, 25 Feb 2026 18:39:35 -0800
Message-ID: <20260226023940.961844-5-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260226023940.961844-1-longli@linux.microsoft.com>
References: <20260226023940.961844-1-longli@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Feb 2026 11:16:38 +0100
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

