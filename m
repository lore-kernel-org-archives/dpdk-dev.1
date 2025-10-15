Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55743CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:08:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9123A40EE3;
	Wed, 15 Oct 2025 11:05:43 +0200 (CEST)
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com
 [209.85.221.225])
 by mails.dpdk.org (Postfix) with ESMTP id 79B9940EE3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:41 +0200 (CEST)
Received: by mail-vk1-f225.google.com with SMTP id
 71dfb90a1353d-54aa0792200so4493448e0c.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519141; x=1761123941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=43CqHR8ycl/y1ykZ7SnL+pJuAlxVxNN54MNbu/Frzco=;
 b=SGvu2UFnxUuwmeQEh8Xcd0z/WG3ycOjs29+g6YELEPxlW/ItaXbFRjhwuT7PV2IlFc
 vD6N8uA+zEu8B/Ygxw7IqTbOx0bh9+vWoo9/03XVf5cCEM9nlBsvMGtrU8vtEo6La4Rb
 sDkqZb/W3rfkpUNAo9OjQ/bweCIWQFxqBxoNM3QGCbUp1cDo8Yjh23ZrT1at2lt2YnnN
 Kny1Q3TiyCvJKQrODsyH+3/qV7JtI4dEFkq1ct/hsWbZNT41HN/ZRJ7dd3yaVeEOFwQV
 FK+A7j/yidDDfy3/t9cy9uwM+Q2VuenxWY4EWI9Exc2jOEVqOsyEW1PSr8OU7H2Illnx
 BTSg==
X-Gm-Message-State: AOJu0YxsuIK+sMiIPgXWqvPQmFjANwJ42iniyR/+hqFDD7FMCWs5E+0q
 wbN4IWY0DzQo3dKkb4Qi5pshUOu6ynDmM+UqpbnNKLRPGKxGZSc9ESpenn8T3PJM6TEPFCTKzZu
 7b/YAtOhCqG2/FXYwIrNYSMfT9NoxcX5OfgJAXxXVuY9cQfICkCSpACVqG1qECnHOVnSs++tiJf
 43ITxoZIGe2+hrGgAATnoCfPHBPdRSh3o95nwqZxBY0BEfJbWkSEykglZ2W/FkwIkCn/wQjw==
X-Gm-Gg: ASbGncuHDHHTmN1v3JHSdLoTosWgERbHMU5likfomfu5TDYSI0Ak66p6Xg9LcAHI+hI
 eYtcjts+BIuIgQX9ULRhro2BC0RUZKsZQ/3FGk8OsMYf7fOPdjJHo4QCg13N8OE8HWOIa5o3s5z
 sHWPrne4ZgppoZtVulq6jbNI4QO0KGiO3kgXT8QV1HGw2Ml8YOFcDdjnqYPCaApr7F5ml4KXotm
 dMIvaZDq04b4bW2prXA/zHsT/KbSW+eLc0pQfGpsrJXKxdUGYPgzh/LY92pGtc15ZFyklLBreJT
 LgqMK3fOvAfjLSsAoqRQL7yhXmY5L6rJ5rRWgeWWbESwg5rFXggXf8Hpd8DBKJwoi9Rj+AMVugK
 4YApWZfd2Kel3zP0DPdLXiQZRp3Ozo/+WkfWZ8WCOpr/3Fp6txVI5qIiUgzae/oeppEYX2GSwsd
 s=
X-Google-Smtp-Source: AGHT+IGvTZyIh2CxpqcFo5g0ux11RBoCBb7Nmwxt2ukTLgbfJLX5d77sGE1lWr+vpwApq1kToDRs3r5PNLYq
X-Received: by 2002:a05:6122:2209:b0:539:3bb5:e4d6 with SMTP id
 71dfb90a1353d-554b8a82a3fmr9162622e0c.1.1760519140760; 
 Wed, 15 Oct 2025 02:05:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-554d7ff0ea3sm1750677e0c.5.2025.10.15.02.05.39
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-780f914b5a4so8770991b3a.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519138; x=1761123938; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43CqHR8ycl/y1ykZ7SnL+pJuAlxVxNN54MNbu/Frzco=;
 b=Zy1Xxbt7EkuoU6x0WfVZfulcUu2FSn9gm2LbR5CaWMefLdXtq2SBGHLIRkgrtAJphk
 6x2y/nPKS+k4TlIJLiVrbi3a2eCZtJvM8JEr9V94P94JKX2CxIFadzcgMEYMp6thkiRj
 +Ie7Y/M+8MoUkxZh6GUEq8B4HWEdK+W8BYkwA=
X-Received: by 2002:a05:6a00:17a7:b0:781:8832:9159 with SMTP id
 d2e1a72fcca58-79385709429mr31050641b3a.4.1760519138557; 
 Wed, 15 Oct 2025 02:05:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:17a7:b0:781:8832:9159 with SMTP id
 d2e1a72fcca58-79385709429mr31050589b3a.4.1760519137741; 
 Wed, 15 Oct 2025 02:05:37 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:37 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v3 52/54] net/bnxt/tf_ulp: add feature bit rx miss handling
Date: Wed, 15 Oct 2025 05:00:22 -0400
Message-Id: <20251015090024.32250-53-manish.kurup@broadcom.com>
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

From: Shahaji Bhosle <shahaji.bhosle@broadcom.com>

Added a new feature bit to all applications to send the miss
packets to parent PF.

Signed-off-by: Shahaji Bhosle <shahaji.bhosle@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h       | 9 ++++++++-
 drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index 73ed3803de..4741fd9cb5 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1070,11 +1070,16 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 	uint64_t bit = 0;
 #endif
 	*out_bits = 0;
+
 	if ((feat_bits | bit) != feat_bits) {
 		BNXT_DRV_DBG(ERR, "Invalid TF feature bit is set %" PRIu64 "\n",
 			     bit);
 		return -EINVAL;
 	}
+
+	if (!bit)
+		return 0;
+
 	if ((bit & BNXT_ULP_FEATURE_BIT_PARENT_DMAC) &&
 	    (bit & BNXT_ULP_FEATURE_BIT_PORT_DMAC)) {
 		BNXT_DRV_DBG(ERR, "Invalid both Port and Parent Mac set\n");
@@ -1099,8 +1104,10 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 		BNXT_DRV_DBG(ERR, "Non VFR Feature is enabled");
 	if (bit & BNXT_ULP_FEATURE_BIT_UNICAST_ONLY)
 		BNXT_DRV_DBG(ERR, "Unicast only Feature is enabled");
-
+	if (bit & BNXT_ULP_FEATURE_BIT_RX_MISS_SEND_TO_PF)
+		BNXT_DRV_DBG(ERR, "Rx miss send to parent PF Feature is enabled");
 	*out_bits =  bit;
+
 	return 0;
 }
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
index 4e9b11e437..6a2d31cf8d 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
+++ b/drivers/net/bnxt/tf_ulp/ulp_template_db_enum.h
@@ -915,7 +915,9 @@ enum bnxt_ulp_feature_bit {
 	BNXT_ULP_FEATURE_BIT_HOT_UPGRADE = 0x00000040,
 	BNXT_ULP_FEATURE_BIT_GLOBAL_TBL_SCOPE = 0x00000080,
 	BNXT_ULP_FEATURE_BIT_NON_VFR_MODE = 0x00000100,
-	BNXT_ULP_FEATURE_BIT_UNICAST_ONLY = 0x00000200
+	BNXT_ULP_FEATURE_BIT_UNICAST_ONLY = 0x00000200,
+	BNXT_ULP_FEATURE_BIT_REDIRECT_ONLY = 0x00000400,
+	BNXT_ULP_FEATURE_BIT_RX_MISS_SEND_TO_PF = 0x00000800
 };
 
 enum bnxt_ulp_flow_dir_bitmask {
-- 
2.39.5 (Apple Git-154)

