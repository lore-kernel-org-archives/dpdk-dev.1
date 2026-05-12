Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFE8CD4846
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 00:51:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5817740650;
	Tue, 12 May 2026 02:51:08 +0200 (CEST)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74]) by mails.dpdk.org (Postfix) with ESMTP id 2500C40278
 for <dev@dpdk.org>; Tue, 12 May 2026 02:51:06 +0200 (CEST)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8acb26fbbb2so67585986d6.2
 for <dev@dpdk.org>; Mon, 11 May 2026 17:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778547065; x=1779151865; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tS33VN/mb+G/G7/sAJHMGL5jYb9q1YfSPd4R3IR26OA=;
 b=i7KsBPWvwZZMkSckLFkgOTXKGmTXXJwPsck35uFwYoaRK7qhwaa/yJjRmcJSBiX2mH
 aduZcBO1+ODN6MapPREIPcJmNGR1f6+/R0ue3YRjuJL19+H3qFWMzNKgwAPooqD6fcLV
 z9DOVd3ACji6vVqnn/ArITlV7uz6gV2Ni/ybPZErGhiD/HaKDcq5oxrlqts/lXREC0R4
 UGE2yGHQZ/FsftmBl8wQUqyfrUeccWAeBNbvW7Tc26IjvVpZ/Gl+WPp+lMWNsPYALt5+
 e1jCCEhktao1Fl81MxQ0gfKGMSuZX09iePFV+yVqHKgaCafdIsERiYGKBVrQSU5PxFdN
 UD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778547065; x=1779151865;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tS33VN/mb+G/G7/sAJHMGL5jYb9q1YfSPd4R3IR26OA=;
 b=h9mZI2VHlnEtcu+E+0rjaruRSwoRF/p0u8BGRrOHi7i1pl5yRY+lfwhW+FFnLGoNJ+
 3XmXg/E6qxU8B9hXfwbJNbDP8vicLn6R4yLgjlHdhg9UtnyEgmOVvu9Yz/vsyrWmfwhi
 nt2vwwhG6nm4Y9F/bfMikN8+Wl06Lnltjylmw04FaJesby1YSfADifAcVkLp0cuo0cYo
 AzzN0k5KvHuvOvvAizgteM6nxKF/2vCGw3SLuNzmYVHv9lY9W0dmGooIMnQAMaJsUw7E
 AHPK1FVkBt5z0Gz87/7N7GXhwqsqVSYuoUl0zEa0VysH/iQ7N0+9RmluLJ+9amXMaJGC
 x8EQ==
X-Gm-Message-State: AOJu0YzhblTyrbVGBRoAqtEcIZG9MQvcXydDR6CalaKnUyOcXHd42R4f
 LyJYC7c/Dg8MZFD/Z013AlFKG0EenloKhG0J+xluXd9e689E/nkocHq942LGkBEgaadzs456uxI
 LUkUq4A==
X-Received: from qvbke22.prod.google.com
 ([2002:a05:6214:3016:b0:8ac:b0a2:6721])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:29cb:b0:8c4:7416:1b6f
 with SMTP id 6a1803df08f44-8c474161d4emr105317386d6.35.1778547065218; Mon, 11
 May 2026 17:51:05 -0700 (PDT)
Date: Tue, 12 May 2026 00:50:51 +0000
In-Reply-To: <20260512005057.944672-1-blasko@google.com>
Mime-Version: 1.0
References: <20260512005057.944672-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512005057.944672-3-blasko@google.com>
Subject: [PATCH 2/6] net/gve: add device option support for HW timestamps
From: mark-blasko <blasko@google.com>
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

