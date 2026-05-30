Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA2BCD6E49
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 16:12:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07ECD4067B;
	Sat, 30 May 2026 18:12:06 +0200 (CEST)
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by mails.dpdk.org (Postfix) with ESMTP id 317874028C
 for <dev@dpdk.org>; Sat, 30 May 2026 18:12:02 +0200 (CEST)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-13621cca8f5so5429787c88.0
 for <dev@dpdk.org>; Sat, 30 May 2026 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780157521;
 x=1780762321; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vYavwhfg7wVQQVrr5nj4nWkWf6KaNmhmP62WK+YtgU=;
 b=ac9vvsUtzVeCNz4uiLNdzRP7vBpbATouF9JoSbO3ZcxTqdldykoLzTi81yOtJ04g6u
 SERJypTe5qDBF25dm6WlN32rG15q75UGS96O7rRBVRrndar2AdZFIFtzz4ETQMYUV1D6
 zA3edWMGJitcmRiGPnie9oJZ/S4FO8NNp+wngSfO1GXuA0hP2CTzRmh3XdcevX1EgSX7
 UmOY1+9YeLRA2QYJ/ZkxlbKLIzt/iRWPi1HOHUNuR6Jm3wLVNmQNb9GIJ3vFTmq6l1HU
 g/vZvOrc+zWEJMfgTFdat6nDt+y9zVApElgBhKq7q9m/p+q2eD76YHq+RrceL/MaHNBO
 Vogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780157521; x=1780762321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1vYavwhfg7wVQQVrr5nj4nWkWf6KaNmhmP62WK+YtgU=;
 b=kM1d+MA4CVzoG+gM+Ial4K+TSsfmIdW3vHWG1ZhsCe/ncOzxecruiecZiMv0/m3FLQ
 zcwTzy0bmLAvgUHR1sKlZG8mHdF620oxAMWSAe9pUFfxTWH1Rz7mmMP1WriShLsb4PF1
 MZOh33JyvVuyf1KubveLaqHXAcPh6VZXo9Axwm4QQgN4g+1PH9ReHZfcKq/82F/kzuPe
 qT6f2r00ArFi/SKhgmBViGY4eL+nD5fx5cSlCao2IiMxZ/gcSBzQLVpayCB8QVHRvTYy
 5PHRJ/U9DcJ7DB31L6E1hHUucJJ1F/5XExtxTMLBbARLFo1v2pMW9oA7IfsbykTAwJDM
 uMHg==
X-Gm-Message-State: AOJu0YybGq4b70GpeXIYwXiCEUKjIJpM5E+cy1EF2XUnb/X6nDBYGhGN
 910ziMyXvXvAiaUUYQVfneqCPuCtXCIadlg+lTMTIizuE1lquwJKQo5PxW+8/Tpi1qOd/ryyOGb
 zv9yh
X-Gm-Gg: Acq92OHmP2Yc7ZSAYqPVNlvayHmzE9Imnd+HbvqLp3SG/ZP2kqhbuuxGGNNaufOvPW/
 Cy6EhDGzzXfAyuJQjATZ8Gj4OfIWIMCoLb4UUnrAwidVnyE3PvvvS62Eaqks9/QLMXkGGQwUiH6
 AcoktN9yjYFcyz6dvunJCKC0b6Vqc2sMGfKZF0FXQ8RGRV7DnI7WRi5wrbM8bEWr9NfQW0auJtq
 a105T+Jw7t3jIC/X9QLNhTL3xYO8brpeqV+hxg0CRJdDIBh5G9I58+kG3q68m+v3zw7CVojFKZT
 3yZKaNmRMMbBGNMYbmXopbVYJERr4aIDNR+WEgEcgOYMnnj2Vaq++xYF4IGHX2ZBQylbefaewSP
 rTe7jv8EB+4boMeHYZS/cEmGclpRhAYQcEfENYjp4MNk5BrhttfKWnKIYU3rXM47n1f0JruQ42H
 K1FbSIZrsji6wIDE72Dh+i7lhCRs1DIi/ohILaguNh6lqf6YCDV3YRzrUu/zowp20ComQuPSfu
X-Received: by 2002:a05:7022:421:b0:136:d421:9efa with SMTP id
 a92af1059eb24-137d425e193mr1918432c88.32.1780157521326; 
 Sat, 30 May 2026 09:12:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69bdfsm3305616c88.9.2026.05.30.09.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 09:12:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC 7/7] ethdev: remove support for queue stats mapping
Date: Sat, 30 May 2026 09:10:02 -0700
Message-ID: <20260530161151.873199-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530161151.873199-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
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

The support for queue stats mapping has since 25.11 release
by commit 2863cbd9ee6d ("ethdev: deprecate queue stats mapping functions")

This patch completes final removal from ethdev and documentation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features.rst         |  7 ----
 doc/guides/rel_notes/deprecation.rst |  6 ---
 lib/ethdev/ethdev_driver.h           | 11 -----
 lib/ethdev/ethdev_trace.h            | 20 ---------
 lib/ethdev/ethdev_trace_points.c     |  6 ---
 lib/ethdev/rte_ethdev.c              | 62 ----------------------------
 lib/ethdev/rte_ethdev.h              | 45 --------------------
 7 files changed, 157 deletions(-)

diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index a075c057ec..0d3476e850 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -748,13 +748,6 @@ If driver does not support this feature the per queue stats will be zero.
 * **[implements] eth_dev_ops**: ``stats_get``, ``stats_reset``.
 * **[related]    API**: ``rte_eth_stats_get``, ``rte_eth_stats_reset()``.
 
-May also support configuring per-queue stat counter mapping.
-Used by some drivers to workaround HW limitations.
-
-* **[implements] eth_dev_ops**: ``queue_stats_mapping_set``.
-* **[related]    API**: ``rte_eth_dev_set_rx_queue_stats_mapping()``,
-  ``rte_eth_dev_set_tx_queue_stats_mapping()``.
-
 
 .. _nic_features_extended_stats:
 
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 17f90a6352..38702b838e 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -78,12 +78,6 @@ Deprecation Notices
   and the header struct ``rte_vxlan_gpe_hdr`` with the macro ``RTE_ETHER_VXLAN_GPE_HLEN``
   will be removed in DPDK 25.11.
 
-* ethdev: The queue stats mapping functions
-  ``rte_eth_dev_set_tx_queue_stats_mapping`` and ``rte_eth_dev_set_rx_queue_stats_mapping``
-  are deprecated and will be removed in a future release.
-  Following the removal of queue statistics from the main ethdev statistics structure,
-  these functions are no longer needed.
-
 * ethdev: The flow API matching pattern structures, ``struct rte_flow_item_*``,
   should start with relevant protocol header structure from lib/net/.
   The individual protocol header fields and the protocol header struct
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 0f336f9567..0477579cc3 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -567,15 +567,6 @@ typedef int (*eth_xstats_disable_counter_t)(struct rte_eth_dev *dev, uint64_t id
 /** @internal Query the state of an xstat the can be enabled and disabled in runtime. */
 typedef int (*eth_xstats_query_state_t)(struct rte_eth_dev *dev, uint64_t id);
 
-/**
- * @internal
- * Set a queue statistics mapping for a Tx/Rx queue of an Ethernet device.
- */
-typedef int (*eth_queue_stats_mapping_set_t)(struct rte_eth_dev *dev,
-					     uint16_t queue_id,
-					     uint8_t stat_idx,
-					     uint8_t is_rx);
-
 /** @internal Get specific information of an Ethernet device. */
 typedef int (*eth_dev_infos_get_t)(struct rte_eth_dev *dev,
 				   struct rte_eth_dev_info *dev_info);
@@ -1454,8 +1445,6 @@ struct eth_dev_ops {
 	eth_xstats_reset_t         xstats_reset;
 	/** Get names of extended statistics */
 	eth_xstats_get_names_t     xstats_get_names;
-	/** Configure per queue stat counter mapping */
-	eth_queue_stats_mapping_set_t queue_stats_mapping_set;
 
 	eth_dev_infos_get_t        dev_infos_get; /**< Get device info */
 	/** Retrieve Rx queue information */
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index 6554cc1a21..6f1804a765 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -310,26 +310,6 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(ret);
 )
 
-RTE_TRACE_POINT(
-	rte_ethdev_trace_set_rx_queue_stats_mapping,
-	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t rx_queue_id,
-		uint8_t stat_idx, int ret),
-	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_u16(rx_queue_id);
-	rte_trace_point_emit_u8(stat_idx);
-	rte_trace_point_emit_int(ret);
-)
-
-RTE_TRACE_POINT(
-	rte_ethdev_trace_set_tx_queue_stats_mapping,
-	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t tx_queue_id,
-		uint8_t stat_idx, int ret),
-	rte_trace_point_emit_u16(port_id);
-	rte_trace_point_emit_u16(tx_queue_id);
-	rte_trace_point_emit_u8(stat_idx);
-	rte_trace_point_emit_int(ret);
-)
-
 RTE_TRACE_POINT(
 	rte_ethdev_trace_fw_version_get,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, const char *fw_version,
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index 0a28378a56..b0644ea489 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -230,12 +230,6 @@ RTE_TRACE_POINT_REGISTER(rte_eth_trace_xstats_get,
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_xstats_reset,
 	lib.ethdev.xstats_reset)
 
-RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_set_tx_queue_stats_mapping,
-	lib.ethdev.set_tx_queue_stats_mapping)
-
-RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_set_rx_queue_stats_mapping,
-	lib.ethdev.set_rx_queue_stats_mapping)
-
 RTE_TRACE_POINT_REGISTER(rte_ethdev_trace_fw_version_get,
 	lib.ethdev.fw_version_get)
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index d0273e3f7b..e9bd5ba473 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -160,11 +160,6 @@ static const struct {
 	{RTE_ETH_DEV_CAPA_FLOW_SHARED_OBJECT_KEEP, "FLOW_SHARED_OBJECT_KEEP"},
 };
 
-enum {
-	STAT_QMAP_TX = 0,
-	STAT_QMAP_RX
-};
-
 static const struct {
 	enum rte_eth_hash_function algo;
 	const char *name;
@@ -3997,63 +3992,6 @@ rte_eth_xstats_query_state(uint16_t port_id, uint64_t id)
 	return -ENOTSUP;
 }
 
-static int
-eth_dev_set_queue_stats_mapping(uint16_t port_id, uint16_t queue_id,
-		uint8_t stat_idx, uint8_t is_rx)
-{
-	struct rte_eth_dev *dev;
-
-	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
-	dev = &rte_eth_devices[port_id];
-
-	if (is_rx && (queue_id >= dev->data->nb_rx_queues))
-		return -EINVAL;
-
-	if (!is_rx && (queue_id >= dev->data->nb_tx_queues))
-		return -EINVAL;
-
-	if (stat_idx >= RTE_ETHDEV_QUEUE_STAT_CNTRS)
-		return -EINVAL;
-
-	if (dev->dev_ops->queue_stats_mapping_set == NULL)
-		return -ENOTSUP;
-	return dev->dev_ops->queue_stats_mapping_set(dev, queue_id, stat_idx, is_rx);
-}
-
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_tx_queue_stats_mapping)
-int
-rte_eth_dev_set_tx_queue_stats_mapping(uint16_t port_id, uint16_t tx_queue_id,
-		uint8_t stat_idx)
-{
-	int ret;
-
-	ret = eth_err(port_id, eth_dev_set_queue_stats_mapping(port_id,
-						tx_queue_id,
-						stat_idx, STAT_QMAP_TX));
-
-	rte_ethdev_trace_set_tx_queue_stats_mapping(port_id, tx_queue_id,
-						    stat_idx, ret);
-
-	return ret;
-}
-
-RTE_EXPORT_SYMBOL(rte_eth_dev_set_rx_queue_stats_mapping)
-int
-rte_eth_dev_set_rx_queue_stats_mapping(uint16_t port_id, uint16_t rx_queue_id,
-		uint8_t stat_idx)
-{
-	int ret;
-
-	ret = eth_err(port_id, eth_dev_set_queue_stats_mapping(port_id,
-						rx_queue_id,
-						stat_idx, STAT_QMAP_RX));
-
-	rte_ethdev_trace_set_rx_queue_stats_mapping(port_id, rx_queue_id,
-						    stat_idx, ret);
-
-	return ret;
-}
-
 RTE_EXPORT_SYMBOL(rte_eth_dev_fw_version_get)
 int
 rte_eth_dev_fw_version_get(uint16_t port_id, char *fw_version, size_t fw_size)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 3f4d2438e4..e91eada38c 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -3478,51 +3478,6 @@ int rte_eth_xstats_query_state(uint16_t port_id, uint64_t id);
  */
 int rte_eth_xstats_reset(uint16_t port_id);
 
-/**
- *  Set a mapping for the specified transmit queue to the specified per-queue
- *  statistics counter.
- *
- * @param port_id
- *   The port identifier of the Ethernet device.
- * @param tx_queue_id
- *   The index of the transmit queue for which a queue stats mapping is required.
- *   The value must be in the range [0, nb_tx_queue - 1] previously supplied
- *   to rte_eth_dev_configure().
- * @param stat_idx
- *   The per-queue packet statistics functionality number that the transmit
- *   queue is to be assigned.
- *   The value must be in the range [0, RTE_ETHDEV_QUEUE_STAT_CNTRS - 1].
- *   Max RTE_ETHDEV_QUEUE_STAT_CNTRS being 256.
- * @return
- *   Zero if successful. Non-zero otherwise.
- */
-__rte_deprecated
-int rte_eth_dev_set_tx_queue_stats_mapping(uint16_t port_id,
-		uint16_t tx_queue_id, uint8_t stat_idx);
-
-/**
- *  Set a mapping for the specified receive queue to the specified per-queue
- *  statistics counter.
- *
- * @param port_id
- *   The port identifier of the Ethernet device.
- * @param rx_queue_id
- *   The index of the receive queue for which a queue stats mapping is required.
- *   The value must be in the range [0, nb_rx_queue - 1] previously supplied
- *   to rte_eth_dev_configure().
- * @param stat_idx
- *   The per-queue packet statistics functionality number that the receive
- *   queue is to be assigned.
- *   The value must be in the range [0, RTE_ETHDEV_QUEUE_STAT_CNTRS - 1].
- *   Max RTE_ETHDEV_QUEUE_STAT_CNTRS being 256.
- * @return
- *   Zero if successful. Non-zero otherwise.
- */
-__rte_deprecated
-int rte_eth_dev_set_rx_queue_stats_mapping(uint16_t port_id,
-					   uint16_t rx_queue_id,
-					   uint8_t stat_idx);
-
 /**
  * Retrieve the Ethernet address of an Ethernet device.
  *
-- 
2.53.0

