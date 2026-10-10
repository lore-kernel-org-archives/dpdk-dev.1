Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F733CA9EBB
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 01:00:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7FE940658;
	Sat, 10 Oct 2026 03:00:07 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id EF1364064F
 for <dev@dpdk.org>; Sat, 10 Oct 2026 03:00:06 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e6188d1e51so2667245ad.0
 for <dev@dpdk.org>; Fri, 09 Oct 2026 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791594006; x=1792198806; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0MRi0aje1LRMs5fLWIarKAUOl0WH1Es+aq64SyTETtQ=;
 b=U/SDFkLoRUS/FD0grIYbCeJdH4mu9UGH48L78J7NWzbnBFkTWfk8LZt7k3TI6AhFpr
 Ti7R752rwNZzb7sAzRadvx2pwffxcmSOxgb5DaMgWND/ghtXxkMtG8rHba8aN3VenT/5
 iAN1DGiSRmBoaEO76C4JGz0/pfuQtseObpnEkk33M598ddLHaOJFNRTdzzHQdTL+8tfY
 pF2xX/baLTbV746gwMwUlPUt8WQl7+x251c4gRntyQa1ZWexHBIorItNtTV8dpRBYU6d
 mowaIBND57h90GQ4Z5pzfbgu0q0rn+6Ls75YHQCnKtXoLTr3hM53pTNj34AuIYkD3grQ
 eHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791594006; x=1792198806;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0MRi0aje1LRMs5fLWIarKAUOl0WH1Es+aq64SyTETtQ=;
 b=hLlm/SEyhzWWSK6ZgsJzPc/X/v0MBmJgUsEbEmguggk7f4VXixig3be71bRboXGUje
 cHVliYVz4dCnBjVjlrsW2+XOUc4OJCqtYcAsKwpyVNm/tq7r4wFQvz6bwjdaFcY+dGXD
 ubzpZqxBioUEWlrY6NTaAklcA1/ql/54d92Tp/BJGzayoyFpomfNdOJFmqmZah2JfL1S
 atMZjW0LKx7iOfzwVdYGvl/SnLnwNHMA3Uy1841Pf/J8XVf/COZ9FW+oTcXH8a4UcS0o
 9pZJSh19AJbcFw5kzywJYNoGSBra7iT5BWG64kLj3TIM/WNz+YhWlELhRnYtaZmLiE4b
 xlcw==
X-Gm-Message-State: AFq9FYL62wuEZbF4F48KEtcOEnnRCMSC9VoNV3FwWRICQxvN6fiVWwFQ
 7d7bJQorhHXvpLzeW3wzbpo139c+NAPtM4N0VMEGDAkH2v2ckh7+4sXgMeG76/d7ST/Dnc1SA8X
 a2HU9yUSFtf9Hxw==
X-Received: from plpg9.prod.google.com ([2002:a17:902:9349:b0:2e4:ba62:8051])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d60f:b0:2e4:a360:fcc6 with SMTP id
 d9443c01a7336-2e842bc1677mr30531685ad.35.1791594005656; 
 Fri, 09 Oct 2026 18:00:05 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:59:40 -0700
In-Reply-To: <20261010005942.560881-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261005193943.1175072-1-joshwash@google.com>
 <20261010005942.560881-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.170.g584c36229d-goog
Message-ID: <20261010005942.560881-9-joshwash@google.com>
Subject: [PATCH v3 8/8] net/gve: refactor timestamp support to clock read type
From: Joshua Washington <joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, blasko@google.com, jtranoleary@google.com
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

Only enable the NIC timestamp device option for DQO queue formats.
GQI has no Rx timestamp support, so it no longer reserves the timestamp
report memzone or starts the clock sync thread.

Signed-off-by: Mark Blasko <blasko@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
v3:
- Keep the nic_ts_report_mz check before advertising
  RTE_ETH_RX_OFFLOAD_TIMESTAMP, so the offload is not advertised when
  timestamp setup failed.
- Drop the redundant GVE_DEV_CLK_UNSUPPORTED check from
  gve_alloc_nic_ts_report().
- Note in the commit message that GQI no longer sets up NIC
  timestamping.
---
 drivers/net/gve/base/gve_adminq.c | 5 +++--
 drivers/net/gve/gve_ethdev.c      | 7 ++++---
 drivers/net/gve/gve_ethdev.h      | 7 ++++++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index db3e43c6b0..65e865939f 100644
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
index 31698bc38a..3c8d1a76e4 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -897,7 +897,8 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
 
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_RSS_HASH;
-	if (!gve_is_gqi(priv) && priv->nic_ts_report_mz)
+	if (priv->clk_read_type != GVE_DEV_CLK_UNSUPPORTED &&
+	    priv->nic_ts_report_mz != NULL)
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 	dev_info->tx_offload_capa =
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS	|
@@ -1377,7 +1378,7 @@ gve_read_clock(struct rte_eth_dev *dev, uint64_t *clock)
 	uint64_t ts;
 	int err;
 
-	if (!priv->nic_timestamp_supported)
+	if (priv->clk_read_type == GVE_DEV_CLK_UNSUPPORTED)
 		return -EOPNOTSUPP;
 
 	if (!priv->nic_ts_report_mz)
@@ -1477,7 +1478,7 @@ gve_setup_nic_timestamp(struct gve_priv *priv)
 {
 	int err;
 
-	if (!priv->nic_timestamp_supported)
+	if (priv->clk_read_type == GVE_DEV_CLK_UNSUPPORTED)
 		return;
 
 	rte_atomic_store_explicit(&priv->nic_ts_read_fails, 0, rte_memory_order_relaxed);
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index b6c06cd82d..19eac9ec0b 100644
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
@@ -407,7 +412,7 @@ struct gve_priv {
 	TAILQ_HEAD(, gve_flow) active_flows;
 
 	/* HW Timestamping Fields */
-	bool nic_timestamp_supported;
+	enum gve_dev_clk_type clk_read_type;
 	const struct rte_memzone *nic_ts_report_mz;
 	struct gve_nic_ts_report *nic_ts_report;
 	pthread_mutex_t nic_ts_lock;
-- 
2.56.0.170.g584c36229d-goog

