Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A440CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:59:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A49542686;
	Tue, 21 Oct 2025 20:58:39 +0200 (CEST)
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com
 [209.85.219.97]) by mails.dpdk.org (Postfix) with ESMTP id 7853240E2B
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:58:37 +0200 (CEST)
Received: by mail-qv1-f97.google.com with SMTP id
 6a1803df08f44-87c167c0389so94255636d6.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073117; x=1761677917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HtdPxNPtmU3K9mZ42u5ladPBVslv1KVckWHQxGzwVss=;
 b=Tsngi3QoGNEf0ZekPNGVRVTUZ6BloLo2diElYRjnyA41utUJ7RDxaR5sYkUgZSQ9j8
 bNZC5dXJ/PSVPKgzWDvZevQ6QC0paoeEVSClmRPz7Kic7AGOkK3CH7XNgngfYttlFuiG
 b+hYX+ae6aGQMx5ukEhKBiPgVF/dwWzLjbqOxVNEjwCUwKXnNa7UlPmPbDKUPlfZNhQW
 GhPerSMuPma5calcn+JLLm+wX1eL+6dTVl6RrISHcGx5gsXSstZMhshrOMcGmuI8xzeA
 bByZUNJLYsFBITQ9B95fsukPCV7conxCznDDFPVFNls1y1SlTJllrqYlPfppQwzs6TiV
 K4FA==
X-Gm-Message-State: AOJu0YwDSi25Pxa1TSCXAghrHjAOOLSH1oYKPkXqJEXI1X3jaN7jqbdq
 xQcutz6VkI0YUHklLbDXPCcvtWe1xE+f0ZvoAdXFpZet/XqviH1EJkvUGtXLXg22Nt/7c+hrI5P
 6I96dUj7WDIkOYQbRcbjIXpQBulTnPqSHJopZQMsdRmH5Or0N+YVAOYQ4QBf5bxEjXOE9POhzow
 R9zqIw028tgNMmeY60d02RIijXFF/dFx2bfjI+8QrxdjLS+TAPDZmGKZCGAqYgBmlWzNezaA==
X-Gm-Gg: ASbGncstbJS3ZC0tJ6fP4MlkZnagiT2jGJCERQz98McJzSUGE3wMSC73TI8ByKs+JJM
 Fbbxn/TQlmq2kfXnJ9xwHZDPlAEWvU7CKgV/lXtO5OzXt/Jpo3kbkxLQAZaIJWysCWuQ0zPGnSK
 I/CW4Dtmp2PxC3CrKNJNunnwvFu/7WLGmVwYUwk/KyD+UXmLj60KJTQLkM/pnkDk2h0IfWnirFk
 s5SgZcWe7AU4JFu0xdg9xDvHRMdBGzcfO3SncyOmfyHrR8jJ3O5ZasYHEMKxuHTu1vM/anMbqKU
 lXp6FcjQqOLuhYdlbt+Wv9npg/JL6/5oqu1SCQxyWClnSM/mA+eUAoriKeyThPZuFnMJGHEyTi/
 vyP164nA7WAbPec09r1aCR8/HRjwQMkmnp5D+fagWZ2kj+pLWtQm2yAOgExVlH89N2IF845IYJ9
 lwipxThxg9LdQAUmXMizcROqaifFFe/eZnEZDP
X-Google-Smtp-Source: AGHT+IEReeHjj4fZrAvQMaOh3Kqrhhs1XwiJqnGX/xoEBi9NoYpb/vdMKAt8bJvoHsbUc0NItfVQ6hkb7Xli
X-Received: by 2002:ad4:5f46:0:b0:87c:2868:51d3 with SMTP id
 6a1803df08f44-87c286857efmr175306596d6.29.1761073116762; 
 Tue, 21 Oct 2025 11:58:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87cf54cbeabsm13890076d6.32.2025.10.21.11.58.36
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:58:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-27c62320f16so61412565ad.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073115; x=1761677915; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtdPxNPtmU3K9mZ42u5ladPBVslv1KVckWHQxGzwVss=;
 b=SZ2QqefVW1ePVw27A5RMgl5CQpW9ZaVNDHc6PZ2FthZEBZ/IQhNB7Fe3x90IszCy04
 CKRxQx9fv/t9kI+6IJhVDBXDhdOJwMA3GYWbVVD5GRZevyzOkYmNTdQf2nk3GmFHIali
 E74JcAMWxiPJWTS2p/8U6fvFxd3i9n7XBXXH8=
X-Received: by 2002:a17:902:d505:b0:27d:69bd:cc65 with SMTP id
 d9443c01a7336-290cb079f3amr201071725ad.45.1761073115015; 
 Tue, 21 Oct 2025 11:58:35 -0700 (PDT)
X-Received: by 2002:a17:902:d505:b0:27d:69bd:cc65 with SMTP id
 d9443c01a7336-290cb079f3amr201071395ad.45.1761073114478; 
 Tue, 21 Oct 2025 11:58:34 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.58.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:58:34 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH v4 51/57] net/bnxt/tf_ulp: add support for unicast only feature
Date: Tue, 21 Oct 2025 14:56:55 -0400
Message-Id: <20251021185701.71881-20-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
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

