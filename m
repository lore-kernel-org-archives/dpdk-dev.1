Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9527CFD375F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 13:59:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42C7740654;
	Wed, 25 Feb 2026 14:58:35 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 69EAD400D6;
 Wed, 25 Feb 2026 03:03:00 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id EF7B420B6F04; Tue, 24 Feb 2026 18:02:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF7B420B6F04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771984979;
 bh=nAMHTXYM8Tt3lQMPOZ2OOQfs//cxt9NX2XslAuT7vU0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iGr1pnWzHoVE/97kYvVtogshNKGUDGWSvI1j2/iAQYZqd0fEOFWOQVVM4tkDNtBNw
 bavH8MCQACMpKEguIh7lnx+sjWrcUk+yHrB6pNENVFYdn6VtjP/uWHh8ePqaMnZLaq
 O3WeaeTGv7ljI4Fp5c1cyRMXinTLtmfirMN5Daaw=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v3 4/7] net/netvsc: fix devargs memory leak on hotplug
Date: Tue, 24 Feb 2026 18:02:36 -0800
Message-ID: <20260225020246.890306-5-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260225020246.890306-1-longli@linux.microsoft.com>
References: <20260225020246.890306-1-longli@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:58:29 +0100
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
index c1e1fbf0ee..3c682ca5be 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -710,6 +710,7 @@ static void netvsc_hotplug_retry(void *args)
 	LIST_REMOVE(hot_ctx, list);
 	rte_spinlock_unlock(&hv->hotadd_lock);
 
+	rte_devargs_reset(d);
 	free(hot_ctx);
 }
 
@@ -1125,6 +1126,7 @@ hn_dev_close(struct rte_eth_dev *dev)
 		hot_ctx = LIST_FIRST(&hv->hotadd_list);
 		rte_eal_alarm_cancel(netvsc_hotplug_retry, hot_ctx);
 		LIST_REMOVE(hot_ctx, list);
+		rte_devargs_reset(&hot_ctx->da);
 		free(hot_ctx);
 	}
 	rte_spinlock_unlock(&hv->hotadd_lock);
-- 
2.43.0

