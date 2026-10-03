Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AABCA5FE3
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 02:52:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3A5342ED0;
	Sat,  3 Oct 2026 04:52:02 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id F133E42ECC
 for <dev@dpdk.org>; Sat,  3 Oct 2026 04:52:00 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so1215645ad.1
 for <dev@dpdk.org>; Fri, 02 Oct 2026 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790995920; x=1791600720; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AaBrZuCT0HkpQw2/iyt/Af1vNiaZN7K/usN3wteWhRQ=;
 b=kxOoY+nznMRFwCmUgQDEi+hGlbUGKZnZWCifTzXsneeXBF62N435B+9rCu3cGJlCC7
 G2tSK5FRLn7wpdGfzeVQgbtRu3hRJK8pKkd2lMZVLN8hfDifIciRlQ9T381FdnigeNgv
 665W+BxiolNp5U8bT6Ag8V7xk4z2E35qYgMM7J6WEoTxn8f7bfS8MCrbeRdebEpw7w/j
 54LtfBrKvcdCv66xCoSjLMWCxn346vEfTKCseWggSdy+WXiXHzGysoUuzjg8+i1BSfk7
 L/Mwt4VqONmQdeeeqNSXJ7GifdVM1+fh3xUZFEGfCYEHgpbYZJ+HFqu61bYruTXJcS7t
 cmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995920; x=1791600720;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AaBrZuCT0HkpQw2/iyt/Af1vNiaZN7K/usN3wteWhRQ=;
 b=0+FR/XgyTylXNP7hs4+lVufTBzbLOdkeYjYqxV/wpPzNztQO1lWDZ9Hg/CsZ8PHpaH
 b0LtqvWHqilKMUAJPQp86mcFOC3xyz4ERz8V9vNIh1OIHf0DesQa5an4Nnlh8xjn6+PL
 ruitNY0ME8IRVsl66wCu78ECyee++bikhpkJd6XSwUG6mVWU380i199njMbTAOKcGLLZ
 DnBGfQJNQDKRFaWK2gREt+1hnyn1x4DNuvRQAiA/gLsMFCYDKn3CxqRMOY1JjZUkb9tb
 ICUp8aYiTZDzAW0jg1RuV4p2rZ7qidc4KkJ8g8algH8d0DzB4PGxeYVY7EfSt+BdnYpv
 Y/WA==
X-Gm-Message-State: AFq9FYIXTVYDC+/ZAFzgp0YpxuRLWxmLGshposHxsRESqgtSuwxWSkBg
 S5063e1co9a/6Tbjdwc0jmXkdhWARUqQN4wRtC4EZENXpp6CwZBLoeyOrqqeGh3ZPjW9vLWdXRl
 PR5fpBr/xBS3N9g==
X-Received: from pleg1.prod.google.com ([2002:a17:902:e381:b0:2e4:9044:4638])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:32c7:b0:2e2:e28a:75a1 with SMTP id
 d9443c01a7336-2e49b80dfe8mr42239205ad.62.1790995919747; 
 Fri, 02 Oct 2026 19:51:59 -0700 (PDT)
Date: Fri,  2 Oct 2026 19:51:40 -0700
In-Reply-To: <20261003025142.1930363-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003025142.1930363-9-joshwash@google.com>
Subject: [PATCH 8/8] net/gve: refactor timestamp support to clock read type
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
index 5a2f95ae19..a1deadc8ba 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -554,6 +554,9 @@ gve_alloc_nic_ts_report(struct gve_priv *priv)
 {
 	char z_name[RTE_MEMZONE_NAMESIZE];
 
+	if (priv->clk_read_type == GVE_DEV_CLK_UNSUPPORTED)
+		return -EOPNOTSUPP;
+
 	snprintf(z_name, sizeof(z_name), "gve_%s_nic_ts_report",
 		 priv->pci_dev->device.name);
 	priv->nic_ts_report_mz = rte_memzone_reserve_aligned(z_name,
@@ -865,7 +868,7 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_RSS_HASH;
-	if (!gve_is_gqi(priv) && priv->nic_ts_report_mz)
+	if (priv->clk_read_type != GVE_DEV_CLK_UNSUPPORTED)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 	dev_info->tx_offload_capa =
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS	|
@@ -1342,7 +1345,7 @@ gve_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
 	uint64_t ts;
 	int err;
 
-	if (!priv->nic_timestamp_supported)
+	if (priv->clk_read_type == GVE_DEV_CLK_UNSUPPORTED)
 		return -EOPNOTSUPP;
 
 	if (!priv->nic_ts_report_mz)
@@ -1443,7 +1446,7 @@ gve_setup_nic_timestamp(struct gve_priv *priv)
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

