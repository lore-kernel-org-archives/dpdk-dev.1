Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB43FCD4F26
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:57:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64A2240A6C;
	Tue, 12 May 2026 09:56:03 +0200 (CEST)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mails.dpdk.org (Postfix) with ESMTP id 9718340278
 for <dev@dpdk.org>; Tue, 12 May 2026 00:44:03 +0200 (CEST)
Received: by mail-qt1-f202.google.com with SMTP id
 d75a77b69052e-50fbc49bef6so75546701cf.0
 for <dev@dpdk.org>; Mon, 11 May 2026 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778539443; x=1779144243; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tS33VN/mb+G/G7/sAJHMGL5jYb9q1YfSPd4R3IR26OA=;
 b=O8uRdboYyiQWRzgTazhILO27YcHu1qx2HC154g7V6kz1HIsFkPzdHWo0FGkjDBFGr1
 dDpHvNhx/+hoIUkqGltltFafiHYw7fpzK9+8BVp8p9iP29iGO959cxPkyyLSaMFw71hS
 PinKQc1hrYzI5tt7pDcKQvzcqFt7k7xfKgl6omNSC1INSeFj5f1I8U5ZvfFLv8TDdRbM
 SdhL/ZQrfO8harCUKP5asvBjGOb1oCwWWzz8mFu9B9+Ac15dzlFrKs3cxHsnZtuGKKxb
 O4Ju3NgR5KTyDcx/IqRzb9PRW1qWfDlGGku4Ue1rsWrRBSAmOBzWL3n1zJjZ0PQN0QrS
 Vk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778539443; x=1779144243;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tS33VN/mb+G/G7/sAJHMGL5jYb9q1YfSPd4R3IR26OA=;
 b=NvoBom9YvVCsnm7rfI5SQIUoXu+NO4braadSc8hlCRBr21PWX1/hYed357GoxovpyG
 pjaFT1QG+u/6kHo2pmhVndYglXw1/blpQ3elM63GomdCxhmf5R+APw0uu4sj9Dqnf3iC
 7Yktn4AjIkQuXW4/2BKvLG3M4S3L7US8H1PuILHFppXbfeYIc7Q0Mh+kwLxCbmeBly7A
 WQcUGKah0GiGTp7bHkrUPKT/9QZnR2Sdx+3rA1K6PW6vGpWTp3eBkvp2R0vIiaj6kA9k
 jih7MlR64hNRKQQfyBOVrt2MW0OUWhGSrNs7i2BgaiENPBByV+Tg5y10QkL+APVo8UYR
 pIRg==
X-Gm-Message-State: AOJu0YyaV4FP1Otcpnl0eCPrstEj9CUWPqmi6GnD/S6W8mTHC0DCIgE3
 5qITKQzxc8I+s5WOq8C9N123HUrHU8pgLEIRRSWy3SLoTlea7DYoBkd/MH6koIL+lz3h4hIft26
 1cfIA8A==
X-Received: from qtblm13.prod.google.com ([2002:ac8:628d:0:b0:50d:6910:6597])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:90e:b0:50f:ae67:96df
 with SMTP id d75a77b69052e-514621d6ed0mr355708641cf.50.1778539442654; Mon, 11
 May 2026 15:44:02 -0700 (PDT)
Date: Mon, 11 May 2026 22:43:50 +0000
In-Reply-To: <20260511224354.872997-1-blasko@google.com>
Mime-Version: 1.0
References: <20260511224354.872997-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511224354.872997-3-blasko@google.com>
Subject: [PATCH 2/6] net/gve: add device option support for HW timestamps
From: mark-blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>, 
 Joshua Washington <joshwash@google.com>,
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 12 May 2026 09:55:49 +0200
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

Introduce the necessary definitions and functions for the device
option flag (GVE_DEV_OPT_ID_NIC_TIMESTAMP) to detect hardware
timestamping support in the gvnic device.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/base/gve_adminq.c | 41 ++++++++++++++++++++++++++-----
 drivers/net/gve/base/gve_adminq.h |  9 +++++++
 drivers/net/gve/gve_ethdev.h      |  3 +++
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 28661fb6cd..c9095fd165 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -38,7 +38,8 @@ void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_option_dqo_rda **dev_op_dqo_rda,
 			     struct gve_device_option_flow_steering **dev_op_flow_steering,
 			     struct gve_device_option_modify_ring **dev_op_modify_ring,
-			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames)
+			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
+			     struct gve_device_option_nic_timestamp **dev_op_nic_timestamp)
 {
 	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
 	u16 option_length = be16_to_cpu(option->option_length);
@@ -168,6 +169,24 @@ void gve_parse_device_option(struct gve_priv *priv,
 		}
 		*dev_op_jumbo_frames = RTE_PTR_ADD(option, sizeof(*option));
 		break;
+	case GVE_DEV_OPT_ID_NIC_TIMESTAMP:
+		if (option_length < sizeof(**dev_op_nic_timestamp) ||
+		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_NIC_TIMESTAMP) {
+			PMD_DRV_LOG(WARNING, GVE_DEVICE_OPTION_ERROR_FMT,
+				    "Nic Timestamp",
+				    (int)sizeof(**dev_op_nic_timestamp),
+				    GVE_DEV_OPT_REQ_FEAT_MASK_NIC_TIMESTAMP,
+				    option_length, req_feat_mask);
+			break;
+		}
+
+		if (option_length > sizeof(**dev_op_nic_timestamp)) {
+			PMD_DRV_LOG(WARNING,
+				    GVE_DEVICE_OPTION_TOO_BIG_FMT,
+				    "Nic Timestamp");
+		}
+		*dev_op_nic_timestamp = RTE_PTR_ADD(option, sizeof(*option));
+		break;
 	default:
 		/* If we don't recognize the option just continue
 		 * without doing anything.
@@ -186,7 +205,8 @@ gve_process_device_options(struct gve_priv *priv,
 			   struct gve_device_option_dqo_rda **dev_op_dqo_rda,
 			   struct gve_device_option_flow_steering **dev_op_flow_steering,
 			   struct gve_device_option_modify_ring **dev_op_modify_ring,
-			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames)
+			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
+			   struct gve_device_option_nic_timestamp **dev_op_nic_timestamp)
 {
 	const int num_options = be16_to_cpu(descriptor->num_device_options);
 	struct gve_device_option *dev_opt;
@@ -207,7 +227,8 @@ gve_process_device_options(struct gve_priv *priv,
 		gve_parse_device_option(priv, dev_opt,
 					dev_op_gqi_rda, dev_op_gqi_qpl,
 					dev_op_dqo_rda, dev_op_flow_steering,
-					dev_op_modify_ring, dev_op_jumbo_frames);
+					dev_op_modify_ring, dev_op_jumbo_frames,
+					dev_op_nic_timestamp);
 		dev_opt = next_opt;
 	}
 
@@ -921,7 +942,8 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 	u32 supported_features_mask,
 	const struct gve_device_option_flow_steering *dev_op_flow_steering,
 	const struct gve_device_option_modify_ring *dev_op_modify_ring,
-	const struct gve_device_option_jumbo_frames *dev_op_jumbo_frames)
+	const struct gve_device_option_jumbo_frames *dev_op_jumbo_frames,
+	const struct gve_device_option_nic_timestamp *dev_op_nic_timestamp)
 {
 	if (dev_op_flow_steering &&
 	    (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK) &&
@@ -948,6 +970,11 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 		PMD_DRV_LOG(INFO, "JUMBO FRAMES device option enabled.");
 		priv->max_mtu = be16_to_cpu(dev_op_jumbo_frames->max_mtu);
 	}
+	if (dev_op_nic_timestamp &&
+	    (supported_features_mask & GVE_SUP_NIC_TIMESTAMP_MASK)) {
+		PMD_DRV_LOG(INFO, "NIC TIMESTAMP device option enabled.");
+		priv->nic_timestamp_supported = true;
+	}
 }
 
 int gve_adminq_describe_device(struct gve_priv *priv)
@@ -955,6 +982,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
 	struct gve_device_option_modify_ring *dev_op_modify_ring = NULL;
 	struct gve_device_option_flow_steering *dev_op_flow_steering = NULL;
+	struct gve_device_option_nic_timestamp *dev_op_nic_timestamp = NULL;
 	struct gve_device_option_gqi_rda *dev_op_gqi_rda = NULL;
 	struct gve_device_option_gqi_qpl *dev_op_gqi_qpl = NULL;
 	struct gve_device_option_dqo_rda *dev_op_dqo_rda = NULL;
@@ -984,7 +1012,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
 					 &dev_op_flow_steering,
 					 &dev_op_modify_ring,
-					 &dev_op_jumbo_frames);
+					 &dev_op_jumbo_frames,
+					 &dev_op_nic_timestamp);
 	if (err)
 		goto free_device_descriptor;
 
@@ -1039,7 +1068,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	gve_enable_supported_features(priv, supported_features_mask,
 				      dev_op_flow_steering, dev_op_modify_ring,
-				      dev_op_jumbo_frames);
+				      dev_op_jumbo_frames, dev_op_nic_timestamp);
 
 free_device_descriptor:
 	gve_free_dma_mem(&descriptor_dma_mem);
diff --git a/drivers/net/gve/base/gve_adminq.h b/drivers/net/gve/base/gve_adminq.h
index d8e5e6a352..eaee5649f2 100644
--- a/drivers/net/gve/base/gve_adminq.h
+++ b/drivers/net/gve/base/gve_adminq.h
@@ -153,6 +153,12 @@ struct gve_device_option_jumbo_frames {
 
 GVE_CHECK_STRUCT_LEN(8, gve_device_option_jumbo_frames);
 
+struct gve_device_option_nic_timestamp {
+	__be32 supported_features_mask;
+};
+
+GVE_CHECK_STRUCT_LEN(4, gve_device_option_nic_timestamp);
+
 /* Terminology:
  *
  * RDA - Raw DMA Addressing - Buffers associated with SKBs are directly DMA
@@ -169,6 +175,7 @@ enum gve_dev_opt_id {
 	GVE_DEV_OPT_ID_MODIFY_RING = 0x6,
 	GVE_DEV_OPT_ID_JUMBO_FRAMES = 0x8,
 	GVE_DEV_OPT_ID_FLOW_STEERING = 0xb,
+	GVE_DEV_OPT_ID_NIC_TIMESTAMP = 0xd,
 };
 
 enum gve_dev_opt_req_feat_mask {
@@ -179,12 +186,14 @@ enum gve_dev_opt_req_feat_mask {
 	GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FRAMES = 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_NIC_TIMESTAMP = 0x0,
 };
 
 enum gve_sup_feature_mask {
 	GVE_SUP_MODIFY_RING_MASK = 1 << 0,
 	GVE_SUP_JUMBO_FRAMES_MASK = 1 << 2,
 	GVE_SUP_FLOW_STEERING_MASK = 1 << 5,
+	GVE_SUP_NIC_TIMESTAMP_MASK = 1 << 8,
 };
 
 #define GVE_DEV_OPT_LEN_GQI_RAW_ADDRESSING 0x0
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 524e48e723..b9b4688367 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -355,6 +355,9 @@ struct gve_priv {
 	void *avail_flow_rule_bmp_mem; /* Backing memory for the bitmap */
 	pthread_mutex_t flow_rule_lock; /* Lock for bitmap and tailq access */
 	TAILQ_HEAD(, gve_flow) active_flows;
+
+	/* HW Timestamping Fields */
+	bool nic_timestamp_supported;
 };
 
 static inline bool
-- 
2.54.0.563.g4f69b47b94-goog

