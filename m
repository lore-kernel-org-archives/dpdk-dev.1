Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D01CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:06:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 606C140EF1;
	Wed, 15 Oct 2025 11:04:53 +0200 (CEST)
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com
 [209.85.160.100])
 by mails.dpdk.org (Postfix) with ESMTP id 6179740F16
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:04:52 +0200 (CEST)
Received: by mail-oa1-f100.google.com with SMTP id
 586e51a60fabf-30cce534a91so1736274fac.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519092; x=1761123892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b15of6Wh2Nf6J5FBjefyUzBQfR6E9NoNzKRctj+/Wg4=;
 b=rFDutmP6Tm6+t/r/SC9rxyo7fiQk+SaR2xU+5XXdqJYEryE5wvgj4P8HZQzMkoiUgN
 fUxSuvgI9TkpdzVYt15FlOauNLPXqWj7sPNXwagppyO9MrbBv7lRK/zk/CA8PoXu70LR
 wcuyzYeznn2fCjcBT4Q6WElHJOvQPAV+x0x+tY1ovPLmmGNWkpOkaYw8KadoF9US5V/D
 /QyGrG5P5LhlGVTCjBgUfp1P2WPlBK5hDSURWC7U6PxHY+74IA7LgsRTzDrnbKp+WHYz
 bh0xN0T//SK/hJYF2y6WKVO024ySTKV5gtenRYVYQri5wq0zKmAqkI2lAgkopbZ2c+AA
 X0Qg==
X-Gm-Message-State: AOJu0YylZFE6o4ePl7CgbU0nwoD/FboduOFZ5sXSNVWDQG2aGmCxWVLz
 JXA5pHhNyWfUaZ10l/K9A1V14WbLmbivnBTJ3dbGJnE9m29NBZl3zFq5dUFIOb1B8h8aQIUKfa1
 VJpJ1v3GB7CKUMufhfzyH/tiH87Okx2rC8GhQ9p8IDmU5hI9FT04/nCZoaAUkpksAtpIQ18SPdK
 6VeVlPVGIHbxsWZkx3guLOBOyYpZHGloNmHQhknvMZiBBuKUH8r4qF9pLLGJy8rJRiPq/K/w==
X-Gm-Gg: ASbGncvR8MMJCvjinQEN1yamY35mcjqknbglmHimDAyWOQ3ltC+prE8eDRLydhlVRUQ
 Pe1tSr9DxPZjLDnzg7jpZUNPkMC7Q4zttYDuS29NqjpvXNZFJe7iGVsSbWhqjoC/N2l7wD142x6
 c/l87k+njWwGK3+MD3UF8LDA69vOXDuN2IT/DOeyjm5ctOD2YFOWdamt6n2AXeuzR6xXV44YviS
 pUf3ny6FLvxnH16cchgmgY83CD5uvCGXdEzIUn3CP76wgouUP+LSoOSTBjUMeKULmfNFh0R0ptj
 EOmaMbo7EbYTP7xtSUiNChm5bjalHsQdSoBb1JBK3pXvMA0tH2jBrgpLYRFDfpKHXOvAOWwK8fP
 ib5x8i7IlFK4vHb2CBPT4usgfYfBdLhAl16RrEUHFfX2J4gXJ5xFBe1xyks00bAILdTPJmB+0a1
 E=
X-Google-Smtp-Source: AGHT+IEiBu7lqQ0QpDXK8Y00zM7AYMzBbixC2iryvDrwO2Co8MWqLc+rjaFkvNyqQLhxgQ0rnFQCxod/3Cpp
X-Received: by 2002:a05:6870:a08e:b0:315:6935:9f68 with SMTP id
 586e51a60fabf-3c0f044032emr13925055fac.0.1760519091589; 
 Wed, 15 Oct 2025 02:04:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-3c8c8bf9760sm1437616fac.11.2025.10.15.02.04.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:04:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-78117b8e49fso18330649b3a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519089; x=1761123889; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b15of6Wh2Nf6J5FBjefyUzBQfR6E9NoNzKRctj+/Wg4=;
 b=F6Ha655xXpbI6+htYWXooD2lHYefeY2OxFS/mjEwiFGPLtROdp/V1u+88cb9vom8qK
 SbBZ/31Iv248gTCmGOdn83IRwahcLBklZCzsS2WE6pB+IW8INfkZBv8KWOFf3tzRAp/4
 JWdcodRb4x8io8GRG4pQacMjefjr5ebbuHjs8=
X-Received: by 2002:a05:6a00:b85:b0:781:32e:53cb with SMTP id
 d2e1a72fcca58-79384f48ca9mr33829118b3a.2.1760519088908; 
 Wed, 15 Oct 2025 02:04:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:b85:b0:781:32e:53cb with SMTP id
 d2e1a72fcca58-79384f48ca9mr33829067b3a.2.1760519088195; 
 Wed, 15 Oct 2025 02:04:48 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.04.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:04:47 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v3 33/54] net/bnxt/tf_ulp: socket direct enable
Date: Wed, 15 Oct 2025 05:00:03 -0400
Message-Id: <20251015090024.32250-34-manish.kurup@broadcom.com>
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

