Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4DACCD1BF
	for <dpdk-dev@archiver.kernel.org>; Sat, 25 Oct 2025 18:34:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B59E340151;
	Sat, 25 Oct 2025 20:33:59 +0200 (CEST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id A617A4003C
 for <dev@dpdk.org>; Sat, 25 Oct 2025 20:33:58 +0200 (CEST)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b626a4cd9d6so676959366b.3
 for <dev@dpdk.org>; Sat, 25 Oct 2025 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761417238;
 x=1762022038; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GrLi6xRHgD7Dis18g4IxnuUuqhjL9YYcHzgGxrI4Iw=;
 b=t2jCkRjxEGDc/fnIOB6UUcvoCGVbwTmMUc2XTFNUaggfq/VtAPnxsG/DKzPVYSqhPe
 hpB4RIhT1yiMF+33qMkwsze0azneq3G+MFuLyjVMdslgf8+6f7DUVBSnoyJFYWu9Silw
 qe25gZQot2/ZqiBhZRtQriphJYwRQmiNTch9GZIJAu1i6eFbVq6hsw6sFUyG5NYyojI9
 TOsYtXG0Cok3FkOiNTGHxjGc/HhAbcB2A7a08wSM/C5LJ5NDcfxvXPScQJ4ZpUAKUa2C
 Fh/9nJPHS/X6ARtYa994EL9DXJc5xt4fvDX0MF07ewieYOHajru2XqG6LmGdAtLG9pG+
 1Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761417238; x=1762022038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GrLi6xRHgD7Dis18g4IxnuUuqhjL9YYcHzgGxrI4Iw=;
 b=mv3hlg5d0JnS6rMF+/JUyxxozknzfhg0CEmkbF12mfFUWUzZ1EX3SbcCSNiSX/uHyg
 sXfyLI1sk+9p+lm3SUuRh7bJ4aHWtNi0Jra+8U024774XascZlolQQNt72N4XibI53kq
 AgikFWbgOvLivCZzkuXoe2OQy/P62nAcs9FtGIhga/UE4JFXBjERvZ9odgbY4r8YOlPp
 5XMvxWAaQBkmqbI2Zad/yiQfQV/zmaQRf7ONVt554rKn2//9+xImPPV/sawlOgIEYa28
 XConxG72MTsBwrwJu/atgZtsRWtwqMw7shBGYcQuHqbiRjKjKySPnCiyUtoNVqQNHXln
 mOww==
X-Gm-Message-State: AOJu0Yz6Cl8lFWYgxxWX+OYPa+URXSm1ZSz0DK0iCczhzeO0zBUjeop5
 3XlB7twK6FYKGuT4Ob/FyiD0P90GAgD5iq7M9yPAxTFyTFzLShGueqXbJjwiSePbcEvfEEUL9VU
 F+580
X-Gm-Gg: ASbGncv6IMikrjwnsPAp4c/7ij2gMQzvGh8iEnvfyCwhZDiYt4Ba7anv9CZjQ4pEzRx
 MNCGmXHxQQS9R4F3bMX6IWypweRVxhVMYPA6zf8oNdEKtXxZuSXZDCeXZDcI/32Qd8vtqics76P
 9SolOYNRt9xwz2dAflVWamrfFRGEQ5ZcVrA2TeqfCX0yVGVN201zD2Kd5zCahes0vzRllPjJEvf
 BwsiJ3YF8mmIpwcCzHBiuVlPnKLJRUHLGLJX/PTTw4ZetQqmnAL5bpFj4kpK24FbRtktLJrW71s
 y0eFY7Ao7gceuz6YtfdYzYhx50umnKVaRQAyiZ1Dh9qRy+6SXSDrfLqpEHzPYFtc+cDiHQkmNC8
 QGHPaDvutzQIJuAVkfcqlhkHTKBGVAn7V2SZ3380r9CtBwaweR4KmX6rbEs3VrTAI5j4fshkJPL
 pPAFAZN/K9mW0fRPbbCyROY1+M1ZMdN1m7YgEy5hc4m75d
X-Google-Smtp-Source: AGHT+IFna46m+06WCZkodxrZ9W/hvttVm2dgIwxhw8V+HGywO2/COqX1SPQQVzCPowi2CuNqFprZlQ==
X-Received: by 2002:a17:907:9701:b0:b46:31be:e8fe with SMTP id
 a640c23a62f3a-b6d6fd8133cmr800803866b.11.1761417238048; 
 Sat, 25 Oct 2025 11:33:58 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853e5138sm263477866b.44.2025.10.25.11.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 11:33:57 -0700 (PDT)
Date: Sat, 25 Oct 2025 11:33:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v12 01/13] net/sxe: add base driver directory and doc
Message-ID: <20251025113352.3115f742@phoenix>
In-Reply-To: <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
References: <20250725104855.73326-13-liujie5@linkdatatechnology.com>
 <20250728090517.1811244-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

The following patch may help you fix the driver and have it build on current 25.11-rc1 or later.

diff --git a/drivers/net/sxe/pf/sxe_queue.c b/drivers/net/sxe/pf/sxe_queue.c
index 75287defda..59447cc8af 100644
--- a/drivers/net/sxe/pf/sxe_queue.c
+++ b/drivers/net/sxe/pf/sxe_queue.c
@@ -676,7 +676,7 @@ s32 __rte_cold sxe_rx_queue_stop(struct rte_eth_dev *dev, u16 queue_id)
 	return 0;
 }
 
-u32 sxe_rx_queue_count(void *rx_queue)
+s32 sxe_rx_queue_count(void *rx_queue)
 {
 	volatile sxe_rx_data_desc_u *desc;
 	struct sxe_rx_queue *rxq;
diff --git a/drivers/net/sxe/pf/sxe_queue.h b/drivers/net/sxe/pf/sxe_queue.h
index 43d8d4d633..c60bc6b9c2 100644
--- a/drivers/net/sxe/pf/sxe_queue.h
+++ b/drivers/net/sxe/pf/sxe_queue.h
@@ -76,7 +76,7 @@ void sxe_rx_queue_init(bool rx_batch_alloc_allowed,
 
 void sxe_rx_queue_free(sxe_rx_queue_s *rxq);
 
-u32 sxe_rx_queue_count(void *rx_queue);
+s32 sxe_rx_queue_count(void *rx_queue);
 
 s32 sxe_mq_mode_check(struct rte_eth_dev *dev);
 
diff --git a/drivers/net/sxe/pf/sxe_stats.c b/drivers/net/sxe/pf/sxe_stats.c
index 34470eae64..dd3196b75d 100644
--- a/drivers/net/sxe/pf/sxe_stats.c
+++ b/drivers/net/sxe/pf/sxe_stats.c
@@ -93,8 +93,8 @@ u32 sxe_xstats_cnt_get(void)
 }
 #endif
 
-s32 sxe_eth_stats_get(struct rte_eth_dev *eth_dev,
-				struct rte_eth_stats *stats)
+s32 sxe_eth_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
+		      struct eth_queue_stats *qstats)
 {
 	struct sxe_adapter *adapter = eth_dev->data->dev_private;
 	struct sxe_stats_info *stats_info = &adapter->stats_info;
@@ -112,16 +112,17 @@ s32 sxe_eth_stats_get(struct rte_eth_dev *eth_dev,
 		goto l_out;
 	}
 
-	for (i = 0; i < RTE_MIN_T(SXE_QUEUE_STAT_COUNT,
-		RTE_ETHDEV_QUEUE_STAT_CNTRS, typeof(i)); i++) {
+	for (i = 0; i < SXE_QUEUE_STAT_COUNT; i++) {
 		rx_packets += stats_info->hw_stats.qprc[i];
 		rx_bytes += stats_info->hw_stats.qbrc[i];
 
-		stats->q_ipackets[i] = stats_info->hw_stats.qprc[i];
-		stats->q_opackets[i] = stats_info->hw_stats.qptc[i];
-		stats->q_ibytes[i] = stats_info->hw_stats.qbrc[i];
-		stats->q_obytes[i] = stats_info->hw_stats.qbtc[i];
-		stats->q_errors[i] = stats_info->hw_stats.qprdc[i];
+		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			qstats->q_ipackets[i] = stats_info->hw_stats.qprc[i];
+			qstats->q_opackets[i] = stats_info->hw_stats.qptc[i];
+			qstats->q_ibytes[i] = stats_info->hw_stats.qbrc[i];
+			qstats->q_obytes[i] = stats_info->hw_stats.qbtc[i];
+			qstats->q_errors[i] = stats_info->hw_stats.qprdc[i];
+		}
 	}
 
 	stats->ipackets = rx_packets;
@@ -278,7 +279,7 @@ s32 sxe_stats_reset(struct rte_eth_dev *eth_dev)
 	sxe_rx_queue_s *rxq;
 	u32 i;
 
-	sxe_eth_stats_get(eth_dev, NULL);
+	sxe_eth_stats_get(eth_dev, NULL, NULL);
 	sxe_hw_stats_seq_clean(hw, &stats_info->hw_stats);
 
 	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
diff --git a/drivers/net/sxe/pf/sxe_stats.h b/drivers/net/sxe/pf/sxe_stats.h
index 7c70761cd6..d84d93421c 100644
--- a/drivers/net/sxe/pf/sxe_stats.h
+++ b/drivers/net/sxe/pf/sxe_stats.h
@@ -7,6 +7,7 @@
 
 #include <rte_ethdev.h>
 #include <rte_ethdev_core.h>
+#include <ethdev_driver.h>
 #include "sxe_hw.h"
 
 #define SXE_STATS_FIELD_NAME_SIZE  50
@@ -31,8 +32,8 @@ struct sxe_stats_field {
 	u32 offset;
 };
 
-s32 sxe_eth_stats_get(struct rte_eth_dev *eth_dev,
-				struct rte_eth_stats *stats);
+s32 sxe_eth_stats_get(struct rte_eth_dev *eth_dev,struct rte_eth_stats *stats,
+		      struct eth_queue_stats *qstats);
 
 s32 sxe_stats_reset(struct rte_eth_dev *eth_dev);
 
diff --git a/drivers/net/sxe/vf/sxevf_stats.c b/drivers/net/sxe/vf/sxevf_stats.c
index 30ce9753dd..3b75126eb7 100644
--- a/drivers/net/sxe/vf/sxevf_stats.c
+++ b/drivers/net/sxe/vf/sxevf_stats.c
@@ -5,6 +5,7 @@
 #if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
 
 #include <rte_ethdev.h>
+#include <ethdev_driver.h>
 
 #include "sxevf_stats.h"
 #include "sxe_logs.h"
@@ -25,8 +26,8 @@ static u32 sxevf_xstats_cnt_get(void)
 }
 #endif
 
-s32 sxevf_eth_stats_get(struct rte_eth_dev *eth_dev,
-				struct rte_eth_stats *stats)
+s32 sxevf_eth_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
+			struct eth_queue_stats *qstats __rte_unused)
 {
 	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
 	struct sxevf_stats_info *stats_info = &adapter->stats_info;
@@ -55,7 +56,7 @@ s32 sxevf_dev_stats_reset(struct rte_eth_dev *eth_dev)
 	struct sxevf_adapter *adapter = eth_dev->data->dev_private;
 	struct sxevf_stats_info *stats_info = &adapter->stats_info;
 
-	sxevf_eth_stats_get(eth_dev, NULL);
+	sxevf_eth_stats_get(eth_dev, NULL, NULL);
 
 	stats_info->hw_stats.vfgprc = 0;
 	stats_info->hw_stats.vfgorc = 0;
diff --git a/drivers/net/sxe/vf/sxevf_stats.h b/drivers/net/sxe/vf/sxevf_stats.h
index ddf56c39df..7a6649577b 100644
--- a/drivers/net/sxe/vf/sxevf_stats.h
+++ b/drivers/net/sxe/vf/sxevf_stats.h
@@ -16,8 +16,8 @@ struct sxevf_stats_info {
 	struct sxevf_hw_stats hw_stats;
 };
 
-s32 sxevf_eth_stats_get(struct rte_eth_dev *eth_dev,
-				struct rte_eth_stats *stats);
+s32 sxevf_eth_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *stats,
+			struct eth_queue_stats *qstats);
 
 s32 sxevf_dev_stats_reset(struct rte_eth_dev *eth_dev);
 
