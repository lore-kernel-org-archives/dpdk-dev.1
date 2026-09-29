Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C02CA5FAB
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:21:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E832640EE2;
	Tue, 29 Sep 2026 02:21:33 +0200 (CEST)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id 0873340ED4
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:30 +0200 (CEST)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-39b2ad862bdso1534682a91.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641289; x=1791246089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h34F53szeVOFJZXb84tVxMbRNsyoaKIO8WSCKJVIvVo=;
 b=hR/5Js4Ri+MohvjHt4LYdfcxbvv8g7zHDQrRC8Xsf5+jbF1XNRJxn/9OEmF7xl6YZU
 1s+4w2Rrh/yeLRRai2hY8IvmIl+GlzuAzUD/fTlOhY7SVsHBi09Piyr5mX4ZZlIC3Bw9
 cobjYuh2FfvIzFfrCzdAvH1yBOOnI28jWBlKbH4w+dtgoN2TEKj4T1nlaZPApBRRBw81
 Ivx8pVrhrzJ44XCpU9uscoQ2VQe+JtgJX17hT9gSmQIBn3uNrDm5JLXgGCNT376P6nJS
 3rwb11GHO/ejkhyZkMpiWgCDp8l0dPrwo27DpDtJKIX5tyDzSZ4nfeJYENm/pQc0k4a0
 7izA==
X-Gm-Message-State: AFq9FYL8C0gEVZIa2V0QfJF3ny4+aD3uinURTRYp8EpKlBYZM4z5/nC1
 VBB4NZvtG6e5XBJG9lvjhfdO5cJ6X9hmC6CubNWeBWvs1hWXi3sIKftYf3X36bk3c8fP0rqnwOs
 1cK7KyKBc994nb3CgBG1OuED5gbmsh41qH8m9nt0taYxg8Ult+7eC+xUTr2HQ8vad05X/G5dEzJ
 NH9nvXxPpktTHjixrH1EJdSC+4Tqo+ytqDET1jWm8NGPQ3jrPOU0pEt1nDGwRSbZmpHaUwWC+TA
 nTY7EsW3vv5
X-Gm-Gg: AYBFou2cl9RKwN9qzQu1Iq1COavJ3hvgodyFpxY+dQNspMf7OaM0fWaMYI09eR14MyH
 zcHEt5vUjsVfzrZJCRMJXs5IkOdvtGj0qcQanVBqjBFomnx3p5ng3/pURpawF+uA1NsOTO1D6q8
 7v99BQLdoG/mzn4MlxFaPSH5uxJdgdyLkfK2bRn9yYhM74HuUQseNmTT2BWDkg+ZqrpkeMTrPwb
 5wW3ZOdB8NFrlNeaxPV589BB7ivxiOToCaitbLoSvjdCItbr1dXvlrznew6GdFhQhbrBDiVYsa9
 sUM0rTlwcHyJ84bEryBk9Oej9IGcHPuQhauNmIa6gUTuqcegMUKqOUVr1mabSI0CKeMihCwQQd3
 UN+rCkXGUbtkB4vVY5G+2FWOGiONrYQJyaNRg2V0XcAMIimDwGaz17OhBenUgISE3YnoVIcaDRD
 Zy4R4my+WMrXov22W50EfveSAF42k2juUH18uNMt0S43e+eS45dg==
X-Received: by 2002:a17:90b:35c4:b0:3a2:b16d:928b with SMTP id
 98e67ed59e1d1-3a2b16da167mr4268925a91.46.1790641288987; 
 Mon, 28 Sep 2026 17:21:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a4986acfbesm236960a91.0.2026.09.28.17.21.28
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939f3426a7cso838608785a.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641287; x=1791246087; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h34F53szeVOFJZXb84tVxMbRNsyoaKIO8WSCKJVIvVo=;
 b=XE4jy4Q3jDt/0iDB06l4u3sIlvGDfZsrvPxGDEwAU4iaaUhlenfjYDn5qf4HJQAwyl
 ePxG/XMk54mbfPtTfbHePI5JiJ3EpagkkL1925/o/ksst0B7F0n704KSKReUfGpjVbvf
 EWWTUifOPWmOFjtvQQwSaxtUMBSTyDF6vVeEg=
X-Received: by 2002:a05:620a:4511:b0:939:a0f3:6aef with SMTP id
 af79cd13be357-93c43be8d8amr2378821885a.23.1790641287068; 
 Mon, 28 Sep 2026 17:21:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4511:b0:939:a0f3:6aef with SMTP id
 af79cd13be357-93c43be8d8amr2378817785a.23.1790641286480; 
 Mon, 28 Sep 2026 17:21:26 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c813a5ae6sm273808385a.13.2026.09.28.17.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:25 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, Joseph Wong <joseph.wong@broadcom.com>,
 stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3 2/5] net/bnxt: fix bounds on firmware-reported resource
 counts
Date: Mon, 28 Sep 2026 18:24:21 -0600
Message-ID: <20260929002424.1208457-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929002424.1208457-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260929002424.1208457-1-Mohammad-Shuab.Siddique@broadcom.com>
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
to 16-bit when used; add the clamp there. max_l2_ctx is 16-bit in both
responses, but its post-read addition with max_rx_em_flows can
overflow a 16-bit sum; widen the addition to 32-bit and clamp the
result.

bnxt_hwrm_func_resc_qcaps() reads max_hw_ring_grps from a response
where that field is declared uint16_t, not uint32_t like func_qcaps's.
Reading it with rte_le_to_cpu_32() instead of rte_le_to_cpu_16() swaps
a 16-bit value as if it were 32-bit; on a big-endian host this shifts
the value into the upper 16 bits, which the clamp then silently forces
down to 65535 instead of the real value. Fixed the accessor to
rte_le_to_cpu_16() and dropped the now-unneeded clamp on this path,
since a correctly-read 16-bit value can never exceed 65535.

Fixes: 2691827e82c0 ("net/bnxt: add HWRM VNIC alloc")
Fixes: 80bf6811fa0f ("net/bnxt: fix L2 context calculation for Thor")
Cc: stable@dpdk.org

Signed-off-by: Joseph Wong <joseph.wong@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v3:
* Removed the defense-in-depth clamp v2 had added to
  bnxt_hwrm_func_resc_qcaps() and fixed the actual bug instead:
  max_hw_ring_grps is uint16_t in that response (unlike func_qcaps's
  uint32_t field), but was read with rte_le_to_cpu_32(). On a
  big-endian host that reads the value into the wrong half of the
  register, which the clamp then silently forced down to 65535
  instead of surfacing the real value. Stephen Hemminger caught this.
  Switched to rte_le_to_cpu_16() and dropped the clamp on this path,
  since a correctly-read 16-bit value can never exceed 65535.

 drivers/net/bnxt/bnxt.h      |  3 +++
 drivers/net/bnxt/bnxt_hwrm.c | 16 +++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

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
index aa8152eaa0..45c11b58da 100644
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
@@ -1555,13 +1559,15 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp)
 	bp->max_cp_rings = rte_le_to_cpu_16(resp->max_cmpl_rings);
 	bp->max_tx_rings = rte_le_to_cpu_16(resp->max_tx_rings);
 	bp->max_rx_rings = rte_le_to_cpu_16(resp->max_rx_rings);
-	bp->max_ring_grps = rte_le_to_cpu_32(resp->max_hw_ring_grps);
+	bp->max_ring_grps = rte_le_to_cpu_16(resp->max_hw_ring_grps);
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

