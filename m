Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F68CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 19:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86D4C40EE4;
	Tue, 21 Oct 2025 21:02:57 +0200 (CEST)
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by mails.dpdk.org (Postfix) with ESMTP id 91B1940A84
 for <dev@dpdk.org>; Tue, 21 Oct 2025 21:02:55 +0200 (CEST)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-7a23208a0c2so2620722b3a.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 12:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073375; x=1761678175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OZspuy+WwQ1mXVYipXVVhGQRPCydy5QTOQxqmX897tU=;
 b=HCL1ryIumAJ2E1icP+/KL52FXNRvOU/5jGlI1yy1z1e/vyasKGL1Fo7ySR1wnbL/1a
 gFwM7WKazMuzO4XsE5c7HvxaOI+57rPXD4sbFYIxLKyqasyjXEmShNKpYUHb+W0a3Vp9
 BT7aiYL67TmCruATTBhgAw792f9S/zuAIzl9RLAYLFGCQiuRcqt1Y07ncZ6z+iGPiB6p
 SeUwtCD6sl2hq3wOwN6SH6fU+LdAa30XixF/YBv9oKRppMGwPIK93Lnb9MWefnVbjR1P
 XqoE+2isuJOA6nnsrhuje/+U007oLVXrbyQ+PXGOA23TBh4Mi0zUOoFbgDC18l909t2l
 HqZw==
X-Gm-Message-State: AOJu0YwwUmnHjBAv1NJVXfMCAKe5JR5YHyQUy8/tAt3UIJ1TpqvYIKL7
 Yn3ntXacd8NTDYXpzJyjXxIyLJbRhYNv+UkXKD2Pz1s6x1dEHFWnqHfvEjNnVNd9DmrUpvvQkd0
 0zaBGrgpxjBOuY6U4ysBU94NdmP0ncJrDW6GjT0YtXri4cKOACzob5oVWRr6lTKlOsTjHTOIe0d
 D/cHoYb3F41DuXwh9UtmlUYxDC6XKLMumaFWAJ1c02lu3/fjEbsjpNzjKlRLDtDOIwFPp8nQ==
X-Gm-Gg: ASbGncudKtGLtMHwAm52byi+iaHx2gybTAlJRj2IU9J/z51YQQthyqX4dnfs70dPo/c
 kR5kvPdB/xLXzQnSLH4AMEcsk+6syJYcvBaTNcWd+kwJMUSuakBWTYVFp2nallhJyGF4Zs+5xTu
 PLA3gdlS4VLwxQzLtErXqIpvSuG2kdqNh/tyHQg5UVjX+pxmGTrqkADh6gSec8sCq5PnuHTwRMF
 1CGZSA2uVGFZSqU6QdtHKvfNE4/m05PzKWKN7lW9CfZBEbE7+vK0IldTPfK07U1f5vYuEP2dCLD
 9kYisJ3SDZtumJXPHbn7ZVhfgXMaRF9f1Ph4nTI3SmAt5jz3QH+aPMk4U2juY8y7LoShUxeiLan
 CLLRrR44SoIDXeykOStqQmuwsXU0JMabwh3wugryE6K1Vcsr81SBBPuL03SbocT9SOtKWDvDEJU
 mQ54ia5xslLeOJiDRMjtysiw5TtWPOILxQvw==
X-Google-Smtp-Source: AGHT+IFjpencUrW0tClExVEXJYh2MDmQQYGnJh7RGGTTZVgUu4wWP4F7Gdt/P0eqa5yLNad6sxMdsO6PkbYB
X-Received: by 2002:a05:6a20:6a1a:b0:334:87c2:445 with SMTP id
 adf61e73a8af0-334a8610a11mr24433185637.36.1761073374657; 
 Tue, 21 Oct 2025 12:02:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-b6cb98121c6sm533565a12.6.2025.10.21.12.02.54
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:02:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-77f64c5cf62so4437253b3a.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073372; x=1761678172; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OZspuy+WwQ1mXVYipXVVhGQRPCydy5QTOQxqmX897tU=;
 b=UDU4qbtfimMqX3Nu4lC4+cLM7v9bjehkk+IqUsGDeCja6sOcCgRgrO5G6ljZ3FZKUa
 LDBj9hPHVVLtYTTp7IfJ5Wml6Bj1QdrmXYCKHL0wNs+082Mr6P8R4magSz/ybGpg+Fqz
 C5ScDYa/XKluqRhlrxbA4RcpOZ7eoKEh3kYGU=
X-Received: by 2002:a05:6a00:a589:b0:7a1:68b2:5341 with SMTP id
 d2e1a72fcca58-7a220a4abf3mr18709391b3a.11.1761073372403; 
 Tue, 21 Oct 2025 12:02:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:a589:b0:7a1:68b2:5341 with SMTP id
 d2e1a72fcca58-7a220a4abf3mr18709356b3a.11.1761073371855; 
 Tue, 21 Oct 2025 12:02:51 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f256dsm12011019b3a.50.2025.10.21.12.02.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 12:02:51 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v4 55/57] net/bnxt/tf_ulp: add feature bit rx miss handling
Date: Tue, 21 Oct 2025 15:01:56 -0400
Message-Id: <20251021190158.74064-3-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021190158.74064-1-manish.kurup@broadcom.com>
References: <20251021190158.74064-1-manish.kurup@broadcom.com>
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
index 84d0315399..bd160e2db9 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1039,11 +1039,16 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
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
@@ -1068,8 +1073,10 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
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

