Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913AED2A54F
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 22:13:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71C2E402C4;
	Thu,  4 Dec 2025 23:13:20 +0100 (CET)
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com
 [209.85.210.228])
 by mails.dpdk.org (Postfix) with ESMTP id 61C8340144
 for <dev@dpdk.org>; Thu,  4 Dec 2025 23:13:18 +0100 (CET)
Received: by mail-pf1-f228.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so1267026b3a.0
 for <dev@dpdk.org>; Thu, 04 Dec 2025 14:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764886397; x=1765491197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHTKrp8HKh+Liy3qbPT9Egn/yccJIyfpwu+8L/n5zR0=;
 b=v3nFufcxyWzISVI21XuKtId2Z9xtCSWALTLezlsahEmc97K3Ejlzli6ZRct/rLfUaP
 rIw3Rb1ddRnh1OY1VLF9tRBLtrSTREY7TyqQ2m4cYpzo0OXSKv7kBJ/lAAVfKFXAiZnU
 HYTreYuHyDBXjF9vuMlCRGwdDudjhd710Fnd9gAKvfWij9zSs/H0WnDhSVYbkRoFZLxZ
 GnlHrcMU2ZZKdxmwr9IzBje54beRM9BZYRLhfvS2XmZ7mZRPawarDGzwGva/X1vmyHU/
 gCC6ndYaG02wiqPjGEKotgWFQqFDwzYJGFNG4LrgagVQR3X4jJl3udMhTvi7mmHuQXZG
 L8Bg==
X-Gm-Message-State: AOJu0YxQ4SPi4Bq9jwttKlnJjOb25bxenbWtTdp8rXig0uxBJJLdeJhJ
 oUwlDAqkBTAv0JaaosMSQ+KHrEmye4ycTaACDlgzHMVTpoOTK+lZrOH+o0kBMmbEkyv6mQtHMaN
 Px3V1pL885o0nyN3V3fInOtSanBK768BJWut29uU85v41zTEd3cdVeNdQTtOBMA+z5mitM6hX7P
 ZwL/g+4g3ig6879XydOItINebFteeGdlzp63fr9dTI80gxiqG/onDCigN1T+KqObGv8s5ASwo8
X-Gm-Gg: ASbGnct2usTIRtHUEzyTFfQBC4tMBUd2a1MOoB83O4L0wA1B8cUeMh2AidC1FZkH7K9
 y53txCNBTmKBW5W5Lx7vUztqZsd05/mJun5Fozgotx2xYTbxrjPmZug6t5+sEckroJTZq1u9YuN
 nlzeRB8NmHFup/5606ToetAU7vKJy2RLf3bFc/hlK9j4EShUpBQ+i39LnFOlPRX+ZDW/WpiSv5h
 2lF1PwSDSLN1x8VyFqMu3BQDdWe+JS9obNyewIrZDZGemGMwEDFZy13lElWid2L2xStJMFuWkPV
 oKSLdRBK8bCpMtC850AdX+uRg8Qftzl/jZ7CMmUb5SZwgK96k9obJYaRaSMH9u9Yls4h+eCKU2D
 xsyA1OFUf2S2BQJQ2+kGE4zb79TsZ/TSEGQaQY2FjI2CuA3DwYC1hk3zpTRTf7ikA5dfJbY0PzF
 k3FE2lpLGl+HclkUjs0mFy3mEJTO42EZfghxxa/S1OijjZEa4=
X-Google-Smtp-Source: AGHT+IGxLrjlHd2noF6wg2dxjFmo0amq7+29HMJJ4e667lcyrSLcwYIoxQI8sfZUyObzxzAVdJy3HkJt26k6
X-Received: by 2002:a05:6a20:6a08:b0:342:873d:7e5a with SMTP id
 adf61e73a8af0-3640384fb8fmr5438740637.36.1764886397402; 
 Thu, 04 Dec 2025 14:13:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-7e2ad3a6f41sm343555b3a.8.2025.12.04.14.13.16
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Dec 2025 14:13:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-bc240cdb249so1403776a12.3
 for <dev@dpdk.org>; Thu, 04 Dec 2025 14:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1764886395; x=1765491195; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHTKrp8HKh+Liy3qbPT9Egn/yccJIyfpwu+8L/n5zR0=;
 b=B5FPnn2btZ8nsp6Yj3M0Gvf1dkCDlT+Uu3XYwVeyXWungV7rwK8RnBeusb8KFPOsM/
 T42eRFxkhUmrs/5zV1MEyugGdyTAWCsjkbNNcDsfvSrTX25Ad9DGX4ghOD1FUuz8ounF
 DX9ZFn64ZCcgvkUkABGzEP4E2fLjD+Eg6/jWM=
X-Received: by 2002:a05:7300:7305:b0:2a4:41c3:3a45 with SMTP id
 5a478bee46e88-2aba422c23dmr3557838eec.2.1764886395312; 
 Thu, 04 Dec 2025 14:13:15 -0800 (PST)
X-Received: by 2002:a05:7300:7305:b0:2a4:41c3:3a45 with SMTP id
 5a478bee46e88-2aba422c23dmr3557817eec.2.1764886394600; 
 Thu, 04 Dec 2025 14:13:14 -0800 (PST)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2aba83d2a5fsm8221646eec.2.2025.12.04.14.13.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Dec 2025 14:13:14 -0800 (PST)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: stable@dpdk.org,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH] net/bnxt: fix a segmentation fault
Date: Thu,  4 Dec 2025 17:13:03 -0500
Message-Id: <20251204221303.77891-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Fix a segmentation fault root-caused to the following

1. bnxt testpmd queries the THOR2 capabilities using an HWRM.
2. Another HWRM is made that overwrites the capabilities context,
   which results in the MPC context not being created.
3. Initializing TruFlow (which depends on the MPC context),
   results in a SEGV.

The fix moves the 2nd HWRM after the capabilities have been
consumed.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_hwrm.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 4d693da1d5..0cef22b5ec 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1198,15 +1198,6 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	if (BNXT_PF(bp))
 		bp->pf->total_vnics = rte_le_to_cpu_16(resp->max_vnics);
 
-	if (flags & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_PTP_SUPPORTED) {
-		if (BNXT_CHIP_P5(bp) || BNXT_PF(bp)) {
-			bp->flags |= BNXT_FLAG_PTP_SUPPORTED;
-			PMD_DRV_LOG_LINE(DEBUG, "PTP SUPPORTED");
-			HWRM_UNLOCK();
-			bnxt_hwrm_ptp_qcfg(bp);
-		}
-	}
-
 	if (flags & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT_STATS_SUPPORTED)
 		bp->flags |= BNXT_FLAG_EXT_STATS_SUPPORTED;
 
@@ -1263,6 +1254,18 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	if (flags_ext3 & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_EXT3_RX_RATE_PROFILE_SEL_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_RX_RATE_PROFILE;
 
+	/* This block should be kept at the end of this function because it
+	 * sends another hwrm msg.
+	 */
+	if (flags & HWRM_FUNC_QCAPS_OUTPUT_FLAGS_PTP_SUPPORTED) {
+		if (BNXT_CHIP_P5(bp) || BNXT_PF(bp)) {
+			bp->flags |= BNXT_FLAG_PTP_SUPPORTED;
+			PMD_DRV_LOG_LINE(DEBUG, "PTP SUPPORTED");
+			HWRM_UNLOCK();
+			bnxt_hwrm_ptp_qcfg(bp);
+		}
+	}
+
 unlock:
 	HWRM_UNLOCK();
 
-- 
2.39.5 (Apple Git-154)

