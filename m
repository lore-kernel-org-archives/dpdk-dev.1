Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D00C531F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 20:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D9D440DD3;
	Thu, 23 Jul 2026 22:29:53 +0200 (CEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by mails.dpdk.org (Postfix) with ESMTP id F27FC40B9E
 for <dev@dpdk.org>; Thu, 23 Jul 2026 22:29:50 +0200 (CEST)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso1162291a91.2
 for <dev@dpdk.org>; Thu, 23 Jul 2026 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784838590;
 x=1785443390; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uc2eEfL1xIgEbk2HTKKH1FbbTC7nsoCaMM20guOA2Ak=;
 b=wPXRIws8Ro+J8MZLHH1f7Lsod4NGBHmpq/EL01FJviV46CmlRF+KgKTM4AyI+665PH
 ltUclhD5uFbOowa01etA3aMuZy0Lcmu1e5up7v2k4HRqbMKQ9yHF2SmRyFNoiYOHZhYg
 2DrIsTQehTZDVzN+ZRdYHyiCpT8gaL9P+d9uEdKJkWpitkZnDtbuwf1bl1w4zaXVz1c9
 Lhz9abou+az5kRlhGApBRpIu/T+s3t+xM6HyfD2Xhyl/4n3Uqa1iuD8isJtzGC/uXpy7
 XKpcIuT+M4YYWgRMqR+fdBjwvP1sT5KwhhaHGsFhN62dUkoPUH9R6urbMngxKYrYDZNZ
 tKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838590; x=1785443390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uc2eEfL1xIgEbk2HTKKH1FbbTC7nsoCaMM20guOA2Ak=;
 b=ouPDomAR61wMgcSHaq1dp9npq3AOgnIX+G4wFPsp2JaarP0tLm3RlLStuJjqJwjCSQ
 Z7OHd150+rZM18/8omxShrzrnaUFEZ4MLSU091sHqqHOEm2RoyX2WsWH61ev8bZfR4z9
 ZFbahuRyXHQUtdDsTYPzhIyKSbh9KfBXKpz+BzjVZ9TfNk992v8SYIaqiW+k0Ky/5/ZU
 /FBXqCQcddUNK6WkXEmPS25wBlTo66jPWrg+QUMfOxncSzkFpErsGi9m1JyzV7UeiXlw
 6NLK/mV5QBSBtg1R6Q5Cml5cYYhlKGb+Ko4lQv8HEaPs3Kv9yK9TJoar/WYecREjnqSB
 4yrw==
X-Gm-Message-State: AOJu0YxQA5uW2i2ciiRZ0+tZTqlcQTr49g9g4xzOQqZqNC1Z2W0Q/8ND
 +JtKD8qyYp3KTaZ9M1wXT+fjEAByIh3MFO/ClFVO2TRuv7zQH698PUbRYKTNvqYACeoyxgZp2qu
 ywxJb
X-Gm-Gg: AR+sD10Yg9dHhGWyCku9XnfUAZ3rrzcfe8tpDpxwMa+kE8ik7D7QSahhGZmANRSstnp
 yL0ni4256cq3OGQQxpCJZpr2d3AWkGBxXgSZyKA/oX2mMrTU39bzFDGUshF0P5GtyJcChtofroB
 U+X2Wk0B+j1loRuU0Hkm7ce471qoplDoCBTOEh741fLwPwKlpDYIcpz4Ry8mWjJM526JwzpfWEe
 otxEJ7lKSrtcaPLEzdOQlDOWG/yeF8OXwApSEI/ufAoI+nBrYCPx8oHiXRmfo3p2bDgw89MTLnG
 1O9UnB1Bur+jxpHiZyWhU2UWWKow/SkUFFYCbv1sq+zzhBfH0EgHOLVddg4AjCa3nvDLc/Hlz+x
 jk24IaGxP3+lS2M7WLjydp/CbMmaIjXtNEhr3f0XmAcRsfNtk7YGYMzSzwvcM1ipGph1i71Oarl
 8b8z2U5l4w+lObsJWH9sS9B0W6Ff1Qj0p/aPyBYwHm
X-Received: by 2002:a17:90a:c888:b0:381:28e0:624d with SMTP id
 98e67ed59e1d1-38ec6566fbamr4928155a91.28.1784838590115; 
 Thu, 23 Jul 2026 13:29:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d12f267fdsm18864877c88.0.2026.07.23.13.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:29:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v2 9/9] ethdev: remove support for queue stats mapping
Date: Thu, 23 Jul 2026 13:28:14 -0700
Message-ID: <20260723202936.378793-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723202936.378793-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
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
index 938617ca75..ed6937c8b5 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -68,6 +68,11 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
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

