Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA22CA0FE7
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 00:03:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC1664060C;
	Tue, 26 Aug 2025 02:03:45 +0200 (CEST)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 19B48402E9
 for <dev@dpdk.org>; Tue, 26 Aug 2025 02:03:44 +0200 (CEST)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-244581c62faso61333945ad.2
 for <dev@dpdk.org>; Mon, 25 Aug 2025 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756166623; x=1756771423; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=w3WSfuWxb5ekEZDsKDNtXdRxOozhH//HrP84oD7qg9c=;
 b=aEy6c+WxSv5ExuXCNeVjKSm56Q8kvT9QDcWczFVJzhT5cnT8BNggbjFiqav0DEDxT7
 QsbaeHEGv6+65Hsh7NPnw2j4ACxO9YQcUCuhaRHViagj7Hchj0vFSO9vFH3Eqb06yxw1
 ea3Pc9ifk3F1fr1Wv6dPi7G0z8b90YTp+P9Kkwe1RZAoAp9T+AvQc3RVB6x4aWnPn86r
 so+ZylAaqiup8+JRpE4z5BsWs3lPsGvHN00hmr+wrR/UHOBAa5ww9UseZtBCONPYToJE
 lGybSG57rMHnf+Hf60eyDuXeoIfTjfZO8wwgKaF0bjCbvkNoAgGR7hOFs7IzCHPEkl9D
 xeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756166623; x=1756771423;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w3WSfuWxb5ekEZDsKDNtXdRxOozhH//HrP84oD7qg9c=;
 b=DIIYsSmHRPT4X+j5AmFag6v2KCQfPIlCHIdo/dNqCClYIaLweVsrif0Qjqtx/z0c6r
 Jqjy5s/zCIBX8Z9vQPqNpu7/7RJbNMZGT0UKR8gAtH+JraTPOiULPVRmA3AGbMIxzdyT
 0UKxh9qHjGKmHBpQO+YR27muuGeEsLqy7WIBFpvkF4Tg/xYutsAzri6V7YpzwOeM0uvJ
 4SM0dzoEI6PDbtOTKY9aQ4sNRXDa3q8+xjdJgxToo8mQDp91BTP6BS2pjj3oLC1CswYE
 m3QjaB5cbeXaMKL+BP2td9LzZOFyPNQlNGOc3F37BksEwJvUXqODM3GN6Y3GkfJClg9R
 cDtA==
X-Gm-Message-State: AOJu0YxYDed/2B84kZ0wvB9vioGWrSxVk9igL8jYF5/QJFlEJwwStxgF
 D4CjS/OHemENJSS8GuKFRMK38tx5PRpB9im180qajpCAsy1Jkw7EjDiLzMgcwgevH1NeKuSqt22
 fT1V6al/qmVvbhA==
X-Google-Smtp-Source: AGHT+IEtIO8CN68eDfootNjspZR5hyE+shTtQRx4ZdlFnrrCRcHgY+b0B9KPmzioWAQGLy93OlW7uc3G7LiN7A==
X-Received: from plka6.prod.google.com ([2002:a17:903:f86:b0:242:fffc:a2ca])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec87:b0:246:6a8b:8473 with SMTP id
 d9443c01a7336-2466a8b8672mr130068915ad.45.1756166623176; 
 Mon, 25 Aug 2025 17:03:43 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:03:35 -0700
In-Reply-To: <20250826000337.3922883-1-joshwash@google.com>
Mime-Version: 1.0
References: <20250826000337.3922883-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826000337.3922883-3-joshwash@google.com>
Subject: [PATCH 2/4] net/gve: add datapath-specific logging for gve
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Ankit Garg <nktgrg@google.com>
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

This would allow for separate control of datapath-related logs vs
non-datapath logs.

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
 drivers/net/gve/gve_logs.h   |  3 +++
 drivers/net/gve/gve_rx_dqo.c |  5 +++--
 drivers/net/gve/gve_tx_dqo.c | 11 ++++++-----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/gve/gve_logs.h b/drivers/net/gve/gve_logs.h
index a3d50fa45c..beada20e02 100644
--- a/drivers/net/gve/gve_logs.h
+++ b/drivers/net/gve/gve_logs.h
@@ -11,4 +11,7 @@ extern int gve_logtype_driver;
 #define PMD_DRV_LOG(level, ...) \
 	RTE_LOG_LINE_PREFIX(level, GVE_DRIVER, "%s(): ", __func__, __VA_ARGS__)
 
+#define PMD_DRV_DP_LOG(level, ...) \
+	RTE_LOG_DP_LINE_PREFIX(level, GVE_DRIVER, "%s(): ", __func__,  __VA_ARGS__)
+
 #endif
diff --git a/drivers/net/gve/gve_rx_dqo.c b/drivers/net/gve/gve_rx_dqo.c
index cd85d90bb6..ccaca1b0ea 100644
--- a/drivers/net/gve/gve_rx_dqo.c
+++ b/drivers/net/gve/gve_rx_dqo.c
@@ -27,8 +27,9 @@ gve_rx_refill_dqo(struct gve_rx_queue *rxq)
 		rxq->stats.no_mbufs += nb_refill;
 		dev = &rte_eth_devices[rxq->port_id];
 		dev->data->rx_mbuf_alloc_failed += nb_refill;
-		PMD_DRV_LOG(DEBUG, "RX mbuf alloc failed port_id=%u queue_id=%u",
-			    rxq->port_id, rxq->queue_id);
+		PMD_DRV_DP_LOG(DEBUG,
+			       "RX mbuf alloc failed port_id=%u queue_id=%u",
+			       rxq->port_id, rxq->queue_id);
 		return;
 	}
 
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index c36c215b94..10ef645802 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -42,7 +42,7 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 		aim_txq->last_desc_cleaned = compl_tag;
 		break;
 	case GVE_COMPL_TYPE_DQO_REINJECTION:
-		PMD_DRV_LOG(DEBUG, "GVE_COMPL_TYPE_DQO_REINJECTION !!!");
+		PMD_DRV_DP_LOG(DEBUG, "GVE_COMPL_TYPE_DQO_REINJECTION !!!");
 		/* FALLTHROUGH */
 	case GVE_COMPL_TYPE_DQO_PKT:
 		/* free all segments. */
@@ -58,10 +58,10 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 		break;
 	case GVE_COMPL_TYPE_DQO_MISS:
 		rte_delay_us_sleep(1);
-		PMD_DRV_LOG(DEBUG, "GVE_COMPL_TYPE_DQO_MISS ignored !!!");
+		PMD_DRV_DP_LOG(DEBUG, "GVE_COMPL_TYPE_DQO_MISS ignored !!!");
 		break;
 	default:
-		PMD_DRV_LOG(ERR, "unknown completion type.");
+		PMD_DRV_DP_LOG(ERR, "unknown completion type.");
 		return;
 	}
 
@@ -206,7 +206,7 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 
 		if (rte_mbuf_check(tx_pkt, true, &reason)) {
-			PMD_DRV_LOG(DEBUG, "Invalid mbuf: %s", reason);
+			PMD_DRV_DP_LOG(DEBUG, "Invalid mbuf: %s", reason);
 			break;
 		}
 
@@ -243,7 +243,8 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		do {
 			if (sw_ring[sw_id] != NULL)
-				PMD_DRV_LOG(DEBUG, "Overwriting an entry in sw_ring");
+				PMD_DRV_DP_LOG(DEBUG,
+					       "Overwriting an entry in sw_ring");
 
 			/* Skip writing descriptor if mbuf has no data. */
 			if (!tx_pkt->data_len)
-- 
2.51.0.rc1.167.g924127e9c0-goog

