Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B89C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:32:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C32840BA3;
	Tue,  1 Sep 2026 22:32:46 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3165540BA3
 for <dev@dpdk.org>; Tue,  1 Sep 2026 22:32:45 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-853c947bfefso250389b3a.0
 for <dev@dpdk.org>; Tue, 01 Sep 2026 13:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788294764;
 x=1788899564; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zNyQv9wSGeH63EDSMRG5IfsckU/cPSXeX5nCm1ogCcs=;
 b=sCaGJbPk2D23NUUwFYdQ4Kcj75Y9kG5YkMqmDFR3NH2hQ7xJv2BtloewrAsdD48H7e
 r09LQfx87CDttx4HMITfZLlgHWOEhKxMHO52+6mS7gE/U9dO+aCRpPOJAwyAoC2+m29W
 zKPuX7LSKkc2rKlBPuT3Ngsf5JdVhtCy0y4ev+0WJdsn5+bhgvGLdEhAO6G14wI0V7w2
 rh7kJsXKQBZX5TYTUW9t22u+X1be8Y6LctDK3V56vgNxKc7vO2nEOb9L0jYjPGbjH8Kx
 9hmJ+b9ebSTVmPi86bCZzwOxzyD+LRvXuAqrGCjiJXkArIcbsF3IpnclG+C6ZcOgqQYv
 1aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294764; x=1788899564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zNyQv9wSGeH63EDSMRG5IfsckU/cPSXeX5nCm1ogCcs=;
 b=ViC0/Tg37qilwTAFzqCyKb8BywJIravqrUU2lB6HAcei3kJTIF9uOG89ZZ0jlF8sLn
 IQTbBKJ0pCQFuIhBjY2Ssp6w1Ckt/XXoQajXXPbKnxWlpcK1J1bOAi8EGe3WOzetvgcI
 4gqR5xYu+XpWcbJ5YwjzE/2EPyvaj+BWg+KncdbVbf/wtgvxMGUqikEdhjmeE0duoFvS
 1zEMLWyhrPF3YYs/aBqxSCewInGY1Wg7LO46r+s0ygXVRolAvb7kGEdYz3ZgggDhU5jv
 WkyZNzJ1sGvr7NAxvNNHLFfnups+PZu0B2hXg4IPFo9bmSStFRQzO+sGUHuAwxIz9lkG
 D2gQ==
X-Gm-Message-State: AFuF++nAjigBi/x+viZCyGKBGo80Pt+I9t0Y0tBRRoXHo/HMsrOGx9G1
 TnTu4fVH5ZAt5omYzVWl12TNrriuxcsi2On+gtioZkm+DjvQhZrbX9v5TIwh/DLgzv7lRMFU2eu
 hLCmV
X-Gm-Gg: AR+sD10tQ7xU9OpewbW8qfM8YuAAhjPhu+vOB9nKRbiD8Hl1x7LASfuyTcsBEJNfH0S
 y5V3TcdXh+6RpSbWdTbMKwcTm6/w1oiKCLzevBR0fU3lb7CPpJjhNG2VZhY53rhsUzPD7zhwvcf
 6um7lqkxId8Wj3Xtr1kSs4HsfQmrh4fhvCXKAmgSb9eSMKZYPpy2+BmrrD0gHDCadkc6G5MJdQT
 InpaPtUcymmzcAa/VbW+8ofyXWHR+O8MroVESZKwZPSN2U6+WkjMmPZ9IOTSaviJ8SovwqqUn23
 3uWD7R1z1+LsgxFjD9KqVxD6D6ZXllvwoboVSot72QNA3RcsylrkvMZ4c/6MVQG90YWmRDb/7PQ
 pwwBTOB6FAVL7EKv9MIVyBveU5rR5PCdxfeHEnVNo+vI2P1R45nuK7B0Ril92T7k6mkCHv0axiz
 RPjDkqNhg7Ct1PvWGcT/KM7DMXuBDXAOS2gkYAQ3dQcW4uQTVThUr0o2P4dTCAWxAVQYWN0hze3
 8GYoQZM7ygEmrg+mjxIyZnVEOZi
X-Received: by 2002:a05:6a00:7099:b0:853:af4d:6292 with SMTP id
 d2e1a72fcca58-85bc6173f11mr6830631b3a.0.1788294764261; 
 Tue, 01 Sep 2026 13:32:44 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85dc0bffbc1sm323980b3a.48.2026.09.01.13.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:32:43 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH 04/22] ethdev: promote hairpin API to stable
Date: Tue,  1 Sep 2026 13:23:03 -0700
Message-ID: <20260901203217.1485915-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

Hairpin support was introduced in v19.11 with the queue setup and
capability query functions, and completed in v20.11 with the
explicit bind/unbind and peer port query functions:

  19.11  rte_eth_rx_hairpin_queue_setup
         rte_eth_tx_hairpin_queue_setup
         rte_eth_dev_hairpin_capability_get
  20.11  rte_eth_hairpin_bind
         rte_eth_hairpin_unbind
         rte_eth_hairpin_get_peer_ports

The interface has been unchanged since and is implemented by
several PMDs, so promote the feature as a whole.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst |  6 +++++
 lib/ethdev/rte_ethdev.c                | 12 ++++-----
 lib/ethdev/rte_ethdev.h                | 36 --------------------------
 3 files changed, 12 insertions(+), 42 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 77ee3380f9..8a60d21a1d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -100,6 +100,12 @@ API Changes
   * meter (MTR) and policing: ``rte_mtr_*``
   * SFF: ``rte_eth_dev_get_module_info`` and ``rte_eth_dev_get_module_eeprom``
   * flow conversion: ``rte_flow_conv``
+  * hairpin queue: ``rte_eth_rx_hairpin_queue_setup``,
+    ``rte_eth_tx_hairpin_queue_setup``,
+    ``rte_eth_dev_hairpin_capability_get``,
+    ``rte_eth_hairpin_bind``,
+    ``rte_eth_hairpin_unbind``,
+    ``rte_eth_hairpin_get_peer_ports``
 
 
 ABI Changes
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 78ad12c2c0..f27f698406 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -2506,7 +2506,7 @@ rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	return eth_err(port_id, ret);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rx_hairpin_queue_setup, 19.11)
+RTE_EXPORT_SYMBOL(rte_eth_rx_hairpin_queue_setup)
 int
 rte_eth_rx_hairpin_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 			       uint16_t nb_rx_desc,
@@ -2724,7 +2724,7 @@ rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		       tx_queue_id, nb_tx_desc, socket_id, &local_conf));
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_tx_hairpin_queue_setup, 19.11)
+RTE_EXPORT_SYMBOL(rte_eth_tx_hairpin_queue_setup)
 int
 rte_eth_tx_hairpin_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 			       uint16_t nb_tx_desc,
@@ -2824,7 +2824,7 @@ rte_eth_tx_hairpin_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_bind, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_hairpin_bind)
 int
 rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port)
 {
@@ -2852,7 +2852,7 @@ rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_unbind, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_hairpin_unbind)
 int
 rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port)
 {
@@ -2880,7 +2880,7 @@ rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hairpin_get_peer_ports, 20.11)
+RTE_EXPORT_SYMBOL(rte_eth_hairpin_get_peer_ports)
 int
 rte_eth_hairpin_get_peer_ports(uint16_t port_id, uint16_t *peer_ports,
 			       size_t len, uint32_t direction)
@@ -7094,7 +7094,7 @@ rte_eth_dev_adjust_nb_rx_tx_desc(uint16_t port_id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_hairpin_capability_get, 19.11)
+RTE_EXPORT_SYMBOL(rte_eth_dev_hairpin_capability_get)
 int
 rte_eth_dev_hairpin_capability_get(uint16_t port_id,
 				   struct rte_eth_hairpin_cap *cap)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 7f0333cbd1..33ec81792d 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1240,9 +1240,6 @@ struct rte_eth_txconf {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to return the Tx or Rx hairpin queue capabilities.
  */
 struct rte_eth_hairpin_queue_cap {
@@ -1262,9 +1259,6 @@ struct rte_eth_hairpin_queue_cap {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to return the hairpin capabilities that are supported.
  */
 struct rte_eth_hairpin_cap {
@@ -1282,9 +1276,6 @@ struct rte_eth_hairpin_cap {
 #define RTE_ETH_MAX_HAIRPIN_PEERS 32
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to hold hairpin peer data.
  */
 struct rte_eth_hairpin_peer {
@@ -1293,9 +1284,6 @@ struct rte_eth_hairpin_peer {
 };
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * A structure used to configure hairpin binding.
  */
 struct rte_eth_hairpin_conf {
@@ -2531,9 +2519,6 @@ int rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 		struct rte_mempool *mb_pool);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Allocate and set up a hairpin receive queue for an Ethernet device.
  *
  * The function set up the selected queue to be used in hairpin.
@@ -2557,7 +2542,6 @@ int rte_eth_rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
  *   - (-EINVAL) if bad parameter.
  *   - (-ENOMEM) if unable to allocate the resources.
  */
-__rte_experimental
 int rte_eth_rx_hairpin_queue_setup
 	(uint16_t port_id, uint16_t rx_queue_id, uint16_t nb_rx_desc,
 	 const struct rte_eth_hairpin_conf *conf);
@@ -2615,9 +2599,6 @@ int rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		const struct rte_eth_txconf *tx_conf);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Allocate and set up a transmit hairpin queue for an Ethernet device.
  *
  * @param port_id
@@ -2639,15 +2620,11 @@ int rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
  *   - (-EINVAL) if bad parameter.
  *   - (-ENOMEM) if unable to allocate the resources.
  */
-__rte_experimental
 int rte_eth_tx_hairpin_queue_setup
 	(uint16_t port_id, uint16_t tx_queue_id, uint16_t nb_tx_desc,
 	 const struct rte_eth_hairpin_conf *conf);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Get all the hairpin peer Rx / Tx ports of the current port.
  * The caller should ensure that the array is large enough to save the ports
  * list.
@@ -2670,14 +2647,10 @@ int rte_eth_tx_hairpin_queue_setup
  *   - (-ENOTSUP) if hardware doesn't support.
  *   - Others detailed errors from PMDs.
  */
-__rte_experimental
 int rte_eth_hairpin_get_peer_ports(uint16_t port_id, uint16_t *peer_ports,
 				   size_t len, uint32_t direction);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Bind all hairpin Tx queues of one port to the Rx queues of the peer port.
  * It is only allowed to call this function after all hairpin queues are
  * configured properly and the devices are in started state.
@@ -2696,13 +2669,9 @@ int rte_eth_hairpin_get_peer_ports(uint16_t port_id, uint16_t *peer_ports,
  *   - (-ENOTSUP) if hardware doesn't support.
  *   - Others detailed errors from PMDs.
  */
-__rte_experimental
 int rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Unbind all hairpin Tx queues of one port from the Rx queues of the peer port.
  * This should be called before closing the Tx or Rx devices, if the bind
  * function is called before.
@@ -2723,7 +2692,6 @@ int rte_eth_hairpin_bind(uint16_t tx_port, uint16_t rx_port);
  *   - (-ENOTSUP) if hardware doesn't support.
  *   - Others detailed errors from PMDs.
  */
-__rte_experimental
 int rte_eth_hairpin_unbind(uint16_t tx_port, uint16_t rx_port);
 
 /**
@@ -5755,9 +5723,6 @@ void *
 rte_eth_dev_get_sec_ctx(uint16_t port_id);
 
 /**
- * @warning
- * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
- *
  * Query the device hairpin capabilities.
  *
  * @param port_id
@@ -5769,7 +5734,6 @@ rte_eth_dev_get_sec_ctx(uint16_t port_id);
  *   - (-ENOTSUP) if hardware doesn't support.
  *   - (-EINVAL) if bad parameter.
  */
-__rte_experimental
 int rte_eth_dev_hairpin_capability_get(uint16_t port_id,
 				       struct rte_eth_hairpin_cap *cap);
 
-- 
2.53.0

