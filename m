Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D062FFD9E2D
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 02:00:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB13F4067E;
	Fri, 27 Feb 2026 02:59:47 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id E4AFD40663;
 Fri, 27 Feb 2026 02:59:42 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 51AB220B6F03; Thu, 26 Feb 2026 17:59:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51AB220B6F03
From: Long Li <longli@microsoft.com>
To: dev@dpdk.org, Wei Hu <weh@microsoft.com>,
 Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH v5 3/7] net/mana: fix PD resource leak on device close
Date: Thu, 26 Feb 2026 17:59:23 -0800
Message-ID: <20260227015928.14338-4-longli@microsoft.com>
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

The Protection Domains (PDs) allocated during device initialization
were not being deallocated on device close, causing a resource leak.

Deallocate both ib_parent_pd and ib_pd in mana_dev_close() before
closing the IB device context. Log errors if deallocation fails,
which would indicate orphaned child resources (QPs, MRs). The close
proceeds regardless because ibv_close_device() will force kernel
cleanup of any remaining resources.

Fixes: 2f5749ead13a ("net/mana: add basic driver with build environment")
Cc: stable@dpdk.org

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/mana/mana.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index b7ae01b152..67396cda1f 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -282,6 +282,20 @@ mana_dev_close(struct rte_eth_dev *dev)
 	if (ret)
 		return ret;
 
+	if (priv->ib_parent_pd) {
+		int err = ibv_dealloc_pd(priv->ib_parent_pd);
+		if (err)
+			DRV_LOG(ERR, "Failed to deallocate parent PD: %d", err);
+		priv->ib_parent_pd = NULL;
+	}
+
+	if (priv->ib_pd) {
+		int err = ibv_dealloc_pd(priv->ib_pd);
+		if (err)
+			DRV_LOG(ERR, "Failed to deallocate PD: %d", err);
+		priv->ib_pd = NULL;
+	}
+
 	ret = ibv_close_device(priv->ib_ctx);
 	if (ret) {
 		ret = errno;
-- 
2.43.0

