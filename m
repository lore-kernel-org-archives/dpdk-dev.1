Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0851CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:18:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AD554042F;
	Wed, 29 Oct 2025 17:18:28 +0100 (CET)
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com
 [74.125.224.97]) by mails.dpdk.org (Postfix) with ESMTP id 0CD8F40663
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:18:27 +0100 (CET)
Received: by mail-yx1-f97.google.com with SMTP id
 956f58d0204a3-63e336b1ac4so193484d50.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754706; x=1762359506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3sxnLaXiWkXvG469e06v5H7cEbF5In/yjOTAzyItFM=;
 b=kckJY2oDrkCgVVTlUESj4Q7UXtwtWKAQUatfHqSra1PiDIcqeSCSlUU8vlNHTmzprP
 yD8tJLS+zVXKZ29hw9wfS2Ox+6JH32Is7B36weJDHp7cUbODfKK1WiLUdgLGg1pQytBY
 U7zhWQF/wsPyJpTh0QZ2u15vc39mDICQuReOxfWFbF5poJUWUU7PqaYkXbpFReSHqeYx
 xGDetDdaoJVpTHeUSiyfzBJkAvlYlSlDguoKIC+ITMA3mxqOfItwS/aJwJRAuDSvAQvl
 Tc+RL3+xKcifQxv3FFnPsNJ4Wt34GDnIXrAFxuxSMCF5opq5bfT3Bh4IasBmsNipL6kz
 nkVg==
X-Gm-Message-State: AOJu0YxQ16EVlDMWzWprqiC8fHY5lLzt7pC6tCEhW1muMR4VJxw0lrDj
 uDhf1nv567MjLW5F8UnTPxSY2QUwd4u3sqisvYIxle45Lqfx2xATFnkZCnXJ4vyqTgsE8/3uZji
 Kx1I3tEqq/SWCD+Gb1BIebUHb0PWH2xx66cPiCy2YklcVvZ9qzlXapJZNQ0Kz7ZBFlaQ0AEBpQV
 vY3YcLlxMQTCnvGo07TJvL2DtHapX8kYdMkEKlHVzF6rhUX8Szrns78CZ/g3fGo0rTN6QgSw==
X-Gm-Gg: ASbGncvjlSu0+/9y2K71HaxRJshZhy3sWnwIFYXA69f+YJdprkajiTEHdnHGBpuzxGf
 zI8yh5Ju9m32cHMd/+1ffSCXKo8XqrEqbyINz+Mqef8h5RnOXTBKcFREJQ7a9Beri8u/7r/cRzR
 9i3jvpFeUdAhD9G8MTclzWbcsA48UayH+FbA6uR+mfU05lrheRN+Ed9zKb5kbU/sWZrL05X1r8a
 JUBcAUg1w+OreAXGOv3915XdFmXvX9l1bBXVs1JfRLmjPNFnBvkDYSM0gdFN+5t3Cu2PMpQB94r
 lPh/++UCknBsgciLwVUF3faYkeXsJk4WnVUpk2SApsMe4X/anzxXvsGXLCbjR6zG7oIMRQ6in4j
 YS9IxvM2LWhhi3MW1Tn4SCgYjs/z6up6YyjqvBTgwBn33PftMSKESAEPqMLec9Co2Iy4O/b2Sac
 MTNat8bAxb0mQef8z2U1NvymEDubeF52M=
X-Google-Smtp-Source: AGHT+IFenUluKwGSSWuRy/Ru0tNDxqRLrHGsyVvPYx5rItvcSy49kim+bXFgbJ3YtqJjN8GO43Uq3Jp9OD8o
X-Received: by 2002:a05:690e:4106:b0:63e:29af:bd23 with SMTP id
 956f58d0204a3-63f828c2b5cmr140470d50.4.1761754706341; 
 Wed, 29 Oct 2025 09:18:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-785ed146afcsm11191967b3.1.2025.10.29.09.18.26
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:18:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ecfa212e61so35819271cf.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754705; x=1762359505; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3sxnLaXiWkXvG469e06v5H7cEbF5In/yjOTAzyItFM=;
 b=KS8ZUgmk8phw4HL3n4TVwnIgAcfZF5E/ObGKJLCyy4sOAL4uKlKl4JP0T23GRHh6Bk
 sNNNPgvAKopC110oyGfyqepPCeOSQ7//ECkzbzy/EwdbDxdEXbc6ZDu9oUV3E4dqx1tl
 Kkjsr5AMW/pI9QUnACqQEQV8gpfbGffdupOmo=
X-Received: by 2002:a05:622a:1354:b0:4cf:1eba:f30d with SMTP id
 d75a77b69052e-4ed218b282dmr2410191cf.23.1761754705330; 
 Wed, 29 Oct 2025 09:18:25 -0700 (PDT)
X-Received: by 2002:a05:622a:1354:b0:4cf:1eba:f30d with SMTP id
 d75a77b69052e-4ed218b282dmr2409461cf.23.1761754704692; 
 Wed, 29 Oct 2025 09:18:24 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.18.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:18:23 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v5 27/57] net/bnxt/tf_core: Cleanup flow scale option build
 flags
Date: Wed, 29 Oct 2025 12:06:42 -0400
Message-Id: <20251029160712.58519-28-manish.kurup@broadcom.com>
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

From: Shuanglin Wang <shuanglin.wang@broadcom.com>

Resolved the build failure when building dpdk with the extra c flag:
-DTF_FLOW_SCALE_QUERY. The issue is caused by the new debug code
in DPDK 24.11.

Signed-off-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
Reviewed-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/tf_core/tf_resources.c     |  2 +-
 drivers/net/bnxt/tf_core/v3/tfc_resources.c | 12 +++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/tf_resources.c b/drivers/net/bnxt/tf_core/tf_resources.c
index b3174ba1af..3219d61cab 100644
--- a/drivers/net/bnxt/tf_core/tf_resources.c
+++ b/drivers/net/bnxt/tf_core/tf_resources.c
@@ -535,7 +535,7 @@ void tf_resc_usage_update_all(struct bnxt *bp)
 
 	tfp = bnxt_ulp_bp_tfp_get(bp, BNXT_ULP_SESSION_TYPE_DEFAULT);
 	if (!tfp || !tfp->session) {
-		BNXT_DRV_DBG(ERR, "Failed to get truflow or session pointer\n");
+		BNXT_DRV_DBG(ERR, "Failed to get truflow or session pointer");
 		return;
 	}
 
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_resources.c b/drivers/net/bnxt/tf_core/v3/tfc_resources.c
index 5fa6d113ca..44b7a0afcb 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_resources.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_resources.c
@@ -59,14 +59,16 @@ tfc_query_resc_usage(struct tfc *tfcp, enum cfa_dir dir)
 
 	rc = tfo_sid_get(tfcp->tfo, &sid);
 	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "Failed to retrieve SID, rc:%s\n",
-				 strerror(-rc));
+		PMD_DRV_LOG_LINE(ERR, "%s: Failed to retrieve SID, rc:%s",
+				 __func__, strerror(-rc));
 		return rc;
 	}
 	tfc_msg_resc_usage_query(tfcp, sid, dir, &data_size, &stats_info);
 	PMD_DRV_LOG_LINE(ERR,
-			 "dir:%s, %d - %d %d(1-slice) - %d %d(2-slices) - %d(4-slices) - %d(unused row) - %d(used_slices)\n",
-			 dir ? "TX" : "RX", stats_info.max_slices,
+			 "%s: dir:%s, %d - %d %d(1-slice) - %d %d(2-slices) - %d(4-slices) - %d(unused row) - %d(used_slices)",
+			 __func__,
+			 dir ? "TX" : "RX",
+			 stats_info.max_slices,
 			 stats_info.row_1_slice_p_used,
 			 stats_info.row_1_slice_f_used,
 			 stats_info.row_2_slice_p_used,
@@ -86,7 +88,7 @@ void tfc_resc_usage_query_all(struct bnxt *bp)
 
 	tfcp = bnxt_ulp_cntxt_tfcp_get(bp->ulp_ctx);
 	if (!tfcp) {
-		BNXT_DRV_DBG(ERR, "Failed to get truflow pointer\n");
+		BNXT_DRV_DBG(ERR, "Failed to get truflow pointer");
 		return;
 	}
 
-- 
2.39.5 (Apple Git-154)

