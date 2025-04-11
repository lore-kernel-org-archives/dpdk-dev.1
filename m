Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB54BC369AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 23:50:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76F2D40E31;
	Sat, 12 Apr 2025 01:49:53 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id 778BD40DCE
 for <dev@dpdk.org>; Sat, 12 Apr 2025 01:49:47 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso2330206a12.1
 for <dev@dpdk.org>; Fri, 11 Apr 2025 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744415386;
 x=1745020186; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvjvq5u82xxmAYW2QOwwHM723QLOCZjSqLrwzsv86J0=;
 b=RYavlGSNhx1tGPysLOwx+YfDSfhENMgOzpiuy7QbFNMjpW5bNXoDak8EwyY1XtYdtg
 40doa2SYF7eab1N7q59hYnWwFTI5SzQGoRI36xwkiBYgVrr06TLft2twev6CML9Tbt1H
 Qw3UA5qoXZiYQdyfwcwYlERpE+WMOCiZPjFj60sGd4/e5R7qg2CmkNjCoeM9U5zHYck4
 ozuSGgR+3qn7RKHF0eK+9oG3GTmZZPNbMUwapRSQm/9006PdQad3oYAIloXESG/F/AX1
 fWehtwzXC8G4lRHMu5vvPLA2QFOvNFSPu8VJkyH1SeuWpUw6jfbqUSfsokDmZOzDRV8/
 PITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744415386; x=1745020186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xvjvq5u82xxmAYW2QOwwHM723QLOCZjSqLrwzsv86J0=;
 b=Vj63J/tsSbjVICMZ9dQt1SrouzJIXb8zwBMmO60rUOfyplqgrAXMZXYs/H42cSRIcx
 3i0viHerC5u3CwO3hooy7ucGpin6gbPIPHmGMRKcroXtW2s6YnTXmyiSNT+WjZFuuhiU
 5TtRqcx9KMEcCkHp1RcHOsUO8mgQhYlobggN02bdPUYU4l77aDYW9bEorznmqQ8qq4Ga
 Yyn7ceXoFGwe1fICToD7MXuXqg8rxAd2uNEFiMY1Jn48XjvWnbq8f1vlWZxyqzM898cg
 LD3JeqcU+r1aWkLmcUB7aGGtILKJ36DP0rRElgw44pStj3CVUrY2NjSa3VJ2JoRetFjo
 d2ZQ==
X-Gm-Message-State: AOJu0Yzw024QWgqDL0oEfuCdqLU9VaMsvVYlv/JT/Xw1xG6KxXPbTaFp
 RAYD10k3cacl3XdU7A5Kakep/SdrLmsRrEPXrPGYyZ/nXCyqS/mp+lF/whfhhQCV54BdiZeowWQ
 M
X-Gm-Gg: ASbGnctkyRQGXDzHHUgz0xveNa9wiiuhuQKNsRig4M9kaS8XAM54Cg6KLU+qG8kHPHN
 skZqeQdoynHvof3fw2HjOVYxKjK2RUfClvtz+eT9Fk9iY3bmdb7UXGUwmYxnMJ7X1Yz2oZJwpIY
 oDbyF5cfbO4V1iLMvgiiVYiSX5iQTttWSti9Gknu3gWT/8xijIHdjkxNghPdBymV2ogx59u1nju
 sTMhlDzP/gxAzWTj8Jj+dk3yHk47344pCIR7okVwMLB254anooVXGneRdUAQ1pwS0sEHOXa3TYn
 hysAloAG4Zr02OJgqOs/7G5ODCQ3DZ8ZDjUMmg3eS3dN8f9hl0XYICNezxN1Cs+ZAufz1fs4iBM
 UUYVASJ3UgoFvl0vOGFN2LpbHed4=
X-Google-Smtp-Source: AGHT+IHo5gncjEFYWP2wOASC0SnPvWeS3R+ZdiaO0EchhJ/lzJi5YV2CIxErIgihtgVVzL083vU21g==
X-Received: by 2002:a17:90b:5251:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-30773142dafmr11933869a91.6.1744415386573; 
 Fri, 11 Apr 2025 16:49:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm6538661a91.12.2025.04.11.16.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 16:49:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [RFC 09/13] ethdev: add port mirror capability
Date: Fri, 11 Apr 2025 16:44:46 -0700
Message-ID: <20250411234927.114568-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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

This adds new feature for port mirroring.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/rte_config.h              |   2 +
 lib/ethdev/ethdev_driver.h       |   3 +
 lib/ethdev/ethdev_private.c      |   3 +
 lib/ethdev/ethdev_trace.h        |  14 +++
 lib/ethdev/ethdev_trace_points.c |   6 +
 lib/ethdev/rte_ethdev.c          | 191 +++++++++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h          |  81 +++++++++++++
 lib/ethdev/rte_ethdev_core.h     |   6 +-
 8 files changed, 304 insertions(+), 2 deletions(-)

diff --git a/config/rte_config.h b/config/rte_config.h
index 86897de75e..3a1fbec6b9 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -70,6 +70,8 @@
 #define RTE_ETHDEV_QUEUE_STAT_CNTRS 16 /* max 256 */
 #define RTE_ETHDEV_RXTX_CALLBACKS 1
 #define RTE_MAX_MULTI_HOST_CTRLS 4
+#define RTE_ETHDEV_MIRROR 1
+#define RTE_MIRROR_BURST_SIZE 256
 
 /* cryptodev defines */
 #define RTE_CRYPTO_MAX_DEVS 64
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 2b4d2ae9c3..9b3215ae2d 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -172,6 +172,9 @@ struct __rte_cache_aligned rte_eth_dev_data {
 	uint32_t dev_flags;             /**< Capabilities */
 	int numa_node;                  /**< NUMA node connection */
 
+	struct rte_eth_mirror *rx_mirror; /**< Port mirroring */
+	struct rte_eth_mirror *tx_mirror; /**< Port mirroring */
+
 	/** VLAN filter configuration */
 	struct rte_vlan_filter_conf vlan_filter_conf;
 
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index bded3f1722..b7bcd1d089 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -284,6 +284,9 @@ eth_dev_fp_ops_setup(struct rte_eth_fp_ops *fpo,
 
 	fpo->txq.data = dev->data->tx_queues;
 	fpo->txq.clbk = (void * __rte_atomic *)(uintptr_t)dev->pre_tx_burst_cbs;
+
+	fpo->rx_mirror = &dev->data->rx_mirror;
+	fpo->tx_mirror = &dev->data->tx_mirror;
 }
 
 RTE_EXPORT_SYMBOL(rte_eth_call_rx_callbacks)
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index c65b78590a..de93037581 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -1035,6 +1035,20 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(ret);
 )
 
+RTE_TRACE_POINT(
+	rte_eth_trace_mirror_bind,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id,
+			     const struct rte_eth_mirror_conf *conf),
+	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_ptr(conf);
+)
+
+RTE_TRACE_POINT(
+	rte_eth_trace_mirror_unbind,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id),
+	rte_trace_point_emit_u16(port_id);
+)
+
 RTE_TRACE_POINT(
 	rte_eth_trace_rx_queue_info_get,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t queue_id,
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index 071c508327..e73ef01332 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -389,6 +389,12 @@ RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_rx_callback,
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_tx_callback,
 	lib.ethdev.remove_tx_callback)
 
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_mirror_bind,
+	lib.ethdev.mirror_bind)
+
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_mirror_unbind,
+	lib.ethdev.mirror_unbind)
+
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_rx_queue_info_get,
 	lib.ethdev.rx_queue_info_get)
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index f7bf762ff7..bea4dac502 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -14,6 +14,7 @@
 #include <bus_driver.h>
 #include <eal_export.h>
 #include <rte_log.h>
+#include <rte_alarm.h>
 #include <rte_interrupts.h>
 #include <rte_kvargs.h>
 #include <rte_memcpy.h>
@@ -52,6 +53,9 @@ static rte_spinlock_t eth_dev_rx_cb_lock = RTE_SPINLOCK_INITIALIZER;
 /* spinlock for add/remove Tx callbacks */
 static rte_spinlock_t eth_dev_tx_cb_lock = RTE_SPINLOCK_INITIALIZER;
 
+/* spinlock for setting up mirror ports */
+static rte_spinlock_t eth_dev_mirror_lock = RTE_SPINLOCK_INITIALIZER;
+
 /* store statistics names and its offset in stats structure  */
 struct rte_eth_xstats_name_off {
 	char name[RTE_ETH_XSTATS_NAME_SIZE];
@@ -7050,6 +7054,193 @@ rte_eth_dev_hairpin_capability_get(uint16_t port_id,
 	return ret;
 }
 
+
+struct rte_eth_mirror {
+	struct rte_mempool *pool;
+	uint32_t snaplen;
+	uint16_t target;
+};
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_add_mirror, 25.07)
+int
+rte_eth_add_mirror(uint16_t port_id, uint16_t target_id, const struct rte_eth_mirror_conf *conf)
+{
+#ifndef RTE_ETHDEV_MIRROR
+	return -ENOTSUP;
+#endif
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(target_id, -ENODEV);
+
+	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+
+	if (conf == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Missing configuration information");
+		return -EINVAL;
+	}
+
+	if (conf->mp == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "not a valid mempool");
+		return -EINVAL;
+	}
+
+	if (conf->direction == 0 ||
+	    conf->direction > (RTE_MIRROR_DIRECTION_INGRESS | RTE_MIRROR_DIRECTION_EGRESS)) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Invalid direction %#x", conf->direction);
+		return -EINVAL;
+	}
+
+	if (conf->snaplen < RTE_ETHER_HDR_LEN) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Invalid snapshot length");
+		return -EINVAL;
+	}
+
+	if (target_id == port_id) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Cannot mirror port to self");
+		return -EINVAL;
+	}
+
+	struct rte_eth_dev_info dev_info;
+	int ret = rte_eth_dev_info_get(target_id, &dev_info);
+	if (ret != 0)
+		return ret;
+
+	if (!(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE)) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Mirror needs lockfree transmit");
+		return -ENOTSUP;
+	}
+
+	struct rte_eth_mirror *mirror = rte_zmalloc(NULL, sizeof(*mirror), 0);
+	if (mirror == NULL)
+		return -ENOMEM;
+
+	mirror->pool = conf->mp;
+	mirror->target = target_id;
+	mirror->snaplen = conf->snaplen;
+
+	rte_spinlock_lock(&eth_dev_mirror_lock);
+	if (dev->data->rx_mirror != NULL || dev->data->tx_mirror != NULL)
+		ret = -EBUSY;
+	else {
+		if (conf->direction & RTE_MIRROR_DIRECTION_INGRESS)
+			rte_atomic_store_explicit(&dev->data->rx_mirror, mirror, rte_memory_order_relaxed);
+		if (conf->direction & RTE_MIRROR_DIRECTION_EGRESS)
+			rte_atomic_store_explicit(&dev->data->tx_mirror, mirror, rte_memory_order_relaxed);
+
+		rte_eth_trace_mirror_bind(port_id, conf);
+		ret = 0;
+	}
+	rte_spinlock_unlock(&eth_dev_mirror_lock);
+
+	return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_remove_mirror, 25.07)
+int
+rte_eth_remove_mirror(uint16_t port_id)
+{
+#ifndef RTE_ETHDEV_MIRROR
+	return -ENOTSUP;
+#endif
+	struct rte_eth_mirror *rx_mirror, *tx_mirror;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+
+	rte_spinlock_lock(&eth_dev_mirror_lock);
+	rx_mirror = rte_atomic_exchange_explicit(&dev->data->rx_mirror, NULL,
+						 rte_memory_order_acquire);
+	tx_mirror = rte_atomic_exchange_explicit(&dev->data->tx_mirror, NULL,
+						 rte_memory_order_acquire);
+
+	rte_spinlock_unlock(&eth_dev_mirror_lock);
+
+	struct rte_eth_mirror *mirror = NULL;
+	if (rx_mirror)
+		mirror = rx_mirror;
+	else if (tx_mirror)
+		mirror = tx_mirror;
+	else
+		return -ENOENT; /* no mirror present */
+
+	/* Defer freeing the mirror until after one second
+	 * to allow for active threads that are using it.
+	 * Assumes no PMD takes more than one second to transmit a burst.
+	 * Alternative would be RCU, but RCU in DPDK is optional.
+	 */
+	rte_eal_alarm_set(US_PER_S, rte_free, mirror);
+	rte_eth_trace_mirror_unbind(port_id);
+	return 0;
+}
+
+static inline void
+eth_dev_mirror(uint16_t port_id, uint16_t queue_id, uint8_t direction,
+	       struct rte_mbuf **pkts, uint16_t nb_pkts,
+	       const struct rte_eth_mirror *mirror)
+{
+	struct rte_mbuf *tosend[RTE_MIRROR_BURST_SIZE];
+	unsigned int count = 0;
+	unsigned int i;
+
+	for (i = 0; i < nb_pkts; i++) {
+		const struct rte_mbuf *m = pkts[i];
+		struct rte_mbuf *mc;
+
+		/*
+		 * maybe use refcount to clone mbuf but lots of restrictions:
+		 *  - assumes application won't overwrite rx mbuf
+		 *  - no vlan insertion
+		 */
+		mc = rte_pktmbuf_copy(m, mirror->pool, 0, mirror->snaplen);
+		if (unlikely(mc == NULL))
+			continue;
+
+		/* if original packet has VLAN offload, then undo offload */
+		if ((direction == RTE_MIRROR_DIRECTION_INGRESS &&
+		     (m->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED)) ||
+		    (direction == RTE_MIRROR_DIRECTION_EGRESS &&
+		     (m->ol_flags & RTE_MBUF_F_TX_VLAN))) {
+			if (unlikely(rte_vlan_insert(&mc) != 0)) {
+				rte_pktmbuf_free(mc);
+				continue;
+			}
+		}
+
+		mc->port = port_id;
+		mc->hash.mirror = (struct rte_mbuf_mirror) {
+			.orig_len = m->pkt_len,
+			.queue_id = queue_id,
+			.direction = direction,
+		};
+
+		tosend[count++] = mc;
+	}
+
+	uint16_t nsent = rte_eth_tx_burst(mirror->target, 0, tosend, count);
+	if (unlikely(nsent < count)) {
+		uint16_t drop = count - nsent;
+
+		/* TODO: need some stats here? */
+		rte_pktmbuf_free_bulk(pkts + nsent, drop);
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_mirror_burst, 25.07)
+void
+rte_eth_mirror_burst(uint16_t port_id, uint16_t queue_id, uint8_t direction,
+		     struct rte_mbuf **pkts, uint16_t nb_pkts,
+		     const struct rte_eth_mirror *mirror)
+{
+	unsigned int i;
+
+	for (i = 0; i < nb_pkts; i += RTE_MIRROR_BURST_SIZE) {
+		uint16_t left  = nb_pkts - i;
+		uint16_t burst = RTE_MIN(left, RTE_MIRROR_BURST_SIZE);
+
+		eth_dev_mirror(port_id, queue_id, direction,
+			       pkts + i, burst, mirror);
+	}
+}
+
 RTE_EXPORT_SYMBOL(rte_eth_dev_pool_ops_supported)
 int
 rte_eth_dev_pool_ops_supported(uint16_t port_id, const char *pool)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ea7f8c4a1a..0588d6f416 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1464,6 +1464,66 @@ enum rte_eth_tunnel_type {
 	RTE_ETH_TUNNEL_TYPE_MAX,
 };
 
+/* Definitions for mirror direction */
+#define RTE_MIRROR_DIRECTION_INGRESS 1
+#define RTE_MIRROR_DIRECTION_EGRESS 2
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Structure used to configure port mirroring.
+ */
+struct rte_eth_mirror_conf {
+	struct rte_mempool *mp;	/**< Memory pool to allocate from */
+	uint32_t snaplen;	/**< Amount of data to copy */
+	uint8_t direction;	/**< bitmask of RTE_MIRROR_DIRECTION_XXX */
+};
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Create a port mirror.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param target_id
+ *   The port identifier of the mirror port.
+ * @param conf
+ *   Settings for the mirror.
+ * @return
+ *   Negative errno value on error, 0 on success.
+ */
+__rte_experimental
+int
+rte_eth_add_mirror(uint16_t port_id, uint16_t target_id,
+		   const struct rte_eth_mirror_conf *conf);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Break port mirroring. After this call no more packets will be sent
+ * the target port.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @return
+ *   Negative errno value on error, 0 on success.
+ */
+__rte_experimental
+int rte_eth_remove_mirror(uint16_t port_id);
+
+/**
+ * @internal
+ * Helper routine for rte_eth_rx_burst() and rte_eth_tx_burst().
+ */
+struct rte_eth_mirror;
+__rte_experimental
+void rte_eth_mirror_burst(uint16_t port_id, uint16_t queue_id, uint8_t dir,
+			  struct rte_mbuf **pkts, uint16_t nb_pkts,
+			  const struct rte_eth_mirror *mirror);
 #ifdef __cplusplus
 }
 #endif
@@ -6331,6 +6391,17 @@ rte_eth_rx_burst(uint16_t port_id, uint16_t queue_id,
 
 	nb_rx = p->rx_pkt_burst(qd, rx_pkts, nb_pkts);
 
+#ifdef RTE_ETHDEV_MIRROR
+	if (p->rx_mirror) {
+		const struct rte_eth_mirror *mirror;
+
+		mirror = rte_atomic_load_explicit(p->rx_mirror, rte_memory_order_relaxed);
+		if (unlikely(mirror != NULL))
+			rte_eth_mirror_burst(port_id, queue_id, RTE_MIRROR_DIRECTION_INGRESS,
+					     rx_pkts, nb_rx, mirror);
+	}
+#endif
+
 #ifdef RTE_ETHDEV_RXTX_CALLBACKS
 	{
 		void *cb;
@@ -6689,6 +6760,16 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
+#ifdef RTE_ETHDEV_MIRROR
+	if (p->tx_mirror) {
+		const struct rte_eth_mirror *mirror;
+
+		mirror = rte_atomic_load_explicit(p->tx_mirror, rte_memory_order_relaxed);
+		if (unlikely(mirror != NULL))
+			rte_eth_mirror_burst(port_id, queue_id, RTE_MIRROR_DIRECTION_EGRESS,
+					     tx_pkts, nb_pkts, mirror);
+	}
+#endif
 	nb_pkts = p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
 
 	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts, nb_pkts);
diff --git a/lib/ethdev/rte_ethdev_core.h b/lib/ethdev/rte_ethdev_core.h
index e55fb42996..2ef3b659f7 100644
--- a/lib/ethdev/rte_ethdev_core.h
+++ b/lib/ethdev/rte_ethdev_core.h
@@ -101,7 +101,8 @@ struct __rte_cache_aligned rte_eth_fp_ops {
 	eth_rx_descriptor_status_t rx_descriptor_status;
 	/** Refill Rx descriptors with the recycling mbufs. */
 	eth_recycle_rx_descriptors_refill_t recycle_rx_descriptors_refill;
-	uintptr_t reserved1[2];
+	uintptr_t reserved1;
+	RTE_ATOMIC(struct rte_eth_mirror *) *rx_mirror;
 	/**@}*/
 
 	/**@{*/
@@ -121,7 +122,8 @@ struct __rte_cache_aligned rte_eth_fp_ops {
 	eth_recycle_tx_mbufs_reuse_t recycle_tx_mbufs_reuse;
 	/** Get the number of used Tx descriptors. */
 	eth_tx_queue_count_t tx_queue_count;
-	uintptr_t reserved2[1];
+	RTE_ATOMIC(struct rte_eth_mirror *) *tx_mirror;
+	uintptr_t reserved2;
 	/**@}*/
 
 };
-- 
2.47.2

