Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A06BC83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 16:33:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41E5940E2A;
	Fri, 18 Jul 2025 18:33:01 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 524E940DD8
 for <dev@dpdk.org>; Fri, 18 Jul 2025 18:32:59 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7e346ab53d8so203700085a.0
 for <dev@dpdk.org>; Fri, 18 Jul 2025 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752856379;
 x=1753461179; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzQ+mQFyuoPk5BOYk/1j4inv6ez4czuxV1Ew1ywMoe0=;
 b=HxIpPXbv7GJuYa/1I5WNKBx6AUz+iQpE1mQzJtuQlq2zX716GwTRHe3KFK0f/IZrD2
 N2FE2+HsjwNH8Cz0HuSoLlW9AssdoLbaw/Eww2kCMvEQU4I0heKeoYqJUVqYpjGIHxrV
 u+wkHXYVQUf8u/e+TaPze4wmcVTgSmj2NsVT5nzzP52A1sOdk8yuWABT892QE1N2kmGX
 evHXlRLQolHNZBUEtppcTOywj/UsQJgs53VnwhcfDvbmbLr1dDRmvhPQLq9IVlj38g8G
 m+dt8IXi9UW3SOSLv9iy/13ZNr/G0TULz8yW6nZCx8jpvXP5PZplWwabCrhQ3kJj1xBX
 sCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752856379; x=1753461179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzQ+mQFyuoPk5BOYk/1j4inv6ez4czuxV1Ew1ywMoe0=;
 b=hEHwbtdZqSv78mphKIQ+3cdrgV3U9FwpmpfTJHqruZGF+vYbC985/a6ZzqyxrIYW3Z
 mPbKbmRfqk8fm0O2d72OC6SuR84wnRNdWMMpdLmXUpkcW7U0RCs0o8M6W95NTo6jFR+J
 bX3SiGZRSifuCzJ6wHsJeqK43vUSWUPI20/cMCtudu6oQdaMPbXCgj2Wn/OyZiMhYQGZ
 hZbrVtXiYnf4FkXU63rayWkzVhX2Hso0xonLFYuncE1wFiebIJh/TJ5i00z1+zi/8TeY
 0IZxgD2vp+uikyN4Y42rSEm9pRhVD0Ypv3X2H/i3anEtpVfh59joXinukOHLVExUkVRm
 pW0A==
X-Gm-Message-State: AOJu0YwA5XvA10SVNwnVGITmn/FslPZHQ2Z/qK21XWRFRw/Ng01hz16Y
 tBegFSRpcbZfcLl3knggIYA37s5HY5CXRXolfhSG6rPFOV7iNQi/D67aboIomeeItjCzja+bMIO
 84wft
X-Gm-Gg: ASbGncsWUgL/T7gsv66k/S9MnOsSP5nOw4W40TbgD+ElqOV1A9+gHKle7KTe9aOSgyb
 tJBZ/IimkavsO7OOUmR8aeu8755fcB8C/IEVabDAgPmoNRscFQQsP/lWPZMB/UEzrPVJfcA4Wa7
 uFJvIkXCq7n3jCoj651fj4s4WMW05sjvhHyUcVVhPlnhXSKh3VYQ41rTOv/9sYcdKqZOujevZBV
 cbKB5F6WvgGBlFWmpRMLUXQT6QIKrlwosBSanONO70C0akvsjNuO94oI2apHdAebP14MzdGajux
 e6WrSCmWt1aU+FqheGNn+N0l6Po/pmQMin4Ba7JmaU1qXMVMwypQzS5fVtymQOXo7NuXh5280jp
 eerO0FCgx6HyFsJDfnGDtlSxCQtg88bbTHFXItawL0U3eAPq+DX5MifQwITMxMsocwCHWkua4qh
 rHwmIYmxs=
X-Google-Smtp-Source: AGHT+IGoVGGfVstKVeEnMTr6nk0NFEYhHlCfTLmYp2p5DLwmZcK7LaN2U+XWi7/UN4BE3lxrTQqptw==
X-Received: by 2002:a05:620a:4687:b0:7cc:8a39:29df with SMTP id
 af79cd13be357-7e34d8bfbacmr1144956785a.9.1752856378136; 
 Fri, 18 Jul 2025 09:32:58 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356cc1aa8sm103392685a.111.2025.07.18.09.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 09:32:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit <ferruh.yigit@amd.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 07/13] ethdev: add port mirroring feature
Date: Fri, 18 Jul 2025 09:28:24 -0700
Message-ID: <20250718163236.9870-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718163236.9870-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250718163236.9870-1-stephen@networkplumber.org>
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

This adds new feature port mirroring to the ethdev layer.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/rte_config.h              |   1 +
 lib/ethdev/ethdev_driver.h       |   6 +
 lib/ethdev/ethdev_private.c      |  58 ++++-
 lib/ethdev/ethdev_private.h      |   3 +
 lib/ethdev/ethdev_trace.h        |  17 ++
 lib/ethdev/ethdev_trace_points.c |   6 +
 lib/ethdev/meson.build           |   1 +
 lib/ethdev/rte_ethdev.c          |  17 +-
 lib/ethdev/rte_ethdev.h          |  23 +-
 lib/ethdev/rte_ethdev_core.h     |  12 +-
 lib/ethdev/rte_mirror.c          | 359 +++++++++++++++++++++++++++++++
 lib/ethdev/rte_mirror.h          |  99 +++++++++
 12 files changed, 584 insertions(+), 18 deletions(-)
 create mode 100644 lib/ethdev/rte_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.h

diff --git a/config/rte_config.h b/config/rte_config.h
index 05344e2619..76eb2aa417 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -69,6 +69,7 @@
 #define RTE_MAX_QUEUES_PER_PORT 1024
 #define RTE_ETHDEV_QUEUE_STAT_CNTRS 16 /* max 256 */
 #define RTE_ETHDEV_RXTX_CALLBACKS 1
+#define RTE_ETHDEV_MIRROR 1
 #define RTE_MAX_MULTI_HOST_CTRLS 4
 
 /* cryptodev defines */
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 2b4d2ae9c3..e6aad6d30a 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -91,6 +91,12 @@ struct __rte_cache_aligned rte_eth_dev {
 	 */
 	RTE_ATOMIC(struct rte_eth_rxtx_callback *) pre_tx_burst_cbs[RTE_MAX_QUEUES_PER_PORT];
 
+	/** Receive mirrors */
+	RTE_ATOMIC(struct rte_eth_mirror *) rx_mirror;
+
+	/** Transmit mirrors */
+	RTE_ATOMIC(struct rte_eth_mirror *) tx_mirror;
+
 	enum rte_eth_dev_state state; /**< Flag indicating the port state */
 	void *security_ctx; /**< Context for security ops */
 };
diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index fffffe2625..dd144db993 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -289,6 +289,8 @@ eth_dev_fp_ops_setup(struct rte_eth_fp_ops *fpo,
 	fpo->tx_descriptor_status = dev->tx_descriptor_status;
 	fpo->recycle_tx_mbufs_reuse = dev->recycle_tx_mbufs_reuse;
 	fpo->recycle_rx_descriptors_refill = dev->recycle_rx_descriptors_refill;
+	fpo->rx_mirror = (struct rte_eth_mirror * __rte_atomic *)(uintptr_t)&dev->rx_mirror;
+	fpo->tx_mirror = (struct rte_eth_mirror * __rte_atomic *)(uintptr_t)&dev->tx_mirror;
 
 	fpo->rxq.data = dev->data->rx_queues;
 	fpo->rxq.clbk = (void * __rte_atomic *)(uintptr_t)dev->post_rx_burst_cbs;
@@ -490,17 +492,53 @@ eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues)
 }
 
 static int
-ethdev_handle_request(const struct ethdev_mp_request *req)
+ethdev_handle_request(const struct ethdev_mp_request *req, size_t len)
 {
+	len -= sizeof(*req);
+
 	switch (req->operation) {
 	case ETH_REQ_START:
+		if (len != 0)
+			return -EINVAL;
+
 		return rte_eth_dev_start(req->port_id);
 
 	case ETH_REQ_STOP:
+		if (len != 0)
+			return -EINVAL;
 		return rte_eth_dev_stop(req->port_id);
 
+	case ETH_REQ_RESET:
+		if (len != 0)
+			return -EINVAL;
+		return rte_eth_dev_reset(req->port_id);
+
+	case ETH_REQ_ADD_MIRROR:
+		if (len != sizeof(struct rte_eth_mirror_conf)) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+				    "add mirror conf wrong size %zu", len);
+			return -EINVAL;
+		}
+
+		const struct rte_eth_mirror_conf *conf
+			= (const struct rte_eth_mirror_conf *) req->config;
+
+		return rte_eth_add_mirror(req->port_id, conf);
+
+	case ETH_REQ_REMOVE_MIRROR:
+		if (len != sizeof(uint16_t)) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+				    "mirror remove wrong size %zu", len);
+			return -EINVAL;
+		}
+
+		uint16_t target = *(const uint16_t *) req->config;
+		return rte_eth_remove_mirror(req->port_id, target);
+
 	default:
-		return -EINVAL;
+		RTE_ETHDEV_LOG_LINE(ERR,
+			    "Unknown mp request operation %u", req->operation);
+		return -ENOTSUP;
 	}
 }
 
@@ -513,23 +551,25 @@ static_assert(sizeof(struct ethdev_mp_response) <= RTE_MP_MAX_PARAM_LEN,
 int
 ethdev_server(const struct rte_mp_msg *mp_msg, const void *peer)
 {
-	const struct ethdev_mp_request *req
-		= (const struct ethdev_mp_request *)mp_msg->param;
-
 	struct rte_mp_msg mp_resp = {
 		.name = ETHDEV_MP,
 	};
 	struct ethdev_mp_response *resp;
+	const struct ethdev_mp_request *req;
 
 	resp = (struct ethdev_mp_response *)mp_resp.param;
 	mp_resp.len_param = sizeof(*resp);
-	resp->res_op = req->operation;
 
 	/* recv client requests */
-	if (mp_msg->len_param != sizeof(*req))
+	if (mp_msg->len_param < (int)sizeof(*req)) {
+		RTE_ETHDEV_LOG_LINE(ERR, "invalid request from secondary");
 		resp->err_value = -EINVAL;
-	else
-		resp->err_value = ethdev_handle_request(req);
+	} else {
+		req = (const struct ethdev_mp_request *)mp_msg->param;
+		resp->res_op = req->operation;
+		resp->err_value = ethdev_handle_request(req, mp_msg->len_param);
+
+	}
 
 	return rte_mp_reply(&mp_resp, peer);
 }
diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
index f58f161871..d2fdc20057 100644
--- a/lib/ethdev/ethdev_private.h
+++ b/lib/ethdev/ethdev_private.h
@@ -85,6 +85,9 @@ int eth_dev_tx_queue_config(struct rte_eth_dev *dev, uint16_t nb_queues);
 enum ethdev_mp_operation {
 	ETH_REQ_START,
 	ETH_REQ_STOP,
+	ETH_REQ_RESET,
+	ETH_REQ_ADD_MIRROR,
+	ETH_REQ_REMOVE_MIRROR,
 };
 
 struct ethdev_mp_request {
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index 482befc209..e137afcbf7 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -1035,6 +1035,23 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(ret);
 )
 
+RTE_TRACE_POINT(
+	rte_eth_trace_add_mirror,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id,
+			     const struct rte_eth_mirror_conf *conf, int ret),
+	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_u16(conf->target);
+	rte_trace_point_emit_int(ret);
+)
+
+RTE_TRACE_POINT(
+	rte_eth_trace_remove_mirror,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t target_id, int ret),
+	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_u16(target_id);
+	rte_trace_point_emit_int(ret);
+)
+
 RTE_TRACE_POINT(
 	rte_eth_trace_rx_queue_info_get,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id, uint16_t queue_id,
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index 071c508327..fa1fd21809 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -389,6 +389,12 @@ RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_rx_callback,
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_tx_callback,
 	lib.ethdev.remove_tx_callback)
 
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_add_mirror,
+	lib.ethdev.add_mirror)
+
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_remove_mirror,
+	lib.ethdev.remove_mirror)
+
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_rx_queue_info_get,
 	lib.ethdev.rx_queue_info_get)
 
diff --git a/lib/ethdev/meson.build b/lib/ethdev/meson.build
index f1d2586591..3672b6a35b 100644
--- a/lib/ethdev/meson.build
+++ b/lib/ethdev/meson.build
@@ -11,6 +11,7 @@ sources = files(
         'rte_ethdev_cman.c',
         'rte_ethdev_telemetry.c',
         'rte_flow.c',
+        'rte_mirror.c',
         'rte_mtr.c',
         'rte_tm.c',
         'sff_telemetry.c',
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 41363af2c3..6602a771bd 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -14,6 +14,8 @@
 #include <bus_driver.h>
 #include <eal_export.h>
 #include <rte_log.h>
+#include <rte_cycles.h>
+#include <rte_alarm.h>
 #include <rte_interrupts.h>
 #include <rte_kvargs.h>
 #include <rte_memcpy.h>
@@ -2041,13 +2043,16 @@ rte_eth_dev_reset(uint16_t port_id)
 	if (dev->dev_ops->dev_reset == NULL)
 		return -ENOTSUP;
 
-	ret = rte_eth_dev_stop(port_id);
-	if (ret != 0) {
-		RTE_ETHDEV_LOG_LINE(ERR,
-			"Failed to stop device (port %u) before reset: %s - ignore",
-			port_id, rte_strerror(-ret));
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		ret = rte_eth_dev_stop(port_id);
+		if (ret != 0)
+			RTE_ETHDEV_LOG_LINE(ERR,
+				    "Failed to stop device (port %u) before reset: %s - ignore",
+				    port_id, rte_strerror(-ret));
+		ret = eth_err(port_id, dev->dev_ops->dev_reset(dev));
+	} else {
+		ret = ethdev_request(port_id, ETH_REQ_STOP, NULL, 0);
 	}
-	ret = eth_err(port_id, dev->dev_ops->dev_reset(dev));
 
 	rte_ethdev_trace_reset(port_id, ret);
 
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index f9fb6ae549..84c757ae37 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -170,6 +170,7 @@
 
 #include "rte_ethdev_trace_fp.h"
 #include "rte_dev_info.h"
+#include "rte_mirror.h"
 
 #ifdef __cplusplus
 extern "C" {
@@ -1466,7 +1467,6 @@ enum rte_eth_tunnel_type {
 	RTE_ETH_TUNNEL_TYPE_ECPRI,
 	RTE_ETH_TUNNEL_TYPE_MAX,
 };
-
 #ifdef __cplusplus
 }
 #endif
@@ -6334,6 +6334,17 @@ rte_eth_rx_burst(uint16_t port_id, uint16_t queue_id,
 
 	nb_rx = p->rx_pkt_burst(qd, rx_pkts, nb_pkts);
 
+#ifdef RTE_ETHDEV_MIRROR
+	{
+		const struct rte_eth_mirror *mirror
+			= rte_atomic_load_explicit(p->rx_mirror, rte_memory_order_relaxed);
+
+		if (unlikely(mirror != NULL))
+			rte_eth_mirror_burst(port_id, queue_id, RTE_ETH_MIRROR_DIRECTION_INGRESS,
+					     rx_pkts, nb_rx, mirror);
+	}
+#endif
+
 #ifdef RTE_ETHDEV_RXTX_CALLBACKS
 	{
 		void *cb;
@@ -6692,6 +6703,16 @@ rte_eth_tx_burst(uint16_t port_id, uint16_t queue_id,
 	}
 #endif
 
+#ifdef  RTE_ETHDEV_MIRROR
+	{
+		const struct rte_eth_mirror *mirror;
+
+		mirror = rte_atomic_load_explicit(p->tx_mirror, rte_memory_order_relaxed);
+		if (unlikely(mirror != NULL))
+			rte_eth_mirror_burst(port_id, queue_id, RTE_ETH_MIRROR_DIRECTION_EGRESS,
+					     tx_pkts, nb_pkts, mirror);
+	}
+#endif
 	nb_pkts = p->tx_pkt_burst(qd, tx_pkts, nb_pkts);
 
 	rte_ethdev_trace_tx_burst(port_id, queue_id, (void **)tx_pkts, nb_pkts);
diff --git a/lib/ethdev/rte_ethdev_core.h b/lib/ethdev/rte_ethdev_core.h
index e55fb42996..b72050d41b 100644
--- a/lib/ethdev/rte_ethdev_core.h
+++ b/lib/ethdev/rte_ethdev_core.h
@@ -22,6 +22,12 @@ RTE_TAILQ_HEAD(rte_eth_dev_cb_list, rte_eth_dev_callback);
 
 struct rte_eth_dev;
 
+struct rte_eth_mirror;
+
+void rte_eth_mirror_burst(uint16_t port_id, uint16_t quque_id, uint8_t dir,
+			  struct rte_mbuf **pkts, uint16_t nb_pkts,
+			  const struct rte_eth_mirror *mirror);
+
 /**
  * @internal Retrieve input packets from a receive queue of an Ethernet device.
  */
@@ -101,7 +107,8 @@ struct __rte_cache_aligned rte_eth_fp_ops {
 	eth_rx_descriptor_status_t rx_descriptor_status;
 	/** Refill Rx descriptors with the recycling mbufs. */
 	eth_recycle_rx_descriptors_refill_t recycle_rx_descriptors_refill;
-	uintptr_t reserved1[2];
+	uintptr_t reserved1;
+	RTE_ATOMIC(struct rte_eth_mirror *) *rx_mirror;
 	/**@}*/
 
 	/**@{*/
@@ -121,7 +128,8 @@ struct __rte_cache_aligned rte_eth_fp_ops {
 	eth_recycle_tx_mbufs_reuse_t recycle_tx_mbufs_reuse;
 	/** Get the number of used Tx descriptors. */
 	eth_tx_queue_count_t tx_queue_count;
-	uintptr_t reserved2[1];
+	RTE_ATOMIC(struct rte_eth_mirror *) *tx_mirror;
+	uintptr_t reserved2;
 	/**@}*/
 
 };
diff --git a/lib/ethdev/rte_mirror.c b/lib/ethdev/rte_mirror.c
new file mode 100644
index 0000000000..accc794bf3
--- /dev/null
+++ b/lib/ethdev/rte_mirror.c
@@ -0,0 +1,359 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_config.h>
+#include <rte_bitops.h>
+#include <rte_eal.h>
+#include <rte_log.h>
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_alarm.h>
+#include <rte_ether.h>
+#include <rte_malloc.h>
+#include <rte_mbuf.h>
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+#include <eal_export.h>
+
+#include "rte_ethdev.h"
+#include "rte_mirror.h"
+#include "ethdev_driver.h"
+#include "ethdev_private.h"
+#include "ethdev_trace.h"
+
+/* Upper bound of packet bursts redirected */
+#define RTE_MIRROR_BURST_SIZE 64
+
+/* spinlock for setting up mirror ports */
+static rte_spinlock_t mirror_port_lock = RTE_SPINLOCK_INITIALIZER;
+
+/* dynamically assigned offload flag to indicate ingress vs egress */
+static uint64_t mirror_origin_flag;
+static int mirror_origin_offset = -1;
+static uint64_t mirror_ingress_flag;
+static uint64_t mirror_egress_flag;
+
+static uint64_t mbuf_timestamp_dynflag;
+static int mbuf_timestamp_offset = -1;
+
+/* register dynamic mbuf fields, done on first mirror creation */
+static int
+ethdev_dyn_mirror_register(void)
+{
+	const struct rte_mbuf_dynfield field_desc = {
+		.name = RTE_MBUF_DYNFIELD_MIRROR_ORIGIN,
+		.size = sizeof(rte_mbuf_origin_t),
+		.align = sizeof(rte_mbuf_origin_t),
+	};
+	struct rte_mbuf_dynflag flag_desc = {
+		.name = RTE_MBUF_DYNFLAG_MIRROR_ORIGIN,
+	};
+	int offset;
+
+	if (rte_mbuf_dyn_tx_timestamp_register(&mbuf_timestamp_offset,
+					       &mbuf_timestamp_dynflag) < 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Failed to register timestamp flag");
+		return -1;
+	}
+
+	offset = rte_mbuf_dynfield_register(&field_desc);
+	if (offset < 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf origin field");
+		return -1;
+	}
+	mirror_origin_offset = offset;
+
+	offset = rte_mbuf_dynflag_register(&flag_desc);
+	if (offset < 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf origin flag");
+		return -1;
+	}
+	mirror_origin_flag = RTE_BIT64(offset);
+
+	strlcpy(flag_desc.name, RTE_MBUF_DYNFLAG_MIRROR_INGRESS, sizeof(flag_desc.name));
+	offset = rte_mbuf_dynflag_register(&flag_desc);
+	if (offset < 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf ingress flag");
+		return -1;
+	}
+	mirror_ingress_flag = RTE_BIT64(offset);
+
+	strlcpy(flag_desc.name, RTE_MBUF_DYNFLAG_MIRROR_EGRESS,
+		sizeof(flag_desc.name));
+	offset = rte_mbuf_dynflag_register(&flag_desc);
+	if (offset < 0) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Failed to register mbuf egress flag");
+		return -1;
+	}
+	mirror_egress_flag = RTE_BIT64(offset);
+
+	return 0;
+}
+
+/**
+ * Structure used to hold information mirror port mirrors for a
+ * queue on Rx and Tx.
+ */
+struct rte_eth_mirror {
+	RTE_ATOMIC(struct rte_eth_mirror *) next;
+	struct rte_eth_mirror_conf conf;
+};
+
+/* Add a new mirror entry to the list. */
+static int
+ethdev_insert_mirror(RTE_ATOMIC(struct rte_eth_mirror **) top,
+		   const struct rte_eth_mirror_conf *conf)
+{
+	struct rte_eth_mirror *mirror;
+
+	/* Don't allow multiple mirrors from same source to target */
+	while ( (mirror = *top) != NULL) {
+		if (mirror->conf.target == conf->target) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+				    "Mirror to port %u already exists", conf->target);
+			return -EEXIST;
+		}
+	}
+
+	mirror = rte_zmalloc(NULL, sizeof(*mirror), 0);
+	if (mirror == NULL)
+		return -ENOMEM;
+
+	mirror->conf = *conf;
+	/* specifying 0 implies the full packet */
+	if (conf->snaplen == 0)
+		mirror->conf.snaplen = UINT32_MAX;
+
+	mirror->next = *top;
+
+	rte_atomic_store_explicit(top, mirror, rte_memory_order_relaxed);
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_add_mirror, 25.11)
+int
+rte_eth_add_mirror(uint16_t port_id, const struct rte_eth_mirror_conf *conf)
+{
+#ifndef RTE_ETHDEV_MIRROR
+	return -ENOTSUP;
+#endif
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+
+	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+	struct rte_eth_dev_info dev_info;
+
+	if (conf == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Missing configuration information");
+		return -EINVAL;
+	}
+
+	if (conf->direction == 0 || conf->direction >
+	    (RTE_ETH_MIRROR_DIRECTION_INGRESS | RTE_ETH_MIRROR_DIRECTION_EGRESS)) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Invalid direction %#x", conf->direction);
+		return -EINVAL;
+	}
+
+	if (conf->mp == NULL) {
+		RTE_ETHDEV_LOG_LINE(ERR, "not a valid mempool");
+		return -EINVAL;
+	}
+
+	if (conf->flags & ~RTE_ETH_MIRROR_FLAG_MASK) {
+		RTE_ETHDEV_LOG_LINE(ERR, "unsupported flags");
+		return -EINVAL;
+	}
+
+	/* Checks that target exists */
+	int ret = rte_eth_dev_info_get(conf->target, &dev_info);
+	if (ret != 0)
+		return ret;
+
+	/* Loopback mirror could create packet storm */
+	if (conf->target == port_id) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Cannot mirror port to self");
+		return -EINVAL;
+	}
+
+	/* Because multiple directions and multiple queues will all going to the mirror port
+	 * need the transmit path to be lockfree.
+	 */
+	if (!(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE)) {
+		RTE_ETHDEV_LOG_LINE(ERR, "Mirror needs lockfree transmit");
+		return -ENOTSUP;
+	}
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		/* Register dynamic fields once */
+		if (mirror_origin_offset < 0) {
+			ret = ethdev_dyn_mirror_register();
+			if (ret < 0)
+				return ret;
+		}
+
+		rte_spinlock_lock(&mirror_port_lock);
+		ret = 0;
+		if (conf->direction & RTE_ETH_MIRROR_DIRECTION_INGRESS)
+			ret = ethdev_insert_mirror(&dev->rx_mirror, conf);
+		if (ret == 0 && (conf->direction & RTE_ETH_MIRROR_DIRECTION_EGRESS))
+			ret = ethdev_insert_mirror(&dev->tx_mirror, conf);
+		rte_spinlock_unlock(&mirror_port_lock);
+	} else {
+		/* in secondary, proxy to primary */
+		ret = ethdev_request(port_id, ETH_REQ_ADD_MIRROR, conf, sizeof(*conf));
+		if (ret != 0)
+			return ret;
+	}
+
+	rte_eth_trace_add_mirror(port_id, conf, ret);
+	return ret;
+}
+
+static bool
+ethdev_delete_mirror(RTE_ATOMIC(struct rte_eth_mirror **) top, uint16_t target_id)
+{
+	struct rte_eth_mirror *mirror;
+
+	while ((mirror = *top) != NULL) {
+		if (mirror->conf.target == target_id)
+			goto found;
+		top = &mirror->next;
+	}
+	/* not found in list */
+	return false;
+
+found:
+	/* unlink from list */
+	rte_atomic_store_explicit(top, mirror->next, rte_memory_order_relaxed);
+
+	/* Defer freeing the mirror until after one second
+	 * to allow for active threads that are using it.
+	 * Assumes no PMD takes more than one second to transmit a burst.
+	 * Alternative would be RCU, but RCU in DPDK is optional.
+	 */
+	rte_eal_alarm_set(US_PER_S, rte_free, mirror);
+	return true;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_remove_mirror, 25.11)
+int
+rte_eth_remove_mirror(uint16_t port_id, uint16_t target_id)
+{
+#ifndef RTE_ETHDEV_MIRROR
+	return -ENOTSUP;
+#endif
+	int ret = 0;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(target_id, -ENODEV);
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		bool found;
+
+		rte_spinlock_lock(&mirror_port_lock);
+		found = ethdev_delete_mirror(&dev->rx_mirror, target_id);
+		found |= ethdev_delete_mirror(&dev->tx_mirror, target_id);
+		rte_spinlock_unlock(&mirror_port_lock);
+		if (!found)
+			ret = -ENOENT; /* no mirror present */
+	} else {
+		ret = ethdev_request(port_id, ETH_REQ_REMOVE_MIRROR,
+				     &target_id, sizeof(target_id));
+	}
+
+	rte_eth_trace_remove_mirror(port_id, target_id, ret);
+	return ret;
+}
+
+static inline void
+eth_dev_mirror(uint16_t port_id, uint16_t queue_id, uint8_t direction,
+	     struct rte_mbuf **pkts, uint16_t nb_pkts,
+	     const struct rte_eth_mirror_conf *conf)
+{
+	struct rte_mbuf *tosend[RTE_MIRROR_BURST_SIZE];
+	unsigned int count = 0;
+	unsigned int i;
+
+	for (i = 0; i < nb_pkts; i++) {
+		struct rte_mbuf *m = pkts[i];
+		struct rte_mbuf *mc;
+
+		if (conf->flags & RTE_ETH_MIRROR_INDIRECT_FLAG) {
+			mc = rte_pktmbuf_alloc(conf->mp);
+			if (unlikely(mc == NULL))
+				continue;
+
+			/* Make both mbuf's point to the same data */
+			rte_pktmbuf_attach(mc, m);
+		} else {
+			mc = rte_pktmbuf_copy(m, conf->mp, 0, conf->snaplen);
+			/* TODO: dropped stats? */
+			if (unlikely(mc == NULL))
+				continue;
+		}
+
+		/* Put info about origin of the packet */
+		if (conf->flags & RTE_ETH_MIRROR_ORIGIN_FLAG) {
+			struct rte_mbuf_origin *origin
+				= RTE_MBUF_DYNFIELD(mc, mirror_origin_offset, rte_mbuf_origin_t *);
+			origin->original_len = m->pkt_len;
+			origin->port_id = port_id;
+			origin->queue_id = queue_id;
+			mc->ol_flags |= mirror_origin_flag;
+		}
+
+		/* Insert timestamp into packet */
+		if (conf->flags & RTE_ETH_MIRROR_TIMESTAMP_FLAG) {
+			*RTE_MBUF_DYNFIELD(m, mbuf_timestamp_offset, rte_mbuf_timestamp_t *)
+				= rte_get_tsc_cycles();
+			mc->ol_flags |= mbuf_timestamp_dynflag;
+		}
+
+		mc->ol_flags &= ~(mirror_ingress_flag | mirror_egress_flag);
+		if (direction & RTE_ETH_MIRROR_DIRECTION_INGRESS)
+			mc->ol_flags |= mirror_ingress_flag;
+		else if (direction & RTE_ETH_MIRROR_DIRECTION_EGRESS)
+			mc->ol_flags |= mirror_egress_flag;
+
+		tosend[count++] = mc;
+	}
+
+	uint16_t nsent = rte_eth_tx_burst(conf->target, 0, tosend, count);
+	if (unlikely(nsent < count)) {
+		uint16_t drop = count - nsent;
+
+		/* TODO: need some stats here? */
+		rte_pktmbuf_free_bulk(pkts + nsent, drop);
+	}
+}
+
+/* This function is really internal but used from inline */
+RTE_EXPORT_SYMBOL(rte_eth_mirror_burst)
+void
+rte_eth_mirror_burst(uint16_t port_id, uint16_t queue_id, uint8_t direction,
+		     struct rte_mbuf **pkts, uint16_t nb_pkts,
+		     const struct rte_eth_mirror *mirror)
+{
+	unsigned int i;
+
+	while (mirror != NULL) {
+		for (i = 0; i < nb_pkts; i += RTE_MIRROR_BURST_SIZE) {
+			uint16_t left  = nb_pkts - i;
+			uint16_t burst = RTE_MIN(left, RTE_MIRROR_BURST_SIZE);
+
+			eth_dev_mirror(port_id, queue_id, direction,
+				       pkts + i, burst, &mirror->conf);
+		}
+
+		mirror = rte_atomic_load_explicit(&mirror->next, rte_memory_order_relaxed);
+	}
+}
diff --git a/lib/ethdev/rte_mirror.h b/lib/ethdev/rte_mirror.h
new file mode 100644
index 0000000000..9369309958
--- /dev/null
+++ b/lib/ethdev/rte_mirror.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#ifndef RTE_MIRROR_H_
+#define RTE_MIRROR_H_
+
+#include <stdint.h>
+
+#include <rte_compat.h>
+#include <rte_mbuf.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * @file
+ * Ethdev port mirroring
+ *
+ * This interface provides the ability to duplicate packets to another port.
+ */
+
+/* Definitions for ethdev analyzer direction */
+#define RTE_ETH_MIRROR_DIRECTION_INGRESS 1
+#define RTE_ETH_MIRROR_DIRECTION_EGRESS 2
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this structure may change without prior notice.
+ *
+ * This dynamic field is added to mbuf's when they are copied to
+ * the port mirror.
+ */
+typedef struct rte_mbuf_origin {
+	uint32_t original_len;	/**< Packet length before copy */
+	uint16_t port_id;	/**< Port where packet originated */
+	uint16_t queue_id;      /**< Queue used for Tx or Rx */
+} rte_mbuf_origin_t;
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this structure may change without prior notice.
+ *
+ * Structure used to configure ethdev Switched Port Analyzer (MIRROR)
+ */
+struct rte_eth_mirror_conf {
+	struct rte_mempool *mp;	/**< Memory pool for copies, If NULL then cloned. */
+	uint32_t snaplen;	/**< Upper limit on number of bytes to copy */
+	uint32_t flags;		/**< bitmask of RTE_ETH_MIRROR_XXX_FLAG's */
+	uint16_t target;	/**< Destination port */
+	uint8_t direction;	/**< bitmask of RTE_ETH_MIRROR_DIRECTION_XXX */
+};
+
+#define RTE_ETH_MIRROR_TIMESTAMP_FLAG 1	/**< insert timestamp into mirrored packet */
+#define RTE_ETH_MIRROR_ORIGIN_FLAG 2	/**< insert rte_mbuf_origin into mirrored packet */
+#define RTE_ETH_MIRROR_INDIRECT_FLAG 4  /**< use rte_mbuf_attach rather than copy */
+
+#define RTE_ETH_MIRROR_FLAG_MASK 7
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Create a Switched Port Analyzer (MIRROR) instance.
+ *
+ * @param port_id
+ *   The port identifier of the source Ethernet device.
+ * @param conf
+ *   Settings for this MIRROR instance..
+ * @return
+ *   Negative errno value on error, 0 on success.
+ */
+__rte_experimental
+int
+rte_eth_add_mirror(uint16_t port_id, const struct rte_eth_mirror_conf *conf);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
+ *
+ * Break port mirrorning.
+ * After this call no more packets will be sent the target port.
+ *
+ * @param port_id
+ *   The port identifier of the source Ethernet device.
+ * @param target_id
+ *   The identifier of the destination port.
+ * @return
+ *   Negative errno value on error, 0 on success.
+ */
+__rte_experimental
+int rte_eth_remove_mirror(uint16_t port_id, uint16_t target_id);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* RTE_MIRROR_H_ */
-- 
2.47.2

