Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7366E98DFA
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 07:58:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C032A40656;
	Mon, 23 Feb 2026 08:57:59 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id AA9D14025A;
 Sat, 21 Feb 2026 03:45:47 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 2EF1F20B6F05; Fri, 20 Feb 2026 18:45:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EF1F20B6F05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771641947;
 bh=jtrzi2EvRpF/wcLCrmk7bvR1SEHUdfsboA4jI5lT4T4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=msTeTH6f8irGKQd8f8YV9EF1O4qthj8XzEaR/+jCS5EVRPd5WCNiN/qy+bknTn47e
 i16hcdKPH9yo6KUuC+D8lhnCECoin+NogpCJueTXubDYuYraWgdHufSDAQoiqDUUUI
 Eyp7b/7UiI6Lh2m+3tNeUBEdrrRh0u07oAQUXvmk=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v2 5/8] net/netvsc: fix devargs memory leak on hotplug
Date: Fri, 20 Feb 2026 18:45:24 -0800
Message-ID: <20260221024540.659098-5-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260221024540.659098-1-longli@linux.microsoft.com>
References: <20260221024540.659098-1-longli@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:57:51 +0100
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
index 813b0e0cdb..4f3966ddd1 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -716,6 +716,7 @@ static void netvsc_hotplug_retry(void *args)
 	LIST_REMOVE(hot_ctx, list);
 	rte_spinlock_unlock(&hv->hotadd_lock);
 
+	rte_devargs_reset(d);
 	free(hot_ctx);
 }
 
@@ -1131,6 +1132,7 @@ hn_dev_close(struct rte_eth_dev *dev)
 		hot_ctx = LIST_FIRST(&hv->hotadd_list);
 		rte_eal_alarm_cancel(netvsc_hotplug_retry, hot_ctx);
 		LIST_REMOVE(hot_ctx, list);
+		rte_devargs_reset(&hot_ctx->da);
 		free(hot_ctx);
 	}
 	rte_spinlock_unlock(&hv->hotadd_lock);
-- 
2.43.0

