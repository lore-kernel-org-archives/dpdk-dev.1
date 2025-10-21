Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD70CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:54:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01B3C410EE;
	Tue, 21 Oct 2025 19:53:07 +0200 (CEST)
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com
 [209.85.215.227])
 by mails.dpdk.org (Postfix) with ESMTP id 2E0E540E38
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:53:04 +0200 (CEST)
Received: by mail-pg1-f227.google.com with SMTP id
 41be03b00d2f7-b6a225b7e9eso4201816a12.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069183; x=1761673983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3sxnLaXiWkXvG469e06v5H7cEbF5In/yjOTAzyItFM=;
 b=Kq9VQQ7WVZq1iWhF0tji3CHFILN3Z7HNudO++PuMH4Tls5UAJcojOj063jNQ+XNdRd
 1fNGI/lLCAK/uVXDvWy9K0xxE59zAbZ4//b+vuEgYacTGcw/tmn4ezgt2Wm6oUz6yjps
 hFCzWHUYfvjLmqTG+L+uSzbpfjb5m6hLapcESxE9pUaIGwCSQwT4SxEOsjMnISSGm5BS
 c4N07DXGNbaf5HKwLKR+PghAjjNuijLxcosPmhVUfX7pDwIYlt9PS0QZDpEZZ1zMo8IX
 G/5Usu2OWLqdt8gY9PzshAIJrHUsahXwnoGxbrqyNQoa97hyOlU3rnYGNuv82i6xE7xJ
 ta4g==
X-Gm-Message-State: AOJu0YxkK0v0xbc+QLVRVg0hL2ujRuz+luIN9JkZz0ej4acOGrP9dNyR
 m84sdosellEtG3C12vmHAs3SNnOawcfKTJVol+N/bRKP7ed7sp89pMNUsIkDpTxL18/nPrpyC1L
 z4TrCOzAP+hN5xKep94NYXOkqe5ZZYlPGs0GyX9aCkg6wBP9ivY//orwb8J2X1XxVV1Xny46vvm
 t7T+h8X73lM2XMvniZrpnk6fOkvOhcb6ijb1eo3IjhIU37nQIBCXMOPSfJY/QxTdE2GJdJmA==
X-Gm-Gg: ASbGncvajiSAG9k1rgwIoDr45iYWKZ8ygYpOQOM4eB1qAkRpB4pSR0YcW6bxbYY5zW5
 4dVBCL1E1troj9e2Vb08QYdsh9gJpO3rZG7WztgSzgS3Uyu/GJXZT5nLfiRRiKnJ6at90MMlcRJ
 koOPQ237eGfFwlOHhkWeVFiegB2f7PfkO6JhwzUZzRpqcUo85HlgNILsHPJpxZAio8LAnVwSbzM
 z1rfwoPei1FG83CCPCq2/BUmBbRFFAkkWLkXjCR1r14KjD76keggg8hq/cLmyJy66GDI7xCWenR
 TKyad0IZq5ETmn7EkNkMTl6xO52pJUZUMTDEJU0W+OZ72ZhNfLTxpCdHN8SvRXjKxmXmbfT3OqZ
 Tat2h1dmgkvMPuz8pspu9rKRp3ZURQGwdb+AFZ+zVhjhVFDXowupBhaavJvkb2gL+HZ2BkBiOOo
 ZS28aNFro4dfN8unT1xUmQ+rVe3bPJvShstPXr
X-Google-Smtp-Source: AGHT+IHDex7o7Q4EpdBNuIyZtySClFTWbcf1ZcHqqvL8744x0+jKwn3RMEwDmC8W+KNMcYdHHn+U+8kTyuvH
X-Received: by 2002:a17:903:b8b:b0:26d:e984:8157 with SMTP id
 d9443c01a7336-290c9c89ca7mr185540495ad.8.1761069182694; 
 Tue, 21 Oct 2025 10:53:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-292471c5c7dsm12931085ad.38.2025.10.21.10.53.02
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:53:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-290e4fade70so44112115ad.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069180; x=1761673980; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3sxnLaXiWkXvG469e06v5H7cEbF5In/yjOTAzyItFM=;
 b=KlqQhEgPuVigsmDNrC30wC6ALpGzP1om70qAIOAlIQWr+IfJ5UlOdLuLmQQahsun98
 dd7no6dHZP/OzNYcOCaTCMPUBBR7UftJqoQnxfvvfOYMRPx5/ArFnbfFW2eEpwtgRiT0
 bQyiBmrvBAIiQFodYbBqylVmazRrKvF524fgY=
X-Received: by 2002:a17:902:d2ca:b0:290:ab25:2986 with SMTP id
 d9443c01a7336-290cb27d770mr239680105ad.48.1761069180625; 
 Tue, 21 Oct 2025 10:53:00 -0700 (PDT)
X-Received: by 2002:a17:902:d2ca:b0:290:ab25:2986 with SMTP id
 d9443c01a7336-290cb27d770mr239679665ad.48.1761069179954; 
 Tue, 21 Oct 2025 10:52:59 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.52.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:52:59 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH v4 27/57] net/bnxt/tf_core: fix build failure with flow scale
 option
Date: Tue, 21 Oct 2025 13:50:19 -0400
Message-Id: <20251021175049.46092-28-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021175049.46092-1-manish.kurup@broadcom.com>
References: <20251015090024.32250-1-manish.kurup@broadcom.com>
 <20251021175049.46092-1-manish.kurup@broadcom.com>
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

