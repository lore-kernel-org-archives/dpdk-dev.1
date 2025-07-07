Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0806FC71130
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 23:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C63DB40674;
	Tue,  8 Jul 2025 01:18:19 +0200 (CEST)
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com
 [209.85.216.74]) by mails.dpdk.org (Postfix) with ESMTP id 46FCE40287
 for <dev@dpdk.org>; Tue,  8 Jul 2025 01:18:16 +0200 (CEST)
Received: by mail-pj1-f74.google.com with SMTP id
 98e67ed59e1d1-315af08594fso3507515a91.2
 for <dev@dpdk.org>; Mon, 07 Jul 2025 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751930295; x=1752535095; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=JL2GR9k8TfrIAtwgBW08TOlQNN+U+HFblbZJQm49WvI=;
 b=wkU9ESgTIPUxOk/DbX8aRGCn2o42sqDGA37zjemqk0mOlisVn+cPtK8cj/HIL8C+8z
 Wbht0mwn/gAAZ5fAVP0pwXKEBsN41sM3FwzfGVtaEY8GVeVhFMVjRgK1jH58Scb5p5UZ
 tDhWib1amOMgCHICH7SOel5FSWi7mlptC7/mZ2Wd3efIWs/vIoQybWI5ddNsI2ENeuft
 Uge3iDTQbFLS144VWzSfW50gJIQ+v2j6FiT15XkoFUUS9cW6z/ogtUCUEKyWLVgUjaiQ
 LUD9fdZVCMb043eRJStQEeWDP5q24qXFtdXuCEays4OAJAwg+fHasjj/w9yiFqXMJ702
 kHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751930295; x=1752535095;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JL2GR9k8TfrIAtwgBW08TOlQNN+U+HFblbZJQm49WvI=;
 b=FQlXlefxPnzshCTUyG/mZA17vfLlUWJn1VVWJL2tZE/9D8Ev5VKTWBsbfE3XK2a34x
 HItLqe9rCFe3+fq6o9YHYn/ZejhaupXBezZKHJtYFQEVE8UWD4NO3OdkttaiEYfHpeTU
 1gT4BwoW6Yw30yZURE0iYWIKTErRvYjavDgRz1aVf8qZnjRicpk9T+swYQuLX2VKFsET
 2nbVD8y/IIpi8yQKZZuR5r1po69Z7GaR1oq7mBOndC2tDS+OD/ML5m3VrfHsNP0DOD0V
 C272E67I+/82K5dNfkzy5wLV2C5H+5JuWlXft7UzQPc9s+IwLOhipLeuxoHyz3VAbFAy
 wtJw==
X-Gm-Message-State: AOJu0YyfhX16EgUpH69mW0EHAnB/HOKrw5mHzcmwxPcMBWY5Pq5sj0IC
 oFGqq7iUUJ7xAruLUaUKRpMJkRIQXvdChYo5y28+nz2wW7umO3ajpjVsUsIdEpVbvtEKsiNBL4E
 nAPdNJtIJcNqINw==
X-Google-Smtp-Source: AGHT+IGal8lxeRJuacB5YzawqgNYim3e5LSdxF9JhwaCJEv9PqFxb2xAEWu1nsz+d/1ophxfxDVBrWQhS+BsvQ==
X-Received: from pjcc8.prod.google.com ([2002:a17:90b:5748:b0:312:1e70:e233])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:6d0:b0:311:9c9a:58c5 with SMTP id
 98e67ed59e1d1-31aadcf5780mr22240461a91.12.1751930295430; 
 Mon, 07 Jul 2025 16:18:15 -0700 (PDT)
Date: Mon,  7 Jul 2025 16:18:05 -0700
In-Reply-To: <20250707231812.1937260-1-joshwash@google.com>
Mime-Version: 1.0
References: <20250707231812.1937260-1-joshwash@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707231812.1937260-2-joshwash@google.com>
Subject: [PATCH 1/7] net/gve: send whole packet when mbuf is large
From: Joshua Washington <joshwash@google.com>
To: Thomas Monjalon <thomas@monjalon.net>,
 Jeroen de Borst <jeroendb@google.com>, 
 Joshua Washington <joshwash@google.com>, Junfeng Guo <junfengg@nvidia.com>, 
 Rushil Gupta <rushilg@google.com>
Cc: dev@dpdk.org, junfeng.guo@intel.com, stable@dpdk.org, 
 Ankit Garg <nktgrg@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Before this patch, only one descriptor would be written per mbuf in a
packet. In cases like TSO, it is possible for a single mbuf to have more
bytes than GVE_MAX_TX_BUF_SIZE_DQO. As such, instead of simply
truncating the data down to this size, the driver should actually write
descriptors for the rest of the buffers in the mbuf segment.

To that effect, the number of descriptors needed to send a packet must
be corrected to account for the potential additional descriptors.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: junfeng.guo@intel.com
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
 .mailmap                     |  1 +
 drivers/net/gve/gve_tx_dqo.c | 54 ++++++++++++++++++++++++------------
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/.mailmap b/.mailmap
index 1ea4f9446d..758878bd8b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -124,6 +124,7 @@ Andy Green <andy@warmcat.com>
 Andy Moreton <andy.moreton@amd.com> <amoreton@xilinx.com> <amoreton@solarflare.com>
 Andy Pei <andy.pei@intel.com>
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
+Ankit Garg <nktgrg@google.com>
 Ankur Dwivedi <adwivedi@marvell.com> <ankur.dwivedi@caviumnetworks.com> <ankur.dwivedi@cavium.com>
 Anna Lukin <annal@silicom.co.il>
 Anoob Joseph <anoobj@marvell.com> <anoob.joseph@caviumnetworks.com>
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 6984f92443..6227fa73b0 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -74,6 +74,19 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 	txq->complq_tail = next;
 }
 
+static uint16_t
+gve_tx_pkt_nb_data_descs(struct rte_mbuf *tx_pkt)
+{
+	int nb_descs = 0;
+
+	while (tx_pkt) {
+		nb_descs += (GVE_TX_MAX_BUF_SIZE_DQO - 1 + tx_pkt->data_len) /
+			GVE_TX_MAX_BUF_SIZE_DQO;
+		tx_pkt = tx_pkt->next;
+	}
+	return nb_descs;
+}
+
 static inline void
 gve_tx_fill_seg_desc_dqo(volatile union gve_tx_desc_dqo *desc, struct rte_mbuf *tx_pkt)
 {
@@ -97,7 +110,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	uint16_t nb_to_clean;
 	uint16_t nb_tx = 0;
 	uint64_t ol_flags;
-	uint16_t nb_used;
+	uint16_t nb_descs;
 	uint16_t tx_id;
 	uint16_t sw_id;
 	uint64_t bytes;
@@ -124,14 +137,14 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		}
 
 		ol_flags = tx_pkt->ol_flags;
-		nb_used = tx_pkt->nb_segs;
 		first_sw_id = sw_id;
 
 		tso = !!(ol_flags & RTE_MBUF_F_TX_TCP_SEG);
 		csum = !!(ol_flags & GVE_TX_CKSUM_OFFLOAD_MASK_DQO);
 
-		nb_used += tso;
-		if (txq->nb_free < nb_used)
+		nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
+		nb_descs += tso;
+		if (txq->nb_free < nb_descs)
 			break;
 
 		if (tso) {
@@ -144,21 +157,28 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			if (sw_ring[sw_id] != NULL)
 				PMD_DRV_LOG(DEBUG, "Overwriting an entry in sw_ring");
 
-			txd = &txr[tx_id];
 			sw_ring[sw_id] = tx_pkt;
 
-			/* fill Tx descriptor */
-			txd->pkt.buf_addr = rte_cpu_to_le_64(rte_mbuf_data_iova(tx_pkt));
-			txd->pkt.dtype = GVE_TX_PKT_DESC_DTYPE_DQO;
-			txd->pkt.compl_tag = rte_cpu_to_le_16(first_sw_id);
-			txd->pkt.buf_size = RTE_MIN(tx_pkt->data_len, GVE_TX_MAX_BUF_SIZE_DQO);
-			txd->pkt.end_of_packet = 0;
-			txd->pkt.checksum_offload_enable = csum;
+			/* fill Tx descriptors */
+			int mbuf_offset = 0;
+			while (mbuf_offset < tx_pkt->data_len) {
+				uint64_t buf_addr = rte_mbuf_data_iova(tx_pkt) +
+					mbuf_offset;
+
+				txd = &txr[tx_id];
+				txd->pkt.buf_addr = rte_cpu_to_le_64(buf_addr);
+				txd->pkt.compl_tag = rte_cpu_to_le_16(first_sw_id);
+				txd->pkt.dtype = GVE_TX_PKT_DESC_DTYPE_DQO;
+				txd->pkt.buf_size = RTE_MIN(tx_pkt->data_len - mbuf_offset,
+							    GVE_TX_MAX_BUF_SIZE_DQO);
+				txd->pkt.end_of_packet = 0;
+				txd->pkt.checksum_offload_enable = csum;
+
+				mbuf_offset += txd->pkt.buf_size;
+				tx_id = (tx_id + 1) & mask;
+			}
 
-			/* size of desc_ring and sw_ring could be different */
-			tx_id = (tx_id + 1) & mask;
 			sw_id = (sw_id + 1) & sw_mask;
-
 			bytes += tx_pkt->data_len;
 			tx_pkt = tx_pkt->next;
 		} while (tx_pkt);
@@ -166,8 +186,8 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		/* fill the last descriptor with End of Packet (EOP) bit */
 		txd->pkt.end_of_packet = 1;
 
-		txq->nb_free -= nb_used;
-		txq->nb_used += nb_used;
+		txq->nb_free -= nb_descs;
+		txq->nb_used += nb_descs;
 	}
 
 	/* update the tail pointer if any packets were processed */
-- 
2.50.0.727.gbf7dc18ff4-goog

