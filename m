Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CB4CA5FE3
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 02:52:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46A4742E99;
	Sat,  3 Oct 2026 04:51:52 +0200 (CEST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mails.dpdk.org (Postfix) with ESMTP id ADB4A4067B
 for <dev@dpdk.org>; Sat,  3 Oct 2026 04:51:50 +0200 (CEST)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-886129276ccso46741b3a.2
 for <dev@dpdk.org>; Fri, 02 Oct 2026 19:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790995910; x=1791600710; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NVr/pTCAm+E0JgNL+m+WZPYBTOTDChVTMOzLwFblwD4=;
 b=YNCB+feERtccw91fiPf+2sLn32IbLbiggoIeDsLJpUfJ02tHD3VHteHx71lozs7Knw
 6V8KOza2yaH9Cigco1M59R+Smo//4jEjgyRph0ZtdFG5P/Sk9LG5wXdHupvZwgn9iWV5
 SOKz1uyQ/ZzucOYg4uczMvHNFNFmXo3d0cVH460PEqbkxfr6blWo8V0XRFYE3p9UU657
 x3t57BcU8QWBYRUZE+MrtF8k+Uop5jwICly1k1KMc397QJGaN7I/HrKOS/RcGgiwgs4N
 9ckJa+OcJBkLGmuljhggKEeLEloY2nzOPH+59DbHxSM2BpzomJ8Yv9fEh/IwXDVVZmtO
 buwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995910; x=1791600710;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NVr/pTCAm+E0JgNL+m+WZPYBTOTDChVTMOzLwFblwD4=;
 b=TAW5FAldSUnZ7zz+pu77OfoGKguAb0XKeAOTTZ+ELopP7+9+Ebe2jH0WVzUcM76VEe
 zEIspDbiuRKodajcX0AZFBoCtB73MVeSqnKMojomTd2Y9BQjXR0oH3V/6A1Hz+0jhGwR
 h+1vLnF1qx1F732RwXa8AznctknpfeVvz1X6EphBHLXFjiPSbCqOwE4fmqyB+0GnC8bT
 lLaB6bvYwwkGKAEGBUuI9SsWrcCYH3eF8eReM4cctmN7Jp5dIC7L3l2k/oqF156gG/FR
 PuKoLH5F5cIDJ/zMIPaqJDLxMYw8Wwu0wegWth9Y3r7tbc6AxwFTLCA2xZKw7G9ypsb9
 4wMA==
X-Gm-Message-State: AFuF++lxkWYoCg37A+i4IPgv4j8IMxK5ANLmKCMs9RZK9aYLeuTl2tnr
 p0NbBS27nA77ZFvr5pGAyAbmdWRFtwJg22zlfiabjm9yTygPqgk8KjPP//804ZjYghZ+QXjIWMO
 ZXOed2KL2jX30Uw==
X-Received: from pfpk16.prod.google.com ([2002:aa7:9d10:0:b0:88b:9d6d:1e0e])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4148:b0:888:1763:b07f with SMTP id
 d2e1a72fcca58-88af249518amr4565927b3a.6.1790995909381; 
 Fri, 02 Oct 2026 19:51:49 -0700 (PDT)
Date: Fri,  2 Oct 2026 19:51:35 -0700
In-Reply-To: <20261003025142.1930363-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261003025142.1930363-4-joshwash@google.com>
Subject: [PATCH 3/8] net/gve: split default queue counts into Tx and Rx
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

Replace default_num_queues with separate default_tx_num_queues and
default_rx_num_queues fields in struct gve_priv. Update AdminQ device
description and queue initialization logic to use the per-direction
default queue counts.

Signed-off-by: Mark Blasko <blasko@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/base/gve_adminq.c | 4 ++--
 drivers/net/gve/gve_ethdev.c      | 8 ++++----
 drivers/net/gve/gve_ethdev.h      | 3 ++-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 74b9a0125c..4dd095880d 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -1083,8 +1083,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	PMD_DRV_LOG(INFO, "MAC addr: " RTE_ETHER_ADDR_PRT_FMT,
 		    RTE_ETHER_ADDR_BYTES(&priv->dev_addr));
 	priv->tx_pages_per_qpl = be16_to_cpu(descriptor->tx_pages_per_qpl);
-
-	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
+	priv->default_tx_num_queues = be16_to_cpu(descriptor->default_num_queues);
+	priv->default_rx_num_queues = be16_to_cpu(descriptor->default_num_queues);
 
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_flow_steering, dev_op_modify_ring,
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 9cfdd03b9d..3ba99fd74c 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1652,10 +1652,10 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	priv->max_nb_txq = RTE_MIN(priv->max_nb_txq, priv->num_ntfy_blks / 2);
 	priv->max_nb_rxq = RTE_MIN(priv->max_nb_rxq, priv->num_ntfy_blks / 2);
 
-	if (priv->default_num_queues > 0) {
-		priv->max_nb_txq = RTE_MIN(priv->default_num_queues, priv->max_nb_txq);
-		priv->max_nb_rxq = RTE_MIN(priv->default_num_queues, priv->max_nb_rxq);
-	}
+	if (priv->default_tx_num_queues > 0)
+		priv->max_nb_txq = RTE_MIN(priv->default_tx_num_queues, priv->max_nb_txq);
+	if (priv->default_rx_num_queues > 0)
+		priv->max_nb_rxq = RTE_MIN(priv->default_rx_num_queues, priv->max_nb_rxq);
 
 	PMD_DRV_LOG(INFO, "Max TX queues %d, Max RX queues %d",
 		    priv->max_nb_txq, priv->max_nb_rxq);
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index ef54b75c32..1a0ac87ed8 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -344,7 +344,8 @@ struct gve_priv {
 
 	uint64_t max_registered_pages;
 	uint64_t num_registered_pages; /* num pages registered with NIC */
-	uint16_t default_num_queues; /* default num queues to set up */
+	uint16_t default_tx_num_queues; /* default num tx queues to set up */
+	uint16_t default_rx_num_queues; /* default num rx queues to set up */
 	enum gve_queue_format queue_format; /* see enum gve_queue_format */
 	uint8_t enable_rsc;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

