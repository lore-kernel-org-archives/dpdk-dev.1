Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11744CCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:57:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7C8D40A7D;
	Tue, 21 Oct 2025 20:57:36 +0200 (CEST)
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com
 [209.85.166.97]) by mails.dpdk.org (Postfix) with ESMTP id 21C0140E1D
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:57:35 +0200 (CEST)
Received: by mail-io1-f97.google.com with SMTP id
 ca18e2360f4ac-93e8d7d177aso121028639f.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073054; x=1761677854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c8rwxgb+bgJR+Jx26Vxp9kSc3+3AGj1fWf8ZauHq7Fw=;
 b=dHfbCjER0vwSAVAl8vILL+DtXEcGuixORXt61yzEKVkfoFSD6ZYy2SyV6UMfzG88n6
 13UdUXFrTWsAvhBu5YsX1IGjQJ1CDW6RT7SDSDthKsKHtIVa2Y5n69bB4tdF9EKoSZ5L
 XJ/OkVr0tf7SKP7pb2D0j99JOafv5+3xabKOPTXdbq1UWYdjorIC49iK7PdqGQzExkGP
 ftY5Hd0dW1syODIQRyEVAeMNO/lZESqo0/MlBXo2/D6eghvR0c8iHW7hx2h4jcxTkG+/
 PTDAqlqzMpx0RDMyij5HlOgXjJ0IKNTYuZUsxPXiYm+FUiLhbGRU/QEiC1AV+PGAHjjR
 aW/g==
X-Gm-Message-State: AOJu0YwGncblFSPCBSrtC5eGUZ7oMA3bozY93EwmzafLFzCt+rC14rKb
 iD+fU+tQXlccceNRO+xK5kDlAHQOuzWGkqSZKUWXOM88IBuioAssY7K5sbROk0rN59AnRdM0BKC
 amzRaVK0JiE0RHG5+n1J6CwOOiH3Uuukxu38jhmNMYoObOCDgISNfip2h0dW7w/D4yUaVsF/nvA
 cM0gUwaCeepYQbYm25Ah+IjXHhhgdWihx3M/V4GmKup5KDE9IkDSGcN69sfAkQPWHC0sXEGQ==
X-Gm-Gg: ASbGncvgsOQ/f99yBW7EB9dn/txJfGNzm8Jc2dmU78wplUc6QThRqFLNX12iYNY1KRt
 oWfBXQz6jyOio8vOAY1qf+sbLqJVhPl5PpZmXR75dGpd/TNv7NXM2bwpNslKd2tpCWxr7kJ61I2
 xJeXBgHc5MpIggO3Ma/Xt6jNJrtoejMS54AyV30USs+XNb4Peh5HOb1rkHbrSM5Mh66UrukrXfY
 VMjmm+4Pa2bBszXgMMMF4C0SQ67LoSC6kmjOuWZmKOEWzv4bO3WefV2ib1IDe0pW8qEoIJA275C
 0llB7CQ4o6Z/erivazWcyGIeh30DfOk+aHh/ueodn4cczDRx4t1drKLfAEAyXYuwISV6DnVtIWC
 dyLiJoC+ZYuskqm//4RUuFOgAXYky2ut+0I6jEBE5P6QslQL3ofM8y3oZyqLKWeX44lm4A21HjX
 rG0b45q1hoRhqAU3E4fk4TIInYCpMUFnuQWR0q
X-Google-Smtp-Source: AGHT+IEq12VmtHZ06zmhzwGFNDGJ5PbBmDnn3FkBkmRdBer64E2a7D+we8eaqDgpGYis7kb9HWJb8MzH8GQV
X-Received: by 2002:a05:6e02:216e:b0:430:ab21:8c4d with SMTP id
 e9e14a558f8ab-430c5232bd3mr254527985ab.11.1761073054330; 
 Tue, 21 Oct 2025 11:57:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 8926c6da1cb9f-5aaa0777540sm24576173.2.2025.10.21.11.57.33
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:57:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b5a013bc46dso3867485a12.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073052; x=1761677852; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8rwxgb+bgJR+Jx26Vxp9kSc3+3AGj1fWf8ZauHq7Fw=;
 b=WBXoRBIv9Pd1w91lj189sNGhxRMnQWWE7uqRTwSxKFfHTIU/QE8nGLGIrDdtLloVY6
 9GWK+uDdavpM3JQVoUILwg28fawOoyW9Ytn1yPnVlYv9CjGs261uZy+Ejto81K1JnNR4
 mE4Y0g84Pfr2ECPsq4pzRfcYZHZqdnRRQLVzQ=
X-Received: by 2002:a17:903:b0e:b0:25c:e2c:6653 with SMTP id
 d9443c01a7336-290cb278e7dmr202726145ad.48.1761073052483; 
 Tue, 21 Oct 2025 11:57:32 -0700 (PDT)
X-Received: by 2002:a17:903:b0e:b0:25c:e2c:6653 with SMTP id
 d9443c01a7336-290cb278e7dmr202725885ad.48.1761073051916; 
 Tue, 21 Oct 2025 11:57:31 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.57.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:57:31 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v4 36/57] net/bnxt/tf_ulp: socket direct enable
Date: Tue, 21 Oct 2025 14:56:40 -0400
Message-Id: <20251021185701.71881-5-manish.kurup@broadcom.com>
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
index e3eb9107ab..de87ce0349 100644
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
index 65df4ecd79..772dd69035 100644
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
index c3f3bcd59d..c46340b1a4 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_utils.h
@@ -1061,8 +1061,9 @@ bnxt_ulp_cap_feat_process(uint64_t feat_bits, uint64_t *out_bits)
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

