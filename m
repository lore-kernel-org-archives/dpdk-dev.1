Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CFBEB3624
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 19:50:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A9761402AA;
	Mon,  2 Mar 2026 20:50:52 +0100 (CET)
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com
 [74.125.224.100])
 by mails.dpdk.org (Postfix) with ESMTP id 3977E4028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 20:50:51 +0100 (CET)
Received: by mail-yx1-f100.google.com with SMTP id
 956f58d0204a3-64ca6595c8aso4450044d50.0
 for <dev@dpdk.org>; Mon, 02 Mar 2026 11:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772481050; x=1773085850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTQJEKPYZV683ido3AoS3q5Q2dUaHJcSMyeGqETfpgI=;
 b=sWSxtBVZTWHdHQLvA3pcncWnmqJ6zOjWdwUUwl3M5YQWwElAdljmWy3L2a9oCVs3mo
 YCKBpdokF9zxZcI4RbSxVpPI6S2A9mVMYRzEF7DZAxBiI6YtDliy99nyp/tadw9Lv7+h
 gBm20kLOXJyr4hq7DteQduj8YhGIan+CRe/MzRTI19Rezmv6kyTdUjVaMNujiiiN7KS3
 Y79Dc5CTt8Z/oiWNTr+rT6M9/0LitGD6uq7q1BDGLqLizfkYPivi4d+x/E9CVxpdpRq/
 3WEGU6EYdltZnjWyZPB3Fda+Gh+pUhaaeedR37q6Hw6h+BMR7Rjv5xMh6eagiacdIk+n
 P4GQ==
X-Gm-Message-State: AOJu0Yy7GageqRGVG03jkCBKPFMY3hPLWhJQ2L3eEoZMz2IQ5oKWU7w5
 UmTJv5WaU84T1pkFTvkmyDoNIVlUpKeYNzY3TSlgvPQobvJb1mFDPPW6Wf8ZmRwy/F3cTHlXB2W
 U9bSC9ZnU38SFBuYfkJh2sMWro/BwSQqzalK5qGKZBS7CjuX79zF8KzgCWlcAISFLrxzFtINUvL
 lRHzi1tA0ErLLZbipN25MKrkw2DO/5nbx7WE4yj5vcWi5Fv61vFvUKPAV4J0Co/dDxFFZnqv4Mz
 sVEiVmRrj2b
X-Gm-Gg: ATEYQzx++d2WwkJSlpQca8BtPsBbo7QRmdgqwm4gtMUn4Qb8iXVSqOdXYYyv7TornbR
 x3O4gwd+jbKbngUKqm+4zZvF0D9elzvmMVLTnBTgWSpHAMND/Qsg29yukaNNqDgbLSIhaXJKNa6
 vVdqHnANvsUZnQDJUlK87LxMF9HkZq1eL3+Bb3uZ8ZhN7uySm0EEAu7v69ugYDH11EL2BzVi85v
 ejjgXWxRDT7IM1JeZWpE+OSpRZbylY/oPvRQn4ZJXyzX9hLo1bx9kU6hZhp7utWBLxi2JiCMEUx
 v9CanPcrEIWCknR6f92M8U7xTiebxSl4KB1Iif24KB4ChTJDtRtSZdwygAE1eR7E9aZxXYNuP0a
 aaKk7qe7oV1ACiQyeJGV6pQHgcYGC6bil7e+zqSX4qUhYmS+l6y/qIkFZzKX7Ie8ji7QpJHKR0v
 cv2jIhBXTUcThwMw8VsNqk8evIEQ8ce5USZ1XVt7mP6n+rl13c3jKO6Lx0AbENLSNJ9aPv7Vqjr
 A==
X-Received: by 2002:a53:cf0d:0:b0:64a:ced1:4fa6 with SMTP id
 956f58d0204a3-64cc207eb33mr8564662d50.12.1772481050311; 
 Mon, 02 Mar 2026 11:50:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-64cb75fb6bfsm1400201d50.8.2026.03.02.11.50.50
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Mar 2026 11:50:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89463017976so449261226d6.2
 for <dev@dpdk.org>; Mon, 02 Mar 2026 11:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1772481049; x=1773085849; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gTQJEKPYZV683ido3AoS3q5Q2dUaHJcSMyeGqETfpgI=;
 b=PfbJ3L4g4+GIP3Ret2yjszLjNfOx+fktuve7U4D4Pk4LNSGgnTw1HWOd19KNui5Jg2
 /dujogCaythpErpouCkpWCbbPkLfjtGuohtHaHGkqZIXku6JIYRW7xNuRqezXCPEgPQf
 TrlB6S5ICp5Q+OCJT+u+inn6/oXu3ozELU0GU=
X-Received: by 2002:a05:620a:d8d:b0:8c7:eb5:8528 with SMTP id
 af79cd13be357-8cbc8d733e0mr1700260885a.1.1772481049234; 
 Mon, 02 Mar 2026 11:50:49 -0800 (PST)
X-Received: by 2002:a05:620a:d8d:b0:8c7:eb5:8528 with SMTP id
 af79cd13be357-8cbc8d733e0mr1700256385a.1.1772481048433; 
 Mon, 02 Mar 2026 11:50:48 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf66c515sm1226939685a.11.2026.03.02.11.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 11:50:48 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Ajit Khaparde <ajit.khaparde@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: allow get stats when port is stopped
Date: Mon,  2 Mar 2026 12:51:57 -0700
Message-ID: <20260302195208.103202-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
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

Currently the driver returns an error if stats are requested
when the port is stopped.
But some applications may need to get the port stats even if
the port is stopped.
Allow the get stats command to show the existing stats
if the port is stopped.
When the port is started the driver will get the stats from
the firmware.

Cc: stable@dpdk.org

Signed-off-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c | 47 ++++++++++-------
 drivers/net/bnxt/bnxt_hwrm.c   | 94 +++++++++++++++++++++++++++++++---
 drivers/net/bnxt/bnxt_stats.c  |  3 --
 3 files changed, 114 insertions(+), 30 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 3c618c6e82..6601ddf575 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -786,7 +786,7 @@ static int bnxt_update_phy_setting(struct bnxt *bp)
 	return rc;
 }
 
-static void bnxt_free_prev_ring_stats(struct bnxt *bp)
+static void bnxt_free_prev_ring_stats_ext(struct bnxt *bp)
 {
 	/* tpa v2 devices use ext variant local struct */
 	if (BNXT_TPA_V2_P7(bp)) {
@@ -796,6 +796,10 @@ static void bnxt_free_prev_ring_stats(struct bnxt *bp)
 		bp->prev_tx_ring_stats_ext = NULL;
 		return;
 	}
+}
+
+static void bnxt_free_prev_ring_stats(struct bnxt *bp)
+{
 	rte_free(bp->prev_rx_ring_stats);
 	rte_free(bp->prev_tx_ring_stats);
 	bp->prev_rx_ring_stats = NULL;
@@ -804,17 +808,19 @@ static void bnxt_free_prev_ring_stats(struct bnxt *bp)
 
 static int bnxt_alloc_prev_ring_ext_stats(struct bnxt *bp)
 {
-	bp->prev_rx_ring_stats_ext = rte_zmalloc("bnxt_prev_rx_ring_stats_ext",
-						 sizeof(struct bnxt_ring_stats_ext) *
-						 bp->rx_cp_nr_rings,
-						 0);
+	if (bp->prev_rx_ring_stats_ext == NULL)
+		bp->prev_rx_ring_stats_ext = rte_zmalloc("bnxt_prev_rx_ring_stats_ext",
+							 sizeof(struct bnxt_ring_stats_ext) *
+							 bp->rx_cp_nr_rings,
+							 0);
 	if (bp->prev_rx_ring_stats_ext == NULL)
 		return -ENOMEM;
 
-	bp->prev_tx_ring_stats_ext = rte_zmalloc("bnxt_prev_tx_ring_stats_ext",
-						 sizeof(struct bnxt_ring_stats_ext) *
-						 bp->tx_cp_nr_rings,
-						 0);
+	if (bp->prev_tx_ring_stats_ext == NULL)
+		bp->prev_tx_ring_stats_ext = rte_zmalloc("bnxt_prev_tx_ring_stats_ext",
+							 sizeof(struct bnxt_ring_stats_ext) *
+							 bp->tx_cp_nr_rings,
+							 0);
 
 	if (bp->tx_cp_nr_rings > 0 && bp->prev_tx_ring_stats_ext == NULL)
 		goto error;
@@ -831,24 +837,26 @@ static int bnxt_alloc_prev_ring_stats(struct bnxt *bp)
 	if (BNXT_TPA_V2_P7(bp))
 		return bnxt_alloc_prev_ring_ext_stats(bp);
 
-	bp->prev_rx_ring_stats =  rte_zmalloc("bnxt_prev_rx_ring_stats",
-					      sizeof(struct bnxt_ring_stats) *
-					      bp->rx_cp_nr_rings,
-					      0);
+	if (bp->prev_rx_ring_stats == NULL)
+		bp->prev_rx_ring_stats =  rte_zmalloc("bnxt_prev_rx_ring_stats",
+						      sizeof(struct bnxt_ring_stats) *
+						      bp->rx_cp_nr_rings,
+						      0);
 	if (bp->prev_rx_ring_stats == NULL)
 		return -ENOMEM;
 
-	bp->prev_tx_ring_stats = rte_zmalloc("bnxt_prev_tx_ring_stats",
-					     sizeof(struct bnxt_ring_stats) *
-					     bp->tx_cp_nr_rings,
-					     0);
+	if (bp->prev_tx_ring_stats == NULL)
+		bp->prev_tx_ring_stats = rte_zmalloc("bnxt_prev_tx_ring_stats",
+						     sizeof(struct bnxt_ring_stats) *
+						     bp->tx_cp_nr_rings,
+						     0);
 	if (bp->tx_cp_nr_rings > 0 && bp->prev_tx_ring_stats == NULL)
 		goto error;
 
 	return 0;
 
 error:
-	bnxt_free_prev_ring_stats(bp);
+	bnxt_free_prev_ring_stats_ext(bp);
 	return -ENOMEM;
 }
 
@@ -1758,7 +1766,6 @@ static int bnxt_dev_stop(struct rte_eth_dev *eth_dev)
 	bnxt_shutdown_nic(bp);
 	bnxt_hwrm_if_change(bp, false);
 
-	bnxt_free_prev_ring_stats(bp);
 	rte_free(bp->mark_table);
 	bp->mark_table = NULL;
 
@@ -1966,6 +1973,8 @@ static int bnxt_dev_close_op(struct rte_eth_dev *eth_dev)
 	if (eth_dev->data->dev_started)
 		ret = bnxt_dev_stop(eth_dev);
 
+	bnxt_free_prev_ring_stats_ext(bp);
+	bnxt_free_prev_ring_stats(bp);
 	bnxt_uninit_resources(bp, false);
 
 	bnxt_drv_uninit(bp);
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 0cef22b5ec..ac5cbbae0c 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -5356,13 +5356,54 @@ static void bnxt_update_prev_stat(uint64_t *cntr, uint64_t *prev_cntr)
 		*prev_cntr = *cntr;
 }
 
+static void bnxt_get_prev_tx_stats(struct bnxt_ring_stats *ring_stats,
+				   struct bnxt_ring_stats *prev_stats)
+{
+	ring_stats->tx_ucast_pkts = prev_stats->tx_ucast_pkts;
+	ring_stats->tx_mcast_pkts = prev_stats->tx_mcast_pkts;
+	ring_stats->tx_bcast_pkts = prev_stats->tx_bcast_pkts;
+	ring_stats->tx_ucast_bytes = prev_stats->tx_ucast_bytes;
+	ring_stats->tx_mcast_bytes = prev_stats->tx_mcast_bytes;
+	ring_stats->tx_bcast_bytes = prev_stats->tx_bcast_bytes;
+	ring_stats->tx_discard_pkts = prev_stats->tx_discard_pkts;
+}
+
+static void bnxt_get_prev_rx_stats(struct bnxt_ring_stats *ring_stats,
+				   struct bnxt_ring_stats *prev_stats)
+{
+	ring_stats->rx_ucast_pkts = prev_stats->rx_ucast_pkts;
+	ring_stats->rx_mcast_pkts = prev_stats->rx_mcast_pkts;
+	ring_stats->rx_bcast_pkts = prev_stats->rx_bcast_pkts;
+	ring_stats->rx_ucast_bytes = prev_stats->rx_ucast_bytes;
+	ring_stats->rx_mcast_bytes = prev_stats->rx_mcast_bytes;
+	ring_stats->rx_bcast_bytes = prev_stats->rx_bcast_bytes;
+	ring_stats->rx_discard_pkts = prev_stats->rx_discard_pkts;
+	ring_stats->rx_error_pkts = prev_stats->rx_error_pkts;
+	ring_stats->rx_agg_pkts = prev_stats->rx_agg_pkts;
+	ring_stats->rx_agg_bytes = prev_stats->rx_agg_bytes;
+	ring_stats->rx_agg_events = prev_stats->rx_agg_events;
+	ring_stats->rx_agg_aborts = prev_stats->rx_agg_aborts;
+}
+
 int bnxt_hwrm_ring_stats(struct bnxt *bp, uint32_t cid, int idx,
 			 struct bnxt_ring_stats *ring_stats, bool rx)
 {
 	int rc = 0;
 	struct hwrm_stat_ctx_query_input req = {.req_type = 0};
 	struct hwrm_stat_ctx_query_output *resp = bp->hwrm_cmd_resp_addr;
+	struct bnxt_ring_stats *prev_stats = &bp->prev_rx_ring_stats[idx];
 
+	if (!rx)
+		prev_stats = &bp->prev_tx_ring_stats[idx];
+
+	if (!bp->eth_dev->data->dev_started) {
+		if (rx)
+			bnxt_get_prev_rx_stats(ring_stats, prev_stats);
+		else
+			bnxt_get_prev_tx_stats(ring_stats, prev_stats);
+
+		return 0;
+	}
 	HWRM_PREP(&req, HWRM_STAT_CTX_QUERY, BNXT_USE_CHIMP_MB);
 
 	req.stat_ctx_id = rte_cpu_to_le_32(cid);
@@ -5372,8 +5413,6 @@ int bnxt_hwrm_ring_stats(struct bnxt *bp, uint32_t cid, int idx,
 	HWRM_CHECK_RESULT();
 
 	if (rx) {
-		struct bnxt_ring_stats *prev_stats = &bp->prev_rx_ring_stats[idx];
-
 		ring_stats->rx_ucast_pkts = rte_le_to_cpu_64(resp->rx_ucast_pkts);
 		bnxt_update_prev_stat(&ring_stats->rx_ucast_pkts,
 				      &prev_stats->rx_ucast_pkts);
@@ -5422,8 +5461,6 @@ int bnxt_hwrm_ring_stats(struct bnxt *bp, uint32_t cid, int idx,
 		bnxt_update_prev_stat(&ring_stats->rx_agg_aborts,
 				      &prev_stats->rx_agg_aborts);
 	} else {
-		struct bnxt_ring_stats *prev_stats = &bp->prev_tx_ring_stats[idx];
-
 		ring_stats->tx_ucast_pkts = rte_le_to_cpu_64(resp->tx_ucast_pkts);
 		bnxt_update_prev_stat(&ring_stats->tx_ucast_pkts,
 				      &prev_stats->tx_ucast_pkts);
@@ -5458,6 +5495,38 @@ int bnxt_hwrm_ring_stats(struct bnxt *bp, uint32_t cid, int idx,
 	return rc;
 }
 
+static void bnxt_get_prev_rx_stats_ext(struct bnxt_ring_stats_ext *ring_stats,
+				       struct bnxt_ring_stats_ext *prev_stats)
+{
+	ring_stats->rx_ucast_pkts = prev_stats->rx_ucast_pkts;
+	ring_stats->rx_mcast_pkts = prev_stats->rx_mcast_pkts;
+	ring_stats->rx_bcast_pkts = prev_stats->rx_bcast_pkts;
+	ring_stats->rx_ucast_bytes = prev_stats->rx_ucast_bytes;
+	ring_stats->rx_mcast_bytes = prev_stats->rx_mcast_bytes;
+	ring_stats->rx_bcast_bytes = prev_stats->rx_bcast_bytes;
+	ring_stats->rx_discard_pkts = prev_stats->rx_discard_pkts;
+	ring_stats->rx_error_pkts = prev_stats->rx_error_pkts;
+	ring_stats->rx_tpa_eligible_pkt = prev_stats->rx_tpa_eligible_pkt;
+	ring_stats->rx_tpa_eligible_bytes = prev_stats->rx_tpa_eligible_bytes;
+	ring_stats->rx_tpa_pkt = prev_stats->rx_tpa_pkt;
+	ring_stats->rx_tpa_bytes = prev_stats->rx_tpa_bytes;
+	ring_stats->rx_tpa_errors = prev_stats->rx_tpa_errors;
+	ring_stats->rx_tpa_events = prev_stats->rx_tpa_events;
+}
+
+static void bnxt_get_prev_tx_stats_ext(struct bnxt_ring_stats_ext *ring_stats,
+				       struct bnxt_ring_stats_ext *prev_stats)
+{
+	ring_stats->tx_ucast_pkts = prev_stats->tx_ucast_pkts;
+	ring_stats->tx_mcast_pkts = prev_stats->tx_mcast_pkts;
+	ring_stats->tx_bcast_pkts = prev_stats->tx_bcast_pkts;
+	ring_stats->tx_ucast_bytes = prev_stats->tx_ucast_bytes;
+	ring_stats->tx_mcast_bytes = prev_stats->tx_mcast_bytes;
+	ring_stats->tx_bcast_bytes = prev_stats->tx_bcast_bytes;
+	ring_stats->tx_discard_pkts = prev_stats->tx_discard_pkts;
+	ring_stats->tx_error_pkts = prev_stats->tx_error_pkts;
+}
+
 int bnxt_hwrm_ring_stats_ext(struct bnxt *bp, uint32_t cid, int idx,
 			     struct bnxt_ring_stats_ext *ring_stats, bool rx)
 {
@@ -5465,6 +5534,19 @@ int bnxt_hwrm_ring_stats_ext(struct bnxt *bp, uint32_t cid, int idx,
 	struct hwrm_stat_ext_ctx_query_input req = {.req_type = 0};
 	struct hwrm_stat_ext_ctx_query_output *resp = bp->hwrm_cmd_resp_addr;
 
+	struct bnxt_ring_stats_ext *prev_stats = &bp->prev_rx_ring_stats_ext[idx];
+
+	if (!rx)
+		prev_stats = &bp->prev_tx_ring_stats_ext[idx];
+
+	if (!bp->eth_dev->data->dev_started) {
+		if (rx)
+			bnxt_get_prev_rx_stats_ext(ring_stats, prev_stats);
+		else
+			bnxt_get_prev_tx_stats_ext(ring_stats, prev_stats);
+
+		return 0;
+	}
 	HWRM_PREP(&req, HWRM_STAT_EXT_CTX_QUERY, BNXT_USE_CHIMP_MB);
 
 	req.stat_ctx_id = rte_cpu_to_le_32(cid);
@@ -5473,8 +5555,6 @@ int bnxt_hwrm_ring_stats_ext(struct bnxt *bp, uint32_t cid, int idx,
 	HWRM_CHECK_RESULT();
 
 	if (rx) {
-		struct bnxt_ring_stats_ext *prev_stats = &bp->prev_rx_ring_stats_ext[idx];
-
 		ring_stats->rx_ucast_pkts = rte_le_to_cpu_64(resp->rx_ucast_pkts);
 		bnxt_update_prev_stat(&ring_stats->rx_ucast_pkts,
 				      &prev_stats->rx_ucast_pkts);
@@ -5531,8 +5611,6 @@ int bnxt_hwrm_ring_stats_ext(struct bnxt *bp, uint32_t cid, int idx,
 		bnxt_update_prev_stat(&ring_stats->rx_tpa_events,
 				      &prev_stats->rx_tpa_events);
 	} else {
-		struct bnxt_ring_stats_ext *prev_stats = &bp->prev_tx_ring_stats_ext[idx];
-
 		ring_stats->tx_ucast_pkts = rte_le_to_cpu_64(resp->tx_ucast_pkts);
 		bnxt_update_prev_stat(&ring_stats->tx_ucast_pkts,
 				      &prev_stats->tx_ucast_pkts);
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 88cfbaf9ff..7b96cf0df9 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -717,9 +717,6 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 	if (rc)
 		return rc;
 
-	if (!eth_dev->data->dev_started)
-		return -EIO;
-
 	if (BNXT_TPA_V2_P7(bp))
 		return bnxt_stats_get_ext(eth_dev, bnxt_stats, qstats);
 
-- 
2.47.3

