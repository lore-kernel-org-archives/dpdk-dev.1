Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E27FC71130
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 23:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21065406B7;
	Tue,  8 Jul 2025 01:18:24 +0200 (CEST)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73]) by mails.dpdk.org (Postfix) with ESMTP id A62E740678
 for <dev@dpdk.org>; Tue,  8 Jul 2025 01:18:20 +0200 (CEST)
Received: by mail-pj1-f73.google.com with SMTP id
 98e67ed59e1d1-313d6d671ffso3484447a91.2
 for <dev@dpdk.org>; Mon, 07 Jul 2025 16:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751930300; x=1752535100; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=uuw3330JdjhnZboSCTPHt6EtIIwq7fHxssD//vz/R6A=;
 b=BH0aCSlc0whnvhafVOkIu9V5SjXi8LM0Ppz1eHbldY8liGbZW3cD6o7lKcfJ547g1E
 w9M6icQL8FXY1VTBe042oJCXLBoxLQkA7ER/PTPTXnCy28LkrUjnO3K04PMQPdZzygDz
 jInNbJKIkMDB80XM6FgSJH4kbBnIYDsmCxQItFY/T5b73I0NF8gH/GWEtp3m7NDSguqT
 xK7o1Bzbq0COI4oNe+phT/iHr+Qvil59O/NuBm74LT66pe+eUtpg8bzCRgZO0RBzlRpT
 I7/VSH2qxRuhpgDGV67rjprl75bnc0+7mMBmRxhv6G1uLHOx1vUJx8EgyvWg7tO+ApdL
 rDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751930300; x=1752535100;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uuw3330JdjhnZboSCTPHt6EtIIwq7fHxssD//vz/R6A=;
 b=ejKLGa0nnz38/t7vINc+5CL4HLw5AhQW10zhSriDLzB+UccjIzLeENOjxCKipjR2hW
 /Qs81nBX6Nf1YG6lx2CGFuHQGyJfM3jKYv6cgLQLX3YC2iy+f+pPk7EZSyQz+DKLCydr
 JvYVebNK3PictphU4/YzyovbJmkqF28I5fiqocwul/tIxTL2KY/zWrhrpcwY4b7CG7HB
 u6HO6qwG9pgkZDqWeIPns8/C1ezwoE/caY+JCy8baivkSsuacRJfQkF8RczUdmrH5ZX/
 e0mDJDxX9EsIqfzJlp5b2zBsf8Muj/NwpP9V00TmzW51hTFtyA7r6ZR4ZW3l2yee30jl
 7ikg==
X-Gm-Message-State: AOJu0YxW8XIVH3BZ4USrYY1alGnjHLd5IgNz2Nb5ETibehDkGjtrHquL
 84CUiEiKxli3XMHzltgjnbUBuP5pOJMOF3cHQn99LG3yk/qzZ80vYu1oTkEq26x/JtgPM8HsElN
 OWRLdIOAZFW1wLw==
X-Google-Smtp-Source: AGHT+IGabgtG7UTOrZqbh9Aaejglg3KOIAHPGMzT2ae4sbNOr6hZQXXyc7Kh2M0a3m+UuW7wSkQm1ae2bkgDeg==
X-Received: from pjbqo5.prod.google.com ([2002:a17:90b:3dc5:b0:312:f650:c7aa])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:b388:b0:312:e90b:419e with SMTP id
 98e67ed59e1d1-31c21cfc274mr1317253a91.12.1751930299912; 
 Mon, 07 Jul 2025 16:18:19 -0700 (PDT)
Date: Mon,  7 Jul 2025 16:18:08 -0700
In-Reply-To: <20250707231812.1937260-1-joshwash@google.com>
Mime-Version: 1.0
References: <20250707231812.1937260-1-joshwash@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707231812.1937260-5-joshwash@google.com>
Subject: [PATCH 4/7] net/gve: validate Tx packet before sending
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Rushil Gupta <rushilg@google.com>, Junfeng Guo <junfengg@nvidia.com>
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

The hardware assumes that a mismatch between the reported packet length
and the total amount of data in the descriptors is caused by a malicious
driver, leading the hardware to disable transmission altogether. To
avoid such a scenario, use rte_mbuf_check to validate that the mbuf is
correctly formed before processing.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: junfeng.guo@intel.com
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
 drivers/net/gve/gve_tx_dqo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index b2e5aae634..7e03e75b20 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -113,13 +113,14 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct rte_mbuf **sw_ring;
 	struct rte_mbuf *tx_pkt;
 	uint16_t mask, sw_mask;
+	uint16_t first_sw_id;
+	const char *reason;
 	uint16_t nb_tx = 0;
 	uint64_t ol_flags;
 	uint16_t nb_descs;
 	uint16_t tx_id;
 	uint16_t sw_id;
 	uint64_t bytes;
-	uint16_t first_sw_id;
 	uint8_t tso;
 	uint8_t csum;
 
@@ -139,6 +140,12 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			gve_tx_clean_descs_dqo(txq, DQO_TX_MULTIPLIER *
 					       txq->rs_thresh);
 
+
+		if (rte_mbuf_check(tx_pkt, true, &reason)) {
+			PMD_DRV_LOG(DEBUG, "Invalid mbuf: %s", reason);
+			break;
+		}
+
 		ol_flags = tx_pkt->ol_flags;
 		first_sw_id = sw_id;
 
-- 
2.50.0.727.gbf7dc18ff4-goog

