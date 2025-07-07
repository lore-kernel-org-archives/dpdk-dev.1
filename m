Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BA2C71130
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 23:18:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 73D7640A4B;
	Tue,  8 Jul 2025 01:18:25 +0200 (CEST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mails.dpdk.org (Postfix) with ESMTP id 621F040676
 for <dev@dpdk.org>; Tue,  8 Jul 2025 01:18:22 +0200 (CEST)
Received: by mail-pf1-f201.google.com with SMTP id
 d2e1a72fcca58-74ae13e99d6so3505071b3a.0
 for <dev@dpdk.org>; Mon, 07 Jul 2025 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751930301; x=1752535101; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=e64lAeGT3uM87THVFZWIidSMHzBj+qR1mgUou9WhE0Q=;
 b=SWBH/5Dr25teOjob5uDf6ZFR4KiGRCm2o4W0W4oVp9g+6WTsFcUjxkx7XX/Qorzxag
 hIC5ShccCuuuxRftJXxvi5fbYSpqd4UTuhDERjCRBwSsmTGdf/FdGaLT7tr4yyw5uiTB
 KtKmoCPlOJr1hAR5qSvBM1Glwc6ti+XEIQ/TtHWC8cIXDGlZ3xndg67TVnDEr7gtqOmN
 521EWSMZlRQFnkJEbeweC/GqKEVjsV34fGu6ItxptFQLOZmu00kIWr8Tj0m0YfOUyNAS
 3zh3Su6ItZoLcqTlp4zu8bZ0ANBI9sk2RgzURJLN5CP7QWJvYb/Ahx2VXzFTHbPGPAkD
 TmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751930301; x=1752535101;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e64lAeGT3uM87THVFZWIidSMHzBj+qR1mgUou9WhE0Q=;
 b=m1+xRlqUjt1Rfpv9ETW9KgXm0lYAvn6+YbtfLAs1el/CzbafbgdV+Gont3u4xQjJhh
 prtYqCZs1LEADa2ehuP2cPIHJpts9hzpw2Ru0ZmA9u8Kvjvm0Yy2PojrWRchauTZDtJT
 0Z5uzmQC7mthCf1wKSmK3H3Lzyla0zQHlSAmto1ATZ5dwNrfDPcoVWHbJeh0mIpxHikT
 pjgrnBlKoGS6NQKqktzFJjMo84O/Hbir8cwe5HI5QJXVcMiUu5IqDtrqeUwSTfpiKSC0
 H2rafO8dSKVW7Ot1FXmRet4RTF+9ko1nDRXc8euurD1Leojr09L4f7yCJJItNogZ1Unf
 NbMA==
X-Gm-Message-State: AOJu0YzAXhcHV33u/wItvVyZbly+D7WVsnOTckMc+KhfQH/AZ4q+GeAc
 EECAg7IQdPnZoMJarEzx+1RIWD2USxcrqoMK/zLGk17IBkvEa9ceaQItF9zlGnfwyM7ngxwXnk/
 iy7Ja+T2B3iNSfQ==
X-Google-Smtp-Source: AGHT+IGDHnSzmfuqfPGxDpPFvyQq6g8iiMskWjJbifV0i5I4sHXHk1HvP/9PY1OrmfJ2KsUJ1VZ9nKVvo1yjug==
X-Received: from pgbcw11.prod.google.com
 ([2002:a05:6a02:428b:b0:b32:1431:4415])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:99a5:b0:21f:53e4:1919 with SMTP id
 adf61e73a8af0-22b6640dd03mr787199637.3.1751930301578; 
 Mon, 07 Jul 2025 16:18:21 -0700 (PDT)
Date: Mon,  7 Jul 2025 16:18:09 -0700
In-Reply-To: <20250707231812.1937260-1-joshwash@google.com>
Mime-Version: 1.0
References: <20250707231812.1937260-1-joshwash@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707231812.1937260-6-joshwash@google.com>
Subject: [PATCH 5/7] net/gve: add DQO Tx descriptor limit
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>, 
 Junfeng Guo <junfengg@nvidia.com>, Rushil Gupta <rushilg@google.com>
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

The hardware supports at most 10 data descriptors per MTU-sized segment.
GVE_TX_MAX_DATA_DESCS was defined in the initial implmenentation, but
the descriptor limit was never actually enforced.

Fixes: 4022f9999f56 ("net/gve: support basic Tx data path for DQO")
Cc: junfeng.guo@intel.com
Cc: stable@dpdk.org

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
 drivers/net/gve/gve_ethdev.c | 1 +
 drivers/net/gve/gve_ethdev.h | 1 +
 drivers/net/gve/gve_tx_dqo.c | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index bdb7f1d075..81325ba98c 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -603,6 +603,7 @@ gve_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 		.nb_max = priv->max_tx_desc_cnt,
 		.nb_min = priv->min_tx_desc_cnt,
 		.nb_align = 1,
+		.nb_mtu_seg_max = GVE_TX_MAX_DATA_DESCS,
 	};
 
 	dev_info->flow_type_rss_offloads = GVE_RTE_RSS_OFFLOAD_ALL;
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 35cb9062b1..195dadc4d4 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -102,6 +102,7 @@ struct gve_tx_stats {
 	uint64_t packets;
 	uint64_t bytes;
 	uint64_t errors;
+	uint64_t too_many_descs;
 };
 
 struct gve_rx_stats {
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 7e03e75b20..27f98cdeb3 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -165,6 +165,12 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				break;
 		}
 
+		/* Drop packet if it doesn't adhere to hardware limits. */
+		if (!tso && nb_descs > GVE_TX_MAX_DATA_DESCS) {
+			txq->stats.too_many_descs++;
+			break;
+		}
+
 		if (tso) {
 			txd = &txr[tx_id];
 			gve_tx_fill_seg_desc_dqo(txd, tx_pkt);
-- 
2.50.0.727.gbf7dc18ff4-goog

