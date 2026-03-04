Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E77EDEBE7
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 01:49:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AAAA740664;
	Wed,  4 Mar 2026 02:49:34 +0100 (CET)
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com
 [209.85.214.202])
 by mails.dpdk.org (Postfix) with ESMTP id 2E4414064C
 for <dev@dpdk.org>; Wed,  4 Mar 2026 02:49:33 +0100 (CET)
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2ae4a6bb316so31784555ad.1
 for <dev@dpdk.org>; Tue, 03 Mar 2026 17:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772588972; x=1773193772; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=1yggORB9/42eYBgKn3bVVXBHGMEX4Q/kgXJehJMnZKQ=;
 b=rrrI2HwpHLI6HsfpO/60iMk7uYbiUFrATFuksfOhuboJ9SHFLbzvIUb/Ga5HpjAtY5
 5G22LsKD8Bid7cDJXdToSVXet+5Ta/JJznb4KdRam15HuaxHto//SxNPrmSrHqfTxXs8
 Zf8TNeaXVeLBc5JNHmiDQNSeFVdjhQpRUAWK6nJVGa1q/B6ysqwLItEt91ZilS5Z4SWe
 JtPrXdYN/AGWEWs4eiy1ptTzyc2GM+/c+CPK2tpZZNEP1u75cAjASxq0m+Cq142oWW3I
 EL1qhfI2GnnQqb1z2/4rHin3+JJYqJDkgBKrDNXXSLXTO47vATloIHZUT4kBSNLTd9ez
 972w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772588972; x=1773193772;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1yggORB9/42eYBgKn3bVVXBHGMEX4Q/kgXJehJMnZKQ=;
 b=Ao015zw3EfMShO1dWpVK0ZaPeqmAGoMe6S2fS1/arpvqn4/ED9kFBJ6aq5C6nmOPnY
 RCm7969LY797UJLHfCNtJEdLnisfE8wUhwj5rEd7wIqSAOmU2Ly6RGA/zpkOEWV0cGjg
 P6EllxknHQDOiUoONwC6iyN7giovx7SwdHp4XMbqKusPDQzxVZ3dgtWNdODK6aB+n/vL
 AA6KJCQgxZzIO5ieTlptBoNOAEp36dveL1AK+LwqUIXrRmIceoNyXE/FiSRMjkRqotW2
 kaXfevSRoViyV6VRbGh63kx/4k1Kt4SiZjJpBUD8fr0orYK05yXYRlgPcmxYqsJA1Lnb
 7gPg==
X-Gm-Message-State: AOJu0YwpuZkrDuO5nbR/y0CsAlN+pEl1vFYKhP7opWo0Z+ZTx9lVhrb3
 /AOxuGNBqv1TmSW19oq5aaku86lOsh+nGER7gjMx97V4kp9wsG6DDDcGdJx3vCU2H8g4SwHlZgu
 MnXfEf9ZG64nwml3qp9hAR9209g==
X-Received: from plbjf2.prod.google.com ([2002:a17:903:2682:b0:2a9:6366:197c])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d54f:b0:2ae:5426:da4f with SMTP id
 d9443c01a7336-2ae6aaf8629mr4989655ad.28.1772588972116; 
 Tue, 03 Mar 2026 17:49:32 -0800 (PST)
Date: Wed,  4 Mar 2026 01:46:24 +0000
In-Reply-To: <20260304014624.1297874-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260303005804.924545-1-jtranoleary@google.com>
 <20260304014624.1297874-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304014624.1297874-5-jtranoleary@google.com>
Subject: [PATCH v3 4/4] net/gve: add rte flow API integration
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, "Jasper Tran O'Leary" <jtranoleary@google.com>, 
 Vee Agarwal <veethebee@google.com>, Joshua Washington <joshwash@google.com>
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

Implement driver callbacks for the following rte flow operations:
create, destroy, and flush. This change enables receive flow steering
(RFS) for n-tuple based flow rules for the gve driver.

The implementation supports matching ingress IPv4/IPv6 traffic combined
with TCP, UDP, SCTP, ESP, or AH protocols. Supported fields for
matching include IP source/destination addresses, L4 source/destination
ports (for TCP/UDP/SCTP), and SPI (for ESP/AH). The only supported
action is RTE_FLOW_ACTION_TYPE_QUEUE, which steers matching packets to
a specified rx queue.

Co-developed-by: Vee Agarwal <veethebee@google.com>
Signed-off-by: Vee Agarwal <veethebee@google.com>
Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
 doc/guides/nics/features/gve.ini       |  12 +
 doc/guides/nics/gve.rst                |  27 +
 doc/guides/rel_notes/release_26_03.rst |   1 +
 drivers/net/gve/base/gve.h             |   3 +-
 drivers/net/gve/gve_ethdev.c           |  83 +++-
 drivers/net/gve/gve_ethdev.h           |  43 ++
 drivers/net/gve/gve_flow_rule.c        | 658 +++++++++++++++++++++++++
 drivers/net/gve/gve_flow_rule.h        |   6 +
 drivers/net/gve/meson.build            |   1 +
 9 files changed, 832 insertions(+), 2 deletions(-)
 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.c

diff --git a/doc/guides/nics/features/gve.ini b/doc/guides/nics/features/gve.ini
index ed040a0..89c97fd 100644
--- a/doc/guides/nics/features/gve.ini
+++ b/doc/guides/nics/features/gve.ini
@@ -19,3 +19,15 @@ Linux                = Y
 x86-32               = Y
 x86-64               = Y
 Usage doc            = Y
+
+[rte_flow items]
+ah                   = Y
+esp                  = Y
+ipv4                 = Y
+ipv6                 = Y
+sctp                 = Y
+tcp                  = Y
+udp                  = Y
+
+[rte_flow actions]
+queue                = Y
diff --git a/doc/guides/nics/gve.rst b/doc/guides/nics/gve.rst
index 6b4d1f7..8367ca9 100644
--- a/doc/guides/nics/gve.rst
+++ b/doc/guides/nics/gve.rst
@@ -103,6 +103,33 @@ the redirection table will be available for querying upon initial hash configura
 When performing redirection table updates,
 it is possible to update individual table entries.
 
+Flow Steering
+^^^^^^^^^^^^^
+
+The driver supports receive flow steering (RFS) via the standard ``rte_flow``
+API. This allows applications to steer traffic to specific queues based on
+5-tuple matching. 3-tuple matching may be supported in future releases.
+
+**Supported Patterns**
+
+L3 Protocols
+  IPv4/IPv6 source and destination addresses.
+L4 Protocols
+  TCP/UDP/SCTP source and destination ports.
+Security Protocols
+  ESP/AH SPI.
+
+**Supported Actions**
+
+- ``RTE_FLOW_ACTION_TYPE_QUEUE``: Steer packets to a specific Rx queue.
+
+**Limitations**
+
+- Flow steering operations are only supported in the primary process.
+- Only ingress flow rules are allowed.
+- Flow priorities are not supported (must be 0).
+- Masking is limited to full matches i.e. 0x00...0 or 0xFF...F.
+
 Application-Initiated Reset
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^

 The driver allows an application to reset the gVNIC device.
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 1855d90..b643809 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -78,6 +78,7 @@ New Features
 * **Updated Google Virtual Ethernet (gve) driver.**
 
   * Added application-initiated device reset.
+  * Added support for receive flow steering.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/gve/base/gve.h b/drivers/net/gve/base/gve.h
index 99514cb..18363fa 100644
--- a/drivers/net/gve/base/gve.h
+++ b/drivers/net/gve/base/gve.h
@@ -50,7 +50,8 @@ enum gve_state_flags_bit {
 	GVE_PRIV_FLAGS_ADMIN_QUEUE_OK		= 1,
 	GVE_PRIV_FLAGS_DEVICE_RESOURCES_OK	= 2,
 	GVE_PRIV_FLAGS_DEVICE_RINGS_OK		= 3,
-	GVE_PRIV_FLAGS_NAPI_ENABLED		= 4,
+	GVE_PRIV_FLAGS_FLOW_SUBSYSTEM_OK	= 4,
+	GVE_PRIV_FLAGS_NAPI_ENABLED		= 5,
 };
 
 enum gve_rss_hash_algorithm {
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 5912fec..6ce3ef3 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -510,6 +510,49 @@ gve_free_ptype_lut_dqo(struct gve_priv *priv)
 	}
 }
 
+static int
+gve_setup_flow_subsystem(struct gve_priv *priv)
+{
+	int err;
+
+	priv->flow_rule_bmp_size =
+			rte_bitmap_get_memory_footprint(priv->max_flow_rules);
+	priv->avail_flow_rule_bmp_mem = rte_zmalloc("gve_flow_rule_bmp",
+			priv->flow_rule_bmp_size, 0);
+	if (!priv->avail_flow_rule_bmp_mem) {
+		PMD_DRV_LOG(ERR, "Failed to alloc bitmap for flow rules.");
+		err = -ENOMEM;
+		goto free_flow_rule_bmp;
+	}
+
+	err = gve_flow_init_bmp(priv);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Failed to initialize flow rule bitmap.");
+		goto free_flow_rule_bmp;
+	}
+
+	TAILQ_INIT(&priv->active_flows);
+	gve_set_flow_subsystem_ok(priv);
+
+	return 0;
+
+free_flow_rule_bmp:
+	gve_flow_free_bmp(priv);
+	return err;
+}
+
+static void
+gve_teardown_flow_subsystem(struct gve_priv *priv)
+{
+	pthread_mutex_lock(&priv->flow_rule_lock);
+
+	gve_clear_flow_subsystem_ok(priv);
+	gve_flow_free_bmp(priv);
+	gve_free_flow_rules(priv);
+
+	pthread_mutex_unlock(&priv->flow_rule_lock);
+}
+
 static void
 gve_teardown_device_resources(struct gve_priv *priv)
 {
@@ -519,7 +562,9 @@ gve_teardown_device_resources(struct gve_priv *priv)
 	if (gve_get_device_resources_ok(priv)) {
 		err = gve_adminq_deconfigure_device_resources(priv);
 		if (err)
-			PMD_DRV_LOG(ERR, "Could not deconfigure device resources: err=%d", err);
+			PMD_DRV_LOG(ERR,
+				"Could not deconfigure device resources: err=%d",
+				err);
 	}
 
 	gve_free_ptype_lut_dqo(priv);
@@ -543,6 +588,11 @@ gve_dev_close(struct rte_eth_dev *dev)
 			PMD_DRV_LOG(ERR, "Failed to stop dev.");
 	}
 
+	if (gve_get_flow_subsystem_ok(priv))
+		gve_teardown_flow_subsystem(priv);
+
+	pthread_mutex_destroy(&priv->flow_rule_lock);
+
 	gve_free_queues(dev);
 	gve_teardown_device_resources(priv);
 	gve_adminq_free(priv);
@@ -566,6 +616,9 @@ gve_dev_reset(struct rte_eth_dev *dev)
 	}
 
 	/* Tear down all device resources before re-initializing. */
+	if (gve_get_flow_subsystem_ok(priv))
+		gve_teardown_flow_subsystem(priv);
+
 	gve_free_queues(dev);
 	gve_teardown_device_resources(priv);
 	gve_adminq_free(priv);
@@ -1094,6 +1147,18 @@ gve_rss_reta_query(struct rte_eth_dev *dev,
 	return 0;
 }
 
+static int
+gve_flow_ops_get(struct rte_eth_dev *dev, const struct rte_flow_ops **ops)
+{
+	struct gve_priv *priv = dev->data->dev_private;
+
+	if (!gve_get_flow_subsystem_ok(priv))
+		return -ENOTSUP;
+
+	*ops = &gve_flow_ops;
+	return 0;
+}
+
 static const struct eth_dev_ops gve_eth_dev_ops = {
 	.dev_configure        = gve_dev_configure,
 	.dev_start            = gve_dev_start,
@@ -1109,6 +1174,7 @@ static const struct eth_dev_ops gve_eth_dev_ops = {
 	.tx_queue_start       = gve_tx_queue_start,
 	.rx_queue_stop        = gve_rx_queue_stop,
 	.tx_queue_stop        = gve_tx_queue_stop,
+	.flow_ops_get         = gve_flow_ops_get,
 	.link_update          = gve_link_update,
 	.stats_get            = gve_dev_stats_get,
 	.stats_reset          = gve_dev_stats_reset,
@@ -1136,6 +1202,7 @@ static const struct eth_dev_ops gve_eth_dev_ops_dqo = {
 	.tx_queue_start       = gve_tx_queue_start_dqo,
 	.rx_queue_stop        = gve_rx_queue_stop_dqo,
 	.tx_queue_stop        = gve_tx_queue_stop_dqo,
+	.flow_ops_get         = gve_flow_ops_get,
 	.link_update          = gve_link_update,
 	.stats_get            = gve_dev_stats_get,
 	.stats_reset          = gve_dev_stats_reset,
@@ -1303,6 +1370,14 @@ gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		    priv->max_nb_txq, priv->max_nb_rxq);
 
 setup_device:
+	if (priv->max_flow_rules) {
+		err = gve_setup_flow_subsystem(priv);
+		if (err)
+			PMD_DRV_LOG(WARNING,
+				    "Failed to set up flow subsystem: err=%d, flow steering will be disabled.",
+				    err);
+	}
+
 	err = gve_setup_device_resources(priv);
 	if (!err)
 		return 0;
@@ -1318,6 +1393,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 	int max_tx_queues, max_rx_queues;
 	struct rte_pci_device *pci_dev;
 	struct gve_registers *reg_bar;
+	pthread_mutexattr_t mutexattr;
 	rte_be32_t *db_bar;
 	int err;
 
@@ -1377,6 +1453,11 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 
 	eth_dev->data->mac_addrs = &priv->dev_addr;
 
+	pthread_mutexattr_init(&mutexattr);
+	pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(&priv->flow_rule_lock, &mutexattr);
+	pthread_mutexattr_destroy(&mutexattr);
+
 	return 0;
 }
 
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 4e07ca8..2d570d0 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -9,6 +9,8 @@
 #include <ethdev_pci.h>
 #include <rte_ether.h>
 #include <rte_pci.h>
+#include <pthread.h>
+#include <rte_bitmap.h>
 
 #include "base/gve.h"
 
@@ -252,6 +254,13 @@ struct gve_rx_queue {
 	uint8_t is_gqi_qpl;
 };
 
+struct gve_flow {
+	uint32_t rule_id;
+	TAILQ_ENTRY(gve_flow) list_handle;
+};
+
+extern const struct rte_flow_ops gve_flow_ops;
+
 struct gve_priv {
 	struct gve_irq_db *irq_dbs; /* array of num_ntfy_blks */
 	const struct rte_memzone *irq_dbs_mz;
@@ -334,7 +343,13 @@ struct gve_priv {
 	struct gve_rss_config rss_config;
 	struct gve_ptype_lut *ptype_lut_dqo;
 
+	/* Flow rule management */
 	uint32_t max_flow_rules;
+	uint32_t flow_rule_bmp_size;
+	struct rte_bitmap *avail_flow_rule_bmp; /* Tracks available rule IDs (1 = available) */
+	void *avail_flow_rule_bmp_mem; /* Backing memory for the bitmap */
+	pthread_mutex_t flow_rule_lock; /* Lock for bitmap and tailq access */
+	TAILQ_HEAD(, gve_flow) active_flows;
 };
 
 static inline bool
@@ -407,6 +422,34 @@ gve_clear_device_rings_ok(struct gve_priv *priv)
 				&priv->state_flags);
 }
 
+static inline bool
+gve_get_flow_subsystem_ok(struct gve_priv *priv)
+{
+	bool ret;
+
+	ret = !!rte_bit_relaxed_get32(GVE_PRIV_FLAGS_FLOW_SUBSYSTEM_OK,
+				      &priv->state_flags);
+	rte_atomic_thread_fence(rte_memory_order_acquire);
+
+	return ret;
+}
+
+static inline void
+gve_set_flow_subsystem_ok(struct gve_priv *priv)
+{
+	rte_atomic_thread_fence(rte_memory_order_release);
+	rte_bit_relaxed_set32(GVE_PRIV_FLAGS_FLOW_SUBSYSTEM_OK,
+			      &priv->state_flags);
+}
+
+static inline void
+gve_clear_flow_subsystem_ok(struct gve_priv *priv)
+{
+	rte_atomic_thread_fence(rte_memory_order_release);
+	rte_bit_relaxed_clear32(GVE_PRIV_FLAGS_FLOW_SUBSYSTEM_OK,
+				&priv->state_flags);
+}
+
 int
 gve_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_desc,
 		   unsigned int socket_id, const struct rte_eth_rxconf *conf,
diff --git a/drivers/net/gve/gve_flow_rule.c b/drivers/net/gve/gve_flow_rule.c
new file mode 100644
index 0000000..af75ae8
--- /dev/null
+++ b/drivers/net/gve/gve_flow_rule.c
@@ -0,0 +1,658 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2026 Google LLC
+ */
+
+#include <rte_flow.h>
+#include <rte_flow_driver.h>
+#include "base/gve_adminq.h"
+#include "gve_ethdev.h"
+
+static int
+gve_validate_flow_attr(const struct rte_flow_attr *attr,
+		       struct rte_flow_error *error)
+{
+	if (attr == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ATTR, NULL,
+				"Invalid flow attribute");
+		return -EINVAL;
+	}
+	if (attr->egress || attr->transfer) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ATTR, attr,
+				"Only ingress is supported");
+		return -EINVAL;
+	}
+	if (!attr->ingress) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ATTR_INGRESS, attr,
+				"Ingress attribute must be set");
+		return -EINVAL;
+	}
+	if (attr->priority != 0) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY, attr,
+				"Priority levels are not supported");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void
+gve_parse_ipv4(const struct rte_flow_item *item,
+	       struct gve_flow_rule_params *rule)
+{
+	if (item->spec) {
+		const struct rte_flow_item_ipv4 *spec = item->spec;
+		const struct rte_flow_item_ipv4 *mask =
+			item->mask ? item->mask : &rte_flow_item_ipv4_mask;
+
+		rule->key.src_ip[0] = spec->hdr.src_addr;
+		rule->key.dst_ip[0] = spec->hdr.dst_addr;
+		rule->mask.src_ip[0] = mask->hdr.src_addr;
+		rule->mask.dst_ip[0] = mask->hdr.dst_addr;
+	}
+}
+
+static void
+gve_parse_ipv6(const struct rte_flow_item *item,
+	       struct gve_flow_rule_params *rule)
+{
+	if (item->spec) {
+		const struct rte_flow_item_ipv6 *spec = item->spec;
+		const struct rte_flow_item_ipv6 *mask =
+			item->mask ? item->mask : &rte_flow_item_ipv6_mask;
+		const __be32 *src_ip = (const __be32 *)&spec->hdr.src_addr;
+		const __be32 *src_mask = (const __be32 *)&mask->hdr.src_addr;
+		const __be32 *dst_ip = (const __be32 *)&spec->hdr.dst_addr;
+		const __be32 *dst_mask = (const __be32 *)&mask->hdr.dst_addr;
+		int i;
+
+		/*
+		 * The device expects IPv6 addresses as an array of 4 32-bit words
+		 * in reverse word order (the MSB word at index 3 and the LSB word
+		 * at index 0). We must reverse the DPDK network byte order array.
+		 */
+		for (i = 0; i < 4; i++) {
+			rule->key.src_ip[3 - i] = src_ip[i];
+			rule->key.dst_ip[3 - i] = dst_ip[i];
+			rule->mask.src_ip[3 - i] = src_mask[i];
+			rule->mask.dst_ip[3 - i] = dst_mask[i];
+		}
+	}
+}
+
+static void
+gve_parse_udp(const struct rte_flow_item *item,
+	      struct gve_flow_rule_params *rule)
+{
+	if (item->spec) {
+		const struct rte_flow_item_udp *spec = item->spec;
+		const struct rte_flow_item_udp *mask =
+			item->mask ? item->mask : &rte_flow_item_udp_mask;
+
+		rule->key.src_port = spec->hdr.src_port;
+		rule->key.dst_port = spec->hdr.dst_port;
+		rule->mask.src_port = mask->hdr.src_port;
+		rule->mask.dst_port = mask->hdr.dst_port;
+	}
+}
+
+static void
+gve_parse_tcp(const struct rte_flow_item *item,
+	      struct gve_flow_rule_params *rule)
+{
+	if (item->spec) {
+		const struct rte_flow_item_tcp *spec = item->spec;
+		const struct rte_flow_item_tcp *mask =
+			item->mask ? item->mask : &rte_flow_item_tcp_mask;
+
+		rule->key.src_port = spec->hdr.src_port;
+		rule->key.dst_port = spec->hdr.dst_port;
+		rule->mask.src_port = mask->hdr.src_port;
+		rule->mask.dst_port = mask->hdr.dst_port;
+	}
+}
+
+static void
+gve_parse_sctp(const struct rte_flow_item *item,
+	       struct gve_flow_rule_params *rule)
+{
+	if (item->spec) {
+		const struct rte_flow_item_sctp *spec = item->spec;
+		const struct rte_flow_item_sctp *mask =
+			item->mask ? item->mask : &rte_flow_item_sctp_mask;
+
+		rule->key.src_port = spec->hdr.src_port;
+		rule->key.dst_port = spec->hdr.dst_port;
+		rule->mask.src_port = mask->hdr.src_port;
+		rule->mask.dst_port = mask->hdr.dst_port;
+	}
+}
+
+static void
+gve_parse_esp(const struct rte_flow_item *item,
+	      struct gve_flow_rule_params *rule)
+{
+	if (item->spec) {
+		const struct rte_flow_item_esp *spec = item->spec;
+		const struct rte_flow_item_esp *mask =
+			item->mask ? item->mask : &rte_flow_item_esp_mask;
+
+		rule->key.spi = spec->hdr.spi;
+		rule->mask.spi = mask->hdr.spi;
+	}
+}
+
+static void
+gve_parse_ah(const struct rte_flow_item *item, struct gve_flow_rule_params *rule)
+{
+	if (item->spec) {
+		const struct rte_flow_item_ah *spec = item->spec;
+		const struct rte_flow_item_ah *mask =
+			item->mask ? item->mask : &rte_flow_item_ah_mask;
+
+		rule->key.spi = spec->spi;
+		rule->mask.spi = mask->spi;
+	}
+}
+
+static int
+gve_validate_and_parse_flow_pattern(const struct rte_flow_item pattern[],
+				    struct rte_flow_error *error,
+				    struct gve_flow_rule_params *rule)
+{
+	const struct rte_flow_item *item = pattern;
+	enum rte_flow_item_type l3_type = RTE_FLOW_ITEM_TYPE_VOID;
+	enum rte_flow_item_type l4_type = RTE_FLOW_ITEM_TYPE_VOID;
+
+	if (pattern == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ITEM_NUM, NULL,
+				"Invalid flow pattern");
+		return -EINVAL;
+	}
+
+	for (; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+		if (item->last) {
+			/* Last and range are not supported as match criteria. */
+			rte_flow_error_set(error, EINVAL,
+					   RTE_FLOW_ERROR_TYPE_ITEM,
+					   item,
+					   "No support for range");
+			return -EINVAL;
+		}
+		switch (item->type) {
+		case RTE_FLOW_ITEM_TYPE_VOID:
+			break;
+		case RTE_FLOW_ITEM_TYPE_IPV4:
+			if (l3_type != RTE_FLOW_ITEM_TYPE_VOID) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item,
+						   "Multiple L3 items not supported");
+				return -EINVAL;
+			}
+			gve_parse_ipv4(item, rule);
+			l3_type = item->type;
+			break;
+		case RTE_FLOW_ITEM_TYPE_IPV6:
+			if (l3_type != RTE_FLOW_ITEM_TYPE_VOID) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item,
+						   "Multiple L3 items not supported");
+				return -EINVAL;
+			}
+			gve_parse_ipv6(item, rule);
+			l3_type = item->type;
+			break;
+		case RTE_FLOW_ITEM_TYPE_UDP:
+			if (l4_type != RTE_FLOW_ITEM_TYPE_VOID) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item,
+						   "Multiple L4 items not supported");
+				return -EINVAL;
+			}
+			gve_parse_udp(item, rule);
+			l4_type = item->type;
+			break;
+		case RTE_FLOW_ITEM_TYPE_TCP:
+			if (l4_type != RTE_FLOW_ITEM_TYPE_VOID) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item,
+						   "Multiple L4 items not supported");
+				return -EINVAL;
+			}
+			gve_parse_tcp(item, rule);
+			l4_type = item->type;
+			break;
+		case RTE_FLOW_ITEM_TYPE_SCTP:
+			if (l4_type != RTE_FLOW_ITEM_TYPE_VOID) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item,
+						   "Multiple L4 items not supported");
+				return -EINVAL;
+			}
+			gve_parse_sctp(item, rule);
+			l4_type = item->type;
+			break;
+		case RTE_FLOW_ITEM_TYPE_ESP:
+			if (l4_type != RTE_FLOW_ITEM_TYPE_VOID) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item,
+						   "Multiple L4 items not supported");
+				return -EINVAL;
+			}
+			gve_parse_esp(item, rule);
+			l4_type = item->type;
+			break;
+		case RTE_FLOW_ITEM_TYPE_AH:
+			if (l4_type != RTE_FLOW_ITEM_TYPE_VOID) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ITEM,
+						   item,
+						   "Multiple L4 items not supported");
+				return -EINVAL;
+			}
+			gve_parse_ah(item, rule);
+			l4_type = item->type;
+			break;
+		default:
+			rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ITEM, item,
+				   "Unsupported flow pattern item type");
+			return -EINVAL;
+		}
+	}
+
+	switch (l3_type) {
+	case RTE_FLOW_ITEM_TYPE_IPV4:
+		switch (l4_type) {
+		case RTE_FLOW_ITEM_TYPE_TCP:
+			rule->flow_type = GVE_FLOW_TYPE_TCPV4;
+			break;
+		case RTE_FLOW_ITEM_TYPE_UDP:
+			rule->flow_type = GVE_FLOW_TYPE_UDPV4;
+			break;
+		case RTE_FLOW_ITEM_TYPE_SCTP:
+			rule->flow_type = GVE_FLOW_TYPE_SCTPV4;
+			break;
+		case RTE_FLOW_ITEM_TYPE_AH:
+			rule->flow_type = GVE_FLOW_TYPE_AHV4;
+			break;
+		case RTE_FLOW_ITEM_TYPE_ESP:
+			rule->flow_type = GVE_FLOW_TYPE_ESPV4;
+			break;
+		default:
+			goto unsupported_flow;
+		}
+		break;
+	case RTE_FLOW_ITEM_TYPE_IPV6:
+		switch (l4_type) {
+		case RTE_FLOW_ITEM_TYPE_TCP:
+			rule->flow_type = GVE_FLOW_TYPE_TCPV6;
+			break;
+		case RTE_FLOW_ITEM_TYPE_UDP:
+			rule->flow_type = GVE_FLOW_TYPE_UDPV6;
+			break;
+		case RTE_FLOW_ITEM_TYPE_SCTP:
+			rule->flow_type = GVE_FLOW_TYPE_SCTPV6;
+			break;
+		case RTE_FLOW_ITEM_TYPE_AH:
+			rule->flow_type = GVE_FLOW_TYPE_AHV6;
+			break;
+		case RTE_FLOW_ITEM_TYPE_ESP:
+			rule->flow_type = GVE_FLOW_TYPE_ESPV6;
+			break;
+		default:
+			goto unsupported_flow;
+		}
+		break;
+	default:
+		goto unsupported_flow;
+	}
+
+	return 0;
+
+unsupported_flow:
+	rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ITEM,
+			   NULL, "Unsupported L3/L4 combination");
+	return -EINVAL;
+}
+
+static int
+gve_validate_and_parse_flow_actions(struct rte_eth_dev *dev,
+				    const struct rte_flow_action actions[],
+				    struct rte_flow_error *error,
+				    struct gve_flow_rule_params *rule)
+{
+	const struct rte_flow_action_queue *action_queue;
+	const struct rte_flow_action *action = actions;
+	int num_queue_actions = 0;
+
+	if (actions == NULL) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ACTION_NUM, NULL,
+				   "Invalid flow actions");
+		return -EINVAL;
+	}
+
+	while (action->type != RTE_FLOW_ACTION_TYPE_END) {
+		switch (action->type) {
+		case RTE_FLOW_ACTION_TYPE_VOID:
+			break;
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+			if (action->conf == NULL) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ACTION_CONF,
+						   action,
+						   "QUEUE action config cannot be NULL.");
+				return -EINVAL;
+			}
+
+			action_queue = action->conf;
+			if (action_queue->index >= dev->data->nb_rx_queues) {
+				rte_flow_error_set(error, EINVAL,
+						   RTE_FLOW_ERROR_TYPE_ACTION_CONF,
+						   action, "Invalid Queue ID");
+				return -EINVAL;
+			}
+
+			rule->action = action_queue->index;
+			num_queue_actions++;
+			break;
+		default:
+			rte_flow_error_set(error, ENOTSUP,
+					   RTE_FLOW_ERROR_TYPE_ACTION,
+					   action,
+					   "Unsupported action. Only QUEUE is permitted.");
+			return -ENOTSUP;
+		}
+		action++;
+	}
+
+	if (num_queue_actions == 0) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
+				   NULL, "A QUEUE action is required.");
+		return -EINVAL;
+	}
+
+	if (num_queue_actions > 1) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ACTION_NUM,
+				   NULL, "Only a single QUEUE action is allowed.");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+gve_validate_and_parse_flow(struct rte_eth_dev *dev,
+			    const struct rte_flow_attr *attr,
+			    const struct rte_flow_item pattern[],
+			    const struct rte_flow_action actions[],
+			    struct rte_flow_error *error,
+			    struct gve_flow_rule_params *rule)
+{
+	int err;
+
+	err = gve_validate_flow_attr(attr, error);
+	if (err)
+		return err;
+
+	err = gve_validate_and_parse_flow_pattern(pattern, error, rule);
+	if (err)
+		return err;
+
+	err = gve_validate_and_parse_flow_actions(dev, actions, error, rule);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int
+gve_flow_init_bmp(struct gve_priv *priv)
+{
+	priv->avail_flow_rule_bmp = rte_bitmap_init_with_all_set(priv->max_flow_rules,
+			priv->avail_flow_rule_bmp_mem, priv->flow_rule_bmp_size);
+	if (priv->avail_flow_rule_bmp == NULL) {
+		PMD_DRV_LOG(ERR, "Flow subsystem failed: cannot init bitmap.");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void
+gve_flow_free_bmp(struct gve_priv *priv)
+{
+	rte_free(priv->avail_flow_rule_bmp_mem);
+	priv->avail_flow_rule_bmp_mem = NULL;
+	priv->avail_flow_rule_bmp = NULL;
+}
+
+/*
+ * The caller must acquire the flow rule lock before calling this function.
+ */
+int
+gve_free_flow_rules(struct gve_priv *priv)
+{
+	struct gve_flow *flow;
+	int err = 0;
+
+	if (!TAILQ_EMPTY(&priv->active_flows)) {
+		err = gve_adminq_reset_flow_rules(priv);
+		if (err) {
+			PMD_DRV_LOG(ERR,
+				"Failed to reset flow rules, internal device err=%d",
+				err);
+		}
+
+		/* Free flows even if AQ fails to avoid leaking memory. */
+		while (!TAILQ_EMPTY(&priv->active_flows)) {
+			flow = TAILQ_FIRST(&priv->active_flows);
+			TAILQ_REMOVE(&priv->active_flows, flow, list_handle);
+			free(flow);
+		}
+	}
+
+	return err;
+}
+
+static struct rte_flow *
+gve_create_flow_rule(struct rte_eth_dev *dev,
+		     const struct rte_flow_attr *attr,
+		     const struct rte_flow_item pattern[],
+		     const struct rte_flow_action actions[],
+		     struct rte_flow_error *error)
+{
+	struct gve_priv *priv = dev->data->dev_private;
+	struct gve_flow_rule_params rule = {0};
+	struct gve_flow *flow;
+	uint64_t slab_bits;
+	uint32_t slab_idx;
+	int err;
+
+	err = gve_validate_and_parse_flow(dev, attr, pattern, actions, error,
+					  &rule);
+	if (err)
+		return NULL;
+
+	flow = calloc(1, sizeof(struct gve_flow));
+	if (flow == NULL) {
+		rte_flow_error_set(error, ENOMEM,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to allocate memory for flow rule.");
+		return NULL;
+	}
+
+	pthread_mutex_lock(&priv->flow_rule_lock);
+
+	if (!gve_get_flow_subsystem_ok(priv)) {
+		rte_flow_error_set(error, ENOTSUP,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to create flow, flow subsystem not initialized.");
+		goto free_flow_and_unlock;
+	}
+
+	/* Try to allocate a new rule ID from the bitmap. */
+	if (rte_bitmap_scan(priv->avail_flow_rule_bmp, &slab_idx,
+			&slab_bits) == 1) {
+		flow->rule_id = slab_idx + __builtin_ctzll(slab_bits);
+		rte_bitmap_clear(priv->avail_flow_rule_bmp, flow->rule_id);
+	} else {
+		rte_flow_error_set(error, ENOMEM,
+				RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				"Failed to create flow, could not allocate a new rule ID.");
+		goto free_flow_and_unlock;
+	}
+
+	err = gve_adminq_add_flow_rule(priv, &rule, flow->rule_id);
+	if (err) {
+		rte_bitmap_set(priv->avail_flow_rule_bmp, flow->rule_id);
+		rte_flow_error_set(error, -err,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "Failed to create flow rule, internal device error.");
+		goto free_flow_and_unlock;
+	}
+
+	TAILQ_INSERT_TAIL(&priv->active_flows, flow, list_handle);
+
+	pthread_mutex_unlock(&priv->flow_rule_lock);
+
+	return (struct rte_flow *)flow;
+
+free_flow_and_unlock:
+	free(flow);
+	pthread_mutex_unlock(&priv->flow_rule_lock);
+	return NULL;
+}
+
+static int
+gve_destroy_flow_rule(struct rte_eth_dev *dev, struct rte_flow *flow_handle,
+		      struct rte_flow_error *error)
+{
+	struct gve_priv *priv = dev->data->dev_private;
+	struct gve_flow *flow;
+	bool flow_rule_active;
+	int err;
+
+	pthread_mutex_lock(&priv->flow_rule_lock);
+
+	if (!gve_get_flow_subsystem_ok(priv)) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to destroy flow, flow subsystem not initialized.");
+		err = -ENOTSUP;
+		goto unlock;
+	}
+
+	flow = (struct gve_flow *)flow_handle;
+
+	if (flow == NULL) {
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to destroy flow, invalid flow provided.");
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	if (flow->rule_id >= priv->max_flow_rules) {
+		PMD_DRV_LOG(ERR,
+			"Cannot destroy flow rule with invalid ID %d.",
+			flow->rule_id);
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to destroy flow, rule ID is invalid.");
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	flow_rule_active = !rte_bitmap_get(priv->avail_flow_rule_bmp,
+					   flow->rule_id);
+
+	if (!flow_rule_active) {
+		rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to destroy flow, handle not found in active list.");
+		err = -EINVAL;
+		goto unlock;
+	}
+
+	err = gve_adminq_del_flow_rule(priv, flow->rule_id);
+	if (err) {
+		rte_flow_error_set(error, -err,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to destroy flow, internal device error.");
+		goto unlock;
+	}
+
+	rte_bitmap_set(priv->avail_flow_rule_bmp, flow->rule_id);
+	TAILQ_REMOVE(&priv->active_flows, flow, list_handle);
+	free(flow);
+
+	err = 0;
+
+unlock:
+	pthread_mutex_unlock(&priv->flow_rule_lock);
+	return err;
+}
+
+static int
+gve_flush_flow_rules(struct rte_eth_dev *dev, struct rte_flow_error *error)
+{
+	struct gve_priv *priv = dev->data->dev_private;
+	int err;
+
+	pthread_mutex_lock(&priv->flow_rule_lock);
+
+	if (!gve_get_flow_subsystem_ok(priv)) {
+		rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to flush rules, flow subsystem not initialized.");
+		err = -ENOTSUP;
+		goto unlock;
+	}
+
+	err = gve_free_flow_rules(priv);
+	if (err) {
+		rte_flow_error_set(error, -err,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to flush rules due to internal device error, disabling flow subsystem.");
+		goto disable_and_free;
+	}
+
+	err = gve_flow_init_bmp(priv);
+	if (err) {
+		rte_flow_error_set(error, -err,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Failed to re-initialize rule ID bitmap, disabling flow subsystem.");
+		goto disable_and_free;
+	}
+
+	pthread_mutex_unlock(&priv->flow_rule_lock);
+
+	return 0;
+
+disable_and_free:
+	gve_clear_flow_subsystem_ok(priv);
+	gve_flow_free_bmp(priv);
+unlock:
+	pthread_mutex_unlock(&priv->flow_rule_lock);
+	return err;
+}
+
+const struct rte_flow_ops gve_flow_ops = {
+	.create = gve_create_flow_rule,
+	.destroy = gve_destroy_flow_rule,
+	.flush = gve_flush_flow_rules,
+};
diff --git a/drivers/net/gve/gve_flow_rule.h b/drivers/net/gve/gve_flow_rule.h
index 8c17ddd..d597a6c 100644
--- a/drivers/net/gve/gve_flow_rule.h
+++ b/drivers/net/gve/gve_flow_rule.h
@@ -56,4 +56,10 @@ struct gve_flow_rule_params {
 	struct gve_flow_spec mask;
 };
 
+struct gve_priv;
+
+int gve_flow_init_bmp(struct gve_priv *priv);
+void gve_flow_free_bmp(struct gve_priv *priv);
+int gve_free_flow_rules(struct gve_priv *priv);
+
 #endif /* _GVE_FLOW_RULE_H_ */
diff --git a/drivers/net/gve/meson.build b/drivers/net/gve/meson.build
index c6a9f36..7074988 100644
--- a/drivers/net/gve/meson.build
+++ b/drivers/net/gve/meson.build
@@ -16,5 +16,6 @@ sources = files(
         'gve_ethdev.c',
         'gve_version.c',
         'gve_rss.c',
+        'gve_flow_rule.c',
 )
 includes += include_directories('base')
-- 
2.53.0.473.g4a7958ca14-goog

