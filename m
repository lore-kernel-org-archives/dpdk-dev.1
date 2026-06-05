Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11FDCD6E6E
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 00:48:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 891F940667;
	Fri,  5 Jun 2026 02:48:37 +0200 (CEST)
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com
 [209.85.221.225])
 by mails.dpdk.org (Postfix) with ESMTP id 89A00402E1
 for <dev@dpdk.org>; Fri,  5 Jun 2026 02:48:33 +0200 (CEST)
Received: by mail-vk1-f225.google.com with SMTP id
 71dfb90a1353d-59bbe027424so1058218e0c.3
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780620513; x=1781225313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nYk59iKSW+NxJMD1w56TfExybN7/iY1DLmm2wUHNbAE=;
 b=rmOkxFymBD+fHX9cHJhGp7UF5wMNNHGAS0HVruKzGbxt6OrtLp02Ble8qzvVu3SDm2
 gr2Gzd1i32y1Iz01Ekx4Asl0NADvByqXpGLFJRd6NmioFP/3Lnnyh4ohcBL2RYkSbsa+
 xSaU+DQQy2O4gj8lA24msqiY5knPQJryMpZ1Hgp2QZEpLtufyRJVRaEet4NSzPUbud0V
 ynV7/rzh9jzOdVHYKJ1VmgNnWzj9SwUbSeE1tfvpOwbMlYp7qYfVCF0Lrkw6J1e/KkIW
 Ieo8suZj5KCkp29CLfv27FAoKMlC+FeQlInTOmAVB2zTcxEzHtLXMw8j+FL//0fgFL6K
 8TiQ==
X-Gm-Message-State: AOJu0YxwxzDb5CopZYOdsOwEsiKl++opSw7X0dMnGH80xK441fqJBAvM
 m5Kh9xfSLmFHQ6ICkyH23RYFYmR2yCMC7HfDJozYlQoV6cXn2Xxw6m2p0HuHOulPFGBxrPyJDw2
 MHvDVJhgTxMrqhY7YJMM5Xh+lBRBbeDcnW6r60qnnplG1z/U/jc4DZ78R6GGPP8fuCSbpsfp1V1
 T99qZYWlo6Oe2oplgpdsg9nhvECmlgKNXPnmi0W66J6A5bhsuOLKy71vaNv0ckxErNzHH5FMXzq
 uGzWvPyl27Z
X-Gm-Gg: Acq92OEcQSUIfmicxRMEW6jHFqRmExgI3bQHfJnGrPnkgZ3DhaNdkkFKnbflOlgBjwN
 lv8kBvKFsTRtC0+A3FfHa1XpkCD9O07pbywfWPnPw1lZCuISjlwWt41XbdOzIuw6pB4RrGVMXFy
 bxi5ktmWdDBiqTYjdnla8HqKp8yMRsTwrMiLbfYfoRGzPf/8X22tJN5onRpFWrVAFcStsYTnzu1
 NkftbqpETZkrJdHIWLihaPMEd7EXLnYKjvXkiZsTjK/hyuTsA7z2Vg/RRV28Obq9+qgOYu/OOeV
 gyLdYxn26DhojTvQi677gi9FS8XKuR83SxROI+X0LZ5euO99OFsLgmtDrALiA5Oa5W6RR15ZgDK
 rbzW/BXQvBwsqAU1HuURSdwmiYcezja52rfh6s9743ewGCCLaZhCfiwQJj06x98SoH2VJT6Hoso
 PR/v/N8VRCvaWAt7GBIRW76HkymdU0J+kulNi2ZEnvZA5mDmXkUuoXlseh6M0ns/qNN/kJYnBWV
 eUiz+cmnw==
X-Received: by 2002:a05:6102:2c89:b0:631:26f6:7021 with SMTP id
 ada2fe7eead31-6fefc8beb6fmr606970137.26.1780620512775; 
 Thu, 04 Jun 2026 17:48:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-6eb5414f3b4sm465133137.5.2026.06.04.17.48.32
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jun 2026 17:48:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8cce1c3c26bso40611536d6.2
 for <dev@dpdk.org>; Thu, 04 Jun 2026 17:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780620512; x=1781225312; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nYk59iKSW+NxJMD1w56TfExybN7/iY1DLmm2wUHNbAE=;
 b=hbmKnX5/NGGqJU9NEswLlvit1SbA5T5kgyLTzdi9ormZWBMbfSfC0s8p56h34K3jFd
 XQDD3iJYOYyf5lQqtlNqzIf5ruRqVgS8iMFW40zsvsXz55OSOy2AXT/lqQyVrMtqFxWO
 hJVf2/uQuGx/XgCUIa1SxP0r7SSEj7KSEElaI=
X-Received: by 2002:a0c:f910:0:b0:8cc:ece4:f88a with SMTP id
 6a1803df08f44-8cee5fb634emr20814046d6.2.1780620512184; 
 Thu, 04 Jun 2026 17:48:32 -0700 (PDT)
X-Received: by 2002:a0c:f910:0:b0:8cc:ece4:f88a with SMTP id
 6a1803df08f44-8cee5fb634emr20813676d6.2.1780620511667; 
 Thu, 04 Jun 2026 17:48:31 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0556c0sm67187396d6.25.2026.06.04.17.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 17:48:31 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 4/5] net/bnxt: prevent a potential segfault
Date: Thu,  4 Jun 2026 18:50:15 -0600
Message-ID: <20260605005016.2290160-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260605005016.2290160-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Ajit Khaparde <ajit.khaparde@broadcom.com>

Add checks to prevent a segfault while accessing members of
structures which may not have been initialized yet.

Fixes: 1b7ceba3e375 ("net/bnxt: support Rx queue count")
Cc: stable@dpdk.org
Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c |  3 +++
 drivers/net/bnxt/bnxt_hwrm.c   |  3 +++
 drivers/net/bnxt/bnxt_ring.c   | 11 ++++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 72a31dfbb5..c45afdb20a 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1435,6 +1435,9 @@ static int bnxt_scattered_rx(struct rte_eth_dev *eth_dev)
 	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
 		struct bnxt_rx_queue *rxq = eth_dev->data->rx_queues[i];
 
+		if (rxq == NULL)
+			continue;
+
 		buf_size = (uint16_t)(rte_pktmbuf_data_room_size(rxq->mb_pool) -
 				      RTE_PKTMBUF_HEADROOM);
 		if (eth_dev->data->mtu + overhead > buf_size)
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index e4ae27d3f4..02a5d00738 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -3328,6 +3328,9 @@ bnxt_free_all_hwrm_stat_ctxs(struct bnxt *bp)
 
 	for (i = 0; i < bp->rx_cp_nr_rings; i++) {
 
+		if (bp->rx_queues[i] == NULL)
+			continue;
+
 		cpr = bp->rx_queues[i]->cp_ring;
 		if (BNXT_HAS_RING_GRPS(bp))
 			bp->grp_info[i].fw_stats_ctx = -1;
diff --git a/drivers/net/bnxt/bnxt_ring.c b/drivers/net/bnxt/bnxt_ring.c
index 579b73d2ce..064520aa62 100644
--- a/drivers/net/bnxt/bnxt_ring.c
+++ b/drivers/net/bnxt/bnxt_ring.c
@@ -723,6 +723,9 @@ static void bnxt_init_all_rings(struct bnxt *bp)
 
 	for (i = 0; i < bp->rx_cp_nr_rings; i++) {
 		rxq = bp->rx_queues[i];
+
+		if (rxq == NULL)
+			continue;
 		/* Rx-compl */
 		cp_ring = rxq->cp_ring->cp_ring_struct;
 		cp_ring->fw_ring_id = INVALID_HW_RING_ID;
@@ -765,9 +768,15 @@ int bnxt_alloc_hwrm_rings(struct bnxt *bp)
 	for (i = 0; i < bp->rx_cp_nr_rings; i++) {
 		unsigned int soc_id = bp->eth_dev->device->numa_node;
 		struct bnxt_rx_queue *rxq  = bp->rx_queues[i];
-		struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
+		struct bnxt_rx_ring_info *rxr;
 		struct bnxt_ring *ring;
 
+
+		if (rxq == NULL)
+			return -EINVAL;
+
+		rxr = rxq->rx_ring;
+
 		if (bnxt_need_agg_ring(bp->eth_dev)) {
 			ring = rxr->ag_ring_struct;
 			if (ring == NULL) {
-- 
2.47.3

