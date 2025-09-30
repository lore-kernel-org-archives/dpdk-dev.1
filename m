Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ED3CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:10:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC7AD40E7C;
	Tue, 30 Sep 2025 09:06:04 +0200 (CEST)
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com
 [209.85.128.226])
 by mails.dpdk.org (Postfix) with ESMTP id 139DF402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:22 +0200 (CEST)
Received: by mail-yw1-f226.google.com with SMTP id
 00721157ae682-74625f748a0so58511347b3.2
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192641; x=1759797441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b15of6Wh2Nf6J5FBjefyUzBQfR6E9NoNzKRctj+/Wg4=;
 b=JJMIo2GXTixHgqWEFAMQ8q+rA27LFubS7KbRO8LnD3Ig4aSXShrU5KMarjEg3blKKs
 HCnCTzdB63QH4C5iGvmTmvY3efgykyjb+ekTVdZyC2Xq1yQQdSMwiU1Bg8pd54QV9YC7
 THK2/ttu9jOWfqcAw/wR4MipVyLSCBfnShUzS6ermqD3s8L4Tp6ZIZBFXOrbTZ/JrN43
 wBuXvkh7W9cMkwd2lPlv4nqHMGKNzXygIujKHD0G3RjH0Hg7TlJdxnUpQxS4Mq518p2k
 dPK1CQsk/XhpRRc9XGDDnYQIlgLPBG61O2fxWmSrI9/DSUwD6scn+swj9WPl/1FgADJ/
 X8bg==
X-Gm-Message-State: AOJu0YyvijZ6yLayjnXUvqEfwOt3f5yAGKQi6pJyNVMlwcC0iHJnbQAm
 qYbYMfUrgnxJmYJ1EdpCUSB67B7ZWYK1WVI2rI4J1Mcfo90cpluiMMDr8v7ikXTw7Sr4Z8PBfdR
 v5KDsZtWaJyIIFMPXGRWjVRDdPcfsgxOzQ1n6LXBKrdvURSqxLrotRiTFq3RLN47xIK7UiScs8i
 GtasGoG8Emxd19Jr98O5ETCbXYPgccvz6LyfItmbQpRWiYFt9jX6rBJXgmKqjBI9bbUfKH3w==
X-Gm-Gg: ASbGncuxNJsTQS9sqG8EHCn9UP3AsZP3KcVOvy2t59VTiiYzbMb/UJ8YD2EZ+boucpi
 0G80V4lKWsMkupBXdsAJiz+F+cs6iTd789jqdT2/vQDG4d/H3yDu9YPY0cQNurLdBs9FgLWMg0l
 swXiG/K0bsuM6t7MExkPGUmfB6DLI3nj9RBPZ9J5JXCftWiDxWiLjHO6GgY7KliYdJnapDVuVrB
 bCt3h06/QXr+kAO5/6yhwf6BT0841+17/gpBDy8cvDOfOotcqoHEFy66afGHhoFpkI0zB769Wfy
 MEdQrboYKtGextO67ZmVJ94ai/Sq+mZjdiv4W70WqtR37gcuKhvFMseOcv3yf9PX7lopFVMkpVm
 4+F223FhEwAhxGKB9++qpHXZ7qVJYKbueTWjyLrjHtQTyNcc33jX/bLC4meRLnln1XWSieek4y/
 RSzVjqc6s=
X-Google-Smtp-Source: AGHT+IGm8ps6hNP4bCVowF2++sdK6afv4evRh7qOKcCZXlQwG94F+HwqHeUfE4eMO4r3jVOc5wUu+/qs8idH
X-Received: by 2002:a53:e00c:0:b0:636:cf70:59e4 with SMTP id
 956f58d0204a3-636cf70646amr15422767d50.36.1759192641383; 
 Mon, 29 Sep 2025 17:37:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-765da7c48a3sm6466797b3.37.2025.09.29.17.37.21
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-783c3400b5dso1365483b3a.1
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192640; x=1759797440; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b15of6Wh2Nf6J5FBjefyUzBQfR6E9NoNzKRctj+/Wg4=;
 b=BqLt6GmxMcax7I/j+UnSErai7XVw+7rYXwL/nZ9bwJNA1Xz6jjpt4Ky0dUzIE3EBws
 gBrRwT92QIIphaOUh+5G4wzmCkOkmUejseuGrx5uBNQYNTAcfoGSPnn5GOXPQdi44wqw
 fs7I4kdcfx0pxQ/oDhNPnsBoATsS4MOf6856I=
X-Received: by 2002:a05:6a21:3992:b0:2f6:ec69:d43c with SMTP id
 adf61e73a8af0-2f6ec69d828mr17644262637.21.1759192639825; 
 Mon, 29 Sep 2025 17:37:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:3992:b0:2f6:ec69:d43c with SMTP id
 adf61e73a8af0-2f6ec69d828mr17644228637.21.1759192639316; 
 Mon, 29 Sep 2025 17:37:19 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:18 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH 33/54] net/bnxt/tf_ulp: socket direct enable
Date: Mon, 29 Sep 2025 20:35:43 -0400
Message-Id: <20250930003604.87108-34-manish.kurup@broadcom.com>
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

