Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0995CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B2AE4066E;
	Wed, 29 Oct 2025 17:20:01 +0100 (CET)
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by mails.dpdk.org (Postfix) with ESMTP id C2F7440669
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:19:59 +0100 (CET)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-29476dc9860so160915ad.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754799; x=1762359599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c8rwxgb+bgJR+Jx26Vxp9kSc3+3AGj1fWf8ZauHq7Fw=;
 b=AL54m3RIT51XWFGdqM5m7XDsBcfweQ24i4HWmYmasxRyPAmC57pDRgQm8RAbyPujTT
 9J2waCahbdZenVKdNYvA6hBpTehEeWKT1xX7rJHZE22DPIjaordEd5rQjCaX3fHnX4Ic
 f2ZJwUVVozOhtHk6qGWWOsJcvKU22upF/7FZQLn7AfNJs/CW+fdAKMy6egwiMK1Le1Ol
 UiIhL2RMofekOZC0jHtJ7cBS/RTM4mr7DjjnNk5mSK9XRJHNbgNBiXJ/bylhV6DeetG4
 QnAapQubV/tOp6NS8TCscIpuBDuA7BmIwM/mMP/8lDYUt7fx2hJTDvIrBEcUb3gN1joq
 khzA==
X-Gm-Message-State: AOJu0YwX2lwWWwTZyGjZEyACeCflbCljAYmAiFF1nCk7B5ISi0BDu/L8
 G5QCeLnzMcT8W/Cjf+XWPFgsFb/bdx5GTAiRe+WR2NTzZEfkwHsMckR1EJsj2K7CuOn5xvYVCtz
 EosMNcfoxEhg30KuYXkU3biQQVWLmlEx6qmEE6bBALttFSvf4gmUtJECwY/8sYUqhXIht9aEUw7
 B8KllSO+XQOxUqTd3GFyKSQFyWBM9qqRbcVTMEev/hSpyayVojetQ4vOK+QT+zoVahAIsgWA==
X-Gm-Gg: ASbGnctEtRf6uOtgTn0rdqAJ8LVmIWtf4Eg7ZVeEMatO5Re+iOqVa6dU3HiblT78g5M
 P4xz6fhX6hwH2bWfAT6S8mG3D8z6C/+PSK554s/qU8FE4zBPEXIgWNkBT2+zwsy/gG50easrRP+
 06m/ZwkJB523sr3UzDoparryOzhrkZTWapL7C4XLZ55oXd7LcoYFUvJUlMXpLkNqoWHNBgt/58X
 AMr5HaxQxAcT0rtRcir3j5fz3GO+1N3pVHA6ZZYa36wIU3yK2jlI/Jw9NKwal9jY4W7+7EOOp/e
 erVw4tVbjjvMFijU9X5k/N5tI9Wh3CcfK2GJJnxwJF8is+BntFkMKQw/4KX8yG8HDTfCvnXTGp9
 NavzZ6sdlFgr89yKmHeax/dsyToZPs1VJlBpL1Tlq/AObjq0E2C4PsGHlmiKjqMzaq0TrtkQhN7
 wXjs02NK5KofF45NeuT+uJ0TYl2vIsSMs=
X-Google-Smtp-Source: AGHT+IHmrcfbASF0WkHyUL04cApZkEj9U11ukClQzACNpybe8yoGFxzUaXZ/65KD6VD3hQADyw01L27t81Az
X-Received: by 2002:a17:903:ad0:b0:269:96db:939 with SMTP id
 d9443c01a7336-294def33bffmr42836635ad.58.1761754798839; 
 Wed, 29 Oct 2025 09:19:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-29498d23328sm13847315ad.29.2025.10.29.09.19.58
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:19:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e8a89c9750so213437811cf.0
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754797; x=1762359597; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8rwxgb+bgJR+Jx26Vxp9kSc3+3AGj1fWf8ZauHq7Fw=;
 b=E1O8Sirtc/AEG7jiKmF4WS2kSq7Uj7FYExnAkXHDR2GBlhkWAxhddSdkFMaHHvfADO
 w6+bP1yNez9SHRNHJiLWBflYglXVCKkyqiMNTmGXj1/8y0y/Lhds1m6VyfoWp8XCOFuq
 GNVW5DeSG1vdXMyrhf+ajk0FTv8WYqBbu4Q6k=
X-Received: by 2002:ac8:5882:0:b0:4de:5b49:dc94 with SMTP id
 d75a77b69052e-4ed15b53f2fmr43781281cf.3.1761754797275; 
 Wed, 29 Oct 2025 09:19:57 -0700 (PDT)
X-Received: by 2002:ac8:5882:0:b0:4de:5b49:dc94 with SMTP id
 d75a77b69052e-4ed15b53f2fmr43780761cf.3.1761754796519; 
 Wed, 29 Oct 2025 09:19:56 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.19.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:19:56 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v5 36/57] net/bnxt/tf_ulp: socket direct enable
Date: Wed, 29 Oct 2025 12:06:51 -0400
Message-Id: <20251029160712.58519-37-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

