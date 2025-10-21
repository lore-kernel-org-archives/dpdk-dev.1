Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E467CCD184
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 17:52:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6039740DFB;
	Tue, 21 Oct 2025 19:52:03 +0200 (CEST)
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com
 [209.85.210.97]) by mails.dpdk.org (Postfix) with ESMTP id 88D4C40DD6
 for <dev@dpdk.org>; Tue, 21 Oct 2025 19:52:01 +0200 (CEST)
Received: by mail-ot1-f97.google.com with SMTP id
 46e09a7af769-7c28378681cso1623634a34.1
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761069121; x=1761673921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O8awvPmoGY/dQQXwjK9SPQZOiFtuSD/X/fXdrTTHrXw=;
 b=p33MI2Y5CgazNIeaX77nI18Aw2MCZX+icKxpERnRvlk3otMgutpUeuId4CUw157Mlv
 P8T9VKiN5Hxa2ONeNruJqNuZllC7BKbRYeyTl9TPUGvpD8OfU5aFhpARGlq00dI/pksk
 ZKuGX6yYxWD6MORV9lbKB92u+u4hGLlSzaHRiJGHULc2Rj4f76/4xSQt2QrTj8TsU1IU
 vkGx856QZnXVh719gS2bpdsMCV4vKqgNWyjnBu3wvvDWecg2v7RPVOHmCeZtc41fF8UZ
 75paQcQ4hslFMHSO1MJzsnrBU/rZbmffrtopoDFEbV1Clyp9y4LBurrM0ujMUhZbXuWe
 wCXg==
X-Gm-Message-State: AOJu0YwoGPP8uKKcQJ2Q4fVefPogW41J2puFreDrtc+1seI+nmc9djmc
 rZsDCEht1Ed3Cqc4hvJc7hK1cshBWMBYReKP1njRA45FG5EASEOmX0Uq/+ys4CZCp3Fu+sib/VK
 /v8ord8pzoerFlYjt1pdJ1WEGHTGOzAFq5Ovp8ORORCDtyCE0g4Uw/u7uPDtgVc1uEVS1m+GXuG
 33aY2n+tZ9TZXUXe9/z1V2LqirNP2RT7q3MViZ4UToxrgwAIKJy4TVj6jfk/HjdoZdVrxugg==
X-Gm-Gg: ASbGncv8A+2ly8dKgYa4le2ANUU+JKhp6v3xtVZ870HnvIyT3GBjkTvHgTxtIgJFvGY
 Ml4slIi+TQEttd4fGbYgVI1w+535tVWaMXjxhMJvCSYCh6kM9NiBkmm/tqPgWauf+tcyZd4ujQC
 XRxxAIf1caMS3Rfx0PkZgHvK+gO3+/CStWJaN+ljYeAMa7PIF++geu5ofBg9dqkvuo5BOz4M7lg
 hyY2RDCtOzxu0uUPsBsWsB4puZPce5Qju/rZOCW8YU9yinJMsf0o9S4qQwd6vGX20r8upueV7Jr
 l25aw9yHjhU8b2DO6sWWfwRDH8K86VrPXnuZZqrWphLmnCGd01nyfZtDbjXsBmmITXE1jqTKd4d
 Ffrrbq7zykCaTCv8UuCShOX74jhLDhUFl+w6lftDqwBnwz9f1jlLXU+rSp09FTox97gIv2RkAnJ
 qQgf63Aq2blbPk4iDd8wwBLxbppwrcOwBP0A==
X-Google-Smtp-Source: AGHT+IHTZBEFFdDfCspqKIKs/S2AAl4rPLZxS2TZXTKVBLn13gUMzHV3hhpmvUN3s2L57RKRscvDC4RfmRSN
X-Received: by 2002:a05:6830:6d0e:b0:79d:4731:9739 with SMTP id
 46e09a7af769-7c27c5e323cmr8663712a34.0.1761069120571; 
 Tue, 21 Oct 2025 10:52:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-7c28888b8f7sm1720819a34.5.2025.10.21.10.52.00
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:52:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-28e538b5f23so65191005ad.3
 for <dev@dpdk.org>; Tue, 21 Oct 2025 10:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761069118; x=1761673918; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8awvPmoGY/dQQXwjK9SPQZOiFtuSD/X/fXdrTTHrXw=;
 b=fpc5t/SLyvKQ/Z/UNVjAO03FMVONIzkXio5W4Mo0Tbx4hRKo3IHvDxWLZufiNgxHsP
 xfhZDli1zbNGazVnMrHKEEBNsjQctL3CRQQUdTDKNr5zmc6piSDcnzMsfqTSRtFUhtG7
 uQcQWa+Gyv7O9LqT/NlRU+vxWcAXJl96qADlY=
X-Received: by 2002:a17:902:c942:b0:290:c5c8:9419 with SMTP id
 d9443c01a7336-290cb65b8e4mr223235165ad.48.1761069118293; 
 Tue, 21 Oct 2025 10:51:58 -0700 (PDT)
X-Received: by 2002:a17:902:c942:b0:290:c5c8:9419 with SMTP id
 d9443c01a7336-290cb65b8e4mr223234805ad.48.1761069117753; 
 Tue, 21 Oct 2025 10:51:57 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292472193c2sm115441495ad.104.2025.10.21.10.51.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 10:51:56 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, Farah Smith <farah.smith@broadcom.com>,
 Peter Spreadborough <peter.spreadborough@broadcom.com>
Subject: [PATCH v4 10/57] net/bnxt/tf_core: thor2 TF table scope sizing
 adjustments
Date: Tue, 21 Oct 2025 13:50:02 -0400
Message-Id: <20251021175049.46092-11-manish.kurup@broadcom.com>
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

From: Farah Smith <farah.smith@broadcom.com>

In order for the pool size to be calculated correctly flow counts
must be updated to the next power of 2 so that the pool_size_exp
shift can be used correctly without losing pool entries due to
rounding errors.  Also, max_pools must be a power of 2 for same
reasons.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
index 88863ed6ad..e7b82eee49 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tbl_scope.c
@@ -86,6 +86,8 @@ static int calc_lkup_rec_cnt(uint32_t flow_cnt, uint16_t key_sz_in_bytes,
 	unsigned int flow_adj;	  /* flow_cnt adjusted for factor */
 	unsigned int key_rec_cnt;
 
+	flow_cnt = 1 << next_pow2(flow_cnt);
+
 	switch (factor) {
 	case TFC_TBL_SCOPE_BUCKET_FACTOR_1:
 		flow_adj = flow_cnt;
@@ -924,6 +926,12 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
 		return -EINVAL;
 	}
 
+	if (parms->max_pools != next_pow2(parms->max_pools)) {
+		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n",
+			    __func__, parms->max_pools);
+		return -EINVAL;
+	}
+
 	for (dir = CFA_DIR_RX; dir < CFA_DIR_MAX; dir++) {
 		rc = calc_lkup_rec_cnt(parms->flow_cnt[dir],
 				       parms->key_sz_in_bytes[dir],
@@ -941,7 +949,8 @@ int tfc_tbl_scope_size_query(struct tfc *tfcp,
 			break;
 
 		rc = calc_pool_sz_exp(&parms->lkup_pool_sz_exp[dir],
-				      parms->lkup_rec_cnt[dir],
+				      parms->lkup_rec_cnt[dir] -
+				      (1 << parms->static_bucket_cnt_exp[dir]),
 				      parms->max_pools);
 		if (rc)
 			break;
@@ -1033,6 +1042,11 @@ int tfc_tbl_scope_mem_alloc(struct tfc *tfcp, uint16_t fid, uint8_t tsid,
 		PMD_DRV_LOG_LINE(ERR, "tsid(%d) not allocated", tsid);
 		return -EINVAL;
 	}
+	if (parms->max_pools != next_pow2(parms->max_pools)) {
+		PMD_DRV_LOG(ERR, "%s: Invalid max_pools %u not pow2\n", __func__,
+			    parms->max_pools);
+		return -EINVAL;
+	}
 
 	/* Normalize page size to a power of 2 */
 	page_sz = 1 << next_pow2(parms->pbl_page_sz_in_bytes);
-- 
2.39.5 (Apple Git-154)

