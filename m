Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F029CD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 21:12:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8232C406BB;
	Wed,  3 Jun 2026 23:12:04 +0200 (CEST)
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98]) by mails.dpdk.org (Postfix) with ESMTP id BBDCE40698
 for <dev@dpdk.org>; Wed,  3 Jun 2026 23:12:02 +0200 (CEST)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-36d5fd50d20so3536697a91.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780521122; x=1781125922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=llsZkLGcuLLn1Ulgbnb6dakMV2Xgb5WaJajsoTXTbmE=;
 b=nrbwVAKmK9dH/mz1wj6GvPY2C8E1vVB+JYiyaoqQhCMePdcTDhnPFjXF4HYvExt2jQ
 itXWD0XwQdrHG+l5fiQYERlhJOXOugqxUYvTLwAhb99+qtr09yqA8k2zFsLz3sp8RY+S
 6RrWfOq3PwYbei5XhDyJAvSdLfLOy5ZeKUE9OgfFvDZAEd3N6/5KcDXHhaMAQHQe16n0
 mD3ClBIvWlnm8c0ekkQVyEwMJNvc+hwLDPk8tKR4Xx2m/5qpsyCMIBCqu/JG4LyYW1R+
 3ZfXL29RwgjnnrGIAFUph7as7+GAgBJjveRCxVJsrNj4LZdrGmKv4GtGNsvBvmNCnASo
 BlRg==
X-Gm-Message-State: AOJu0YxhFaEa5zQ9erp/m8fkiJzOxLmEnxCM1hwuvhGxQqjl9gmQBwz/
 C8V0zAYhfr7NIxqo5aB0cnsaeeaLJNpoDACXxQMKtEo221Ma6sDzy8vreBrIV/eNMu0Ho5y+vAx
 v67J6n+R6fmiCY9neb0KjtD6x57VF+CRi3TxP7uOJGqtK8Vy41AVtxbuwkPWeUeK8LwhZK5dnWQ
 dzyoN0+nnP7qZuxLppOqNfIhvR1ki+zBJZSu9ywVVYDQoDOv0tEFFABRON/gQM3mDcueHOdMZ4i
 7OUKeRbvdKi
X-Gm-Gg: Acq92OEFnLHXwKYsWLJnNzKddX9i9/8LkhUFhAjko5w3tViujgCfnJxPY3BUUOiuizn
 Bmx8t/omHIKSLf6mWODAQKXMQ8ZVHXh0OnXy7EXNVUvAIkytd+Sm54ezBbcicMbzi6W1QC5jPD+
 SUlnVOYPYx3OGu+xGm1FwiytMc6uquhRvoFPd5G6uPLmPfjwWWV/h+3sOgz7FoV5oA+HxK6JG4X
 wfAE272C5yQmh3/mvPoDGYQNEoI1TJ7CJHB0oakl7A1EOVSv3zvjAFPOlU568C3VFh66OLwWmMo
 gD8qUBAuzAVOBGxzrKyud04Kgwt+SG6/n49w60ri5PAAZnKveJcFPLUkYje4y4gK2x7KKWCkeO6
 gUxA1jUOgtczHMWP6sowe1ktoHzlJVS7AU6RCbAsl1zbA4QlttIp2gdKvwHtbZTmCz3CGs0/YI5
 g/TWNFaNL+6ihonLh12Dw845hw84TA9g==
X-Received: by 2002:a17:90b:1c05:b0:36b:abd1:d9d with SMTP id
 98e67ed59e1d1-36e32380e5fmr4686904a91.6.1780521121850; 
 Wed, 03 Jun 2026 14:12:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-36f70161786sm85907a91.3.2026.06.03.14.12.01
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 14:12:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ccf62978bfso120144716d6.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780521120; x=1781125920; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llsZkLGcuLLn1Ulgbnb6dakMV2Xgb5WaJajsoTXTbmE=;
 b=QO3ysvjoSY7Z0dfyEkLhD2oxCGUg9fpLTZ4C1M5IHCI7FrUO7uxaJo9Ihtl/EtcOqG
 WbTh6mxjjNCj7Z2PaQckg+ptgfcdX9noihpg9qmR0k8p3NNC/W0V/uJJpYEftBxKueVA
 WyR3FyWtgCQWXBbWgfFr4h5c+zG5dC6+tfciY=
X-Received: by 2002:a05:6214:21c2:b0:8cc:dffe:6422 with SMTP id
 6a1803df08f44-8cecdc55583mr80152716d6.21.1780521120595; 
 Wed, 03 Jun 2026 14:12:00 -0700 (PDT)
X-Received: by 2002:a05:6214:21c2:b0:8cc:dffe:6422 with SMTP id
 6a1803df08f44-8cecdc55583mr80152096d6.21.1780521120059; 
 Wed, 03 Jun 2026 14:12:00 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd0520d3sm31665416d6.27.2026.06.03.14.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 14:11:59 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 4/5] net/bnxt: prevent a potential segfault
Date: Wed,  3 Jun 2026 15:13:40 -0600
Message-ID: <20260603211341.2112344-5-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260603211341.2112344-1-Mohammad-Shuab.Siddique@broadcom.com>
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
@@ -765,9 +768,14 @@ int bnxt_alloc_hwrm_rings(struct bnxt *bp)
 	for (i = 0; i < bp->rx_cp_nr_rings; i++) {
 		unsigned int soc_id = bp->eth_dev->device->numa_node;
 		struct bnxt_rx_queue *rxq  = bp->rx_queues[i];
-		struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
+		struct bnxt_rx_ring_info *rxr;
 		struct bnxt_ring *ring;
 
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

