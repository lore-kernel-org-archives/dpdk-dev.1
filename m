Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89485C982D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:24:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 661A842FDD;
	Fri, 18 Sep 2026 05:24:30 +0200 (CEST)
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com
 [209.85.210.97]) by mails.dpdk.org (Postfix) with ESMTP id 4B25642F87
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:24:28 +0200 (CEST)
Received: by mail-ot1-f97.google.com with SMTP id
 46e09a7af769-7f64ea07036so71980a34.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701867; x=1790306667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GAnjTSfbe4Ry7GAcG6PPMT7sAWo5cPIFryyl+9y9bUU=;
 b=p2loxmcBOxzcfvcsWr4foOvtvzEVPZBrJFKfWKC+0AxnsksEbMwJa4mhm1FxWgLDfz
 AEYf0C+xMDTpZ0V1NFaqGgT+BCd8j2myIxeug8oNuqHPu/58yxteTxHfxFmByQrzS44k
 LCa7xH7Cm9Xu6nVPVrFOuADWXn0thIB7Zis3Y6DJAKTvBdAK+DpUXeeOy2JH+rM0mf+i
 DvaS+vlVhRnRfGFgXH9EVAFMtAIeXMuaz0DmFsfa/0GUkczY2TjB0YEXpwpwyyJx0Gpv
 uhYIxofnDKaAGkozJhZoA9YwqAOjmgHfYxqlYf1KFlTrQzaDS7SRWkJLrK2Cox3FMMuq
 Wh1A==
X-Gm-Message-State: AFuF++m7+1Em6t/dEx2G4lwcWobGNr3olBi+FBKs7UY6WA3us/WIKVui
 +Myr2U/LzCeoVgF65pL74kyA2RWCfWmGwpsq62u3lydKEpCPegLw9KMT3TDAyZeVPY9QfJJ2kVD
 HEqHS2086nzXyvasFwi+zOLLtmt/JtqM58xDEcUv4rUDS/tWTlBDzIuwX9LmD3IP+UdYSmmHWaO
 PU5ovZCCCJeSgSPJWS6s4+CFiCnfvE1vOGJCRyjE9GTXe2ZoOjrLnD/JR/NENwoUlJwDPdZ3rhJ
 K9mDSEm03Rj
X-Gm-Gg: AYBFou2q5SsGetMpjSZpMc5PxUeEr1W+WU+jfYf+pRU/JkpY0PCIehfhewsuC35kaao
 KoKKOlyAcMPlOmzWTzTdb15lso+RCmO+736K2+1XoV15DLu+559YcjSINMYuyQy9pRhuXPLv+Eh
 tAscpJZ7euXqwKtrHoSm6CdW84OvYhNEGBXN0RQGuHmHwOyf2htQ//ENOAZvkC/buCFEzLTfQqO
 Z6RTxHWrsdc8z0SQzi9E3W3N2swYa4NmjaxQkXahx1r6+hy1RmW99DqxEqkafCsiCPz/O/r1G8f
 xln5gPUZqA96V3YTWgGFVUNlPkorgW02kJgYy5PgSg9UEbchebiT68hjRafNb99lC6UOXWB0yTy
 LWY2jQkWv+MGguWWJ/7kUY+UpYt9ZoOrBjdydFL8fym50v8QtZ6km/aIiDxTS5OkHL9yMKE0Iuz
 I+aplAcBiIw/gLgb3XAzDbSJQabGAv/+fOrIzD2ifMbUba+OeIig==
X-Received: by 2002:a05:6830:82b5:b0:80b:95aa:5c2a with SMTP id
 46e09a7af769-80de115e243mr1650398a34.9.1789701867468; 
 Thu, 17 Sep 2026 20:24:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-80e4271c129sm274683a34.2.2026.09.17.20.24.26
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:24:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so715861a91.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701865; x=1790306665; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GAnjTSfbe4Ry7GAcG6PPMT7sAWo5cPIFryyl+9y9bUU=;
 b=R83NmA0OmN8VU0hSFntbW4Jg/D0SYVg073gRVkwSLAkL3DPFg5AtuPR/2ovJ8EA5EZ
 zM9u0WjN96u11ybXPwDHo/BnHsKkTqCMSWRxjtk8+Vmjf0QiTnLdssw9op5qvGlboz3I
 a/6yqMGuHNzQV+I22sAhNInY+SpBA2WHPeNw8=
X-Received: by 2002:a17:90b:3d92:b0:398:c315:fa6f with SMTP id
 98e67ed59e1d1-39e54b78015mr2808248a91.14.1789701865523; 
 Thu, 17 Sep 2026 20:24:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3d92:b0:398:c315:fa6f with SMTP id
 98e67ed59e1d1-39e54b78015mr2808199a91.14.1789701864957; 
 Thu, 17 Sep 2026 20:24:24 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c287b023bsm597708eec.23.2026.09.17.20.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:24:24 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 2/5] net/bnxt: fix bounds on firmware-reported resource counts
Date: Thu, 17 Sep 2026 21:27:23 -0600
Message-ID: <20260918032726.763384-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Joseph Wong <joseph.wong@broadcom.com>

When parsing max_ring_grps and max_l2_ctx values from firmware, clamp
values if they exceed a 16-bit value. max_hw_ring_grps is received as
32-bit in __bnxt_hwrm_func_qcaps() (the func_qcaps response) but cast
to 16-bit when used; add the clamp there and, as defense-in-depth,
also in bnxt_hwrm_func_resc_qcaps() in case that response's field ever
widens. max_l2_ctx is 16-bit in both responses, but its post-read
addition with max_rx_em_flows can overflow a 16-bit sum; widen the
addition to 32-bit and clamp the result.

Fixes: 2691827e82c ("net/bnxt: add HWRM VNIC alloc")
Fixes: 80bf6811fa0 ("net/bnxt: fix L2 context calculation for Thor")
Cc: stable@dpdk.org

Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt.h      |  3 +++
 drivers/net/bnxt/bnxt_hwrm.c | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 336de75da0..69455af31f 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -863,6 +863,9 @@ struct bnxt {
 #define BNXT_P7_MAX_NQ_RING_CNT	512
 #define BNXT_P7_CQ_MAX_L2_ENT	8192
 
+#define BNXT_MAX_RING_GRPS	65535U
+#define BNXT_MAX_L2_CTX		65535U
+
 	uint32_t			flags2;
 #define BNXT_FLAGS2_PTP_TIMESYNC_ENABLED	BIT(0)
 #define BNXT_FLAGS2_PTP_ALARM_SCHEDULED		BIT(1)
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index aa8152eaa0..765aa7c452 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1125,6 +1125,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	HWRM_CHECK_RESULT();
 
 	bp->max_ring_grps = rte_le_to_cpu_32(resp->max_hw_ring_grps);
+	if (bp->max_ring_grps > BNXT_MAX_RING_GRPS)
+		bp->max_ring_grps = BNXT_MAX_RING_GRPS;
 	flags = rte_le_to_cpu_32(resp->flags);
 	flags_ext2 = rte_le_to_cpu_32(resp->flags_ext2);
 	flags_ext3 = rte_le_to_cpu_32(resp->flags_ext3);
@@ -1155,8 +1157,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	bp->first_vf_id = rte_le_to_cpu_16(resp->first_vf_id);
 	bp->max_rx_em_flows = rte_le_to_cpu_16(resp->max_rx_em_flows);
 	bp->max_l2_ctx = rte_le_to_cpu_16(resp->max_l2_ctxs);
-	if (!BNXT_CHIP_P5_P7(bp) && !bp->pdev->max_vfs)
-		bp->max_l2_ctx += bp->max_rx_em_flows;
+	if (!BNXT_CHIP_P5_P7(bp) && !bp->pdev->max_vfs) {
+		uint32_t l2_ctx = bp->max_l2_ctx + bp->max_rx_em_flows;
+		bp->max_l2_ctx = (uint16_t)RTE_MIN(l2_ctx, (uint32_t)BNXT_MAX_L2_CTX);
+	}
 	if (bp->vnic_cap_flags & BNXT_VNIC_CAP_COS_CLASSIFY)
 		bp->max_vnics = rte_le_to_cpu_16(BNXT_MAX_VNICS_COS_CLASSIFY);
 	else
@@ -1556,12 +1560,16 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp)
 	bp->max_tx_rings = rte_le_to_cpu_16(resp->max_tx_rings);
 	bp->max_rx_rings = rte_le_to_cpu_16(resp->max_rx_rings);
 	bp->max_ring_grps = rte_le_to_cpu_32(resp->max_hw_ring_grps);
+	if (bp->max_ring_grps > BNXT_MAX_RING_GRPS)
+		bp->max_ring_grps = BNXT_MAX_RING_GRPS;
 	/* func_resource_qcaps does not return max_rx_em_flows.
 	 * So use the value provided by func_qcaps.
 	 */
 	bp->max_l2_ctx = rte_le_to_cpu_16(resp->max_l2_ctxs);
-	if (!BNXT_CHIP_P5_P7(bp) && !bp->pdev->max_vfs)
-		bp->max_l2_ctx += bp->max_rx_em_flows;
+	if (!BNXT_CHIP_P5_P7(bp) && !bp->pdev->max_vfs) {
+		uint32_t l2_ctx = bp->max_l2_ctx + bp->max_rx_em_flows;
+		bp->max_l2_ctx = (uint16_t)RTE_MIN(l2_ctx, (uint32_t)BNXT_MAX_L2_CTX);
+	}
 	if (bp->vnic_cap_flags & BNXT_VNIC_CAP_COS_CLASSIFY)
 		bp->max_vnics = rte_le_to_cpu_16(BNXT_MAX_VNICS_COS_CLASSIFY);
 	else
-- 
2.47.3

