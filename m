Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDF9CAC5B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:12:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 932D742759;
	Tue, 30 Sep 2025 09:06:35 +0200 (CEST)
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com
 [209.85.128.228])
 by mails.dpdk.org (Postfix) with ESMTP id 8392E402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:50 +0200 (CEST)
Received: by mail-yw1-f228.google.com with SMTP id
 00721157ae682-71d6083cc69so61692527b3.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192670; x=1759797470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=43CqHR8ycl/y1ykZ7SnL+pJuAlxVxNN54MNbu/Frzco=;
 b=DxT4MZphGXUVADoMqlz7wQ6dILSthSFgMLMnbMdDQraxlxZ0KeUZCVmAhoWCiLLE9M
 UdADQH6n102gjAXT41qL1GM3tGSkIy7Z6W9XXOoYMBIg3+5HHGaG7Apuy/NuD4f9EWce
 PG49d4ZCUJbaLEZ7yYQvmZtvwqUsxkE51hdZKypqRR9SY21XbhcR539hLlVD1mkk7lc/
 Z+d+7fSW/rPhZjeqg+o8zww0bkpB5TVdIBTwuSr/X+YOU9skbfKbYdJ/UPl92fhk85hB
 r29tDrwjLDgcz2pC2+pW4rmXt8wn/a+eQ26Tw4YcRwKygNRI7H/UEL7MCifRMl9tdppL
 KgTA==
X-Gm-Message-State: AOJu0YwNLf1kW0B+wXgipNmoxccocXEIW+G7SsxCe2TEESpcFjoaKlWo
 A3mKkWJi+D/NGhxJtpyWU341gPQ54NLCsW3RqVtH2uXqw+LiAV8j6ZWaI4xVUCEA44fwtGuvzSz
 5sBu5V5FwJdDGAQoz6+Hd1ra951yWWZqwpdD/DD+rRTAM/MscWskN4SzGQkiAskKhpUfI5vcO98
 3b++hFjUHHSQmBNW0iUmkUj/blmCXmUPt0/ojjZruZaYyN7UaVII0+nWoW0+kxwApjDY4yKg==
X-Gm-Gg: ASbGncuvgya3b2vn0YEalhgyi8Rt9rou3NjAIsShbZfpkQ5cBlFg7wS409sHK8DnR8n
 BovpR2fL2GKZF1gG33nkrGlnXbRFYptbFJywztMupC1zX/a+3c5xOxfVE/FLYyIubW/xziULh9i
 XSrKUlcQqH7ezxrmNiuKECxleso2XK16iaprTFmfY3WcA4puFsl1Spv7z6ruY6Gh+lVPgVOTAcv
 UzmA5uE3oRPYbz1OrF+w2GmymacqKK7XsaKNArO84CnEPvi+eg3vn3J1+OBI+QvV2KWt2z6Lafa
 DrkHxUMcv49Q1XfZywNDDhYUucLcoeh8gId4qWXPN9NeTaAERvpTos//tc1H2N7fqP21U5qFtYH
 giNXnvVz0v9LO0ICA83zcWe+qZRuJMyYn+kwt6y4F8t3wwD1e6pT0Obh9JNIw062gMILiegq+NB
 a4CQ==
X-Google-Smtp-Source: AGHT+IFarJx+V+SoGDbio5ioZ4TmTltpLzO9o4Ggl80dkA52rsabcqBkgkgLo3guz0MScGr4ITX/sD68DOTf
X-Received: by 2002:a05:690c:3808:b0:725:bf60:28cc with SMTP id
 00721157ae682-763fce5f892mr253636287b3.12.1759192669766; 
 Mon, 29 Sep 2025 17:37:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-765cd8f51d2sm6023977b3.4.2025.09.29.17.37.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b4c72281674so3238679a12.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192668; x=1759797468; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43CqHR8ycl/y1ykZ7SnL+pJuAlxVxNN54MNbu/Frzco=;
 b=PlAr7aI/BsdtcW9N+H5uZTrusGi4fCGhSovxef/aR/YP/nMlUIlTVmSdaGTqrsCiCO
 6XbI44CG4KaVMVjCy5+A6xssfe7Y8UMmEJ5/7AJG+K3On+Eb4GfAjJAvu0fZoh4kC9Di
 2Drr4dOf1DUO7/HWe9pl5AhRY8dCFyEbjOkGY=
X-Received: by 2002:a17:90b:1b47:b0:32b:bac7:5a41 with SMTP id
 98e67ed59e1d1-3342a30467bmr22539949a91.37.1759192668231; 
 Mon, 29 Sep 2025 17:37:48 -0700 (PDT)
X-Received: by 2002:a17:90b:1b47:b0:32b:bac7:5a41 with SMTP id
 98e67ed59e1d1-3342a30467bmr22539919a91.37.1759192667688; 
 Mon, 29 Sep 2025 17:37:47 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:47 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH 52/54] net/bnxt/tf_ulp: add feature bit rx miss handling
Date: Mon, 29 Sep 2025 20:36:02 -0400
Message-Id: <20250930003604.87108-53-manish.kurup@broadcom.com>
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

