Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B275C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:57:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1076402E7;
	Thu, 20 Feb 2025 17:57:06 +0100 (CET)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id E947A402CC
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:57:04 +0100 (CET)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-219f8263ae0so26049455ad.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740070624;
 x=1740675424; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdtvX3TQiRG3dE11tCj8PWZzf+gKgY3w9K/AC7zCSMA=;
 b=KeVYmJNjUChug18w5PUmjyrnhLPqo3Hb1F9u9mr9g1bBrl5K85xotnpVtWm9PyzmcL
 cffgxOGnftw3fO/q8B9NjBquL/6NSs3oUvNJs2/7CMM8rNzGJrTqKdgEcJRtSeljL7f6
 GFsnUyg0hsDTQOjYqh0PeKQX55VX9/xUlws58PRNgw/PCZqXzrzj8Z19MTRItuZjBzlQ
 1SmBDfGV5ZqcEMXMi9cat35tkbmwIDbk/WUrXaVynqRAu7pXnSghYCscWZWHg0Oo78FG
 dEn2eRowk0jeVs1INdOE/KE6lRCKw8VBSelq+mDcoSyEXthbWzQnl6EjFo9lu8PTrTSa
 6SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740070624; x=1740675424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hdtvX3TQiRG3dE11tCj8PWZzf+gKgY3w9K/AC7zCSMA=;
 b=aemr1WzF7sfe6SS2cevh/jECmyzESnpFyCbOHyMY7bUFu3LufK+WGF/3W+/bbz+oCi
 7/O7gTD3WRV+OImQKD9Z+9Lhq7qSehN0LBBPQzPb+JIA0fqah7d0ktzSKTLReAlKLFB/
 QY7nLcSUT64UQwLAXk7EUwqhguv47Af77fdD7plDYLRomKtI+HokqbC931TfRmh0Zdd6
 jPXGJ6ALDo8DNTnfkzlloD3vK0lYT0GZXfb8MnmCp96mzHy0H5Nuin4YoDa74Y/4WuVB
 YdkRrgQiMJQ0SjHa6Xui9Od1U/1JPY4QXrob5UgxZJzUIh7s6OBYtqjP22U2LnDLooaN
 ecHA==
X-Gm-Message-State: AOJu0Yz50rWdBQksmPC41nYlD5qw2mMRmT0ouhsj5XGkW0BNkucYjtWo
 vspq2gbuZBqOSbxYYiuX/btgGWiBZO7F/einatlaWUZbDPCXTQfHEqB9jar/yLiyaGoDywGlK7D
 0
X-Gm-Gg: ASbGnct4IBQxm5GAcaKLrZRjjTOxGMib07HdnY+eYnjTy1k7PRgh6NxhDKMZKBt93tK
 JmlFqIvAt3Z64l20zJSz/PGtCiRIGTp7oeG+oYTi7okYw5jHgGH43C+aJ0nQYvOBY/EddSWaKXf
 GGwkBwKPXYIxHURx02n/AFWwuu+Pag7mdz1xjUNdzZ6Vvk/gh4/x5tFQvn68QgNBJBCncOKq01p
 TlYdxRj7FX+JjhEkME2DlBtQ3uXLk4qjrwPW6faY0ArjjCx5ooFnvd3hEiKBJiXyiPl0fqto25D
 6dtRTX9CI7ZX6OSRb/bFTVZIAUpprmPCuqsVSFzcnKwZk/TKwZeGGectBJlK+w+xUvSz
X-Google-Smtp-Source: AGHT+IFheFIopdfsJvu2WzZCRBL8EgTiiGHKLbOTPUdfKgk81EPrqafL/xrjtCd/vkhclbRROA2PiQ==
X-Received: by 2002:a17:903:41c3:b0:220:c113:714e with SMTP id
 d9443c01a7336-2210405c6c1mr374985185ad.21.1740070623949; 
 Thu, 20 Feb 2025 08:57:03 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53491b3sm122729435ad.40.2025.02.20.08.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:57:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>,
 Naga Harish K S V <s.v.naga.harish.k@intel.com>
Subject: [PATCH v3 02/14] eventdev: remover unnecessary deref on function
 pointers
Date: Thu, 20 Feb 2025 08:55:16 -0800
Message-ID: <20250220165644.16421-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220165644.16421-1-stephen@networkplumber.org>
References: <20250217185743.169778-1-stephen@networkplumber.org>
 <20250220165644.16421-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The expression *dev_dev_ops->foo and dev->dev_ops->foo are equivalent.
Cleanup the result by removing unneeded parenthesis and make lines
compact.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eventdev/rte_event_crypto_adapter.c |  37 ++----
 lib/eventdev/rte_event_dma_adapter.c    |  16 +--
 lib/eventdev/rte_event_eth_rx_adapter.c |  50 ++++----
 lib/eventdev/rte_eventdev.c             | 164 +++++++++++-------------
 4 files changed, 119 insertions(+), 148 deletions(-)

diff --git a/lib/eventdev/rte_event_crypto_adapter.c b/lib/eventdev/rte_event_crypto_adapter.c
index 939ca1cad9..fc43e056d7 100644
--- a/lib/eventdev/rte_event_crypto_adapter.c
+++ b/lib/eventdev/rte_event_crypto_adapter.c
@@ -1132,7 +1132,7 @@ rte_event_crypto_adapter_queue_pair_add(uint8_t id,
 	     adapter->mode == RTE_EVENT_CRYPTO_ADAPTER_OP_NEW) ||
 	    (cap & RTE_EVENT_CRYPTO_ADAPTER_CAP_INTERNAL_PORT_OP_NEW &&
 	     adapter->mode == RTE_EVENT_CRYPTO_ADAPTER_OP_NEW)) {
-		if (*dev->dev_ops->crypto_adapter_queue_pair_add == NULL)
+		if (dev->dev_ops->crypto_adapter_queue_pair_add == NULL)
 			return -ENOTSUP;
 		if (dev_info->qpairs == NULL) {
 			dev_info->qpairs =
@@ -1144,10 +1144,8 @@ rte_event_crypto_adapter_queue_pair_add(uint8_t id,
 				return -ENOMEM;
 		}
 
-		ret = (*dev->dev_ops->crypto_adapter_queue_pair_add)(dev,
-				dev_info->dev,
-				queue_pair_id,
-				conf);
+		ret = dev->dev_ops->crypto_adapter_queue_pair_add(dev, dev_info->dev,
+								  queue_pair_id, conf);
 		if (ret)
 			return ret;
 
@@ -1233,11 +1231,10 @@ rte_event_crypto_adapter_queue_pair_del(uint8_t id, uint8_t cdev_id,
 	if ((cap & RTE_EVENT_CRYPTO_ADAPTER_CAP_INTERNAL_PORT_OP_FWD) ||
 	    (cap & RTE_EVENT_CRYPTO_ADAPTER_CAP_INTERNAL_PORT_OP_NEW &&
 	     adapter->mode == RTE_EVENT_CRYPTO_ADAPTER_OP_NEW)) {
-		if (*dev->dev_ops->crypto_adapter_queue_pair_del == NULL)
+		if (dev->dev_ops->crypto_adapter_queue_pair_del == NULL)
 			return -ENOTSUP;
-		ret = (*dev->dev_ops->crypto_adapter_queue_pair_del)(dev,
-						dev_info->dev,
-						queue_pair_id);
+		ret = dev->dev_ops->crypto_adapter_queue_pair_del(dev,
+							  dev_info->dev, queue_pair_id);
 		if (ret == 0) {
 			eca_update_qp_info(adapter,
 					&adapter->cdevs[cdev_id],
@@ -1308,10 +1305,8 @@ eca_adapter_ctrl(uint8_t id, int start)
 		dev_info->dev_started = start;
 		if (dev_info->internal_event_port == 0)
 			continue;
-		start ? (*dev->dev_ops->crypto_adapter_start)(dev,
-						&dev_info->dev[i]) :
-			(*dev->dev_ops->crypto_adapter_stop)(dev,
-						&dev_info->dev[i]);
+		start ? dev->dev_ops->crypto_adapter_start(dev, &dev_info->dev[i]) :
+			dev->dev_ops->crypto_adapter_stop(dev, &dev_info->dev[i]);
 	}
 
 	if (use_service)
@@ -1367,11 +1362,9 @@ rte_event_crypto_adapter_stats_get(uint8_t id,
 	for (i = 0; i < rte_cryptodev_count(); i++) {
 		dev_info = &adapter->cdevs[i];
 		if (dev_info->internal_event_port == 0 ||
-			dev->dev_ops->crypto_adapter_stats_get == NULL)
+		    dev->dev_ops->crypto_adapter_stats_get == NULL)
 			continue;
-		ret = (*dev->dev_ops->crypto_adapter_stats_get)(dev,
-						dev_info->dev,
-						&dev_stats);
+		ret = dev->dev_ops->crypto_adapter_stats_get(dev, dev_info->dev, &dev_stats);
 		if (ret)
 			continue;
 
@@ -1418,10 +1411,9 @@ rte_event_crypto_adapter_stats_reset(uint8_t id)
 	for (i = 0; i < rte_cryptodev_count(); i++) {
 		dev_info = &adapter->cdevs[i];
 		if (dev_info->internal_event_port == 0 ||
-			dev->dev_ops->crypto_adapter_stats_reset == NULL)
+		    dev->dev_ops->crypto_adapter_stats_reset == NULL)
 			continue;
-		(*dev->dev_ops->crypto_adapter_stats_reset)(dev,
-						dev_info->dev);
+		dev->dev_ops->crypto_adapter_stats_reset(dev, dev_info->dev);
 	}
 
 	memset(&adapter->crypto_stats, 0, sizeof(adapter->crypto_stats));
@@ -1606,9 +1598,8 @@ rte_event_crypto_adapter_vector_limits_get(
 		return -ENOTSUP;
 	}
 
-	if ((*dev->dev_ops->crypto_adapter_vector_limits_get) == NULL)
+	if (dev->dev_ops->crypto_adapter_vector_limits_get == NULL)
 		return -ENOTSUP;
 
-	return dev->dev_ops->crypto_adapter_vector_limits_get(
-		dev, cdev, limits);
+	return dev->dev_ops->crypto_adapter_vector_limits_get(dev, cdev, limits);
 }
diff --git a/lib/eventdev/rte_event_dma_adapter.c b/lib/eventdev/rte_event_dma_adapter.c
index 165374d195..d9a02a30f2 100644
--- a/lib/eventdev/rte_event_dma_adapter.c
+++ b/lib/eventdev/rte_event_dma_adapter.c
@@ -1030,7 +1030,7 @@ rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dma_dev_id, uint16_t vchan,
 	     adapter->mode == RTE_EVENT_DMA_ADAPTER_OP_NEW) ||
 	    (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_NEW &&
 	     adapter->mode == RTE_EVENT_DMA_ADAPTER_OP_NEW)) {
-		if (*dev->dev_ops->dma_adapter_vchan_add == NULL)
+		if (dev->dev_ops->dma_adapter_vchan_add == NULL)
 			return -ENOTSUP;
 		if (dev_info->vchanq == NULL) {
 			dev_info->vchanq = rte_zmalloc_socket(adapter->mem_name,
@@ -1054,7 +1054,7 @@ rte_event_dma_adapter_vchan_add(uint8_t id, int16_t dma_dev_id, uint16_t vchan,
 			}
 		}
 
-		ret = (*dev->dev_ops->dma_adapter_vchan_add)(dev, dma_dev_id, vchan, event);
+		ret = dev->dev_ops->dma_adapter_vchan_add(dev, dma_dev_id, vchan, event);
 		if (ret)
 			return ret;
 
@@ -1132,9 +1132,9 @@ rte_event_dma_adapter_vchan_del(uint8_t id, int16_t dma_dev_id, uint16_t vchan)
 	if ((cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_FWD) ||
 	    (cap & RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_NEW &&
 	     adapter->mode == RTE_EVENT_DMA_ADAPTER_OP_NEW)) {
-		if (*dev->dev_ops->dma_adapter_vchan_del == NULL)
+		if (dev->dev_ops->dma_adapter_vchan_del == NULL)
 			return -ENOTSUP;
-		ret = (*dev->dev_ops->dma_adapter_vchan_del)(dev, dma_dev_id, vchan);
+		ret = dev->dev_ops->dma_adapter_vchan_del(dev, dma_dev_id, vchan);
 		if (ret == 0) {
 			edma_update_vchanq_info(adapter, dev_info, vchan, 0);
 			if (dev_info->num_vchanq == 0) {
@@ -1212,8 +1212,8 @@ edma_adapter_ctrl(uint8_t id, int start)
 		dev_info->dev_started = start;
 		if (dev_info->internal_event_port == 0)
 			continue;
-		start ? (*dev->dev_ops->dma_adapter_start)(dev, i) :
-			(*dev->dev_ops->dma_adapter_stop)(dev, i);
+		start ? dev->dev_ops->dma_adapter_start(dev, i) :
+			dev->dev_ops->dma_adapter_stop(dev, i);
 	}
 
 	if (use_service)
@@ -1363,7 +1363,7 @@ rte_event_dma_adapter_stats_get(uint8_t id, struct rte_event_dma_adapter_stats *
 		    dev->dev_ops->dma_adapter_stats_get == NULL)
 			continue;
 
-		ret = (*dev->dev_ops->dma_adapter_stats_get)(dev, i, &dev_stats);
+		ret = dev->dev_ops->dma_adapter_stats_get(dev, i, &dev_stats);
 		if (ret)
 			continue;
 
@@ -1404,7 +1404,7 @@ rte_event_dma_adapter_stats_reset(uint8_t id)
 		    dev->dev_ops->dma_adapter_stats_reset == NULL)
 			continue;
 
-		(*dev->dev_ops->dma_adapter_stats_reset)(dev, i);
+		dev->dev_ops->dma_adapter_stats_reset(dev, i);
 	}
 
 	memset(&adapter->dma_stats, 0, sizeof(adapter->dma_stats));
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index 39674c4604..669788430b 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -2362,10 +2362,8 @@ rxa_ctrl(uint8_t id, int start)
 		dev_info->dev_rx_started = start;
 		if (dev_info->internal_event_port == 0)
 			continue;
-		start ? (*dev->dev_ops->eth_rx_adapter_start)(dev,
-						&rte_eth_devices[i]) :
-			(*dev->dev_ops->eth_rx_adapter_stop)(dev,
-						&rte_eth_devices[i]);
+		start ? dev->dev_ops->eth_rx_adapter_start(dev, &rte_eth_devices[i]) :
+			dev->dev_ops->eth_rx_adapter_stop(dev, &rte_eth_devices[i]);
 	}
 
 	if (use_service) {
@@ -2749,7 +2747,7 @@ rte_event_eth_rx_adapter_queue_add(uint8_t id,
 	dev_info = &rx_adapter->eth_devices[eth_dev_id];
 
 	if (cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT) {
-		if (*dev->dev_ops->eth_rx_adapter_queue_add == NULL)
+		if (dev->dev_ops->eth_rx_adapter_queue_add == NULL)
 			return -ENOTSUP;
 		if (dev_info->rx_queue == NULL) {
 			dev_info->rx_queue =
@@ -2761,9 +2759,8 @@ rte_event_eth_rx_adapter_queue_add(uint8_t id,
 				return -ENOMEM;
 		}
 
-		ret = (*dev->dev_ops->eth_rx_adapter_queue_add)(dev,
-				&rte_eth_devices[eth_dev_id],
-				rx_queue_id, queue_conf);
+		ret = dev->dev_ops->eth_rx_adapter_queue_add(dev, &rte_eth_devices[eth_dev_id],
+							     rx_queue_id, queue_conf);
 		if (ret == 0) {
 			dev_info->internal_event_port = 1;
 			rxa_update_queue(rx_adapter,
@@ -2847,11 +2844,10 @@ rte_event_eth_rx_adapter_queue_del(uint8_t id, uint16_t eth_dev_id,
 	dev_info = &rx_adapter->eth_devices[eth_dev_id];
 
 	if (cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT) {
-		if (*dev->dev_ops->eth_rx_adapter_queue_del == NULL)
+		if (dev->dev_ops->eth_rx_adapter_queue_del == NULL)
 			return -ENOTSUP;
-		ret = (*dev->dev_ops->eth_rx_adapter_queue_del)(dev,
-						&rte_eth_devices[eth_dev_id],
-						rx_queue_id);
+		ret = dev->dev_ops->eth_rx_adapter_queue_del(dev, &rte_eth_devices[eth_dev_id],
+							     rx_queue_id);
 		if (ret == 0) {
 			rxa_update_queue(rx_adapter,
 					&rx_adapter->eth_devices[eth_dev_id],
@@ -2959,10 +2955,11 @@ rte_event_eth_rx_adapter_vector_limits_get(
 	}
 
 	if (cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT) {
-		if (*dev->dev_ops->eth_rx_adapter_vector_limits_get == NULL)
+		if (dev->dev_ops->eth_rx_adapter_vector_limits_get == NULL)
 			return -ENOTSUP;
-		ret = dev->dev_ops->eth_rx_adapter_vector_limits_get(
-			dev, &rte_eth_devices[eth_port_id], limits);
+		ret = dev->dev_ops->eth_rx_adapter_vector_limits_get(dev,
+								     &rte_eth_devices[eth_port_id],
+								     limits);
 	} else {
 		ret = rxa_sw_vector_limits(limits);
 	}
@@ -3051,11 +3048,10 @@ rte_event_eth_rx_adapter_stats_get(uint8_t id,
 		}
 
 		if (dev_info->internal_event_port == 0 ||
-			dev->dev_ops->eth_rx_adapter_stats_get == NULL)
+		    dev->dev_ops->eth_rx_adapter_stats_get == NULL)
 			continue;
-		ret = (*dev->dev_ops->eth_rx_adapter_stats_get)(dev,
-						&rte_eth_devices[i],
-						&dev_stats);
+		ret = dev->dev_ops->eth_rx_adapter_stats_get(dev, &rte_eth_devices[i],
+							     &dev_stats);
 		if (ret)
 			continue;
 		dev_stats_sum.rx_packets += dev_stats.rx_packets;
@@ -3127,7 +3123,7 @@ rte_event_eth_rx_adapter_queue_stats_get(uint8_t id,
 
 	dev = &rte_eventdevs[rx_adapter->eventdev_id];
 	if (dev->dev_ops->eth_rx_adapter_queue_stats_get != NULL) {
-		return (*dev->dev_ops->eth_rx_adapter_queue_stats_get)(dev,
+		return dev->dev_ops->eth_rx_adapter_queue_stats_get(dev,
 						&rte_eth_devices[eth_dev_id],
 						rx_queue_id, stats);
 	}
@@ -3172,10 +3168,9 @@ rte_event_eth_rx_adapter_stats_reset(uint8_t id)
 		}
 
 		if (dev_info->internal_event_port == 0 ||
-			dev->dev_ops->eth_rx_adapter_stats_reset == NULL)
+		    dev->dev_ops->eth_rx_adapter_stats_reset == NULL)
 			continue;
-		(*dev->dev_ops->eth_rx_adapter_stats_reset)(dev,
-							&rte_eth_devices[i]);
+		dev->dev_ops->eth_rx_adapter_stats_reset(dev, &rte_eth_devices[i]);
 	}
 
 	memset(&rx_adapter->stats, 0, sizeof(rx_adapter->stats));
@@ -3229,7 +3224,7 @@ rte_event_eth_rx_adapter_queue_stats_reset(uint8_t id,
 
 	dev = &rte_eventdevs[rx_adapter->eventdev_id];
 	if (dev->dev_ops->eth_rx_adapter_queue_stats_reset != NULL) {
-		return (*dev->dev_ops->eth_rx_adapter_queue_stats_reset)(dev,
+		return dev->dev_ops->eth_rx_adapter_queue_stats_reset(dev,
 						&rte_eth_devices[eth_dev_id],
 						rx_queue_id);
 	}
@@ -3396,10 +3391,9 @@ rte_event_eth_rx_adapter_queue_conf_get(uint8_t id,
 
 	dev = &rte_eventdevs[rx_adapter->eventdev_id];
 	if (dev->dev_ops->eth_rx_adapter_queue_conf_get != NULL) {
-		ret = (*dev->dev_ops->eth_rx_adapter_queue_conf_get)(dev,
-						&rte_eth_devices[eth_dev_id],
-						rx_queue_id,
-						queue_conf);
+		ret = dev->dev_ops->eth_rx_adapter_queue_conf_get(dev,
+								  &rte_eth_devices[eth_dev_id],
+								  rx_queue_id, queue_conf);
 		return ret;
 	}
 
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index 1078e0bcee..43cd95d765 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -100,9 +100,9 @@ rte_event_dev_info_get(uint8_t dev_id, struct rte_event_dev_info *dev_info)
 
 	memset(dev_info, 0, sizeof(struct rte_event_dev_info));
 
-	if (*dev->dev_ops->dev_infos_get == NULL)
+	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
-	(*dev->dev_ops->dev_infos_get)(dev, dev_info);
+	dev->dev_ops->dev_infos_get(dev, dev_info);
 
 	dev_info->dequeue_timeout_ns = dev->data->dev_conf.dequeue_timeout_ns;
 
@@ -137,10 +137,8 @@ rte_event_eth_rx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 		*caps = 0;
 
 	return dev->dev_ops->eth_rx_adapter_caps_get ?
-				(*dev->dev_ops->eth_rx_adapter_caps_get)(dev,
-						&rte_eth_devices[eth_port_id],
-						caps)
-				: 0;
+		dev->dev_ops->eth_rx_adapter_caps_get(dev, &rte_eth_devices[eth_port_id], caps)
+		: 0;
 }
 
 int
@@ -164,11 +162,8 @@ rte_event_timer_adapter_caps_get(uint8_t dev_id, uint32_t *caps)
 		*caps = 0;
 
 	return dev->dev_ops->timer_adapter_caps_get ?
-				(*dev->dev_ops->timer_adapter_caps_get)(dev,
-									0,
-									caps,
-									&ops)
-				: 0;
+		dev->dev_ops->timer_adapter_caps_get(dev, 0, caps, &ops)
+		: 0;
 }
 
 int
@@ -196,8 +191,7 @@ rte_event_crypto_adapter_caps_get(uint8_t dev_id, uint8_t cdev_id,
 		*caps = 0;
 
 	return dev->dev_ops->crypto_adapter_caps_get ?
-		(*dev->dev_ops->crypto_adapter_caps_get)
-		(dev, cdev, caps) : 0;
+		dev->dev_ops->crypto_adapter_caps_get(dev, cdev, caps) : 0;
 }
 
 int
@@ -224,10 +218,8 @@ rte_event_eth_tx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 		*caps = 0;
 
 	return dev->dev_ops->eth_tx_adapter_caps_get ?
-			(*dev->dev_ops->eth_tx_adapter_caps_get)(dev,
-								eth_dev,
-								caps)
-			: 0;
+		dev->dev_ops->eth_tx_adapter_caps_get(dev, eth_dev, caps)
+		: 0;
 }
 
 int
@@ -247,7 +239,7 @@ rte_event_dma_adapter_caps_get(uint8_t dev_id, uint8_t dma_dev_id, uint32_t *cap
 	*caps = 0;
 
 	if (dev->dev_ops->dma_adapter_caps_get)
-		return (*dev->dev_ops->dma_adapter_caps_get)(dev, dma_dev_id, caps);
+		return dev->dev_ops->dma_adapter_caps_get(dev, dma_dev_id, caps);
 
 	return 0;
 }
@@ -264,11 +256,11 @@ event_dev_queue_config(struct rte_eventdev *dev, uint8_t nb_queues)
 
 	if (nb_queues != 0) {
 		queues_cfg = dev->data->queues_cfg;
-		if (*dev->dev_ops->queue_release == NULL)
+		if (dev->dev_ops->queue_release == NULL)
 			return -ENOTSUP;
 
 		for (i = nb_queues; i < old_nb_queues; i++)
-			(*dev->dev_ops->queue_release)(dev, i);
+			dev->dev_ops->queue_release(dev, i);
 
 
 		if (nb_queues > old_nb_queues) {
@@ -278,11 +270,11 @@ event_dev_queue_config(struct rte_eventdev *dev, uint8_t nb_queues)
 				sizeof(queues_cfg[0]) * new_qs);
 		}
 	} else {
-		if (*dev->dev_ops->queue_release == NULL)
+		if (dev->dev_ops->queue_release == NULL)
 			return -ENOTSUP;
 
 		for (i = nb_queues; i < old_nb_queues; i++)
-			(*dev->dev_ops->queue_release)(dev, i);
+			dev->dev_ops->queue_release(dev, i);
 	}
 
 	dev->data->nb_queues = nb_queues;
@@ -304,14 +296,14 @@ event_dev_port_config(struct rte_eventdev *dev, uint8_t nb_ports)
 			 dev->data->dev_id);
 
 	if (nb_ports != 0) { /* re-config */
-		if (*dev->dev_ops->port_release == NULL)
+		if (dev->dev_ops->port_release == NULL)
 			return -ENOTSUP;
 
 		ports = dev->data->ports;
 		ports_cfg = dev->data->ports_cfg;
 
 		for (i = nb_ports; i < old_nb_ports; i++)
-			(*dev->dev_ops->port_release)(ports[i]);
+			(dev->dev_ops->port_release)(ports[i]);
 
 		if (nb_ports > old_nb_ports) {
 			uint8_t new_ps = nb_ports - old_nb_ports;
@@ -331,12 +323,12 @@ event_dev_port_config(struct rte_eventdev *dev, uint8_t nb_ports)
 			}
 		}
 	} else {
-		if (*dev->dev_ops->port_release == NULL)
+		if (dev->dev_ops->port_release == NULL)
 			return -ENOTSUP;
 
 		ports = dev->data->ports;
 		for (i = nb_ports; i < old_nb_ports; i++) {
-			(*dev->dev_ops->port_release)(ports[i]);
+			(dev->dev_ops->port_release)(ports[i]);
 			ports[i] = NULL;
 		}
 	}
@@ -356,9 +348,9 @@ rte_event_dev_configure(uint8_t dev_id,
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_eventdevs[dev_id];
 
-	if (*dev->dev_ops->dev_infos_get == NULL)
+	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
-	if (*dev->dev_ops->dev_configure == NULL)
+	if (dev->dev_ops->dev_configure == NULL)
 		return -ENOTSUP;
 
 	if (dev->data->dev_started) {
@@ -370,7 +362,7 @@ rte_event_dev_configure(uint8_t dev_id,
 	if (dev_conf == NULL)
 		return -EINVAL;
 
-	(*dev->dev_ops->dev_infos_get)(dev, &info);
+	dev->dev_ops->dev_infos_get(dev, &info);
 
 	/* Check dequeue_timeout_ns value is in limit */
 	if (!(dev_conf->event_dev_cfg & RTE_EVENT_DEV_CFG_PER_DEQUEUE_TIMEOUT)) {
@@ -524,7 +516,7 @@ rte_event_dev_configure(uint8_t dev_id,
 	event_dev_fp_ops_reset(rte_event_fp_ops + dev_id);
 
 	/* Configure the device */
-	diag = (*dev->dev_ops->dev_configure)(dev);
+	diag = (dev->dev_ops->dev_configure)(dev);
 	if (diag != 0) {
 		RTE_EDEV_LOG_ERR("dev%d dev_configure = %d", dev_id, diag);
 		event_dev_fp_ops_reset(rte_event_fp_ops + dev_id);
@@ -564,10 +556,10 @@ rte_event_queue_default_conf_get(uint8_t dev_id, uint8_t queue_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->queue_def_conf == NULL)
+	if (dev->dev_ops->queue_def_conf == NULL)
 		return -ENOTSUP;
 	memset(queue_conf, 0, sizeof(struct rte_event_queue_conf));
-	(*dev->dev_ops->queue_def_conf)(dev, queue_id, queue_conf);
+	dev->dev_ops->queue_def_conf(dev, queue_id, queue_conf);
 
 	rte_eventdev_trace_queue_default_conf_get(dev_id, dev, queue_id, queue_conf);
 
@@ -654,19 +646,19 @@ rte_event_queue_setup(uint8_t dev_id, uint8_t queue_id,
 		return -EBUSY;
 	}
 
-	if (*dev->dev_ops->queue_setup == NULL)
+	if (dev->dev_ops->queue_setup == NULL)
 		return -ENOTSUP;
 
 	if (queue_conf == NULL) {
-		if (*dev->dev_ops->queue_def_conf == NULL)
+		if (dev->dev_ops->queue_def_conf == NULL)
 			return -ENOTSUP;
-		(*dev->dev_ops->queue_def_conf)(dev, queue_id, &def_conf);
+		dev->dev_ops->queue_def_conf(dev, queue_id, &def_conf);
 		queue_conf = &def_conf;
 	}
 
 	dev->data->queues_cfg[queue_id] = *queue_conf;
 	rte_eventdev_trace_queue_setup(dev_id, queue_id, queue_conf);
-	return (*dev->dev_ops->queue_setup)(dev, queue_id, queue_conf);
+	return dev->dev_ops->queue_setup(dev, queue_id, queue_conf);
 }
 
 static inline int
@@ -695,10 +687,10 @@ rte_event_port_default_conf_get(uint8_t dev_id, uint8_t port_id,
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->port_def_conf == NULL)
+	if (dev->dev_ops->port_def_conf == NULL)
 		return -ENOTSUP;
 	memset(port_conf, 0, sizeof(struct rte_event_port_conf));
-	(*dev->dev_ops->port_def_conf)(dev, port_id, port_conf);
+	dev->dev_ops->port_def_conf(dev, port_id, port_conf);
 
 	rte_eventdev_trace_port_default_conf_get(dev_id, dev, port_id, port_conf);
 
@@ -770,19 +762,19 @@ rte_event_port_setup(uint8_t dev_id, uint8_t port_id,
 		return -EBUSY;
 	}
 
-	if (*dev->dev_ops->port_setup == NULL)
+	if (dev->dev_ops->port_setup == NULL)
 		return -ENOTSUP;
 
 	if (port_conf == NULL) {
-		if (*dev->dev_ops->port_def_conf == NULL)
+		if (dev->dev_ops->port_def_conf == NULL)
 			return -ENOTSUP;
-		(*dev->dev_ops->port_def_conf)(dev, port_id, &def_conf);
+		dev->dev_ops->port_def_conf(dev, port_id, &def_conf);
 		port_conf = &def_conf;
 	}
 
 	dev->data->ports_cfg[port_id] = *port_conf;
 
-	diag = (*dev->dev_ops->port_setup)(dev, port_id, port_conf);
+	diag = dev->dev_ops->port_setup(dev, port_id, port_conf);
 
 	/* Unlink all the queues from this port(default state after setup) */
 	if (!diag)
@@ -812,8 +804,7 @@ rte_event_port_quiesce(uint8_t dev_id, uint8_t port_id,
 	}
 
 	if (dev->dev_ops->port_quiesce)
-		(*dev->dev_ops->port_quiesce)(dev, dev->data->ports[port_id],
-					      release_cb, args);
+		dev->dev_ops->port_quiesce(dev, dev->data->ports[port_id], release_cb, args);
 }
 
 int
@@ -979,10 +970,9 @@ rte_event_queue_attr_set(uint8_t dev_id, uint8_t queue_id, uint32_t attr_id,
 		return -ENOTSUP;
 	}
 
-	if (*dev->dev_ops->queue_attr_set == NULL)
+	if (dev->dev_ops->queue_attr_set == NULL)
 		return -ENOTSUP;
-	return (*dev->dev_ops->queue_attr_set)(dev, queue_id, attr_id,
-					       attr_value);
+	return dev->dev_ops->queue_attr_set(dev, queue_id, attr_id, attr_value);
 }
 
 int
@@ -1007,23 +997,23 @@ rte_event_port_profile_links_set(uint8_t dev_id, uint8_t port_id, const uint8_t
 	RTE_EVENTDEV_VALID_DEVID_OR_ERRNO_RET(dev_id, EINVAL, 0);
 	dev = &rte_eventdevs[dev_id];
 
-	if (*dev->dev_ops->dev_infos_get == NULL)
+	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
 
-	(*dev->dev_ops->dev_infos_get)(dev, &info);
+	dev->dev_ops->dev_infos_get(dev, &info);
 	if (profile_id >= RTE_EVENT_MAX_PROFILES_PER_PORT ||
 	    profile_id >= info.max_profiles_per_port) {
 		RTE_EDEV_LOG_ERR("Invalid profile_id=%" PRIu8, profile_id);
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->port_link == NULL) {
+	if (dev->dev_ops->port_link == NULL) {
 		RTE_EDEV_LOG_ERR("Function not supported");
 		rte_errno = ENOTSUP;
 		return 0;
 	}
 
-	if (profile_id && *dev->dev_ops->port_link_profile == NULL) {
+	if (profile_id && dev->dev_ops->port_link_profile == NULL) {
 		RTE_EDEV_LOG_ERR("Function not supported");
 		rte_errno = ENOTSUP;
 		return 0;
@@ -1057,11 +1047,11 @@ rte_event_port_profile_links_set(uint8_t dev_id, uint8_t port_id, const uint8_t
 		}
 
 	if (profile_id)
-		diag = (*dev->dev_ops->port_link_profile)(dev, dev->data->ports[port_id], queues,
-							  priorities, nb_links, profile_id);
+		diag = dev->dev_ops->port_link_profile(dev, dev->data->ports[port_id], queues,
+						       priorities, nb_links, profile_id);
 	else
-		diag = (*dev->dev_ops->port_link)(dev, dev->data->ports[port_id], queues,
-						  priorities, nb_links);
+		diag = dev->dev_ops->port_link(dev, dev->data->ports[port_id], queues,
+					       priorities, nb_links);
 	if (diag < 0)
 		return diag;
 
@@ -1095,23 +1085,23 @@ rte_event_port_profile_unlink(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 	RTE_EVENTDEV_VALID_DEVID_OR_ERRNO_RET(dev_id, EINVAL, 0);
 	dev = &rte_eventdevs[dev_id];
 
-	if (*dev->dev_ops->dev_infos_get == NULL)
+	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
 
-	(*dev->dev_ops->dev_infos_get)(dev, &info);
+	dev->dev_ops->dev_infos_get(dev, &info);
 	if (profile_id >= RTE_EVENT_MAX_PROFILES_PER_PORT ||
 	    profile_id >= info.max_profiles_per_port) {
 		RTE_EDEV_LOG_ERR("Invalid profile_id=%" PRIu8, profile_id);
 		return -EINVAL;
 	}
 
-	if (*dev->dev_ops->port_unlink == NULL) {
+	if (dev->dev_ops->port_unlink == NULL) {
 		RTE_EDEV_LOG_ERR("Function not supported");
 		rte_errno = ENOTSUP;
 		return 0;
 	}
 
-	if (profile_id && *dev->dev_ops->port_unlink_profile == NULL) {
+	if (profile_id && dev->dev_ops->port_unlink_profile == NULL) {
 		RTE_EDEV_LOG_ERR("Function not supported");
 		rte_errno = ENOTSUP;
 		return 0;
@@ -1153,11 +1143,11 @@ rte_event_port_profile_unlink(uint8_t dev_id, uint8_t port_id, uint8_t queues[],
 		}
 
 	if (profile_id)
-		diag = (*dev->dev_ops->port_unlink_profile)(dev, dev->data->ports[port_id], queues,
-							    nb_unlinks, profile_id);
+		diag = dev->dev_ops->port_unlink_profile(dev, dev->data->ports[port_id], queues,
+							 nb_unlinks, profile_id);
 	else
-		diag = (*dev->dev_ops->port_unlink)(dev, dev->data->ports[port_id], queues,
-						    nb_unlinks);
+		diag = dev->dev_ops->port_unlink(dev, dev->data->ports[port_id], queues,
+						 nb_unlinks);
 	if (diag < 0)
 		return diag;
 
@@ -1186,11 +1176,10 @@ rte_event_port_unlinks_in_progress(uint8_t dev_id, uint8_t port_id)
 	 * This allows PMDs which handle unlink synchronously to not implement
 	 * this function at all.
 	 */
-	if (*dev->dev_ops->port_unlinks_in_progress == NULL)
+	if (dev->dev_ops->port_unlinks_in_progress == NULL)
 		return 0;
 
-	return (*dev->dev_ops->port_unlinks_in_progress)(dev,
-			dev->data->ports[port_id]);
+	return dev->dev_ops->port_unlinks_in_progress(dev, dev->data->ports[port_id]);
 }
 
 int
@@ -1237,10 +1226,10 @@ rte_event_port_profile_links_get(uint8_t dev_id, uint8_t port_id, uint8_t queues
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 
 	dev = &rte_eventdevs[dev_id];
-	if (*dev->dev_ops->dev_infos_get == NULL)
+	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
 
-	(*dev->dev_ops->dev_infos_get)(dev, &info);
+	dev->dev_ops->dev_infos_get(dev, &info);
 	if (profile_id >= RTE_EVENT_MAX_PROFILES_PER_PORT ||
 	    profile_id >= info.max_profiles_per_port) {
 		RTE_EDEV_LOG_ERR("Invalid profile_id=%" PRIu8, profile_id);
@@ -1278,13 +1267,13 @@ rte_event_dequeue_timeout_ticks(uint8_t dev_id, uint64_t ns,
 
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_eventdevs[dev_id];
-	if (*dev->dev_ops->timeout_ticks == NULL)
+	if (dev->dev_ops->timeout_ticks == NULL)
 		return -ENOTSUP;
 
 	if (timeout_ticks == NULL)
 		return -EINVAL;
 
-	return (*dev->dev_ops->timeout_ticks)(dev, ns, timeout_ticks);
+	return dev->dev_ops->timeout_ticks(dev, ns, timeout_ticks);
 }
 
 int
@@ -1313,12 +1302,12 @@ rte_event_dev_dump(uint8_t dev_id, FILE *f)
 
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_eventdevs[dev_id];
-	if (*dev->dev_ops->dump == NULL)
+	if (dev->dev_ops->dump == NULL)
 		return -ENOTSUP;
 	if (f == NULL)
 		return -EINVAL;
 
-	(*dev->dev_ops->dump)(dev, f);
+	dev->dev_ops->dump(dev, f);
 	return 0;
 
 }
@@ -1329,9 +1318,7 @@ xstats_get_count(uint8_t dev_id, enum rte_event_dev_xstats_mode mode,
 {
 	struct rte_eventdev *dev = &rte_eventdevs[dev_id];
 	if (dev->dev_ops->xstats_get_names != NULL)
-		return (*dev->dev_ops->xstats_get_names)(dev, mode,
-							queue_port_id,
-							NULL, NULL, 0);
+		return dev->dev_ops->xstats_get_names(dev, mode, queue_port_id, NULL, NULL, 0);
 	return 0;
 }
 
@@ -1352,8 +1339,8 @@ rte_event_dev_xstats_names_get(uint8_t dev_id,
 	const struct rte_eventdev *dev = &rte_eventdevs[dev_id];
 
 	if (dev->dev_ops->xstats_get_names != NULL)
-		return (*dev->dev_ops->xstats_get_names)(dev, mode,
-				queue_port_id, xstats_names, ids, size);
+		return dev->dev_ops->xstats_get_names(dev, mode, queue_port_id,
+						      xstats_names, ids, size);
 
 	return -ENOTSUP;
 }
@@ -1369,8 +1356,8 @@ rte_event_dev_xstats_get(uint8_t dev_id, enum rte_event_dev_xstats_mode mode,
 
 	/* implemented by the driver */
 	if (dev->dev_ops->xstats_get != NULL)
-		return (*dev->dev_ops->xstats_get)(dev, mode, queue_port_id,
-				ids, values, n);
+		return dev->dev_ops->xstats_get(dev, mode, queue_port_id,
+						ids, values, n);
 	return -ENOTSUP;
 }
 
@@ -1389,7 +1376,7 @@ rte_event_dev_xstats_by_name_get(uint8_t dev_id, const char *name,
 
 	/* implemented by driver */
 	if (dev->dev_ops->xstats_get_by_name != NULL)
-		return (*dev->dev_ops->xstats_get_by_name)(dev, name, id);
+		return dev->dev_ops->xstats_get_by_name(dev, name, id);
 	return -ENOTSUP;
 }
 
@@ -1401,8 +1388,7 @@ int rte_event_dev_xstats_reset(uint8_t dev_id,
 	struct rte_eventdev *dev = &rte_eventdevs[dev_id];
 
 	if (dev->dev_ops->xstats_reset != NULL)
-		return (*dev->dev_ops->xstats_reset)(dev, mode, queue_port_id,
-							ids, nb_ids);
+		return dev->dev_ops->xstats_reset(dev, mode, queue_port_id, ids, nb_ids);
 	return -ENOTSUP;
 }
 
@@ -1423,7 +1409,7 @@ int rte_event_dev_selftest(uint8_t dev_id)
 			rte_mbuf_dynfield_register(&test_seqn_dynfield_desc);
 		if (rte_event_pmd_selftest_seqn_dynfield_offset < 0)
 			return -ENOMEM;
-		return (*dev->dev_ops->dev_selftest)();
+		return dev->dev_ops->dev_selftest();
 	}
 	return -ENOTSUP;
 }
@@ -1483,7 +1469,7 @@ rte_event_dev_start(uint8_t dev_id)
 
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_eventdevs[dev_id];
-	if (*dev->dev_ops->dev_start == NULL)
+	if (dev->dev_ops->dev_start == NULL)
 		return -ENOTSUP;
 
 	if (dev->data->dev_started != 0) {
@@ -1492,7 +1478,7 @@ rte_event_dev_start(uint8_t dev_id)
 		return 0;
 	}
 
-	diag = (*dev->dev_ops->dev_start)(dev);
+	diag = (dev->dev_ops->dev_start)(dev);
 	rte_eventdev_trace_start(dev_id, diag);
 	if (diag == 0)
 		dev->data->dev_started = 1;
@@ -1533,7 +1519,7 @@ rte_event_dev_stop(uint8_t dev_id)
 
 	RTE_EVENTDEV_VALID_DEVID_OR_RET(dev_id);
 	dev = &rte_eventdevs[dev_id];
-	if (*dev->dev_ops->dev_stop == NULL)
+	if (dev->dev_ops->dev_stop == NULL)
 		return;
 
 	if (dev->data->dev_started == 0) {
@@ -1543,7 +1529,7 @@ rte_event_dev_stop(uint8_t dev_id)
 	}
 
 	dev->data->dev_started = 0;
-	(*dev->dev_ops->dev_stop)(dev);
+	dev->dev_ops->dev_stop(dev);
 	rte_eventdev_trace_stop(dev_id);
 	event_dev_fp_ops_reset(rte_event_fp_ops + dev_id);
 }
@@ -1555,7 +1541,7 @@ rte_event_dev_close(uint8_t dev_id)
 
 	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
 	dev = &rte_eventdevs[dev_id];
-	if (*dev->dev_ops->dev_close == NULL)
+	if (dev->dev_ops->dev_close == NULL)
 		return -ENOTSUP;
 
 	/* Device must be stopped before it can be closed */
@@ -1567,7 +1553,7 @@ rte_event_dev_close(uint8_t dev_id)
 
 	event_dev_fp_ops_reset(rte_event_fp_ops + dev_id);
 	rte_eventdev_trace_close(dev_id);
-	return (*dev->dev_ops->dev_close)(dev);
+	return dev->dev_ops->dev_close(dev);
 }
 
 static inline int
-- 
2.47.2

