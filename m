Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E31CD6E57
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 20:36:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 570D740672;
	Wed,  3 Jun 2026 22:36:00 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 170B54066B
 for <dev@dpdk.org>; Wed,  3 Jun 2026 22:35:59 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-36b9b15af73so6483433a91.0
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780518958; x=1781123758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DfzoR95cz6RrHrOXeXAAPaoP/NUrLteCyp3IdUYibhw=;
 b=HlBaM1Gvd8oFsmexsy5C4jXnMgko2A36wjM1Os03jVhR+H0/TMJx0ZGjQYo4NolSUo
 lGeAwBzzWaoONUV7VupwHql9gz9qmQoQsep8WPK43+7urgLTPTwZs2zYDuEyGrOJhYTr
 sySigVnulRwWh+zwjtniEO4vIsK4qVnij+U2CesxoH0tpGKsIBazerFe+nK83YnPEpZg
 Rn2/tYv0EDQRrAeaI1I3RiyGXyd6L7qeE5ETy9QwyQcqolc8iJAIpc9i9TR5ZJhXRb+p
 9oLoSqDZVHsRj2LuXxPa2LPOfBC1zL85lzQhGcxRCyqJGdVQRLN03KRmCJeXrKZaBNjk
 ZPNA==
X-Gm-Message-State: AOJu0YybUwpn3ljZphVupQWu7nOolXVqyyN30cQvT1S8xGPhCRqvUumN
 kUKBFXdXrkERwyHZsfPxYer7yNWg+J7YJcvjB8xIVy01zk3kW4/TEGTgdZMNhhRwUKBKtn7CcTY
 9vIrTgru5PRHZPrttbvZqwBMb0em/GBE4HzTnRxJ9Eaxg/SNS3UpTP4edPEZ8wqGQJoL4ow/yqd
 FjZ8OG5c0ztcpaSmOsaV8EDeWWt/YoWTsVt/gdmjn2kmjg4wSHjKzjtlvc2NT1u5plczgCyaY6F
 zU4T4iAI3qj
X-Gm-Gg: Acq92OFdJTZLEBMAriXMGPPgC8Lyst34S86jx6ZjNDzxNnQXBBm3KVE1O0+jmwFkS8e
 1in3Lz60PA22t8UfSzuedbZFtoPeK4nW6a4RAwjJTg2JlL5Kph7y0fxzN0VrB2qfR1ZYM7OD420
 RK13653za18Wz+1j2jR/ZoD4RHPjpnk8e5nnA6RhUAGCqBK3WGQMzM3cXnQh6WVTTH0VW1K7TFK
 hv5z0Lvz/4cspoZhoMAsME4eFDX2cfpNRtRlfxsqpMSugTorGDZJMMgCVJErZSJqKCekRX633JI
 HuP65yJt1e/RkWIl44DbzVxZBFgqBp91So2pdjoHfNxoyZ61TMZ/yDl9aeR7qV5hVg1x+BbIXpt
 jyI1bOGPVPNg+52Enuq3fU1AFkGvlcZmbrYz6kbqEc9RiABBj2eGggqIq2RaqbCgcU1TWpKE4KQ
 CN+7LteX1OY0wIysIgBgtAVrRLdQM/H8YWOiFgnyw/jtlkMmdx03Gys0OUcYjm9M9MWyK+LlrdA
 7Y0Lrq5Xw==
X-Received: by 2002:a17:90b:164c:b0:36d:ae6a:22f4 with SMTP id
 98e67ed59e1d1-36e33bb8f9cmr4966769a91.15.1780518958059; 
 Wed, 03 Jun 2026 13:35:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-36f6dba8297sm75617a91.5.2026.06.03.13.35.57
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 13:35:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9157f453a27so590285a.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 13:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780518957; x=1781123757; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfzoR95cz6RrHrOXeXAAPaoP/NUrLteCyp3IdUYibhw=;
 b=YZtR020iyraN3/Z96hJfjFKDAhYtPhlptyUxm4tS/NWfTfqMlFNK2En23ivryYIK30
 uSVJzaHAT2oszRt/xwpEu5VbGgexsFYxEIZx9jfm+flCM7KMMk/qtLzybSmRUzly7OZ4
 NxssYZo3v98CRVlkD1AW2bpw7mKGDuChy1i2s=
X-Received: by 2002:a05:620a:4482:b0:914:d093:abbe with SMTP id
 af79cd13be357-9158a659b63mr857036885a.12.1780518956703; 
 Wed, 03 Jun 2026 13:35:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4482:b0:914:d093:abbe with SMTP id
 af79cd13be357-9158a659b63mr857030385a.12.1780518956065; 
 Wed, 03 Jun 2026 13:35:56 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a22dbbesm340925085a.13.2026.06.03.13.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:35:55 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 2/4] net/bnxt: Support for PTP on Wh+ using HWRM interface
Date: Wed,  3 Jun 2026 14:37:36 -0600
Message-ID: <20260603203738.2084478-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603203738.2084478-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603203738.2084478-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Get rid of old code relying on mapped registers and use HWRM
interface wherever applicable during PTP initialization for Wh+.

Fixes: b11cceb83a34 ("net/bnxt: support timesync")
Cc: stable@dpdk.org
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 63 ++--------------------------------
 drivers/net/bnxt/bnxt_hwrm.c   | 31 ++---------------
 2 files changed, 4 insertions(+), 90 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 7d70d0f3ec..14d8fa705d 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -3754,55 +3754,6 @@ bnxt_dev_supported_ptypes_get_op(struct rte_eth_dev *dev,
 	return ptypes;
 }
 
-static int bnxt_map_regs(struct bnxt *bp, uint32_t *reg_arr, int count,
-			 int reg_win)
-{
-	uint32_t reg_base = *reg_arr & 0xfffff000;
-	uint32_t win_off;
-	int i;
-
-	for (i = 0; i < count; i++) {
-		if ((reg_arr[i] & 0xfffff000) != reg_base)
-			return -ERANGE;
-	}
-	win_off = BNXT_GRCPF_REG_WINDOW_BASE_OUT + (reg_win - 1) * 4;
-	rte_write32(reg_base, (uint8_t *)bp->bar0 + win_off);
-	return 0;
-}
-
-static int bnxt_map_ptp_regs(struct bnxt *bp)
-{
-	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-	uint32_t *reg_arr;
-	int rc, i;
-
-	reg_arr = ptp->rx_regs;
-	rc = bnxt_map_regs(bp, reg_arr, BNXT_PTP_RX_REGS, 5);
-	if (rc)
-		return rc;
-
-	reg_arr = ptp->tx_regs;
-	rc = bnxt_map_regs(bp, reg_arr, BNXT_PTP_TX_REGS, 6);
-	if (rc)
-		return rc;
-
-	for (i = 0; i < BNXT_PTP_RX_REGS; i++)
-		ptp->rx_mapped_regs[i] = 0x5000 + (ptp->rx_regs[i] & 0xfff);
-
-	for (i = 0; i < BNXT_PTP_TX_REGS; i++)
-		ptp->tx_mapped_regs[i] = 0x6000 + (ptp->tx_regs[i] & 0xfff);
-
-	return 0;
-}
-
-static void bnxt_unmap_ptp_regs(struct bnxt *bp)
-{
-	rte_write32(0, (uint8_t *)bp->bar0 +
-			 BNXT_GRCPF_REG_WINDOW_BASE_OUT + 16);
-	rte_write32(0, (uint8_t *)bp->bar0 +
-			 BNXT_GRCPF_REG_WINDOW_BASE_OUT + 20);
-}
-
 static uint64_t bnxt_cc_read(struct bnxt *bp)
 {
 	uint64_t ns;
@@ -3976,13 +3927,7 @@ bnxt_timesync_enable(struct rte_eth_dev *dev)
 	ptp->tx_tstamp_tc.cc_shift = shift;
 	ptp->tx_tstamp_tc.nsec_mask = (1ULL << shift) - 1;
 
-	/* TODO Revisit for Thor 2 */
-	if (!BNXT_CHIP_P5(bp))
-		bnxt_map_ptp_regs(bp);
-	else
-		rc = bnxt_ptp_start(bp);
-
-	return rc;
+	return bnxt_ptp_start(bp);
 }
 
 static int
@@ -4001,12 +3946,8 @@ bnxt_timesync_disable(struct rte_eth_dev *dev)
 
 	bnxt_hwrm_ptp_cfg(bp);
 
-	/* TODO Revisit for Thor 2 */
 	bp->ptp_all_rx_tstamp = 0;
-	if (!BNXT_CHIP_P5(bp))
-		bnxt_unmap_ptp_regs(bp);
-	else
-		bnxt_ptp_stop(bp);
+	bnxt_ptp_stop(bp);
 
 	return 0;
 }
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index afc948ac29..68e75e43bd 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -1027,14 +1027,8 @@ static int bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 
 	HWRM_CHECK_RESULT();
 
-	/* TODO Revisit for Thor 2 */
-	if (BNXT_CHIP_P5(bp)) {
-		if (!(resp->flags & HWRM_PORT_MAC_PTP_QCFG_OUTPUT_FLAGS_HWRM_ACCESS))
-			return 0;
-	} else {
-		if (!(resp->flags & HWRM_PORT_MAC_PTP_QCFG_OUTPUT_FLAGS_DIRECT_ACCESS))
-			return 0;
-	}
+	if (!(resp->flags & HWRM_PORT_MAC_PTP_QCFG_OUTPUT_FLAGS_HWRM_ACCESS))
+		return 0;
 
 	if (resp->flags & HWRM_PORT_MAC_PTP_QCFG_OUTPUT_FLAGS_ONE_STEP_TX_TS)
 		bp->flags |= BNXT_FLAG_FW_CAP_ONE_STEP_TX_TS;
@@ -1043,27 +1037,6 @@ static int bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 	if (!ptp)
 		return -ENOMEM;
 
-	if (!BNXT_CHIP_P5(bp)) {
-		ptp->rx_regs[BNXT_PTP_RX_TS_L] =
-			rte_le_to_cpu_32(resp->rx_ts_reg_off_lower);
-		ptp->rx_regs[BNXT_PTP_RX_TS_H] =
-			rte_le_to_cpu_32(resp->rx_ts_reg_off_upper);
-		ptp->rx_regs[BNXT_PTP_RX_SEQ] =
-			rte_le_to_cpu_32(resp->rx_ts_reg_off_seq_id);
-		ptp->rx_regs[BNXT_PTP_RX_FIFO] =
-			rte_le_to_cpu_32(resp->rx_ts_reg_off_fifo);
-		ptp->rx_regs[BNXT_PTP_RX_FIFO_ADV] =
-			rte_le_to_cpu_32(resp->rx_ts_reg_off_fifo_adv);
-		ptp->tx_regs[BNXT_PTP_TX_TS_L] =
-			rte_le_to_cpu_32(resp->tx_ts_reg_off_lower);
-		ptp->tx_regs[BNXT_PTP_TX_TS_H] =
-			rte_le_to_cpu_32(resp->tx_ts_reg_off_upper);
-		ptp->tx_regs[BNXT_PTP_TX_SEQ] =
-			rte_le_to_cpu_32(resp->tx_ts_reg_off_seq_id);
-		ptp->tx_regs[BNXT_PTP_TX_FIFO] =
-			rte_le_to_cpu_32(resp->tx_ts_reg_off_fifo);
-	}
-
 	ptp->bp = bp;
 	bp->ptp_cfg = ptp;
 
-- 
2.47.3

