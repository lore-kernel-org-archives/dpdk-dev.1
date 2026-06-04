Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A109CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 22:55:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B61BF40695;
	Fri,  5 Jun 2026 00:54:42 +0200 (CEST)
Received: from mail-dy1-f228.google.com (mail-dy1-f228.google.com
 [74.125.82.228]) by mails.dpdk.org (Postfix) with ESMTP id D348B40673
 for <dev@dpdk.org>; Fri,  5 Jun 2026 00:54:40 +0200 (CEST)
Received: by mail-dy1-f228.google.com with SMTP id
 5a478bee46e88-304f590dd91so1476328eec.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 15:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780613680; x=1781218480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GflDDq4bN9JyZWiNch7ZnxwEhtupu76oxdcRQM+ou+g=;
 b=aOpvMZPUt0WoMnI9OUKTeO7X5VoJh+n0pfrNCB559O9VP8daYI5365MBCZC68PKW4K
 nyBhnNOShigp4e5IeVGOYAEHMApEJmAeGKpPW9J/205+CcCstQvvqVsoPhBQJL9xaIAW
 ZxFaCpUsJzZAixD3f3Xd2TFHp7Bq6CRYTvnNQCrpqEFblS/C4EqbNBme4e4CF3XZfTOq
 eK03Zegf7YEKSxs3hUtx+xPMW84e7lPooOwnaYztrjXikqq76b5kDSZPkzETGAVzKbVJ
 CKUpojj5+bVdz9UH072FexW7OtFTmyi8J/aa2MyLz7CPvVs0gtaiQvN21iOTErDphDbq
 5rWQ==
X-Gm-Message-State: AOJu0Ywiw6IVD86FnZdruEGMHJacQE/K7UUQeSnpYde5s9xun5KGepPA
 I+W4xAeiI1IA+75wW9a66jczW9oV123g0krIHtVx6+vnezaZrujxoanYN1RmAPGFl4QGo4swYZs
 Qd16H5qGoV3jO4SMqZtb6FTH7EZ2zB2VfIsUTb6xnPYF80MoJbRSxIHtCrIF19klOzPJZxW549w
 WVFv/hOCiU1zxXkguf8lvYNYY4aZGEOJihoCZt9ths7HCS1vKD/JSV2m+C7b9F75YC1nVBE5NYo
 LHFeuAikeTv
X-Gm-Gg: Acq92OFpRWNmH1JFr+LnXjcBkFFXquovHWaSo0M2t1E4Ch+jH/OZkMWJJPZObZzt6od
 Cx7F5VQGpsTRhOMfQxXOTg9oNXD3RWLwY0ikPlyi9t0LhT0aav3DIixyU+JAOyDIotGfz+udd4j
 aYqqP9ek6zm77yGg/QMgwu3hOuMTVI/73eGPTdUaqkzqTRAc/TyTt1pg9A4tWgpGu1xPt3h9bSq
 07XTDTTs+qLWjk/9ov5D6wBJiWVMx0SfKwEwUoQ1l1cVoK6dRdvIfOgvK1rwZSomDKD3A0QtKX6
 l+O4lJxiuHYo8haG98TsmXDjB3hyC/KBVfPyaPm2rhg2JCiiKVSxhZvxNgxC8duch7syPKnwSy1
 88fMwfXdA4EcznC2EHNhpO2xdG/+R+mV+Z0tVjJDrjz3Fv3VuHJD3W6mx3NWcpT1Cdnrg0Oyvr/
 +GZ4UeKaKi1kbhYGi2yC40wrKCM+i1Gw==
X-Received: by 2002:a05:7300:4347:b0:304:bce9:25fa with SMTP id
 5a478bee46e88-3077b3305c5mr381318eec.4.1780613679870; 
 Thu, 04 Jun 2026 15:54:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-3074de3a522sm393016eec.27.2026.06.04.15.54.39
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 15:54:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ccd719a2f2so31645606d6.0
 for <dev@dpdk.org>; Thu, 04 Jun 2026 15:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780613678; x=1781218478; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GflDDq4bN9JyZWiNch7ZnxwEhtupu76oxdcRQM+ou+g=;
 b=FyI19HID4wuGAlZbixba7gQtkHgpoXNQnFpDS5GgtuvKf7RKs039RDB16THdXuHPZI
 BkOOumBOj/2RZx2QbTnqFsuHEOT4RxT90rnJCBD+cVuooek/Hwk8cgWB0n6kZTXlYv8Q
 cxF7yAnzHZDOdBvyn2rDz4YGLYlzj1BSINBLE=
X-Received: by 2002:a05:6214:5196:b0:8ce:f1b:74ec with SMTP id
 6a1803df08f44-8cee611f20emr21428296d6.25.1780613678594; 
 Thu, 04 Jun 2026 15:54:38 -0700 (PDT)
X-Received: by 2002:a05:6214:5196:b0:8ce:f1b:74ec with SMTP id
 6a1803df08f44-8cee611f20emr21427986d6.25.1780613678143; 
 Thu, 04 Jun 2026 15:54:38 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd053032sm67043146d6.24.2026.06.04.15.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 15:54:37 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 4/4] net/bnxt: fix RSS hash mode configuration for VFs
Date: Thu,  4 Jun 2026 16:56:22 -0600
Message-ID: <20260604225622.2285191-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604225622.2285191-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260604225622.2285191-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

Fixed VFs attempting global RSS configuration which is not
permitted by firmware. VFs (including trusted VFs) must use
per-VNIC RSS configuration with actual vnic_id and rss_ctx_idx
values.

Fixes: 8b9adaf0da6b ("net/bnxt: support RSS on ESP and AH headers")
Cc: stable@dpdk.org
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 0c82935de9..afc948ac29 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -2970,8 +2970,22 @@ bnxt_hwrm_vnic_rss_cfg_hash_mode_p5(struct bnxt *bp, struct bnxt_vnic_info *vnic
 		req.hash_mode_flags = BNXT_HASH_MODE_INNERMOST;
 	else
 		req.hash_mode_flags = vnic->hash_mode;
-	req.vnic_id = rte_cpu_to_le_16(BNXT_DFLT_VNIC_ID_INVALID);
-	req.rss_ctx_idx = rte_cpu_to_le_16(BNXT_RSS_CTX_IDX_INVALID);
+
+	/* VFs must use actual vnic_id for per-VNIC configuration.
+	 * PFs can use INVALID vnic_id for global configuration.
+	 * This is because VFs don't have permission to configure
+	 * global hash mode, even if they're trusted.
+	 */
+	if (BNXT_VF(bp)) {
+		req.vnic_id = rte_cpu_to_le_16(vnic->fw_vnic_id);
+		req.rss_ctx_idx = rte_cpu_to_le_16(vnic->fw_grp_ids[0]);
+		PMD_DRV_LOG_LINE(DEBUG, "VF using per-VNIC RSS config (vnic_id=%u)",
+				vnic->fw_vnic_id);
+	} else {
+		req.vnic_id = rte_cpu_to_le_16(BNXT_DFLT_VNIC_ID_INVALID);
+		req.rss_ctx_idx = rte_cpu_to_le_16(BNXT_RSS_CTX_IDX_INVALID);
+		PMD_DRV_LOG_LINE(DEBUG, "PF using global RSS config");
+	}
 
 	PMD_DRV_LOG_LINE(DEBUG, "RSS CFG: Hash level %d", req.hash_mode_flags);
 	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req),
-- 
2.47.3

