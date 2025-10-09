Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3A7CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:19:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CF8140A71;
	Fri, 10 Oct 2025 00:16:57 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id 765AD4067C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:56 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3381f041d7fso2866994a91.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048215; x=1760653015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=43CqHR8ycl/y1ykZ7SnL+pJuAlxVxNN54MNbu/Frzco=;
 b=PRZsmiiNFJ5GSECXIY/a0p1itOkGxi8otkzz/aWHcQIE0igSJdlcBXWh7E2jPCtVkR
 3DIYrdGEBrVlm86e8TriUhKzPqa8YowEcM0hDoW+3sktGe7uILaFRyvLqs4G/PIy6IX/
 uz5VUSyRVNdXa3ohRZxltucIjiwFOMTVbJyHO+RUgNY8J5JVkX9/iirNYSYr70lrcRAJ
 SJCJydC+S/gd93orytNk3QZyTsS99LA5jmAYV9B89hjubCivU53mift7SbmAM7fQvy2r
 ZiBsUmLpJNhu0ZL344epquM8paVwQ7FFHYU0zn2+1e2CbbEpHmAfvLbCI4j9ttvQbjTF
 0gGw==
X-Gm-Message-State: AOJu0YxA826AubNtlMRRLJTMZMQ0cPxaWRQII/p5Ggmer9k4jQ/M85/2
 FsUxt+YyQOX2TY0dA4gETGwigAMaW/jny6MZsEDUAibHk9+u0kU5C1CnyzlJkgI/+H9Abu8kMcR
 PgE1DJXWqwS+P7LTVkolxF1gN7RbXToSc22/F521z/5k8iU+OQ8ROLjEnjcV0ikQCkpIgaMfEIq
 tWbHh66j92wxGGFQU9FI4/bQ8w5mkAbsqcPkGfEYq8vjQcuR2yesmnYgEywXlfrN9mSEBY3w==
X-Gm-Gg: ASbGncvjrG4TEUtxbdX/eyoCUgQQo+vC070kw0BsfwjwnRBS52HDy/nFVgKH5tmBosw
 1aDcN0UyYX2EOFhBe0jxGBk4vwm1KmJQ8gHugJDH/g1qJAA90ku4GTi2TyvL3UFKqtZfe4olbP3
 X0hJXRS3M2G1OAJdvX2lNPbAFLScgQ0srb3BnGD3CIiNxI/oRNf2Yzblk5eaOEj1+9g2C5EDv/l
 iaW9mxOkaYjRQRIIbTPIZjrS8KYvfu3fenM4TK6PtFNnrGSOQnbZSq93ngzK2+Szxy7BtaVJRBT
 8Y10hiAhm9iIZ6ghATHtoZn3KV7OBDISQ7TgPBjEQpg4VGJqL41Ldiw72Fl9A3och8J4ei1cc7l
 EhLLYDGunTPFSmIX3V4uVxWnqYWwnMWasxzBi/ov0ng4hCK6O3L+HmPNemOOLy1KioPOaHtTzt0
 mU1dZq
X-Google-Smtp-Source: AGHT+IGRSb7PXP3FNUy2azfGGg7FEgaU6ltH4cIIEgkCLdEfwgqzlfFq08h2wHUcZPF+fNnVFLLNJkC+whBB
X-Received: by 2002:a17:90b:1b01:b0:32e:7277:9a81 with SMTP id
 98e67ed59e1d1-33b51660588mr11676416a91.4.1760048215484; 
 Thu, 09 Oct 2025 15:16:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-33b626cf798sm61132a91.6.2025.10.09.15.16.55
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:55 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4df7cdf22cbso113588151cf.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048214; x=1760653014; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=43CqHR8ycl/y1ykZ7SnL+pJuAlxVxNN54MNbu/Frzco=;
 b=Vi/qN0euE7epIq75RB7bfJZqk1Ah1qSa8EMeAETdLwFSTerRyDJKKjHI629vp3buH8
 SZMdLoi7sLBiCSi/PSj/PXXShEtcYICMjeex6Zp0KrMS32+YzJf/fN+bm3uSvf2UKQTL
 vQjzi2t4w0uqFEJ6WXlUXsZOxnfce6cK8TIGc=
X-Received: by 2002:ac8:5f0e:0:b0:4cf:1eba:f30d with SMTP id
 d75a77b69052e-4e6de86ab3dmr174712091cf.23.1760048213885; 
 Thu, 09 Oct 2025 15:16:53 -0700 (PDT)
X-Received: by 2002:ac8:5f0e:0:b0:4cf:1eba:f30d with SMTP id
 d75a77b69052e-4e6de86ab3dmr174711631cf.23.1760048213372; 
 Thu, 09 Oct 2025 15:16:53 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:52 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shahaji Bhosle <shahaji.bhosle@broadcom.com>,
 Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v2 52/54] net/bnxt/tf_ulp: add feature bit rx miss handling
Date: Thu,  9 Oct 2025 18:11:27 -0400
Message-Id: <20251009221129.28256-53-manish.kurup@broadcom.com>
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

