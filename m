Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D7DCCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B06FE40E28;
	Fri, 10 Oct 2025 00:16:43 +0200 (CEST)
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com
 [209.85.128.228])
 by mails.dpdk.org (Postfix) with ESMTP id 3546840E2C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:42 +0200 (CEST)
Received: by mail-yw1-f228.google.com with SMTP id
 00721157ae682-780fe73e337so11897497b3.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048201; x=1760653001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5KGpGEz5P1y4nWuNa5ksdPca7HqUHJl8C/KPOIKGt50=;
 b=vpF4Yz3WokwZQOoZKWiKK+RQE3bXdJsOhchj8M6isB19IxJMY344+cmAMOMg4dJ0vz
 9VuegxCDhWf9sHuoDKz04tlHhvSbZQhi5dvh/CJvzmJl/i1szfkWE+gv7rd0W/DtRdjF
 LfX4inNUXWFlRrN+5NtSBKgQ2575jkjk7gSmGRxFocwEdBUzLNmA6GoUH8o291o/DuFG
 OdRf4DDolmA9RtxyzG2u0ziwpTVG+mlxr2L5zWglDBlk+HVs+hLBk5N+HbC1wRQMMx/u
 FpcrFbLYwpRi147gCQK3HtsEoQrJhmj1zBsuRT6CvfpIq3ShFrElG+iHNL7B844wimwb
 moAw==
X-Gm-Message-State: AOJu0Yx4H/7u3fYkdcJ2jCYL4Q1SNp73QZrSvyoUvM2RviaDa/QZNlUJ
 uFQPmh6yEkpQxA2EDHmk0SKtbilPAx2Ra+VEZH2fxJ/OkWYcRmUNAsnWlf0SQOkbdUdHLMIL9zP
 xqX1+H5gemC38lHsOhTmAbRiTydD3Jl2hrJSyf1in4zJNVXvPwM1Q5gDbkN0US7fR+AP9lUPwvx
 3u9xit34An7Ozwu5Su2rn3P4WAWxmq9Dg+rvxxjw+PSkoQlzvsesxlWeIexLkJ8cFeY0/9fQ==
X-Gm-Gg: ASbGncvx1T6tF9L+b2iK2qfTHBfyDWVOk7L1L/ipJlf2BltSdzIK+PEWcPqGJbmR/3X
 Mnal/djXByn2yJv5cx6CSi8d1BShUu39DsinJfzmu7o5Yk/cwEtBk7+09iOa8aLogA7E+REMb4p
 NkMMn6TEqmpifDnN/2kogzHH+WK851/iKWNmiJ7qxthEoJ2XHbgeSFMHq+J2hKQt1OFHcQxwS/Q
 TbVgDC05kAEMf2YrekOsKuTFWKJKsPYujAwN3TXYPsHQ4Rqozudpd6DPGXMmBKiOXhTPA+xp33d
 htFIcEGyzJxqTZjOeYmDM8IxcIyWphWIhQkMWnkZ8hlxNBRYANXS3T4B8lI5M2vx9NgKd8sCvqm
 633s4aj0YpjWR0QX0x+rRfIhvwwiR+ah4kCibO35QuFe0Z/txDB5ho5fMi4GC+FhQp7Obya+t23
 w3tk6KYb8=
X-Google-Smtp-Source: AGHT+IFZkZ+u/J5ODu+aKtfGMoGqFCYLGE/K0H3cqTtZpO2OhexuNEoto478W9Yk9v8EhtFb02dw6VNORdSW
X-Received: by 2002:a05:690c:ec6:b0:750:bb77:4433 with SMTP id
 00721157ae682-780e1424f14mr104692047b3.19.1760048201496; 
 Thu, 09 Oct 2025 15:16:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-78106fac206sm434797b3.17.2025.10.09.15.16.41
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-78e45d71f05so37158456d6.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048200; x=1760653000; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KGpGEz5P1y4nWuNa5ksdPca7HqUHJl8C/KPOIKGt50=;
 b=HruiGim8VfdZlTMUVPfLILQq0Ke1r7Y8dXBOk4mxIHslOUu2yooosRMn4VyjKfMWmn
 IrPx3Btc7+PoJTqYG4QqaBRcp/WHYmFwPZ8nwQByRRkAMuHQR5TneGvFIYW+3NXeh1Td
 HQMIy3aLfn43qfVQD/cSsSDV8Dbwzo8EN9w/0=
X-Received: by 2002:a05:6214:529b:b0:80e:327d:be66 with SMTP id
 6a1803df08f44-87b2efb93f7mr136132066d6.39.1760048200389; 
 Thu, 09 Oct 2025 15:16:40 -0700 (PDT)
X-Received: by 2002:a05:6214:529b:b0:80e:327d:be66 with SMTP id
 6a1803df08f44-87b2efb93f7mr136131486d6.39.1760048199901; 
 Thu, 09 Oct 2025 15:16:39 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:39 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v2 48/54] net/bnxt/tf_ulp: add support for unicast only feature
Date: Thu,  9 Oct 2025 18:11:23 -0400
Message-Id: <20251009221129.28256-49-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

