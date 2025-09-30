Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC7CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:08:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7279040E2F;
	Tue, 30 Sep 2025 09:05:55 +0200 (CEST)
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com
 [209.85.161.98]) by mails.dpdk.org (Postfix) with ESMTP id 869B2402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:07 +0200 (CEST)
Received: by mail-oo1-f98.google.com with SMTP id
 006d021491bc7-643cd58c678so1406677eaf.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192627; x=1759797427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3sxnLaXiWkXvG469e06v5H7cEbF5In/yjOTAzyItFM=;
 b=WOGgrQz5h302RZ8lRl6WCgiCEW40W96gus6HYP+ho4FqEh66J5oQzvniaS6naFyb3+
 ftVwWUrs94Ix4e/yrQALM6AYMIPDGBtHZqiigVPtJDViiT256PYS6t3+D5vLYkvCJani
 FYCqbNSRLcZkDET18j5pAoeHdr4KShy3FXGoRjdQiP5DjbTtMwEOGZA3AC92Nk9z3bLW
 mOi4UlaU1Skv1Ueyamw0ubYKNN9H43QSzWMIlzyRwYhENzqvAMStkHWS5gF2HPfQdbwU
 04SFVIBGPvz7yUD2ALg13c8pR3DQGyqJS6RgRbl6ZVRtdOIAl14FLE+d/TOFB9mXNCqJ
 wsTQ==
X-Gm-Message-State: AOJu0Yww3L5L9hr5cFRdZWmHaP7zztH3YOVVmvSecDTSCX2YTibcxW6s
 FLqhxVaFYxeNWjk7adzamPNM2bj319L8015xTUAlpqh4GgoOe3ET8XrbUqhe8c4seBRrhhgaSiY
 IW79H2S3O3wqtP5RBlDzJgN+Wd46xJyDMppBV97MOtTMlyxPw8Q6LcMOtDVO2ggTtx4daVyJ7dL
 r6hJpqVXwuwJWnDw93OFnUDBLS4pvckCkkcl599wZeRNRBCbmzWWYJKg0/Jpk/LXt/yNhuyg==
X-Gm-Gg: ASbGncuPyTEaoLjYaN/OvkPfSC4BlmgIM9EtXaiQk1i4pZwZwEAEv6x9qX10AkbS9hs
 8jR1ybc2WNykoPBKFDwtxIBne3gXfeLJtHcd872ul/Sz+6N2NZlV3ABN5GTpZT31mhk0P8rbYBP
 ZdeBDZOLazbGrQjIH//Ds01QQoYEOQChV1n1i9RsrhgZm1YGaEw6/A2McDe2AbagPsohxVIW7c4
 UB3Ro+2mniqjchEjajD5v1RkFI4YbVnnDKfoy9U97i4tEJIstma4eSPNGGDdcBd03CTPzMt1gFC
 T+SmEKLZ0angQ0JEbHCeY22fbz6+1nlD9G0AYh54dffeyuzCGE37ygq8xzmlKsfL5+f5RVE3UzO
 0/Di9YeFH9Zm2A98XCHoQ9KBrL94fx6o/Q4QPr0BEhYCduiuvvgauUkOMgtlTZY23UrT5urZAGE
 j/fkE9uGs=
X-Google-Smtp-Source: AGHT+IFzX2XeOcNHoufxrajmApRjzGoXNbVG0HuXrIPe9bCnmleHv7ZsingUtFA97VUIm3rP7BHLI45Tb+Vm
X-Received: by 2002:a05:6870:783:b0:340:a15c:111b with SMTP id
 586e51a60fabf-35ebf10ab82mr7775343fac.14.1759192626658; 
 Mon, 29 Sep 2025 17:37:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-363a2ce97f1sm1059853fac.3.2025.09.29.17.37.06
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b55153c5ef2so3547743a12.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192625; x=1759797425; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3sxnLaXiWkXvG469e06v5H7cEbF5In/yjOTAzyItFM=;
 b=CokamxlqHyN842AHdzqzqkhPbv09NOfcKPy/53ei5mVRIJ16EY6LOdgbGO7MynEuRD
 fA1tjdokAsjKBiP+JBR+Za1rB1yK0EVZXg2azVoqFR94itgrSk7Nmhf9694u4Ke04Xvh
 3ZF8T7RgjyyTTQuQj0hBJnXjdsyDstHpPTiyk=
X-Received: by 2002:a05:6a20:e212:b0:2af:65aa:4eef with SMTP id
 adf61e73a8af0-2e7d37e3fa8mr21630163637.47.1759192624834; 
 Mon, 29 Sep 2025 17:37:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:e212:b0:2af:65aa:4eef with SMTP id
 adf61e73a8af0-2e7d37e3fa8mr21630133637.47.1759192624289; 
 Mon, 29 Sep 2025 17:37:04 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:03 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Subject: [PATCH 24/54] net/bnxt/tf_core: fix build failure with flow scale
 option
Date: Mon, 29 Sep 2025 20:35:34 -0400
Message-Id: <20250930003604.87108-25-manish.kurup@broadcom.com>
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

