Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94181CCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08C7840E1C;
	Fri, 10 Oct 2025 00:16:16 +0200 (CEST)
Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com
 [209.85.160.228])
 by mails.dpdk.org (Postfix) with ESMTP id 8EE2240DF6
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:12 +0200 (CEST)
Received: by mail-qt1-f228.google.com with SMTP id
 d75a77b69052e-4d9f38478e0so15500201cf.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048172; x=1760652972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b15of6Wh2Nf6J5FBjefyUzBQfR6E9NoNzKRctj+/Wg4=;
 b=QtmhhDf5onzJz+exTIRnNkA8Ios1Wc3vKqKLKG+iipNmjqHXk7LeJIUq7FOay19cyy
 eAKCqEnQfaLxPbSiZnm9+mvoddT5jbG6uhKyLcJnD9SPXoe91qAO+XG2HI3M5rV8kYNE
 Im+mTmUvO+4rqc2+EBpx0ggth3Yg/r3mwDwgAiwZT5sF+gI4Ox/ihATY0vsZG07tynj9
 TNh51aNWcpiexcYj9+0KZrcR05yum/jWxuMaLaiFn1S9XM2GQI1QrnAWwCRqS/kbypVk
 HxCeLhCfdUlDNTSi3sIsw1yUGWQxrs5tgqkcuItYpPHQVuFkxYwILLv+JvAD+hdax7vq
 NBoA==
X-Gm-Message-State: AOJu0YyKrDw4gpmUgFsXHVOd2Bc8EmAZsCzK+sFAjmrCw9Nzrp/Q9Kro
 57DVvm8o2Y0eRNs8Y2IyWbrKgxquhN7Q2QOfg6BMnO51zmiTjDCK9YBuYvupCfVDjajL6WMNvnI
 FBy5HyTEYYYCI2g8Z1Cc54gX2lRB8RNpVJ7igkLzXIy3fciaFEd5eSpOuBYDpxIRqjCcSMQMTaA
 utdXCAFdHJNAlOdmxzCzzPCKcmGVjMaJf7FGuPci0pkgcLI0dJZuyYwPb3ycvF+9gsbxawog==
X-Gm-Gg: ASbGnctobLejm84zSUAkzNdTpPBudjKDs0NeAi9LYLysUu33nOExpM87p7niBG9L5S0
 xqpmpWRbNwK27dAyZosT8k4TxE82BdoxilOuDQJYMz9ag9dqQZ9+Nt6vRqMu9DUo60H+GU0cptf
 l3HFQPFQ0tURB8nsNDGFQ254yV1Ga+ooa8YDlCrXYyqjejuP5XlJXacDE9AiLoMDiu38/o64+xG
 HYOn0puywRRHew5320HfzDjGkjCcEqCwji4UL2aWRoWgjtpFHEIhPo/OWdnc/gGAnZpu5mD2m5q
 5vR5VoLPeD7iatVSpVMNgP7NGpFE9UBUlGpX2LVABbwgYE55kQE7FbFNzvkH9LK1qkZDxhy16Va
 t54IS/pk30cHuRJo2aoSmRU/lcAkgNamwXDJ63XIm1I36SH4tkA3ebM6FWM/j2cXDCvveFbeEmc
 3Rs7ICuYc=
X-Google-Smtp-Source: AGHT+IHQw/W+SOSuUuiHgF5k6e6nNLfheg8NIo4luKwWmXOPevJmWNECwy1zEonkcVROjdrii6lB7MSmR2zX
X-Received: by 2002:a05:622a:1a8d:b0:4af:36a:a60f with SMTP id
 d75a77b69052e-4e6de86a69bmr165476831cf.21.1760048171921; 
 Thu, 09 Oct 2025 15:16:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
 by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-87bc354c10dsm366046d6.28.2025.10.09.15.16.11
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-85dd8633b1bso943114785a.1
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048171; x=1760652971; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b15of6Wh2Nf6J5FBjefyUzBQfR6E9NoNzKRctj+/Wg4=;
 b=Ujx1KUTOuuM8RKcrAvZkBRuBjPFCkr9AitnhzNUQMzDy7jzz/Wo0ReeQ1fO4qoNJ4B
 c5+DctTlPJbcRuPG3G3bSwD0JxIjsCo2kRhWAE7+Moky7y8BlzX0IPfZtWj1QLnmOf13
 /7+8Xsh9xDk/7Uv+BiOuTk4b8lsVnV1ebwTaA=
X-Received: by 2002:ad4:5c48:0:b0:81a:33f3:62cf with SMTP id
 6a1803df08f44-87a051f9359mr205948176d6.4.1760048170934; 
 Thu, 09 Oct 2025 15:16:10 -0700 (PDT)
X-Received: by 2002:ad4:5c48:0:b0:81a:33f3:62cf with SMTP id
 6a1803df08f44-87a051f9359mr205947696d6.4.1760048170365; 
 Thu, 09 Oct 2025 15:16:10 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:10 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v2 33/54] net/bnxt/tf_ulp: socket direct enable
Date: Thu,  9 Oct 2025 18:11:08 -0400
Message-Id: <20251009221129.28256-34-manish.kurup@broadcom.com>
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

From: Farah Smith <farah.smith@broadcom.com>

1. Remove code which requires multi-root to be configured in order for
the socket direct feature be enabled.  This is not required and was
a customer specific implementation.

2. Always enable the global table scope for Thor2 when the socket
direct feature is enabled.

3. Remove global table scope feature bit.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c    | 12 +++---------
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c   | 16 ++++------------
 drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h |  5 +++--
 3 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
index 4a1ccfa2a3..78fd96ce48 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tf.c
@@ -420,15 +420,9 @@ ulp_tf_cntxt_app_caps_init(struct bnxt *bp,
 		if (info[i].flags & BNXT_ULP_APP_CAP_BC_MC_SUPPORT)
 			ulp_ctx->cfg_data->ulp_flags |=
 				BNXT_ULP_APP_BC_MC_SUPPORT;
-		if (info[i].flags & BNXT_ULP_APP_CAP_SOCKET_DIRECT) {
-			/* Enable socket direction only if MR is enabled in fw*/
-			if (BNXT_MULTIROOT_EN(bp)) {
-				ulp_ctx->cfg_data->ulp_flags |=
-					BNXT_ULP_APP_SOCKET_DIRECT;
-				BNXT_DRV_DBG(INFO,
-					     "Socket Direct feature is enabled\n");
-			}
-		}
+		if (info[i].flags & BNXT_ULP_APP_CAP_SOCKET_DIRECT)
+			ulp_ctx->cfg_data->ulp_flags |=
+				BNXT_ULP_APP_SOCKET_DIRECT;
 		if (info[i].flags & BNXT_ULP_APP_CAP_HA_DYNAMIC) {
 			/* Read the environment variable to determine hot up */
 			if (!bnxt_pmd_get_hot_up_config()) {
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
index 8443e3e7ba..7271cbb863 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.c
@@ -553,18 +553,10 @@ ulp_tfc_cntxt_app_caps_init(struct bnxt *bp, uint8_t app_id, uint32_t dev_id)
 		if (info[i].flags & BNXT_ULP_APP_CAP_BC_MC_SUPPORT)
 			ulp_ctx->cfg_data->ulp_flags |=
 				BNXT_ULP_APP_BC_MC_SUPPORT;
-		if (info[i].flags & BNXT_ULP_APP_CAP_SOCKET_DIRECT) {
-			/* Enable socket direction only if MR is enabled in fw*/
-			if (BNXT_MULTIROOT_EN(bp)) {
-				ulp_ctx->cfg_data->ulp_flags |=
-					BNXT_ULP_APP_SOCKET_DIRECT;
-				BNXT_DRV_DBG(DEBUG,
-					    "Socket Direct feature is enabled");
-			} else {
-				BNXT_DRV_DBG(DEBUG,
-					     "No Socket Direct feature - must enable multiroot");
-			}
-		}
+		if (info[i].flags & BNXT_ULP_APP_CAP_SOCKET_DIRECT)
+			ulp_ctx->cfg_data->ulp_flags |=
+				BNXT_ULP_APP_SOCKET_DIRECT;
+
 		/* Update the capability feature bits*/
 		if (bnxt_ulp_cap_feat_process(info[i].feature_bits,
 					      &ulp_ctx->cfg_data->feature_bits))
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
index cb826b2c19..4134e2f628 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1092,8 +1092,9 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
 	if (bit & BNXT_ULP_FEATURE_BIT_SPECIAL_VXLAN)
 		BNXT_DRV_DBG(ERR, "Special VXLAN Feature is enabled\n");
 	if (bit & BNXT_ULP_FEATURE_BIT_HOT_UPGRADE)
-		BNXT_DRV_DBG(ERR, "Hot Upgrade Feature is enabled\n");
-
+		BNXT_DRV_DBG(ERR, "Hot Upgrade Feature is enabled");
+	if (bit & BNXT_ULP_FEATURE_BIT_SOCKET_DIRECT)
+		BNXT_DRV_DBG(ERR, "Socket Direct Feature is enabled");
 	*out_bits =  bit;
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)

