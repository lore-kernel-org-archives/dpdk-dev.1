Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB6AC3601B
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Apr 2025 23:25:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2865540656;
	Thu,  3 Apr 2025 01:24:54 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 1047540653
 for <dev@dpdk.org>; Thu,  3 Apr 2025 01:24:52 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-6e90b8d4686so2937796d6.2
 for <dev@dpdk.org>; Wed, 02 Apr 2025 16:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1743636291;
 x=1744241091; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYOCZkYTCA6nkNT2fSnkg6LFZYwB3bJTDcIJHGOdUKE=;
 b=IDKJkgCCpyeqoxl2qQEadqnsLDlR+MVJHzz6PGubbawD0s5voWbr87AcPNAnTWg4ej
 7lz3d5yIiUGg52D/kuc8NaZftUw2Wh47j2dPiG12FHQ4dzDm7TzomSMxlBQw1F4mX7Ej
 Iw7F5t63r7Xbq3d8KBhHUMVH08JHnpudfJ5/0XGOCPKbaHnI3X2WF+rTIufQiyKC61XO
 tPe5d8kakV1jjPOV+AyCPHaGNDs/GX4ZEwekcfXORDF4qifk44Hji0Kk3L/jGSIZ8qZU
 Wj5lqdSGLkEyg/CtROHjAKjRK6L51/8V7ZX/meyAPgWqPcLC8Vi6R3t8+7b4TAF0Qh/f
 AMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743636291; x=1744241091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYOCZkYTCA6nkNT2fSnkg6LFZYwB3bJTDcIJHGOdUKE=;
 b=mlR4LofSG1RCB4m/yEp7fyiubESblurICzTqDZ3dW/hholp2DIy8/SpbpKBzvjJVwV
 hbv+qFWXUAHp0tf5yWTbXxAMwcuKlBQct1DDLat1wP8FLfEFBrHaO7Bn62n8uxpaFH1m
 sGINCEqK3voVJ+jK1uf+ZaLG92IjC2gvjao03k5D75slIVTOHwcQ+9sfvP5uB1QS4pT7
 7ZEdUF4qJf40j2Q8f9nRL3sJv1HmFBkTQvz1XfhnO2z/nz+PelpRBc7QBszJntaYNSyu
 JMBUGMq8mTqsFMfva0K6CU28hshqI7A3N0MH3RNXblKjJ7/HiInDf2hetmPKHOMGDC2H
 2wow==
X-Gm-Message-State: AOJu0YwclKdozqow9EKUP0qovYDNBJnnEYt3jNdEGCo3CfLgaFWk4sba
 Pzkh3/MQl8xHmUwahpnRkTv7DcHQA61JMxDQaxTxdFjWpK3I13uRI7MvjZb6De4hBAfsh28rWym
 q
X-Gm-Gg: ASbGncsEjkabbx0590UvukjIkLfltsjE5UrnwHaT12Tncb0PG02GSa66pRUz7mny6d0
 vt3/hVf7S7+qb2l0e3F9VtsPPdeDcyt3o8pqMwR/fGy0zT1l7eVnfofxtkbPUMyzLhSxMaqMomZ
 2gLu+dEOT11MDrs4ILdGi1FhyuohZJbzPyQjf6HQiZSx/t+ROKKEsLINXgiZCdbRi+lnlJLO/M8
 0/RvONXcNvbRYVdZnE7q2B+12z470Y7kDbLK8oTCDqdrCUD8nyNNnbe5OK47/OJxt7xGas2Vj9B
 i4W6/OdLyAWIuH9UT1KaxxVcd++Ou+ooENJF5ABzrTNCGSKgy0ir01GwRUywTcDFgjOrSiFP/Qp
 4Wb+2U/KDLWShQOba6A==
X-Google-Smtp-Source: AGHT+IE78Wguyi0IjnG9B1LzmbizNrmn0dLRvNFsFjbw1FFuSYoB7JEEBLSryKfedMJmkZjz+pd8tA==
X-Received: by 2002:a05:6214:2a4f:b0:6e4:4331:aae6 with SMTP id
 6a1803df08f44-6ef0f69572amr868356d6.39.1743636291434; 
 Wed, 02 Apr 2025 16:24:51 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ef0f14e993sm672826d6.112.2025.04.02.16.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 16:24:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v12 03/10] net/sfc: replace use of rte_mbuf_sanity_check
Date: Wed,  2 Apr 2025 16:23:13 -0700
Message-ID: <20250402232441.440346-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250402232441.440346-1-stephen@networkplumber.org>
References: <20240529233811.663211-1-stephen@networkplumber.org>
 <20250402232441.440346-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Renamed to rte_mbuf_verify.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/sfc/sfc_ef100_rx.c     | 6 +++---
 drivers/net/sfc/sfc_ef10_essb_rx.c | 4 ++--
 drivers/net/sfc/sfc_ef10_rx.c      | 4 ++--
 drivers/net/sfc/sfc_rx.c           | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sfc/sfc_ef100_rx.c b/drivers/net/sfc/sfc_ef100_rx.c
index e283879e6b..5ebfba4dcf 100644
--- a/drivers/net/sfc/sfc_ef100_rx.c
+++ b/drivers/net/sfc/sfc_ef100_rx.c
@@ -179,7 +179,7 @@ sfc_ef100_rx_qrefill(struct sfc_ef100_rxq *rxq)
 			struct sfc_ef100_rx_sw_desc *rxd;
 			rte_iova_t dma_addr;
 
-			__rte_mbuf_raw_sanity_check(m);
+			__rte_mbuf_raw_verify(m);
 
 			dma_addr = rte_mbuf_data_iova_default(m);
 			if (rxq->flags & SFC_EF100_RXQ_NIC_DMA_MAP) {
@@ -551,7 +551,7 @@ sfc_ef100_rx_process_ready_pkts(struct sfc_ef100_rxq *rxq,
 		rxq->ready_pkts--;
 
 		pkt = sfc_ef100_rx_next_mbuf(rxq);
-		__rte_mbuf_raw_sanity_check(pkt);
+		__rte_mbuf_raw_verify(pkt);
 
 		RTE_BUILD_BUG_ON(sizeof(pkt->rearm_data[0]) !=
 				 sizeof(rxq->rearm_data));
@@ -575,7 +575,7 @@ sfc_ef100_rx_process_ready_pkts(struct sfc_ef100_rxq *rxq,
 			struct rte_mbuf *seg;
 
 			seg = sfc_ef100_rx_next_mbuf(rxq);
-			__rte_mbuf_raw_sanity_check(seg);
+			__rte_mbuf_raw_verify(seg);
 
 			seg->data_off = RTE_PKTMBUF_HEADROOM;
 
diff --git a/drivers/net/sfc/sfc_ef10_essb_rx.c b/drivers/net/sfc/sfc_ef10_essb_rx.c
index 78bd430363..74647e2792 100644
--- a/drivers/net/sfc/sfc_ef10_essb_rx.c
+++ b/drivers/net/sfc/sfc_ef10_essb_rx.c
@@ -125,7 +125,7 @@ sfc_ef10_essb_next_mbuf(const struct sfc_ef10_essb_rxq *rxq,
 	struct rte_mbuf *m;
 
 	m = (struct rte_mbuf *)((uintptr_t)mbuf + rxq->buf_stride);
-	__rte_mbuf_raw_sanity_check(m);
+	__rte_mbuf_raw_verify(m);
 	return m;
 }
 
@@ -136,7 +136,7 @@ sfc_ef10_essb_mbuf_by_index(const struct sfc_ef10_essb_rxq *rxq,
 	struct rte_mbuf *m;
 
 	m = (struct rte_mbuf *)((uintptr_t)mbuf + idx * rxq->buf_stride);
-	__rte_mbuf_raw_sanity_check(m);
+	__rte_mbuf_raw_verify(m);
 	return m;
 }
 
diff --git a/drivers/net/sfc/sfc_ef10_rx.c b/drivers/net/sfc/sfc_ef10_rx.c
index 60442930b3..f4fc815570 100644
--- a/drivers/net/sfc/sfc_ef10_rx.c
+++ b/drivers/net/sfc/sfc_ef10_rx.c
@@ -148,7 +148,7 @@ sfc_ef10_rx_qrefill(struct sfc_ef10_rxq *rxq)
 			struct sfc_ef10_rx_sw_desc *rxd;
 			rte_iova_t phys_addr;
 
-			__rte_mbuf_raw_sanity_check(m);
+			__rte_mbuf_raw_verify(m);
 
 			SFC_ASSERT((id & ~ptr_mask) == 0);
 			rxd = &rxq->sw_ring[id];
@@ -297,7 +297,7 @@ sfc_ef10_rx_process_event(struct sfc_ef10_rxq *rxq, efx_qword_t rx_ev,
 		rxd = &rxq->sw_ring[pending++ & ptr_mask];
 		m = rxd->mbuf;
 
-		__rte_mbuf_raw_sanity_check(m);
+		__rte_mbuf_raw_verify(m);
 
 		m->data_off = RTE_PKTMBUF_HEADROOM;
 		rte_pktmbuf_data_len(m) = seg_len;
diff --git a/drivers/net/sfc/sfc_rx.c b/drivers/net/sfc/sfc_rx.c
index a193229265..c885ce2b05 100644
--- a/drivers/net/sfc/sfc_rx.c
+++ b/drivers/net/sfc/sfc_rx.c
@@ -120,7 +120,7 @@ sfc_efx_rx_qrefill(struct sfc_efx_rxq *rxq)
 		     ++i, id = (id + 1) & rxq->ptr_mask) {
 			m = objs[i];
 
-			__rte_mbuf_raw_sanity_check(m);
+			__rte_mbuf_raw_verify(m);
 
 			rxd = &rxq->sw_desc[id];
 			rxd->mbuf = m;
-- 
2.47.2

