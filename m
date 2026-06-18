Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF600CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:11:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1FCC7402CA;
	Thu, 18 Jun 2026 16:11:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 84B77402CA
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781791901; x=1813327901;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eKHPCnRDZAkrO7LmI5tkDIbgp/s9OYj3yRG+F1YChnk=;
 b=RIRmnundH90kswji2rn0ZzjNAbaDOZ/HnWsxkOut3GKa7VJHzBm/oYIY
 J89aBiCTwAJG+sEfGIUTzeEF93KVOjXYZ2TbPLmz9mUmw9oo2WupoX/tT
 s9ZdbugzmV+tfR4uwAvpH9g9eYenJFCMMOeqDzBfzRIAJ13FTlsejX2Tq
 15U8GL91ww2TJXLu4iMET+20OkWllcZhJEfed1R+f6aDP2Taj0QUhiKeq
 WsqmeoEjrIIAviw6U7nXUKPF+GdUVHsmQXtvsg8I759tyy3IoyEZuzqrP
 RikOHjhPdReZd/XjcpdomrV0p+sa41cdVSnralaXHzB56qCVNqhY8JA9C w==;
X-CSE-ConnectionGUID: vKpq/F/RSXmvu7p4062zRA==
X-CSE-MsgGUID: WQEo3JOTSROn81j6rcFwQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82628718"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82628718"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 07:11:39 -0700
X-CSE-ConnectionGUID: OmhApwTBT7i1O0AiViSb7A==
X-CSE-MsgGUID: y39J7oT1SwanrZW8eIZsfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="244211194"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by fmviesa010.fm.intel.com with ESMTP; 18 Jun 2026 07:11:38 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v2 1/7] ethdev: add header split mbuf callback API
Date: Thu, 18 Jun 2026 10:38:31 -0400
Message-ID: <20260618143837.310156-2-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618143837.310156-1-dawid.wesierski@intel.com>
References: <20260618143837.310156-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

Add rte_eth_hdrs_set_mbuf_callback() that allows applications to
register a callback providing custom payload mbufs for header split RX
mode. When registered, a PMD that supports header split is expected to
call this callback at mbuf allocation points to obtain user-provided
payload buffers instead of allocating from the mempool.

This enables zero-copy RX for header split: the NIC DMAs the payload
directly into application-managed buffers (e.g., mapped frame buffers
with known IOVA), bypassing an extra memcpy from the mempool mbuf.

A new struct rte_eth_hdrs_mbuf describes the payload buffer (virtual
address and IOVA), and the new dev_ops hook hdrs_mbuf_set_cb lets each
PMD wire the callback to its receive queue state.

The API is marked experimental and exported with version 26.07.

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 lib/ethdev/ethdev_driver.h | 10 +++++++++
 lib/ethdev/rte_ethdev.c    | 17 ++++++++++++++
 lib/ethdev/rte_ethdev.h    | 46 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 0f336f9567..b48681268c 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -1292,6 +1292,13 @@ typedef int (*eth_cman_config_set_t)(struct rte_eth_dev *dev,
 typedef int (*eth_cman_config_get_t)(struct rte_eth_dev *dev,
 				struct rte_eth_cman_config *config);
 
+/** @internal
+ * Set header split payload mbuf callback for a receive queue.
+ */
+typedef int (*eth_hdrs_mbuf_set_cb_t)(struct rte_eth_dev *dev,
+	uint16_t rx_queue_id, void *priv,
+	rte_eth_hdrs_mbuf_callback_fn cb);
+
 /**
  * @internal
  * Dump Rx descriptor info to a file.
@@ -1652,6 +1659,9 @@ struct eth_dev_ops {
 	/** Dump Tx descriptor info */
 	eth_tx_descriptor_dump_t eth_tx_descriptor_dump;
 
+	/** Set header split mbuf callback */
+	eth_hdrs_mbuf_set_cb_t hdrs_mbuf_set_cb;
+
 	/** Get congestion management information */
 	eth_cman_info_get_t cman_info_get;
 	/** Initialize congestion management structure with default values */
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..d5820ccd22 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -7316,6 +7316,23 @@ rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hdrs_set_mbuf_callback, 26.07)
+int
+rte_eth_hdrs_set_mbuf_callback(uint16_t port_id, uint16_t rx_queue_id,
+	void *priv, rte_eth_hdrs_mbuf_callback_fn cb)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (dev->dev_ops->hdrs_mbuf_set_cb == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id,
+		dev->dev_ops->hdrs_mbuf_set_cb(dev, rx_queue_id, priv, cb));
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priv_dump, 22.03)
 int
 rte_eth_dev_priv_dump(uint16_t port_id, FILE *file)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ee400b386f..dbf2c23a35 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6985,6 +6985,52 @@ rte_eth_tx_buffer(uint16_t port_id, uint16_t queue_id,
 	return rte_eth_tx_buffer_flush(port_id, queue_id, buffer);
 }
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ *
+ * Buffer descriptor for header split payload mbuf callback.
+ */
+struct rte_eth_hdrs_mbuf {
+	void *buf_addr;       /**< Virtual address of payload buffer. */
+	rte_iova_t buf_iova;  /**< IOVA of payload buffer. */
+};
+
+/**
+ * Callback function type for providing custom payload mbufs
+ * in header split mode.
+ *
+ * @param priv
+ *   User-provided private context.
+ * @param mbuf
+ *   Pointer to buffer descriptor to be filled by the callback.
+ * @return
+ *   0 on success, negative errno on failure.
+ */
+typedef int (*rte_eth_hdrs_mbuf_callback_fn)(void *priv,
+	struct rte_eth_hdrs_mbuf *mbuf);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ *
+ * Register a callback to provide custom payload mbufs for header split RX.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param rx_queue_id
+ *   The index of the receive queue.
+ * @param priv
+ *   User-provided private context passed to the callback.
+ * @param cb
+ *   Callback function that provides payload buffer descriptors.
+ * @return
+ *   0 on success, negative errno on failure.
+ */
+__rte_experimental
+int rte_eth_hdrs_set_mbuf_callback(uint16_t port_id, uint16_t rx_queue_id,
+		void *priv, rte_eth_hdrs_mbuf_callback_fn cb);
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

