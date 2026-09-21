Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA7C982DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:17:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3DEA40E35;
	Mon, 21 Sep 2026 04:17:06 +0200 (CEST)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id A73FE40E17
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:17:03 +0200 (CEST)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2d9db539a54so8106665ad.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957023; x=1790561823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h1ocKQvW3k0J24OxayGSfSs1wQIVxwGLd6ncfNMVywU=;
 b=HNK6CBhjYWcROu/rxSwvMaL5/FT1t2WHfvfsfAQOfS0chi5gdCZ5IaJC/WtpsdZVSO
 brZffQ/ouoEBQtum7xoMzoBCymhiUHnLJlY4uK2LKO8ZhDtT+WJgNv+8DEMsL0y7uiz+
 i3eb/nhtgT1C1yqPBq0PxwNvuOGJRaNuxDs+yYNwXhx6yksYVL8g/r3/nT0Eabwwf0M0
 jhdwcqrDM+RPItx+q5zJZWJHw0IqAUSwI8HvkhUxcPeyWy/Axj5Jvv+hgD8Jmgi9/BO3
 ne9Xu1Yo2Kct30T15hhWoQfB/1uA9Y1w5U01Xladn9ox5lJsVQ0icbrWKQIDlvcFd0Xg
 fcSA==
X-Gm-Message-State: AFuF++nMGPxMT6tcesQ5KWSqzUNc1ylqRGRnoTI88XfqJDwU9R9Prg4S
 uQsZN4grRCfYY5qKWKny0oNjTP+teqGaq59OlSwjXa5unpl+blfn0xnzdM+wtPSfA977ajmi3Ye
 MorxA79Li2XqbzhmI16obyvYEuF2c96Ejm1Y1+pX3No/XX4CU3cK0kN53fGnsUs2tKdeb+rPUjH
 NHnnYDHdJUJjqXFssh4mXlTJiTl83WIia5Mzqn8ATCg31px7GbeO2n8cr7EgyMXD1tBUFJbz+og
 +UVNSP0RGri
X-Gm-Gg: AYBFou1ONdmisUiHTGJ3aQ0YzCrFJUH68Ku/RDdKFinpFaR8TW2RkDImn7M9Chw2lBr
 AXAViuKnB6Fcy8R0f7nh9OobkVsk9f+htXLKA2aONbs8la0Kn+WUkyQO9oi6OExxvqxrTc6YB7b
 Fnj67346DFv/tG71cJE2ysQFMHYDBf65FDFLK+iCr7psu9x52QdvwqeHdH1TGb2tyE2m1xw/nW8
 5H6uMd4mDjoflyHs4/Mh4n4CKEYm12mGNCzo/L7cXBz3239EvZJv96I76yYDQZjheKAMl/nC3F4
 Ah7MPELa+22t7KV0jd4jhHSTZM9xDaZNR3+DzH4rjYv1WRUlA24cssXdOj24DTkPDLcvEE60fMf
 VtBjj9TxHiym4aCg0RnNaYu9ii8cmPKZaglYNTuQox48a9TpNGXzk4JhDaXgPC4Xgh6Rj3MmK7q
 Kj6mlyz9agsKKb4Lcw5r4WMxARMQsaxWAuXd8TiWEBkgfPsVd/ZA==
X-Received: by 2002:a17:902:e88d:b0:2de:c1f6:5b20 with SMTP id
 d9443c01a7336-2dec1f65dabmr75521685ad.22.1789957022687; 
 Sun, 20 Sep 2026 19:17:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2df231a531asm1659195ad.43.2026.09.20.19.17.02
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:17:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc4922b7c31so2531797a12.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957021; x=1790561821; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h1ocKQvW3k0J24OxayGSfSs1wQIVxwGLd6ncfNMVywU=;
 b=E/PqGyGwYhJt/J9exHEobx82lVnnJ6eulPsngn1a5JdTUG8aCeiUizk3BmXpoONe/J
 Hm+v5/gMunADdfczsFvR4j4Whp+GmeYBzTecchFW0/YiMIVi01Gx/vsBGSyx2XT5FVJj
 6SHo1r1HfPbYmQTp3IGxgUhR3bZYOLKnWShiQ=
X-Received: by 2002:a17:902:7005:b0:2dd:c0ff:e734 with SMTP id
 d9443c01a7336-2ddc0ffe9e7mr57676535ad.70.1789957020812; 
 Sun, 20 Sep 2026 19:17:00 -0700 (PDT)
X-Received: by 2002:a17:902:7005:b0:2dd:c0ff:e734 with SMTP id
 d9443c01a7336-2ddc0ffe9e7mr57676305ad.70.1789957020203; 
 Sun, 20 Sep 2026 19:17:00 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c331d55cfsm18536753eec.30.2026.09.20.19.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:16:59 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 2/5] net/bnxt: fix bounds on firmware-reported resource
 counts
Date: Sun, 20 Sep 2026 20:19:59 -0600
Message-ID: <20260921022002.1033815-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Fixes: 2691827e82c0 ("net/bnxt: add HWRM VNIC alloc")
Fixes: 80bf6811fa0f ("net/bnxt: fix L2 context calculation for Thor")
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

