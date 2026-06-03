Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580CFCD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 17:50:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90BBE4066F;
	Wed,  3 Jun 2026 19:50:07 +0200 (CEST)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 796824066E
 for <dev@dpdk.org>; Wed,  3 Jun 2026 19:50:06 +0200 (CEST)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-36d630c0e35so4528594a91.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780509005; x=1781113805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e+V6lYrZ79iQ6nrgKPrSotp7RpcBeAxoYkL1bbfZ+pI=;
 b=FugDEblX3obHSunGmkLJ1ewCGIeOCYjg02AJhpJTkEbdU3B++ILolJhjp/JdxokzJB
 1G7gAkxFSXq1+edTNsTfp9ZRwSsVRpuIFBxooSkZpXupa6aabwCG3I82oCqI6BjHtPtD
 D4TugdF6FbayXC3ARfGsN5dhf7LjlWZBaJgrq3uFZnS5UXrSDxB/OVqAmV4bUByXzLfW
 zRG+El7rBFunoUclwj/A1nFKpNLZiZU3QEBqlNTryU3hQiWr4CUq07trBtTDC7KZ0HJ1
 5eFtX0OcjSTP6dq+1Gqgr5Gq7mD16s+ugSNlUxeb+7OkeVolFIGmVBmR/POQR902JSza
 jnLA==
X-Gm-Message-State: AOJu0Yx4fGIC0nbYf796khFFSXzMppCYXoQMnIqIisddZr1ZjOAuQkwr
 DtrTMjnkfM23UBAM/DBYVECN/1GMopvNpoAAhAI2qQjeF1mgOIP7FE9YNFt3p5A7TlylV22VaJ3
 h/1a93uCuTg3IjcZAyWizfnlCVcMVg7/rx8MoyER4qOfvlrb13wYxu0VDroIG2NsYAgbcsm3RNU
 bR946cGnew0+mPCJ9HAleaazoC7bwlA9B2nn+lTxfGrwMhQRHnJK4MXpcVFcdiBfJ9s1YN/dG1R
 rXxKLhBHNwV
X-Gm-Gg: Acq92OGqvJATb7QrJe4Sml3JthlLrGgKlejfmn9xheaUi8643zxTN9YBBSucDenemHW
 FYDRw8kojOCvocoyDJsIfVUu3zhQJnH120RPvzrp3yfqVmX+e5r7qehX6uk5x9aZMR0J6IcaPc3
 z48HhfEK66KoiblNb6TFdenheUjPtfIJObrsQOY/kUpJAlfw/cZ4l2NVQJ8IgElmZcbiPrxTMzy
 PoUgnaiMqHRfNsxbwOn74qp0m8qPkMdHyrEnxk3uSR/5Hl5wHQbXHiLn5mSqoydQQ2VFewOO1C7
 1pWkgFlW+8USs8bVTPhS9c/Dl93YLsYzpIJEyKD4ugoRxNEMnYA3RsCV/T2gDYM5wU3BLrmv6kA
 71fAnDzSHKQ33hSpqekzake6zg9ahm2+m2rfxnUTzOFPtKNi8mpsg1UpcK03ibyrXDW6Fauo0ZC
 kGNB1jmYFxVX8bs8dm7QFgGp0N4iinOFbNF/VkXDhHfQEQ2+2vz1DcYAUqGx3F+MVMC1/xfn3O7
 UDzrjKxD7rs
X-Received: by 2002:a17:90a:d650:b0:36b:7f69:c152 with SMTP id
 98e67ed59e1d1-36e30f0eb04mr4676602a91.18.1780509005510; 
 Wed, 03 Jun 2026 10:50:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-36e6b90952asm97720a91.0.2026.06.03.10.50.05
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 10:50:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5178444b752so10658131cf.3
 for <dev@dpdk.org>; Wed, 03 Jun 2026 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780509004; x=1781113804; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+V6lYrZ79iQ6nrgKPrSotp7RpcBeAxoYkL1bbfZ+pI=;
 b=YUWhdzLIj0gWERGTIme+TRMpiFhUBxAaG8dOI5e+eGiDG+5m8W9YDIb3iEhs3ElFYd
 e+oPzs2O2ViM9R9q7IkvTBu1SLtbzJFocPPjuAumWOvp+eM1cwHz2S+W10Y7CirrpiOm
 EVef/kImP0PdJdiObi+kKQvGiDu/iPnFFMEK0=
X-Received: by 2002:a05:622a:56:b0:517:5bc1:e1f0 with SMTP id
 d75a77b69052e-517784b6fdbmr68229201cf.0.1780509000901; 
 Wed, 03 Jun 2026 10:50:00 -0700 (PDT)
X-Received: by 2002:a05:622a:56:b0:517:5bc1:e1f0 with SMTP id
 d75a77b69052e-517784b6fdbmr68228591cf.0.1780509000285; 
 Wed, 03 Jun 2026 10:50:00 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517780e8169sm29021021cf.2.2026.06.03.10.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:49:59 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 4/4] net/bnxt: fix RSS hash mode configuration for VFs
Date: Wed,  3 Jun 2026 11:51:37 -0600
Message-ID: <20260603175137.1990204-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603175137.1990204-1-Mohammad-Shuab.Siddique@broadcom.com>
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

