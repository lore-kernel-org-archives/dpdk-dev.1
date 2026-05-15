Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E402FCD343F
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 23:19:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C395D4065F;
	Sat, 16 May 2026 01:19:45 +0200 (CEST)
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com
 [74.125.224.73]) by mails.dpdk.org (Postfix) with ESMTP id B5632402E1
 for <dev@dpdk.org>; Sat, 16 May 2026 01:19:42 +0200 (CEST)
Received: by mail-yx1-f73.google.com with SMTP id
 956f58d0204a3-65d8659ae23so5191290d50.1
 for <dev@dpdk.org>; Fri, 15 May 2026 16:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778887182; x=1779491982; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=NRIG3hpabqjHprsgdaq58cSJ6OqwqMdeF0gPGPY/7H4=;
 b=lB35ab4IftrP757UNc9pQuXSfaVojQIUpCKp7La7VO2fk1+flFkIFRS9fRlNlEEuBV
 um2bCjtbAD1xShWubZibvQYVI3Ew1f15xgJ+4esDC5K+zcf03Df6SR67hMt4zAj9AZaf
 hLUiV45L9eocGg2Wlls1OR/4YEhyea/G4Ax3cdiDfRGtLJ+dR6pWnaYD+pVVEq+nrP44
 WBgV81Bren0DAk72neTVx/jNFJogHR0Ns/RtjA6F07H4YeDOG7Q4DhasL6TyKwXa9kJV
 bxj+2j+1S7yw5gNFcDOYDht1sFK99v4iLt0Cfnh8YV1nxfsE8ZQRz9m/FlxU4IQzLN3y
 z5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778887182; x=1779491982;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NRIG3hpabqjHprsgdaq58cSJ6OqwqMdeF0gPGPY/7H4=;
 b=nLJdkfQTDPp3/+1GKY/rRqjTUcU2BL2K3Jz3aJ6edC7iCDa+qaNkxIgItpNmNZv4wP
 sxrGGtqQeicbqlpNn2mU77CR3XDnoWvZkeRKtupBgskASAczuEZQSzVRjyJMuiouHDoK
 5PzLZZHvdBPQZSZpfxI6b/YCLrC/xcXCpL41dHdk1it4p8ZJXfYyztkrlZIOK/TigVdm
 XMIyOqJZS7sa7GgTSCoja+zfBCZO/ddQe3ZodcA93AejQ2FdNhEAnxQn7qbrqxJB6R2S
 e8DcSEqU34Y+OW2Gg8HMC4d0mzST7Z8WSe1VVuuhTEWE30WcDomxEG1mrxTj9MdNaAzq
 FiYw==
X-Gm-Message-State: AOJu0Yy3rc9O8lNCy3oHGkJhbWk7K/LvQng6VZGEhsuNX4w1RK6dcAID
 4HcPfNqHU6Y+8c5RPS3s5OtLxIqO6Lz2JKKkXxZTOjawYHTr8VWgg0qatk8+YMwOCxZvYzcwF43
 dRm0m5A==
X-Received: from ywjj4-n1.prod.google.com
 ([2002:a05:690c:a084:10b0:79a:99be:693f])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:4007:b0:650:26c1:ee84
 with SMTP id 956f58d0204a3-65e0b04a256mr9137943d50.11.1778887181812; Fri, 15
 May 2026 16:19:41 -0700 (PDT)
Date: Fri, 15 May 2026 23:19:31 +0000
In-Reply-To: <20260515231936.3296603-1-blasko@google.com>
Mime-Version: 1.0
References: <20260511224354.872997-1-blasko@google.com>
 <20260515231936.3296603-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515231936.3296603-3-blasko@google.com>
Subject: [PATCH v2 2/6] net/gve: add device option support for HW timestamps
From: Mark Blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>, 
 Joshua Washington <joshwash@google.com>,
 "Jasper Tran O'Leary" <jtranoleary@google.com>
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
index 743ab8e7ae..1ced1e442e 100644
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
 
@@ -920,7 +941,8 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 	u32 supported_features_mask,
 	const struct gve_device_option_flow_steering *dev_op_flow_steering,
 	const struct gve_device_option_modify_ring *dev_op_modify_ring,
-	const struct gve_device_option_jumbo_frames *dev_op_jumbo_frames)
+	const struct gve_device_option_jumbo_frames *dev_op_jumbo_frames,
+	const struct gve_device_option_nic_timestamp *dev_op_nic_timestamp)
 {
 	if (dev_op_flow_steering &&
 	    (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK) &&
@@ -947,6 +969,11 @@ static void gve_enable_supported_features(struct gve_priv *priv,
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
@@ -954,6 +981,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
 	struct gve_device_option_modify_ring *dev_op_modify_ring = NULL;
 	struct gve_device_option_flow_steering *dev_op_flow_steering = NULL;
+	struct gve_device_option_nic_timestamp *dev_op_nic_timestamp = NULL;
 	struct gve_device_option_gqi_rda *dev_op_gqi_rda = NULL;
 	struct gve_device_option_gqi_qpl *dev_op_gqi_qpl = NULL;
 	struct gve_device_option_dqo_rda *dev_op_dqo_rda = NULL;
@@ -983,7 +1011,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
 					 &dev_op_flow_steering,
 					 &dev_op_modify_ring,
-					 &dev_op_jumbo_frames);
+					 &dev_op_jumbo_frames,
+					 &dev_op_nic_timestamp);
 	if (err)
 		goto free_device_descriptor;
 
@@ -1038,7 +1067,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
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

