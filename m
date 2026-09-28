Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B6ACA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 05:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04EC9410CF;
	Tue, 29 Sep 2026 07:41:55 +0200 (CEST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48]) by mails.dpdk.org (Postfix) with ESMTP id D3BCD402F0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 19:28:10 +0200 (CEST)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-5b8eddcef9eso64935e87.1
 for <dev@dpdk.org>; Mon, 28 Sep 2026 10:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790616490; x=1791221290; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SdQ0HhNRgDlEP8bY/Xiw/bEU96D3ZecC8z2fJKmqweA=;
 b=O6AEyL1sPcXOa+vCjgFf3Or0TPLx+SLA2T2xMe8Kb5Xbv3XTjBYbD1ITDBDfTLd1To
 +xOcS00i9OVW9QpuDV1ZEz4ZaMDvpgzzdONpDMUSloVvRNgOouzVmicqp8i2i7lOPf9h
 3Sk+3rIUI/nEQc6XLpmqo6n2YwYqOEo+4vByJJugEK9hYZGZv5BPCqphyRVZxhC12A7r
 LLfIAyNIyZI/0eB6D++oqkVL9U7DYQh2ue82GgU5I+sgX/uHgx4YTXmIe7bWntJfqIiS
 zXlUxIRfvhT2W7VZ6r2JLfER85p0fm40Ucx1y2DLFiiaYbq/1ZOYJkz2tdEFoU5fwpDY
 VpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790616490; x=1791221290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SdQ0HhNRgDlEP8bY/Xiw/bEU96D3ZecC8z2fJKmqweA=;
 b=T3sHvwDE8pDOtiwpLmSGcMaTGHXwaaok/WjT56bRJhByxBIGx89wrMtCZlhk2kBxOt
 JTqw1ApDYmUUn1n2G4C+ukThZMR/GMQsyMOwkB3cV+XY92R8tCbfhR+8tGwHWNHLNDVW
 eWjS8jsn0O7toDQ/fjbxHrgi6lsRE3nBpIRf+M/rS1AiQIKMLDUglS/+cAtUecAlIxG+
 bXhYVWgmw2gpoVWSiTbMFg9zUpy/u614qus8I+4So5c07slwnzcUBUhu0ixFr+ZNqR+7
 TpL+ZsXtFGO83n/zMWnHXOwmb7D1GX3p4t5mfpog9EOC9FO7vmzZzyKXdu0wG/eh/xym
 9m/A==
X-Gm-Message-State: AFq9FYIGpa8LMCATC/ws10uNfX+7gZSeVY13MG/KHd8QKEUiyrBkeZyO
 gWMf12u80VCE5ZKd8OZDlCdIpJvybl5TXp3MXaAJKzLrfOfjTtalUDKFEJfW0NwA
X-Gm-Gg: AYBFou21NUPuNnWWUoeVrg+0uaS2rrHudUu0XTPv0lNSMWygcGCqJrkJSePLo4ihGY6
 elYRQun8/4Ko/NP0cZ7TgvhHoSb1hP7pf2+4XQVemZ3dD4t5wZoSR58vX/5ZOzWkbxGwqhbj5Mw
 Xxeasbf1rVchEVZZeCgJA6Tswmk3pbXy/0z+KkBPFibnG0u+MucJHRHu/rxybdvXB4l6GZDD2zq
 WnxSAKfaDIbyqvL1ZALJ8lS+/vnY0v4wnU4z0QwSMKkUNyWOWHaZ+WUkoRKnT+l/6tbMck29+dk
 Shs8nos9vMOnb/VTypKNCbd2vnq/ArNWIF8zwTw5NSUmm0XJAHVI8GXjrv3HVSsb16NytUFrHUc
 lDCJx+zI1JiYI/L929xDUXP6jTCVqjOVhlEA6WXr6TomO8rsLdI0uJofa69bVKz209aOSiqPKCN
 /7G/Dz0OjZG7BADv4KHVpykfJtFqjk7qy4YuAbL8xszOO2/Ot8o3E0+YcTCNKKAP8vCkk=
X-Received: by 2002:a05:6512:1388:b0:5b8:f821:6fb3 with SMTP id
 2adb3069b0e04-5b8f821726emr1431877e87.43.1790616489983; 
 Mon, 28 Sep 2026 10:28:09 -0700 (PDT)
Received: from fedora ([185.61.79.67]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9debc0ec1sm706837e87.68.2026.09.28.10.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 10:28:09 -0700 (PDT)
From: Omar Munchaev <omarmunchaev@gmail.com>
X-Google-Original-From: Omar Munchaev <omar.munchaev@gmail.com>
To: dev@dpdk.org
Cc: Omar Munchaev <omar.munchaev@gmail.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] net/ice: fix missing type casts for flex descriptors
Date: Tue, 29 Sep 2026 00:27:58 +0700
Message-ID: <20260928172759.3369704-1-omar.munchaev@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 07:41:44 +0200
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

When ice driver was ported to use the common Rx descriptor format,
some type casts were missed. Add them.

Fixes: e70342ba90a83 ("net/ice: use common Rx queue structure")
Cc: stable@dpdk.org

Signed-off-by: Omar Munchaev <omar.munchaev@gmail.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index b333444cbf..882af80833 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -2698,7 +2698,7 @@ ice_fdir_setup_rx_resources(struct ice_pf *pf)
 	}
 
 	/* Allocate RX hardware ring descriptors. */
-	ring_size = sizeof(union ice_32byte_rx_desc) * ICE_FDIR_NUM_RX_DESC;
+	ring_size = sizeof(union ci_rx_flex_desc) * ICE_FDIR_NUM_RX_DESC;
 	ring_size = RTE_ALIGN(ring_size, ICE_DMA_MEM_ALIGN);
 
 	rz = rte_eth_dma_zone_reserve(dev, "fdir_rx_ring",
@@ -2718,7 +2718,7 @@ ice_fdir_setup_rx_resources(struct ice_pf *pf)
 
 	rxq->rx_ring_phys_addr = rz->iova;
 	memset(rz->addr, 0, ICE_FDIR_NUM_RX_DESC *
-	       sizeof(union ice_32byte_rx_desc));
+	       sizeof(union ci_rx_flex_desc));
 	rxq->rx_flex_ring = (union ci_rx_flex_desc *)rz->addr;
 
 	/*
@@ -4464,15 +4464,15 @@ ice_set_default_ptype_table(struct rte_eth_dev *dev)
 static inline int
 ice_check_fdir_programming_status(struct ci_rx_queue *rxq)
 {
-	volatile union ice_32byte_rx_desc *rxdp;
-	uint64_t qword1;
-	uint32_t rx_status;
-	uint32_t error;
-	uint32_t id;
+	volatile union ci_rx_flex_desc *rxdp;
+	uint16_t qword1;
+	uint16_t rx_status;
+	uint16_t error;
+	uint16_t id;
 	int ret = -EAGAIN;
 
-	rxdp = (volatile union ice_32byte_rx_desc *)&rxq->rx_flex_ring[rxq->rx_tail];
-	qword1 = rte_le_to_cpu_64(rxdp->wb.qword1.status_error_len);
+	rxdp = &rxq->rx_flex_ring[rxq->rx_tail];
+	qword1 = rte_le_to_cpu_16(rxdp->wb.status_error0);
 	rx_status = (qword1 & ICE_RXD_QW1_STATUS_M)
 			>> ICE_RXD_QW1_STATUS_S;
 
@@ -4497,7 +4497,7 @@ ice_check_fdir_programming_status(struct ci_rx_queue *rxq)
 			ret = -EINVAL;
 		}
 err:
-		rxdp->wb.qword1.status_error_len = 0;
+		rxdp->wb.status_error0 = 0;
 		rxq->rx_tail++;
 		if (unlikely(rxq->rx_tail == rxq->nb_rx_desc))
 			rxq->rx_tail = 0;
-- 
2.55.0

