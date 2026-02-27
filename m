Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641EC1039881
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 19:53:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E2D74060F;
	Fri, 27 Feb 2026 20:52:56 +0100 (CET)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73]) by mails.dpdk.org (Postfix) with ESMTP id 4DDB6402E7
 for <dev@dpdk.org>; Fri, 27 Feb 2026 20:52:55 +0100 (CET)
Received: by mail-pj1-f73.google.com with SMTP id
 98e67ed59e1d1-35626b11c51so2321975a91.1
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772221974; x=1772826774; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=9tEaPTKnb+wNGOkyIyc9mw5KfTfMWw8Ne1JZB5W3DoY=;
 b=pBBIfZS4lMc9K341GyVJg6kpm/+PIB5BaVnJqg9IsZDxIBaAzUOPfBo/yceXyAcq2D
 4/gWotJW2gBLWUjBhcUcuFNR0aZG9JEgW/xeBfYz14eKzLO6ud5LVgWx1vFJFhw2M4bc
 5VR00CPf1X5RSA0QthqPN5HvhY71LPUc4Fl4JS/NHxbRseQVBNUrXD5aZNNcBxNIM0wt
 k+BuOKpS3Kd3fLSVkisA2ie66UNhfKyc7oejqH6fkja+4GWBFGf+zI+3YUB09Ai4k6s5
 iFgwc9jKMv6EPjFDnPrrD9FvtLun/vPChSAzbInmt14xNAkQZLtKd3PwrfJhpiBaDTYF
 0N8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772221974; x=1772826774;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9tEaPTKnb+wNGOkyIyc9mw5KfTfMWw8Ne1JZB5W3DoY=;
 b=q9MQhfLFwGSN659p7j8A7K8NT0nrxYvp/EhphcpuUJOSTDMH6Fz2jn9XwV/ftksLpw
 rkjsrk6AV3V5VU7bK+gvyXWm/e4o9yzobGaRW8P++9UDOCtLjneaEE0aaK8IeVYNVrAa
 W4uFDhlEXhbOSiNvlI34ouVnegV/aCU7tjwVlY5iW1AsQShxSa4eqei80PvvMB+D5wAS
 CBG23GLcmAuosWyNj9f0XzuGgK96XBH4o1wQc9TqDGlSroLhUhC9PV09Eg8ZQb07vG6i
 zjGEE+AWwm5Y6+MzWFw9TWUP3hs8sRNS1Cl4YJujv+fNdyp7e+0bxuSUYtotP8ygfLLd
 pS2Q==
X-Gm-Message-State: AOJu0Yz5WPQTk6CrGglIMdPyLoLD8li1GFBufGieiCfKLxe0WrSSfED0
 hgDUjRTVyQDIUGem+f2R8bkP7sUxCeigNOqJ1dA1btFTNyVWfVhnk8KT8PyCyuZKYKdVbUJggbF
 iTmEqG/yhz7og2RwU+dofbso1pQ==
X-Received: from pjblk14.prod.google.com ([2002:a17:90b:33ce:b0:358:ee3e:b3da])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:234a:b0:340:ec6f:5ac5 with SMTP id
 98e67ed59e1d1-35965c27fdamr2823976a91.2.1772221974256; 
 Fri, 27 Feb 2026 11:52:54 -0800 (PST)
Date: Fri, 27 Feb 2026 19:51:23 +0000
In-Reply-To: <20260227195126.3545607-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260227195126.3545607-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227195126.3545607-2-jtranoleary@google.com>
Subject: [PATCH 1/4] net/gve: add flow steering device option
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Vee Agarwal <veethebee@google.com>, 
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

From: Vee Agarwal <veethebee@google.com>

Add a new device option to signal to the driver that the device supports
flow steering. This device option also carries the maximum number of
flow steering rules that the device can store.

Signed-off-by: Vee Agarwal <veethebee@google.com>
Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/base/gve_adminq.c | 36 ++++++++++++++++++++++++++++---
 drivers/net/gve/base/gve_adminq.h | 11 ++++++++++
 drivers/net/gve/gve_ethdev.h      |  2 ++
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 6bd98d5..64b9468 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -36,6 +36,7 @@ void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_option_gqi_rda **dev_op_gqi_rda,
 			     struct gve_device_option_gqi_qpl **dev_op_gqi_qpl,
 			     struct gve_device_option_dqo_rda **dev_op_dqo_rda,
+			     struct gve_device_option_flow_steering **dev_op_flow_steering,
 			     struct gve_device_option_modify_ring **dev_op_modify_ring,
 			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames)
 {
@@ -109,6 +110,22 @@ void gve_parse_device_option(struct gve_priv *priv,
 		}
 		*dev_op_dqo_rda = RTE_PTR_ADD(option, sizeof(*option));
 		break;
+	case GVE_DEV_OPT_ID_FLOW_STEERING:
+		if (option_length < sizeof(**dev_op_flow_steering) ||
+		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING) {
+			PMD_DRV_LOG(WARNING, GVE_DEVICE_OPTION_ERROR_FMT,
+				    "Flow Steering", (int)sizeof(**dev_op_flow_steering),
+				    GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING,
+				    option_length, req_feat_mask);
+			break;
+		}
+
+		if (option_length > sizeof(**dev_op_flow_steering)) {
+			PMD_DRV_LOG(WARNING,
+				    GVE_DEVICE_OPTION_TOO_BIG_FMT, "Flow Steering");
+		}
+		*dev_op_flow_steering = RTE_PTR_ADD(option, sizeof(*option));
+		break;
 	case GVE_DEV_OPT_ID_MODIFY_RING:
 		/* Min ring size bound is optional. */
 		if (option_length < (sizeof(**dev_op_modify_ring) -
@@ -167,6 +184,7 @@ gve_process_device_options(struct gve_priv *priv,
 			   struct gve_device_option_gqi_rda **dev_op_gqi_rda,
 			   struct gve_device_option_gqi_qpl **dev_op_gqi_qpl,
 			   struct gve_device_option_dqo_rda **dev_op_dqo_rda,
+			   struct gve_device_option_flow_steering **dev_op_flow_steering,
 			   struct gve_device_option_modify_ring **dev_op_modify_ring,
 			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames)
 {
@@ -188,8 +206,8 @@ gve_process_device_options(struct gve_priv *priv,
 
 		gve_parse_device_option(priv, dev_opt,
 					dev_op_gqi_rda, dev_op_gqi_qpl,
-					dev_op_dqo_rda, dev_op_modify_ring,
-					dev_op_jumbo_frames);
+					dev_op_dqo_rda, dev_op_flow_steering,
+					dev_op_modify_ring, dev_op_jumbo_frames);
 		dev_opt = next_opt;
 	}
 
@@ -777,9 +795,19 @@ gve_set_max_desc_cnt(struct gve_priv *priv,
 
 static void gve_enable_supported_features(struct gve_priv *priv,
 	u32 supported_features_mask,
+	const struct gve_device_option_flow_steering *dev_op_flow_steering,
 	const struct gve_device_option_modify_ring *dev_op_modify_ring,
 	const struct gve_device_option_jumbo_frames *dev_op_jumbo_frames)
 {
+	if (dev_op_flow_steering &&
+	    (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK) &&
+	    dev_op_flow_steering->max_flow_rules) {
+		priv->max_flow_rules =
+			be32_to_cpu(dev_op_flow_steering->max_flow_rules);
+		PMD_DRV_LOG(INFO,
+			    "FLOW STEERING device option enabled with max rule limit of %u.",
+			    priv->max_flow_rules);
+	}
 	if (dev_op_modify_ring &&
 	    (supported_features_mask & GVE_SUP_MODIFY_RING_MASK)) {
 		PMD_DRV_LOG(INFO, "MODIFY RING device option enabled.");
@@ -802,6 +830,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 {
 	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
 	struct gve_device_option_modify_ring *dev_op_modify_ring = NULL;
+	struct gve_device_option_flow_steering *dev_op_flow_steering = NULL;
 	struct gve_device_option_gqi_rda *dev_op_gqi_rda = NULL;
 	struct gve_device_option_gqi_qpl *dev_op_gqi_qpl = NULL;
 	struct gve_device_option_dqo_rda *dev_op_dqo_rda = NULL;
@@ -829,6 +858,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	err = gve_process_device_options(priv, descriptor, &dev_op_gqi_rda,
 					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
+					 &dev_op_flow_steering,
 					 &dev_op_modify_ring,
 					 &dev_op_jumbo_frames);
 	if (err)
@@ -884,7 +914,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
 
 	gve_enable_supported_features(priv, supported_features_mask,
-				      dev_op_modify_ring,
+				      dev_op_flow_steering, dev_op_modify_ring,
 				      dev_op_jumbo_frames);
 
 free_device_descriptor:
diff --git a/drivers/net/gve/base/gve_adminq.h b/drivers/net/gve/base/gve_adminq.h
index 6a3d469..e237353 100644
--- a/drivers/net/gve/base/gve_adminq.h
+++ b/drivers/net/gve/base/gve_adminq.h
@@ -117,6 +117,14 @@ struct gve_ring_size_bound {
 
 GVE_CHECK_STRUCT_LEN(4, gve_ring_size_bound);
 
+struct gve_device_option_flow_steering {
+	__be32 supported_features_mask;
+	__be32 reserved;
+	__be32 max_flow_rules;
+};
+
+GVE_CHECK_STRUCT_LEN(12, gve_device_option_flow_steering);
+
 struct gve_device_option_modify_ring {
 	__be32 supported_features_mask;
 	struct gve_ring_size_bound max_ring_size;
@@ -148,6 +156,7 @@ enum gve_dev_opt_id {
 	GVE_DEV_OPT_ID_DQO_RDA = 0x4,
 	GVE_DEV_OPT_ID_MODIFY_RING = 0x6,
 	GVE_DEV_OPT_ID_JUMBO_FRAMES = 0x8,
+	GVE_DEV_OPT_ID_FLOW_STEERING = 0xb,
 };
 
 enum gve_dev_opt_req_feat_mask {
@@ -155,6 +164,7 @@ enum gve_dev_opt_req_feat_mask {
 	GVE_DEV_OPT_REQ_FEAT_MASK_GQI_RDA = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_GQI_QPL = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_RDA = 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FRAMES = 0x0,
 };
@@ -162,6 +172,7 @@ enum gve_dev_opt_req_feat_mask {
 enum gve_sup_feature_mask {
 	GVE_SUP_MODIFY_RING_MASK = 1 << 0,
 	GVE_SUP_JUMBO_FRAMES_MASK = 1 << 2,
+	GVE_SUP_FLOW_STEERING_MASK = 1 << 5,
 };
 
 #define GVE_DEV_OPT_LEN_GQI_RAW_ADDRESSING 0x0
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index f7cc781..3a810b6 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -332,6 +332,8 @@ struct gve_priv {
 
 	struct gve_rss_config rss_config;
 	struct gve_ptype_lut *ptype_lut_dqo;
+
+	uint32_t max_flow_rules;
 };
 
 static inline bool
-- 
2.53.0.473.g4a7958ca14-goog

