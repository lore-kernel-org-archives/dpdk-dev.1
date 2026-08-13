Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFF0C5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:05:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E90142E59;
	Thu, 13 Aug 2026 20:04:54 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id F0FD942E72
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:04:52 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so123662a91.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644292;
 x=1787249092; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hM1D33GRh2UhI46NXhgcgjCfE1ApsvNUCZMb5Ri57KI=;
 b=w24oNX8rW1K0EjnHmnw+GbX2QYmZXFJQlMwiTMO2UtlEMOJoH/qgZOcpTLxg/S3yqV
 0dv5Ngp+Q6WjsSbJJiB8wId+881sHZrpn4YGWDaNXT4uXKdto4hBeTyXoIEZrnMcgWKa
 +KrgprqYhBO6GDUgHVGxPoY/JvLtkeVctAejyoDuQOouCr8Jk90Mx22t+4RpYy1t8+ye
 h6C+NAzJr/J97g27wQFcvpOkXzMO4ZDgDYLfewKd6gjO+vynIbSR/COY1aPk5n42HvWV
 eAocA/UEyLddQB3Yi2NdhlTgnslZOBmNHPSqr+a/Kn+paKODqEhKCcMUFQEAZXp/YT9o
 kCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644292; x=1787249092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hM1D33GRh2UhI46NXhgcgjCfE1ApsvNUCZMb5Ri57KI=;
 b=PJXJLJ3NKQ7KYCsv082TzALSIaCE8m1jgko/2Gy+XPJR1kD0xPva4MgbHfri4eoc51
 smtnNWeiItTZ8GgIcOiBrmzyc6gjMSv/WcRbgTFqBJmGXoESVFy2Cra8uAD+VQbrLS3I
 MNenaD6c3tBSQyCvLhK0LMDdsJ87OLdKQuCuTqTLL1hcSio9Ga8Kf+LKUJYem/cdlFxc
 DgtcC9OazY0axkGbRiSqhbY1VEmsGqEqxi8Q7d/4KSSChdJVI5CVw/31d27zQ5td1Udp
 nLgDh4FX5W9Z2bFJ3SZq1eGGFknHw6Rh86nxoZw49FTptIURSzwVKsRhmfBvQ3aNO4ju
 a6Hw==
X-Gm-Message-State: AOJu0YzpbJp6pE6rO5Mn4g38SBBlGV8ZyXJ0Kyv1XkjDOWhWTMUs1cwn
 xp1LnfC729LFlt+oOZh4tMcyCNA+n0gHqWXp/8ot7mz8VM4it1lW7qOQSZKaaYyKqpDv1dbT+fM
 Ec+IU
X-Gm-Gg: AR+sD13bYORywPu/0Q3l6CvADrTF7vwjO5stGlYFr3dAZrW/qIAUo0Gjkqgsx0Cn4s6
 vTqc1tPnkCb6YDUCrMhpKwE8hQuQ+v6mufbtUdmB5QuGNwBDzAtHM7iUtICU0gObkaPs2PE+4Er
 HFgYNEPnCG7L5SWCzLJpX130VaWGluFsNdfiP23mHcmcMqFdFKBv0IdfZnJVz3PTAsY5mOOcRcs
 uGNwI/1sxkXhu5CWjOuWpXFMCgJ6x4sK4a1SQrxF4zTRblFVQte0lWunTE+58Nz3KTB6YVEfGbL
 1moHk7tSDp1aPCbEQ97UQ5OjW0l/YvRdKR7dVbnjHOA+bXysCtBUTKnu0S2U1DZFPiTXV2cv/L8
 jPia9ewnW6HXImzjjLwrEubi0nYWe+2qBjj1dNTsMi2cuQXli6Xcx4ikMkKjI3gOkIcPvE5yAGB
 YSE+Qwr1zc+RsS/c6LvOH7NhRnXIn64C/AP5RxWpWncusuzQ7DcSLtZRzN/+JLKvg6S+fQBXud8
 pTCCLrrPjYBqnGpUSaANwHHF4o=
X-Received: by 2002:a17:90b:2dc8:b0:38e:2e86:ed02 with SMTP id
 98e67ed59e1d1-3931e233622mr8868692a91.14.1786644291872; 
 Thu, 13 Aug 2026 11:04:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v3 11/16] ethdev: remove support for queue stats mapping
Date: Thu, 13 Aug 2026 10:55:10 -0700
Message-ID: <20260813180402.622784-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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

The support for queue stats mapping has been deprecated since 25.11
release by commit 2863cbd9ee6d ("ethdev: deprecate queue stats mapping
functions")

This patch completes final removal from ethdev and documentation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 doc/guides/nics/features.rst           |  7 ---
 doc/guides/rel_notes/deprecation.rst   |  6 ---
 doc/guides/rel_notes/release_26_11.rst |  5 +++
 lib/ethdev/ethdev_driver.h             | 11 -----
 lib/ethdev/ethdev_trace.h              | 20 ---------
 lib/ethdev/ethdev_trace_points.c       |  6 ---
 lib/ethdev/rte_ethdev.c                | 62 --------------------------
 lib/ethdev/rte_ethdev.h                | 45 -------------------
 8 files changed, 5 insertions(+), 157 deletions(-)

diff --git a/doc/guides/nics/features.rst b/doc/guides/nics/features.rst
index 0b0c69e7cd..d6852b063c 100644
--- a/doc/guides/nics/features.rst
+++ b/doc/guides/nics/features.rst
@@ -764,13 +764,6 @@ If driver does not support this feature the per queue stats will be zero.
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
index 6ad7698c6b..aaa2918865 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -83,12 +83,6 @@ Deprecation Notices
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
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..d29d7591e9 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -77,6 +77,11 @@ Removed Items
     ``rte_rib6_is_equal``
   * table: ``RTE_LPM_IPV6_ADDR_SIZE``
 
+* ethdev: Removed support for ethdev queue stats mapping.
+
+  ``rte_eth_dev_set_tx_queue_stats_mapping`` and ``rte_eth_dev_set_rx_queue_stats_mapping``
+  were deprecated and are now removed.
+
 
 API Changes
 -----------
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
index 9efeaf77cb..d6915a6b08 100644
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
@@ -4005,63 +4000,6 @@ rte_eth_xstats_query_state(uint16_t port_id, uint64_t id)
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
index ee400b386f..3aa7a22fbc 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -3491,51 +3491,6 @@ int rte_eth_xstats_query_state(uint16_t port_id, uint64_t id);
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

