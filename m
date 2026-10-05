Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A042CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 19:40:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AB6340DF8;
	Mon,  5 Oct 2026 21:40:21 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id 44E0D40DCF
 for <dev@dpdk.org>; Mon,  5 Oct 2026 21:40:19 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cee1ec30f2so22212595ad.3
 for <dev@dpdk.org>; Mon, 05 Oct 2026 12:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791229218; x=1791834018; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s3KLItvmwwx465ZGyivYclqbhRwYNoNBaEBQTQUfFoU=;
 b=WgcE+68uMiUVWSdQMCW3gDh+SSM7WO/CBcNZr1rgfAeMb3exDgAAzBWe3uDctRaKla
 rrup+zZtqTROPA7kDJuF9GrFmsZiKPhvsR0BBUG/wVzsMl2h97eRkvZMwPnHq9xN5ruf
 oyvralgu3/qgBC13VJvCBVq9leWJ7lZLyPDNwaMs+ckNPN2vEvxaARXt/J47xVZHLlgy
 aFbaxXUkYlzCeSxyPA5KnVvTYXzfryq08yeuqHQOjPiTABYSW9HU6+P+t0v8cuTkk3wu
 mWxpxUjo3N5VxG+nVr2GNjnf2rCJer+s1VBmkiKgaLwM/UeOctUuuXI+7f6S5yv1y+Zv
 4fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229218; x=1791834018;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s3KLItvmwwx465ZGyivYclqbhRwYNoNBaEBQTQUfFoU=;
 b=YK0TwKZ0LwFIwB9a78hCHa/JIhFyOgJcKSf4BUOai7fASVMI6QapKzhCoQGk+gArs0
 OFqb5HGl1Pz+AnDBNBB+uIFEIdH8oLkHv2aYYte2JPxAQDvRb2oVXwYzcAF/pqzhcBee
 q2jYvpYeVP94I+0xOMETb/2VmeUmRTwrj9K5SNnwTLIFrK7/u6aO7F4QKHZ9iuikv/EJ
 8qolkdtQdJMDpRf4QPWYf5GpcgcQ3tFqxB5EQVB/YVXRn5lVcrZyXAy730fnRv5ufhKG
 83m+R9s0FG8BmDDrHErVyPY5LjuBzMPtHFRJ5Qq/Tfgh0VVpDoIKOO79bRLmL3Tr+Evy
 L4xQ==
X-Gm-Message-State: AFq9FYJjPNipPhW1I5cyMsGlyEO6tQbijkt7b4zsaZuiIDAiUE/LWcBH
 2BlSaGOIlaGBBJ1rLTzluvO7yWmZAbRepSsD+9J4fUdx8aF4lfgIzbaFd/LvXtfZyjjugIt4kNd
 8DUlyubeOJCQyCg==
X-Received: from plbmz15.prod.google.com ([2002:a17:903:350f:b0:2e1:2a93:3745])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dacd:b0:2dd:c053:ec73 with SMTP id
 d9443c01a7336-2e5104ee47fmr72289825ad.38.1791229217977; 
 Mon, 05 Oct 2026 12:40:17 -0700 (PDT)
Date: Mon,  5 Oct 2026 12:39:39 -0700
In-Reply-To: <20261005193943.1175072-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
 <20261005193943.1175072-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005193943.1175072-9-joshwash@google.com>
Subject: [PATCH v2 8/8] net/gve: refactor timestamp support to clock read type
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>
Content-Type: text/plain; charset="UTF-8"
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

From: Mark Blasko <blasko@google.com>

Replace the boolean nic_timestamp_supported field with enum
gve_dev_clk_type to represent the device clock read mode
(unsupported, Cmd). Update AdminQ capability negotiation
and ethdev operations to check clk_read_type.

Signed-off-by: Mark Blasko <blasko@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/base/gve_adminq.c | 5 +++--
 drivers/net/gve/gve_ethdev.c      | 9 ++++++---
 drivers/net/gve/gve_ethdev.h      | 7 ++++++-
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 60e8544ef4..6fd9323f0c 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -994,9 +994,10 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 		priv->max_mtu = be16_to_cpu(dev_op_jumbo_frames->max_mtu);
 	}
 	if (dev_op_nic_timestamp &&
-	    (supported_features_mask & GVE_SUP_NIC_TIMESTAMP_MASK)) {
+	    (supported_features_mask & GVE_SUP_NIC_TIMESTAMP_MASK) &&
+	    !gve_is_gqi(priv)) {
 		PMD_DRV_LOG(INFO, "NIC TIMESTAMP device option enabled.");
-		priv->nic_timestamp_supported = true;
+		priv->clk_read_type = GVE_DEV_CLK_CMD;
 	}
 }
 
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index aa8beed3c4..b4a5f59816 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -555,6 +555,9 @@ gve_alloc_nic_ts_report(struct gve_priv *priv)
 {
 	char z_name[RTE_MEMZONE_NAMESIZE];
 
+	if (priv->clk_read_type == GVE_DEV_CLK_UNSUPPORTED)
+		return -EOPNOTSUPP;
+
 	snprintf(z_name, sizeof(z_name), "gve_%s_nic_ts_report",
 		 priv->pci_dev->device.name);
 	priv->nic_ts_report_mz = rte_memzone_reserve_aligned(z_name,
@@ -866,7 +869,7 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_RSS_HASH;
-	if (!gve_is_gqi(priv) && priv->nic_ts_report_mz)
+	if (priv->clk_read_type != GVE_DEV_CLK_UNSUPPORTED)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 	dev_info->tx_offload_capa =
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS	|
@@ -1343,7 +1346,7 @@ gve_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
 	uint64_t ts;
 	int err;
 
-	if (!priv->nic_timestamp_supported)
+	if (priv->clk_read_type == GVE_DEV_CLK_UNSUPPORTED)
 		return -EOPNOTSUPP;
 
 	if (!priv->nic_ts_report_mz)
@@ -1444,7 +1447,7 @@ gve_setup_nic_timestamp(struct gve_priv *priv)
 {
 	int err;
 
-	if (!priv->nic_timestamp_supported)
+	if (priv->clk_read_type == GVE_DEV_CLK_UNSUPPORTED)
 		return;
 
 	rte_atomic_store_explicit(&priv->nic_ts_read_fails, 0, rte_memory_order_relaxed);
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index ef93db0c1d..21454802f9 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -274,6 +274,11 @@ extern const struct rte_flow_ops gve_flow_ops;
 struct gve_priv;
 struct gve_flow_rule_params;
 
+enum gve_dev_clk_type {
+	GVE_DEV_CLK_UNSUPPORTED = 0,
+	GVE_DEV_CLK_CMD,
+};
+
 struct gve_ctrl_ops {
 	int (*init_ctrl_plane)(struct gve_priv *priv);
 	void (*free_ctrl_plane)(struct gve_priv *priv);
@@ -411,7 +416,7 @@ struct gve_priv {
 	TAILQ_HEAD(, gve_flow) active_flows;
 
 	/* HW Timestamping Fields */
-	bool nic_timestamp_supported;
+	enum gve_dev_clk_type clk_read_type;
 	const struct rte_memzone *nic_ts_report_mz;
 	struct gve_nic_ts_report *nic_ts_report;
 	pthread_mutex_t nic_ts_lock;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

