Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17592CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 19:40:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1339F40E03;
	Mon,  5 Oct 2026 21:40:08 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mails.dpdk.org (Postfix) with ESMTP id AAEAD40DD5
 for <dev@dpdk.org>; Mon,  5 Oct 2026 21:40:06 +0200 (CEST)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e2f3251e91so18047915ad.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 12:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791229206; x=1791834006; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NVr/pTCAm+E0JgNL+m+WZPYBTOTDChVTMOzLwFblwD4=;
 b=l2coNl5lDX77q4y2ZoYpmWRRspATYxPEd2md/7Btvhl/yU9UGSvS3H0ZomedGmbLJV
 BZhxpbbYXFOSs7SMCYtzooDUAU9fGEQgHS6Pa66R4JfKhjUdO0vyDQF0/t5GX46vfQj/
 CUqSdEBZMHp0+WAljXgG4qPW5F49ibxo7RZoAO+S6VAj+kgz2QeJnA4/Qrr6zSH+dJgE
 DMir/1BksoU7N1CbEmw9uxANxAdevn8A4M87XvSUsnR7F1z2bsk/0gl+0OBtEIOjnbrQ
 oOkkt0jrAk3lmNcII56H2TIWYfbMxbk2fA80CxZiosHy1AUx5LCNy1FTqnPgKcla+pm5
 dRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791229206; x=1791834006;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NVr/pTCAm+E0JgNL+m+WZPYBTOTDChVTMOzLwFblwD4=;
 b=HFHceEckE7sJnxJHEAbGgKRWLOee1fY7ml0BDu6CAbVRX2rDJX16gcmkaWSOzr4xQl
 hiFufAnnicbxn1dGZy9ubDRhp8uFQJR8fVK66Uvl5xbJmaRmLWieJZJqXrsWofMti2e+
 N77rNjlhBiRyaRMNsM2c3x2IZmH7F9kOSziJe7LuyhSyhgBhwR335ztsCKa9SDVlzy/M
 HO4KnnpKZWTMYwGzW+hjYDIICJk2bNGpCnxESX+3ca1J2LstJIsKJ8TNouwcNpnXJQfO
 kGaXc0PZmhGu9MCW4EqZmTtZIClYnkzsqqcgfjQxaohhcOIRYUlxYfoSP4xqJsbgqBv5
 WAFg==
X-Gm-Message-State: AFq9FYJzt4oFLENwhshHAb6bf5P8IcT8Hg8O/cALKRb8yO0Jc+qbgkdz
 Nm70PM0PFsqbkaetgf5k/aaeMRTMjrqTLILXfrKzSfuVNTcLqKHHfpxasx22uhcnlB/HXMwpWnb
 /oBb9aMilwEhzAw==
X-Received: from plble11.prod.google.com ([2002:a17:902:fb0b:b0:2e3:1b6e:33bb])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c950:b0:2dd:c100:4b81 with SMTP id
 d9443c01a7336-2e49b6dc966mr105943365ad.56.1791229205430; 
 Mon, 05 Oct 2026 12:40:05 -0700 (PDT)
Date: Mon,  5 Oct 2026 12:39:34 -0700
In-Reply-To: <20261005193943.1175072-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261003025142.1930363-1-joshwash@google.com>
 <20261005193943.1175072-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005193943.1175072-4-joshwash@google.com>
Subject: [PATCH v2 3/8] net/gve: split default queue counts into Tx and Rx
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

