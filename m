Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64083CA601E
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 01:00:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A90F4060F;
	Sat, 10 Oct 2026 02:59:56 +0200 (CEST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mails.dpdk.org (Postfix) with ESMTP id 60AEF40615
 for <dev@dpdk.org>; Sat, 10 Oct 2026 02:59:55 +0200 (CEST)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e827b3a6b4so3620055ad.2
 for <dev@dpdk.org>; Fri, 09 Oct 2026 17:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791593994; x=1792198794; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FdCbBX+3hmDfRw2zAzkVMmm2KiKLMsf/OeoagKJvIV8=;
 b=KHfO4vWQjqZq0JCa5G1oUdoVOKWrXyyJMQFEYF7haW+N1ejs3INzg4okWUgLax1PHU
 FQA19BM3xRlMNx9SmSOC67+1Lkk8KZzwO0Cw+URrZ9PYnmZTjvltX+5+klqJU9qjofvx
 evT3rZCFuPi5Z4DH9ntQ+RMG/woWLx333U67L4KKp5IPbKG5uMJ03Dgg0mZBBeXNoGxz
 sSH0TbUj/cjLQgCOAs0N5Jjmv95Bm3Ts7Av/FTyqRZZjhw9FePy/Th6UsU26R6kZm05Z
 0OVTg8Ru37HLnKRUpakM+HD1ox5LPh7R1ymstuQ4C3WSWUYzI2qwI9GvT6JvXoPNsU7H
 Kb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791593994; x=1792198794;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FdCbBX+3hmDfRw2zAzkVMmm2KiKLMsf/OeoagKJvIV8=;
 b=Sg0NQ25FBGnzUrevExCD95262nk6sMHoBIIeNNXTDqUG5fmWb7B36hioGPH4prO47R
 TXtPAGoNF1owXREo2TdjlE+qv7CYQVBGGR6ixB4kzf74dkJmX3flWTJliKvyVgqjpbdR
 gNq7C8rOHQ1DMyRV80hNPjiXN/7wxt3L7oYtDWcVHDNsNStdcszoJiGZGXGX6/bsrR15
 bHE14nQpA6y/PGaGzMGG8uDQcFKZQgzAT+GI4LNtaVJPkhH3iqfB2SFKFZ4EqdgjXIYO
 +Kcfh4o9AaZN7B/+Gm0V+Zitl5q+/9IdNVFtdP9dFHRROhbTLg8nUq6uRTC7EPSeqPRD
 tkiA==
X-Gm-Message-State: AFq9FYJHa6tfphGkoroCjH6hSBdAj06Ar2epBIB2ws/NvxPoK8ikGPM4
 YYJXsTOoclzP1xgh4ZFkSGI9KQ6FqODgzqRX3la5Z6dw61KrIMoiFhqbFjYXmSgXsLGUeiQCX0A
 H9gDkl5WVn1xkqQ==
X-Received: from plbbb2.prod.google.com ([2002:a17:902:bc82:b0:2e5:6150:b950])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef45:b0:2e8:2f7:4a60 with SMTP id
 d9443c01a7336-2e842cd211emr27771495ad.51.1791593994231; 
 Fri, 09 Oct 2026 17:59:54 -0700 (PDT)
Date: Fri,  9 Oct 2026 17:59:36 -0700
In-Reply-To: <20261010005942.560881-1-joshwash@google.com>
Mime-Version: 1.0
References: <20261005193943.1175072-1-joshwash@google.com>
 <20261010005942.560881-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.170.g584c36229d-goog
Message-ID: <20261010005942.560881-5-joshwash@google.com>
Subject: [PATCH v3 4/8] net/gve: split default queue counts into Tx and Rx
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
index 30ceeeabd0..1ee49856af 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1683,10 +1683,10 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
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
index 10572a754e..fb894f0061 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -339,7 +339,8 @@ struct gve_priv {
 
 	uint64_t max_registered_pages;
 	uint64_t num_registered_pages; /* num pages registered with NIC */
-	uint16_t default_num_queues; /* default num queues to set up */
+	uint16_t default_tx_num_queues; /* default num tx queues to set up */
+	uint16_t default_rx_num_queues; /* default num rx queues to set up */
 	enum gve_queue_format queue_format; /* see enum gve_queue_format */
 	uint8_t enable_rsc;
 
-- 
2.56.0.170.g584c36229d-goog

