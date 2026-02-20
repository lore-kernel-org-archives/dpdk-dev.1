Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5650C55184
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:10:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A3174067E;
	Fri, 20 Feb 2026 11:09:41 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 518F84027B;
 Fri, 20 Feb 2026 02:10:23 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id CC26420B6F00; Thu, 19 Feb 2026 17:10:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC26420B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771549822;
 bh=Kbi0yFW7Aw0qWRsOkEz23tcyCP+sfEKlWmBJK9HqNc4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a5dBnb1OQHvXJKyiVfTNwRFMsN1nJqj8mIaQDCemI7N6H82Lisqad7lGfOhJgLwl4
 ewKo2tVFUk1xgwYZc+gGWR/XiS3k5TWPfHrVNWuKeL7PH0BK8hoXjf9fLY4Q7HJvIl
 DqguuyT+leeJosKjXBHq6JbnB/AOpVMTTLm1Nt+I=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Wei Hu <weh@microsoft.com>, stable@dpdk.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 5/8] net/netvsc: fix devargs memory leak on hotplug
Date: Thu, 19 Feb 2026 17:09:35 -0800
Message-ID: <20260220010938.595319-6-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260220010938.595319-2-longli@linux.microsoft.com>
References: <20260220010938.595319-2-longli@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Feb 2026 11:09:31 +0100
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
index 62e6f49d3d..6327dc2132 100644
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

