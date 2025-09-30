Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C40CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:11:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98555410EA;
	Tue, 30 Sep 2025 09:06:26 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id 717D3402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:45 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-b5516ee0b0bso3796368a12.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192664; x=1759797464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5KGpGEz5P1y4nWuNa5ksdPca7HqUHJl8C/KPOIKGt50=;
 b=VFjwVtTdJN3ZH28MG/HpfMULFnUXPWSutj8ChICbRc7A51DNPQwLFZDMJ15Wk3BE9d
 WS5bqGUb+9i1AAVVgyfvsogd54YX6cOGaHywpK5LEHOo/nYJzwcpH6uhJIomyoKjH4Vz
 HApAoTr8oYVJFvJ0MFIuqP6/ncscIm/modtXk6RuycTcynYFj1uvVmWGBjvQcFS7zg6p
 QNbwL0ERwStsQSbzpGu8+JUgayZFnAGY/f56yzqm6GSCIue9+zFs/CnSHlz2dgOyAxfp
 sl/kzZfPvqB6WnhA49ZK1y02zj7BzABAD2+fyuOhRoswtmO4KQEuGepscFTCviLYg4W2
 kYBA==
X-Gm-Message-State: AOJu0YwRaX2Cdnqnn7RLkneRWl5vjxYfZe50kJPR07IiWHW8RLaEBFgz
 SBHgm5fDaRHHW+zmT34UJ2H2J9H5DxVwysv5CA60VLpO0DcxKDRjM+alOkYnxJpc/Lm8XIulGi/
 ylUyxzYmzAR8ZvYIeGEcnmNPKXMiSnmtm05qB4X+dDEj2Pow8Nq5SGTIl8b5CF9pGPwmmMCFgsh
 wHdZWS2CrdoT7yTizfjujH391L7xu7Nme/MNqrD43EfXN0AHNvWNlJ6Dgp3PlChcKfSSyotA==
X-Gm-Gg: ASbGncvVtWX5hjCq+0hC75ihJCk1yzCDCRr8YAGG087Qog/C/4LXX9qZ0PxFwUI8+QA
 hExvHLd5kJNI7LIgrlD9q2VYDuuU71r/yPJaYxHu3h9AL5pp1XxLXWfQXOp2wHdHxNGPC7niPWn
 BwUsRNolPICNuRnVb+Q6KmlTWsBbUFhIuT0Yjm6XbolePm9GOZ3h+ck+ZvdJi32CtPTqI1ljd2z
 Geuue6Z4AxnIeOIecc8AZ8AeSwJUt6wkzxxiZ7rrLQwwx0/lV3UlW5nIzm82TNSyFEoDUC2ydCm
 8012/kIMjPjxh/D577l5WEgEr8P+txU/AFYHrjFXNDWXyFQnrkKvrPUlPDAJBLmQOznr2TJNWuj
 HqzNWBXdfKpyWa5kf9bIs8yFXmhfHtc2Ha9gRM889mQ6+vYiL+gOSZAjlC0+MfboP6aCQHvIfYu
 5ZPOrkKns=
X-Google-Smtp-Source: AGHT+IFjPnRlmM3Ym7MIyKZ/X31+PKoT1fHjJyXaoutaXNM9gH9+73icErHM1J1udGQeu+sdWt6PXdl4nWfr
X-Received: by 2002:a17:902:c402:b0:26a:ac66:ef3f with SMTP id
 d9443c01a7336-27ed49df693mr184931955ad.8.1759192664516; 
 Mon, 29 Sep 2025 17:37:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27ed6816df9sm11057655ad.60.2025.09.29.17.37.44
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-780d26fb6b4so4427506b3a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192662; x=1759797462; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5KGpGEz5P1y4nWuNa5ksdPca7HqUHJl8C/KPOIKGt50=;
 b=LgTsd/ezYNIeF2Tc3x9vB9bTWB/hNv5Nnfsqmc2tgjgZIkiLGZhfJxqA4WtlK4gGbY
 SSAyY+qlLeoIvFpcOKJX7Njz8rtY2dzE6MYwl8oZ7kQnbCmIins/M8VZbk97gVlaU7oV
 8L/jIVzgSG97lJIgqCeaKff5e2/3x+UtYzTW4=
X-Received: by 2002:a05:6a20:1588:b0:2f7:bb9:24c with SMTP id
 adf61e73a8af0-2f70bb90519mr17154399637.35.1759192662203; 
 Mon, 29 Sep 2025 17:37:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:1588:b0:2f7:bb9:24c with SMTP id
 adf61e73a8af0-2f70bb90519mr17154358637.35.1759192661542; 
 Mon, 29 Sep 2025 17:37:41 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:41 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Subject: [PATCH 48/54] net/bnxt/tf_ulp: add support for unicast only feature
Date: Mon, 29 Sep 2025 20:35:58 -0400
Message-Id: <20250930003604.87108-49-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

