Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85161CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5F2D40DC9;
	Wed, 29 Oct 2025 17:23:50 +0100 (CET)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id 206394066C
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:23:46 +0100 (CET)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-29476dc9860so199145ad.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761755025; x=1762359825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HtdPxNPtmU3K9mZ42u5ladPBVslv1KVckWHQxGzwVss=;
 b=pSh2+hdtRg2yYhSox0ZDo0kKAk3hyf+dITfmKtWh8L2mOzzFJBp7/POUehy9JC/Gzx
 HfJ+6K6fmM7CYZ0rjSSsPwxcNXJpQ8q9Gejlxfl1+T2saCSkKYWOGepbrHvoz64tkE5R
 EiY2RDCrVfzNYZ6uQDh4A0Ki+KV026D+JyP0bJxAvOTKVxKWc8GM0YLDgk0NafBPRcbi
 rFEGr21cD5dfpLxVCY05Bg1RqG6ga8V13XEWZ3MB+mUFUp0RJBFGclsoouRuAshUqAiQ
 xjxXEFkLXhRSg1lqCp6qsaNR3Vsm7Enpbb+MSyiVqqQ9XsOkiuv2sr0AN0c3RXz5FaQ7
 0s7g==
X-Gm-Message-State: AOJu0YxUAmwnQKo6iRodpVLT4iNDPreCBjIzVJVAJ1HORlWwF/HOrSKy
 JF8XKG3CAJcOje1zFpt2nWW9oDBzR4ws+wrS89YfuPrk3v5T1JDDSlyBADp9fApg6/6jI7as73F
 /pco/IASRIjEblxgftdbYXpi4DkvRTSjoyQwdPWjz7wJ0+jF1b+2cJ3A46/q9SqeuueXeLtw8Az
 VjSk9cUPthTu01tmptHSE7U5mGwRWkk8CQIG0sbPGxjzLYpylvSrrN6iBnmCXZw3WaoTFVxA==
X-Gm-Gg: ASbGnctpBmbrfZfYUeikSXKMOdD7k21hJfjreQYvDch1ZemRN6xLfJ9rb403PfHDGVy
 UNQEQRIuDK2C4vufb+iG/Q69HhKN+BY3Mkydjny5YzvN7jQFM9YpiM6v3KE0w48YDcCWJ+jemTN
 l4NxReN1zVs67KkR94puQdS6kWbZoMwSL/NE5DYb7/C8Cj1GmO9pL89xzP2huMUEULsh93s5fQG
 8cCpQH/7l3/SzR1Qr0LYI+RD+gHau5/4zl/+8dO2hRatzFnf/pBV0v6/61wqgxZgEbV3n9cH8bl
 N8gVMghDDf7G0tfka4INIp0FblKZ4YptjUOzQLCqdKsMCh/lznEKD7SYFT/k9bhU4g5930ktC0s
 7jYgy9czF1fASaFHhgWSRKG+0/bPnB8NwgBjU4tE4MSlmUjHiekKAUBSrIa4LvAga1u9YGWwbK3
 Echihcv3pTiUmBYQPNP8ZzfYZ9P4ZpY9s=
X-Google-Smtp-Source: AGHT+IH78vU5PMjaE7bB3I/GuwJ+/scSk/luubv5VZQQqBiH95zY7sAZMQZ/xXfbVsTT85O34wf+Xpny544/
X-Received: by 2002:a17:902:ecd0:b0:271:479d:3de2 with SMTP id
 d9443c01a7336-294dee121bcmr46296525ad.13.1761755025168; 
 Wed, 29 Oct 2025 09:23:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29498cf507fsm13007765ad.8.2025.10.29.09.23.44
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:23:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8a65ae81248so847124885a.2
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761755023; x=1762359823; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtdPxNPtmU3K9mZ42u5ladPBVslv1KVckWHQxGzwVss=;
 b=AU+d/hU58VGNxcQZS2KNsITXN+GLmyJE/PTh4EwUp7Pnv5wohWhDhJ7zP5pqrIKhC7
 5fFP/e36irtEIy9VSuaRcSzKphIET7ydrde2c6c8PeWhyKVwTbAmF7HQ1FNmXg9aRcCn
 AkuxF476wecuhZxAoSu8UTYJtklH6gwvlqLeM=
X-Received: by 2002:a05:620a:45a6:b0:82a:fb2c:ae06 with SMTP id
 af79cd13be357-8a8ed1639b4mr476571785a.1.1761755023517; 
 Wed, 29 Oct 2025 09:23:43 -0700 (PDT)
X-Received: by 2002:a05:620a:45a6:b0:82a:fb2c:ae06 with SMTP id
 af79cd13be357-8a8ed1639b4mr476566285a.1.1761755022913; 
 Wed, 29 Oct 2025 09:23:42 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.23.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:23:42 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v5 51/57] net/bnxt/tf_ulp: add support for unicast only feature
Date: Wed, 29 Oct 2025 12:07:06 -0400
Message-Id: <20251029160712.58519-52-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Added support for unicast only feature bit in the truflow application.
This enables the application to not receive broadcast, multicast or
unknown mac addresses to the ports that are participating in the
application.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c          | 5 +++++
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c         | 5 +++++
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h       | 2 ++
 drivers/net/bnxt/tf_ulp/ulp_def_rules.c        | 3 ---
 drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h | 3 ++-
 5 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index 54a5e6968c..d2d97d9cf0 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
@@ -475,6 +475,11 @@ ulp_tf_cntxt_app_caps_init(struct bnxt *bp,
 					      &ulp_ctx->cfg_data->feature_bits))
 			return -EINVAL;
 
+		if ((ulp_ctx->cfg_data->feature_bits &
+		     BNXT_ULP_FEATURE_BIT_UNICAST_ONLY))
+			ulp_ctx->cfg_data->ulp_flags |=
+			BNXT_ULP_APP_UNICAST_ONLY;
+
 		bnxt_ulp_cntxt_ptr2_default_class_bits_set(ulp_ctx,
 							   info[i].default_class_bits);
 		bnxt_ulp_cntxt_ptr2_default_act_bits_set(ulp_ctx,
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index 772dd69035..ad44ec93ca 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -562,6 +562,11 @@ ulp_tfc_cntxt_app_caps_init(struct bnxt *bp, uint8_t app_id, uint32_t dev_id)
 					      &ulp_ctx->cfg_data->feature_bits))
 			return -EINVAL;
 
+		if ((ulp_ctx->cfg_data->feature_bits &
+		     BNXT_ULP_FEATURE_BIT_UNICAST_ONLY))
+			ulp_ctx->cfg_data->ulp_flags |=
+			BNXT_ULP_APP_UNICAST_ONLY;
+
 		bnxt_ulp_default_app_priority_set(ulp_ctx,
 						  info[i].default_priority);
 		bnxt_ulp_max_def_priority_set(ulp_ctx,
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index 14ee1e05fb..84d0315399 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1066,6 +1066,8 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 		BNXT_DRV_DBG(ERR, "Socket Direct Feature is enabled");
 	if (bit & BNXT_ULP_FEATURE_BIT_NON_VFR_MODE)
 		BNXT_DRV_DBG(ERR, "Non VFR Feature is enabled");
+	if (bit & BNXT_ULP_FEATURE_BIT_UNICAST_ONLY)
+		BNXT_DRV_DBG(ERR, "Unicast only Feature is enabled");
 
 	*out_bits =  bit;
 	return 0;
diff --git a/drivers/net/bnxt/tf_ulp/ulp_def_rules.c b/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
index 30cd944362..4d96882087 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_def_rules.c
@@ -829,9 +829,6 @@ bnxt_ulp_promisc_mode_set(struct bnxt *bp, uint8_t enable)
 	    !bp->ulp_ctx)
 		return rc;
 
-	if (!BNXT_CHIP_P5(bp))
-		return rc;
-
 	port_id = bp->eth_dev->data->port_id;
 	info = &bp->ulp_ctx->cfg_data->df_rule_info[port_id];
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
index d63862ffba..4e9b11e437 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
@@ -914,7 +914,8 @@ enum bnxt_ulp_feature_bit {
 	BNXT_ULP_FEATURE_BIT_SPECIAL_VXLAN = 0x00000020,
 	BNXT_ULP_FEATURE_BIT_HOT_UPGRADE = 0x00000040,
 	BNXT_ULP_FEATURE_BIT_GLOBAL_TBL_SCOPE = 0x00000080,
-	BNXT_ULP_FEATURE_BIT_NON_VFR_MODE = 0x00000100
+	BNXT_ULP_FEATURE_BIT_NON_VFR_MODE = 0x00000100,
+	BNXT_ULP_FEATURE_BIT_UNICAST_ONLY = 0x00000200
 };
 
 enum bnxt_ulp_flow_dir_bitmask {
-- 
2.39.5 (Apple Git-154)

