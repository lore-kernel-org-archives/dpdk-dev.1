Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C377CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:07:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94A0142686;
	Wed, 15 Oct 2025 11:05:32 +0200 (CEST)
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com
 [209.85.221.228])
 by mails.dpdk.org (Postfix) with ESMTP id 8700D4113C
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:31 +0200 (CEST)
Received: by mail-vk1-f228.google.com with SMTP id
 71dfb90a1353d-554f1c13bcaso2592883e0c.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519131; x=1761123931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5KGpGEz5P1y4nWuNa5ksdPca7HqUHJl8C/KPOIKGt50=;
 b=pyUm1gTSrAjt3Q863kBV0sEb5Gl2w0pwRSbpSgl1kO+QtIk04eOedaQ9n0P62y7HrE
 G8cPu0WzC3DlgrrDflzkSjeQIcil9NaJEC1O7dVuJbOBoWcvPQVmSOzJj9IXgV6sCVIA
 AtwX8srZzFnGCuGpNw39M1Vv3j0/8dRkLasxmGY/H9j4lKik2U76s6868kPhbh1Q+GHY
 3jZhtAWRZXQU5r1KihSv7ARjV1WPb+y8Le59+7GSjK7deqvNPrK3egzVkjSXsyEVl6rs
 aUVulwFqhals03kumOVZX8eyQNqZuv/FSI+UzoultuwhNS3H/PS5yrcYneob2/dXEDUG
 RwsA==
X-Gm-Message-State: AOJu0YwEvkH9mS+iRohBR8Eqct9uGGj8Bjmgyd43sllgTUonefYkRoxD
 DbjAq2v8icuNl6a1G/wOnA1MSefdMvWA6dfqzx5xd+k2E7SS8Xu8yj0GUhSVMHaNu1YgzKOgz98
 RLQP7C2t97fm04b6QKVc+CNtaSX3/K1pJV6j6QMki+BrRYCCwnISDt5yvkLCqEcixUduMTkxzPD
 EYFrfxNkjczOirW8w7/rTUhajqfBrOjGPfbhOyFoEv4yJ4C8JSyZl9sPT/F+LyOzVhwSvBwg==
X-Gm-Gg: ASbGncutkNWMjMnTtQgldRTEt0jAnquXRnI2sea27F7g1btVK38l7U++1v15WF7g5kv
 sk3BwJMLybi3ZA/RwprHBQwDnZ4NpciKt9ZV2fEr8/kMW41PTK/uJBTA/Z/zZAqjgVWDLEpYl4z
 YsmAOF5l0ItMJM36wneGzvtgDWfGOlMnAorDb+49XR4oqOYO79ujCmXWuGyn7vL6UdqrUry18XG
 2XhFjaNPIw8ZHv/1PSCvnWDHIfPAjYgwJ22S1iF7MmgtcHzg+3DWBrSSYc6PIrZRfh6XOKu943k
 CozvF5KTf5qshtYA+hp83nBheBne3FrSvQ8x5xkRnj/lXJiRHReCACSK/shnSy7+3SPxRP0BSCe
 CeiTFqRSHT87dsZNRVyige/zSUAvGz3N8koyKruKWDkBt/pRbQu5emwAuqgvcggKYkLMFlhPSZ1
 y1Yw==
X-Google-Smtp-Source: AGHT+IHWLmf0rsjgf4POZG9xkmucFJg1ysFooZXrBVPIJ6r3Pb/KenSbJR7/Sl3vrXEsX11GtgKf32txRS3Z
X-Received: by 2002:a05:6122:32d4:b0:54b:bea5:87ee with SMTP id
 71dfb90a1353d-554b8addc30mr10345842e0c.7.1760519130829; 
 Wed, 15 Oct 2025 02:05:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-554d7ef0fabsm1725597e0c.1.2025.10.15.02.05.29
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-76e2eb787f2so8833872b3a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519128; x=1761123928; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KGpGEz5P1y4nWuNa5ksdPca7HqUHJl8C/KPOIKGt50=;
 b=Yuc2O9EmCr1bhX79WZfYFHdsjFtqgORGYYL78+u08mcJr2UF8Skr3zjAq52iqFBxSB
 TeIldjVP8GlxkTSerPZhzXsWn8cTZpOWkFD+RpL4vmHwf2Ir+tgEtALIMdcugn5TvQZI
 T03nZVJ+1kiCWc0nLPg8uWfpFxav8abHa9MLQ=
X-Received: by 2002:a05:6a00:9a1:b0:781:2ba:ef14 with SMTP id
 d2e1a72fcca58-79387637461mr30622011b3a.25.1760519128505; 
 Wed, 15 Oct 2025 02:05:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:9a1:b0:781:2ba:ef14 with SMTP id
 d2e1a72fcca58-79387637461mr30621967b3a.25.1760519127809; 
 Wed, 15 Oct 2025 02:05:27 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:27 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v3 48/54] net/bnxt/tf_ulp: add support for unicast only feature
Date: Wed, 15 Oct 2025 05:00:18 -0400
Message-Id: <20251015090024.32250-49-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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
index 3228bf4f99..9d32217a21 100644
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
index 7271cbb863..fc713e95da 100644
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
index baff9ef049..73ed3803de 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1097,6 +1097,8 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
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

