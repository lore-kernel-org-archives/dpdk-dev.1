Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6784FC5518E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:10:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FE1840663;
	Fri, 20 Feb 2026 11:09:39 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1A91740276;
 Fri, 20 Feb 2026 02:10:22 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 8EE7420B6F00; Thu, 19 Feb 2026 17:10:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EE7420B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771549821;
 bh=vanFg+taqqQnZjgbOr0eFxigfN6yw+bqyoX2EHTpVPU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H75bXwPuaK985KHDygrM1zh7j0MuctMukpUr+F4Vhtp9FKnqMSVprCWPU0HLsaYcL
 ItljsvwDsa0hCshJZdkSfmm9zRQ9eVws4ew8kXds+0+2uzVF9qjYae3t/FotrT8ecZ
 nGxLrIW1g2On/ZlerjJlujTpm6hYHA22f/08zrr8=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Wei Hu <weh@microsoft.com>, stable@dpdk.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 4/8] net/mana: fix PD resource leak on device close
Date: Thu, 19 Feb 2026 17:09:34 -0800
Message-ID: <20260220010938.595319-5-longli@linux.microsoft.com>
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
index b7ae01b152..6f70a6d774 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -282,6 +282,20 @@ mana_dev_close(struct rte_eth_dev *dev)
 	if (ret)
 		return ret;
 
+	if (priv->ib_parent_pd) {
+		ret = ibv_dealloc_pd(priv->ib_parent_pd);
+		if (ret)
+			DRV_LOG(ERR, "Failed to deallocate parent PD: %d", ret);
+		priv->ib_parent_pd = NULL;
+	}
+
+	if (priv->ib_pd) {
+		ret = ibv_dealloc_pd(priv->ib_pd);
+		if (ret)
+			DRV_LOG(ERR, "Failed to deallocate PD: %d", ret);
+		priv->ib_pd = NULL;
+	}
+
 	ret = ibv_close_device(priv->ib_ctx);
 	if (ret) {
 		ret = errno;
-- 
2.43.0

