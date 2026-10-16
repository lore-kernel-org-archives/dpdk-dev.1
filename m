Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70957CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 11:32:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2585E40A72;
	Fri, 16 Oct 2026 13:31:36 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 0A8F840291
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:27:06 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso7927868eec.1
 for <dev@dpdk.org>; Thu, 15 Oct 2026 23:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132025; x=1792736825; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vBDiA7CD41MoYgfVqcLFQGwKkr/kbKYe/bmBfqLS4ro=;
 b=XO7GGSbI+N4ec1sMQwazR/zMgk9Y+WmUKhlNKDsep8Dr20yg8lWXuWOhbCpjC9SsDW
 Qm53stlgy8WU2RMEGlp1gCaKTQlbW0X7ZqK7jAtOLGl5i4nZXU7MTyuvFzywT2IA0iq3
 +bYTwK3ab4Sfde2WO9PjwwME1z4S8JtHnGhk2uT3Czoa+yb9lGDpeFqkNXA/Rj5oVrWh
 Coq+z4j+/bP1LuHagm2x/ywHcE/Kw9PXqfzEgimHCt32yTLtevdpzG9bnftucLxlHJjz
 HQD1waDubM6yCpPFKpEGzF3p9YFtD+279p2yI56OVeSwt6Ygpy/tD6A2f/AFGDVPLpJr
 51Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132025; x=1792736825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vBDiA7CD41MoYgfVqcLFQGwKkr/kbKYe/bmBfqLS4ro=;
 b=Ci/mYaYu99/disjsR/VvBl4DDtQdWtAotqSyvf9SJeAXC3WFcsuMoWAUA3BQn2LnaM
 9e3Nu1g6DWDZdQCmnxP24XOy96PVjuTZKOBcFeSC416ZoWyxU0QP4kHFDbs16tYINcgB
 tCYHP15OtEaJf9lGiXItErz/hej1IyX4QK51pdymDJy5tB++5/os98SecXXhSsMjmTFg
 yuV7LEcb+haZxzhDPTuKOJaVVtFMsBSz3108ZQ9tw4W1dUeVtdIvdKZSnRnaaka9gmB+
 ZKWgpAoGnAMz+k0ob2+wO2QlZYWsoSDnSm5OfHC3Agi3h/DYmKnnOWJISxtzQMDToxkm
 8ABg==
X-Gm-Message-State: AFq9FYIrGFbSxgHuKrn6Ma9vSQBNrfLit30akMQ8WTSAadvsAr3+6niQ
 OHtYcaS/ffvZxREga8j4vlmt6cxmxJJXB1zmZQi8BbmWUjdYI1p9rePvYDoZ3g==
X-Gm-Gg: AYBFou0g95wbY7dk8bHsmjvRjNh2W5WvmK10DlSNmXMp05m1JfgCPgymTRRBdDeXbYl
 lCvkfnrWed6skhOnwwecUrgorBrle+6/1tEbAMbczcxCVmGMXLQ4pqqoPuZ1J6IU11y7ZZcp8gy
 I18I8aUdAvOQBDwYlLHoPFm/pHf/GS1rlh84LMtYgc+RgXJbZdFjrUlF/JM1i6Gi6DZjvDiJUww
 1UJ4d62LqvN6QZ6A+zA4hyDdLfyrHWEMH3qIP7zbShApeq+QohxwwHE7MgwJPYkO3hyP0rU06uj
 ALQEKn+RDKS6E/BG6CQZHb99EJxCBBRRNYhyHpPnMWh/G5I1TnnpNhT2xsDZemYx4wyr0mGrSrv
 9cEc353dDTKA696xRUwc4uD/fLeHbMIrGQB0jcx55/FUZ3Z3t267KrBWvv7vtIJUl15KHgsrYie
 oA9XEgR2wjwGeURX84bs9U5qS0rlGV0w32cwm9p/5FNzytOmP/EvUUgyBtqsV50eNibKKxivIM
X-Received: by 2002:a05:701b:4653:b0:155:7721:3a4c with SMTP id
 a92af1059eb24-16a62bc8067mr26011489c88.35.1792132024817; 
 Thu, 15 Oct 2026 23:27:04 -0700 (PDT)
Received: from aviuser.. ([192.19.252.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa3ebsm2743324c88.8.2026.10.15.23.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:27:04 -0700 (PDT)
From: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
To: dev@dpdk.org
Cc: joshwash@google.com,
	stephen@networkplumber.org,
	stable@dpdk.org
Subject: [PATCH v3 05/10] net/gve: add cacheline overlap margin to DQO Tx ring
Date: Fri, 16 Oct 2026 06:26:42 +0000
Message-ID: <ec96ead0d262dd7e0a1b587d89375a170327a8b4.1792129992.git.tathagat.dpdk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792129992.git.tathagat.dpdk@gmail.com>
References: <cover.1792129992.git.tathagat.dpdk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:31:30 +0200
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

The GVNIC DQO hardware DMA engine prefetches descriptors in cacheline
units (64 bytes = 4 descriptors of 16 bytes each). When producer tail
and consumer head indices share a cacheline, CPU and device DMA memory
collisions can occur.

Align with the Linux driver (gve_has_tx_slots_available()) by requiring
GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP (4 descriptors) headroom when
checking descriptor availability before enqueueing packets.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: stable@dpdk.org

Signed-off-by: Tathagat Priyadarshi <tathagat.dpdk@gmail.com>
Acked-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 36d56b7d26..c5ae2136ad 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -259,6 +259,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct gve_tx_pkt *pkts;
 	struct rte_mbuf *tx_pkt;
 	uint16_t compl_tag;
+	uint16_t req_descs;
 	const char *reason;
 	uint16_t nb_tx = 0;
 	uint64_t bytes = 0;
@@ -291,14 +292,17 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		nb_descs = gve_tx_pkt_nb_data_descs(tx_pkt);
 		nb_descs += tso;
+		req_descs = nb_descs + GVE_TX_MIN_DESC_PREVENT_CACHE_OVERLAP;
 
-		/* Clean if there aren't enough descriptors to send the packet. */
-		if (unlikely(!gve_can_tx(txq, nb_descs, 1))) {
+		/* Clean if there aren't enough descriptors to send the packet
+		 * while maintaining the cacheline overlap margin.
+		 */
+		if (unlikely(!gve_can_tx(txq, req_descs, 1))) {
 			int nb_to_clean = RTE_MAX(DQO_TX_MULTIPLIER * txq->rs_thresh,
-						  nb_descs);
+						  (int)req_descs);
 
 			gve_tx_clean_descs_dqo(txq, nb_to_clean);
-			if (!gve_can_tx(txq, nb_descs, 1))
+			if (!gve_can_tx(txq, req_descs, 1))
 				break;
 		}
 
-- 
2.43.0

