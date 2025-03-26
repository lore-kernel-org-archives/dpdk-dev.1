Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DF9C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 13:15:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B466D4064E;
	Wed, 26 Mar 2025 14:15:12 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4075F402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 14:15:11 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q5TAkX005736;
 Wed, 26 Mar 2025 06:15:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 7GRzgQbEJQk1ovdI07umD+3/jqJsnOrRyoZUOM5CFU=; b=RjeL9LM4fzspcacY5
 /vhRyqmHCp9TDYID2tTTQ428hcMaPji1dabD8UZHJ9p+oQzQ5PgZb61ARHWrQgKd
 7qBDKXFWzIlcAL7QFnl5j8uzb8L9DNeQrBZoWjCPLIuUJ1kmxQjF75YUu7i27awa
 Z5saWSRXvnyJc7xsW2AmDQ98lk12Y7ZotltHNcKjlZXE8j24Flv7nv6/SStJ+BEl
 54/PW8vRpM/C/kzK5B7tE4WU7kQkcYv6payZvsVSp2lTgzZQTzNWcxlb1mzmS4Df
 7ipgcMhm2lb36zruQhrnu65tveYg2/MHsxI4vHiIsE2bw4w4OaotKpEwd1oGEUc0
 D6PFA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45mbfj8tjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Mar 2025 06:15:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 26 Mar 2025 06:14:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Mar 2025 06:14:52 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id AB7BB5B6932;
 Wed, 26 Mar 2025 06:14:50 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [RFC 1/2] eventdev: introduce event vector adapter
Date: Wed, 26 Mar 2025 18:44:35 +0530
Message-ID: <20250326131441.5965-2-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326131441.5965-1-pbhagavatula@marvell.com>
References: <20250326131441.5965-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -MvD_6H5QDEPcOEZuC07_Z3CL6JW_tnc
X-Authority-Analysis: v=2.4 cv=auuyCTZV c=1 sm=1 tr=0 ts=67e3fddd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=5asfUFzjyNl_b0hA91gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=RVmHIydaz68A:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: -MvD_6H5QDEPcOEZuC07_Z3CL6JW_tnc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

The event vector adapter supports offloading creation of
event vectors by vectorizing objects (mbufs/ptrs/u64s).
Applications can create a vector adapter associated with
an event queue and enqueue objects to be vectorized.
When the vector reaches the configured size or when the timeout
is reached, the vector adapter will enqueue the vector to the
event queue.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 config/rte_config.h                     |   1 +
 lib/eventdev/event_vector_adapter_pmd.h |  87 +++++
 lib/eventdev/eventdev_pmd.h             |  36 ++
 lib/eventdev/meson.build                |   3 +
 lib/eventdev/rte_event_vector_adapter.c | 444 ++++++++++++++++++++++
 lib/eventdev/rte_event_vector_adapter.h | 469 ++++++++++++++++++++++++
 lib/eventdev/rte_eventdev.c             |  21 ++
 lib/eventdev/rte_eventdev.h             |   8 +
 lib/eventdev/version.map                |  13 +
 9 files changed, 1082 insertions(+)
 create mode 100644 lib/eventdev/event_vector_adapter_pmd.h
 create mode 100644 lib/eventdev/rte_event_vector_adapter.c
 create mode 100644 lib/eventdev/rte_event_vector_adapter.h

diff --git a/config/rte_config.h b/config/rte_config.h
index 86897de75e..9535c48d81 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -92,6 +92,7 @@
 #define RTE_EVENT_CRYPTO_ADAPTER_MAX_INSTANCE 32
 #define RTE_EVENT_ETH_TX_ADAPTER_MAX_INSTANCE 32
 #define RTE_EVENT_DMA_ADAPTER_MAX_INSTANCE 32
+#define RTE_EVENT_VECTOR_ADAPTER_MAX_INSTANCE_PER_QUEUE 32
 
 /* rawdev defines */
 #define RTE_RAWDEV_MAX_DEVS 64
diff --git a/lib/eventdev/event_vector_adapter_pmd.h b/lib/eventdev/event_vector_adapter_pmd.h
new file mode 100644
index 0000000000..dab0350564
--- /dev/null
+++ b/lib/eventdev/event_vector_adapter_pmd.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell International Ltd.
+ * All rights reserved.
+ */
+#ifndef __EVENT_VECTOR_ADAPTER_PMD_H__
+#define __EVENT_VECTOR_ADAPTER_PMD_H__
+/**
+ * @file
+ * RTE Event Vector Adapter API (PMD Side)
+ *
+ * @note
+ * This file provides implementation helpers for internal use by PMDs.  They
+ * are not intended to be exposed to applications and are not subject to ABI
+ * versioning.
+ */
+#include "eventdev_pmd.h"
+#include "rte_event_vector_adapter.h"
+
+typedef int (*rte_event_vector_adapter_create_t)(struct rte_event_vector_adapter *adapter);
+/**< @internal Event vector adapter implementation setup */
+typedef int (*rte_event_vector_adapter_destroy_t)(struct rte_event_vector_adapter *adapter);
+/**< @internal Event vector adapter implementation teardown */
+typedef int (*rte_event_vector_adapter_caps_get_t)(struct rte_eventdev *dev);
+/**< @internal Get capabilities for event vector adapter */
+typedef int (*rte_event_vector_adapter_stats_get_t)(const struct rte_event_vector_adapter *adapter,
+						    struct rte_event_vector_adapter_stats *stats);
+/**< @internal Get statistics for event vector adapter */
+typedef int (*rte_event_vector_adapter_stats_reset_t)(
+	const struct rte_event_vector_adapter *adapter);
+/**< @internal Reset statistics for event vector adapter */
+
+/**
+ * @internal Structure containing the functions exported by an event vector
+ * adapter implementation.
+ */
+struct event_vector_adapter_ops {
+	rte_event_vector_adapter_create_t create;
+	/**< Set up adapter */
+	rte_event_vector_adapter_destroy_t destroy;
+	/**< Tear down adapter */
+	rte_event_vector_adapter_caps_get_t caps_get;
+	/**< Get capabilities from driver */
+	rte_event_vector_adapter_stats_get_t stats_get;
+	/**< Get adapter statistics */
+	rte_event_vector_adapter_stats_reset_t stats_reset;
+	/**< Reset adapter statistics */
+
+	rte_event_vector_adapter_enqueue_t enqueue;
+	/**< Enqueue ptrs into the event vector adapter */
+};
+/**
+ * @internal Adapter data; structure to be placed in shared memory to be
+ * accessible by various processes in a multi-process configuration.
+ */
+struct __rte_cache_aligned rte_event_vector_adapter_data {
+	uint32_t id;
+	/**< Event vector adapter ID */
+	uint8_t event_dev_id;
+	/**< Event device ID */
+	uint32_t socket_id;
+	/**< Socket ID where memory is allocated */
+	uint8_t event_port_id;
+	/**< Optional: event port ID used when the inbuilt port is absent */
+	const struct rte_memzone *mz;
+	/**< Event vector adapter memzone pointer */
+	struct rte_event_vector_adapter_conf conf;
+	/**< Configuration used to configure the adapter. */
+	uint32_t caps;
+	/**< Adapter capabilities */
+	void *adapter_priv;
+	/**< Vector adapter private data*/
+	uint32_t unified_service_id;
+	/**< Unified Service ID*/
+};
+
+static int
+dummy_vector_adapter_enqueue(struct rte_event_vector_adapter *adapter, uintptr_t ptrs[],
+			     uint16_t num_events, uint64_t flags)
+{
+	RTE_SET_USED(adapter);
+	RTE_SET_USED(ptrs);
+	RTE_SET_USED(num_events);
+	RTE_SET_USED(flags);
+	return 0;
+}
+
+#endif /* __EVENT_VECTOR_ADAPTER_PMD_H__ */
diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
index ad13ba5b03..d03461316b 100644
--- a/lib/eventdev/eventdev_pmd.h
+++ b/lib/eventdev/eventdev_pmd.h
@@ -26,6 +26,7 @@
 
 #include "event_timer_adapter_pmd.h"
 #include "rte_event_eth_rx_adapter.h"
+#include "rte_event_vector_adapter.h"
 #include "rte_eventdev.h"
 
 #ifdef __cplusplus
@@ -1555,6 +1556,36 @@ typedef int (*eventdev_dma_adapter_stats_get)(const struct rte_eventdev *dev,
 typedef int (*eventdev_dma_adapter_stats_reset)(const struct rte_eventdev *dev,
 						const int16_t dma_dev_id);
 
+/**
+ * Event device vector adapter capabilities.
+ *
+ * @param dev
+ *   Event device pointer
+ * @param caps
+ *   Vector adapter capabilities
+ * @param ops
+ *   Vector adapter ops
+ *
+ * @return
+ *   Return 0 on success.
+ *
+ */
+typedef int (*eventdev_vector_adapter_caps_get_t)(const struct rte_eventdev *dev, uint32_t *caps,
+						  const struct event_vector_adapter_ops **ops);
+
+/**
+ * Event device vector adapter info.
+ *
+ * @param dev
+ *   Event device pointer
+ * @param info
+ *   Vector adapter info
+ *
+ * @return
+ *   Return 0 on success.
+ */
+typedef int (*eventdev_vector_adapter_info_get_t)(const struct rte_eventdev *dev,
+						  struct rte_event_vector_adapter_info *info);
 
 /** Event device operations function pointer table */
 struct eventdev_ops {
@@ -1697,6 +1728,11 @@ struct eventdev_ops {
 	eventdev_dma_adapter_stats_reset dma_adapter_stats_reset;
 	/**< Reset DMA stats */
 
+	eventdev_vector_adapter_caps_get_t vector_adapter_caps_get;
+	/**< Get vector adapter capabilities */
+	eventdev_vector_adapter_info_get_t vector_adapter_info_get;
+	/**< Get vector adapter info */
+
 	eventdev_selftest dev_selftest;
 	/**< Start eventdev Selftest */
 
diff --git a/lib/eventdev/meson.build b/lib/eventdev/meson.build
index 71dea91727..0797c145e7 100644
--- a/lib/eventdev/meson.build
+++ b/lib/eventdev/meson.build
@@ -18,6 +18,7 @@ sources = files(
         'rte_event_eth_tx_adapter.c',
         'rte_event_ring.c',
         'rte_event_timer_adapter.c',
+        'rte_event_vector_adapter.c',
         'rte_eventdev.c',
 )
 headers = files(
@@ -27,6 +28,7 @@ headers = files(
         'rte_event_eth_tx_adapter.h',
         'rte_event_ring.h',
         'rte_event_timer_adapter.h',
+        'rte_event_vector_adapter.h',
         'rte_eventdev.h',
         'rte_eventdev_trace_fp.h',
 )
@@ -38,6 +40,7 @@ driver_sdk_headers += files(
         'eventdev_pmd_pci.h',
         'eventdev_pmd_vdev.h',
         'event_timer_adapter_pmd.h',
+        'event_vector_adapter_pmd.h',
 )
 
 deps += ['ring', 'ethdev', 'hash', 'mempool', 'mbuf', 'timer', 'cryptodev', 'dmadev']
diff --git a/lib/eventdev/rte_event_vector_adapter.c b/lib/eventdev/rte_event_vector_adapter.c
new file mode 100644
index 0000000000..5f38a9a40b
--- /dev/null
+++ b/lib/eventdev/rte_event_vector_adapter.c
@@ -0,0 +1,444 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell International Ltd.
+ * All rights reserved.
+ */
+
+#include <rte_errno.h>
+#include <rte_malloc.h>
+#include <rte_mcslock.h>
+#include <rte_service_component.h>
+#include <rte_tailq.h>
+
+#include "event_vector_adapter_pmd.h"
+#include "eventdev_pmd.h"
+#include "rte_event_vector_adapter.h"
+
+#define ADAPTER_ID(dev_id, queue_id, adapter_id)                                                   \
+	((uint32_t)dev_id << 16 | (uint32_t)queue_id << 8 | (uint32_t)adapter_id)
+#define DEV_ID_FROM_ADAPTER_ID(adapter_id)     ((adapter_id >> 16) & 0xFF)
+#define QUEUE_ID_FROM_ADAPTER_ID(adapter_id)   ((adapter_id >> 8) & 0xFF)
+#define ADAPTER_ID_FROM_ADAPTER_ID(adapter_id) (adapter_id & 0xFF)
+
+#define MZ_NAME_MAX_LEN	    64
+#define DATA_MZ_NAME_FORMAT "rte_event_vector_adapter_data_%d_%d_%d"
+
+RTE_LOG_REGISTER_SUFFIX(ev_vector_logtype, adapter.vector, NOTICE);
+#define RTE_LOGTYPE_EVVEC ev_vector_logtype
+
+struct rte_event_vector_adapter *adapters[RTE_EVENT_MAX_DEVS][RTE_EVENT_MAX_QUEUES_PER_DEV];
+
+#define EVVEC_LOG(level, logtype, ...)                                                             \
+	RTE_LOG_LINE_PREFIX(level, logtype,                                                        \
+			    "EVVEC: %s() line %u: ", __func__ RTE_LOG_COMMA __LINE__, __VA_ARGS__)
+#define EVVEC_LOG_ERR(...) EVVEC_LOG(ERR, EVVEC, __VA_ARGS__)
+
+#ifdef RTE_LIBRTE_EVENTDEV_DEBUG
+#define EVVEC_LOG_DBG(...) EVVEC_LOG(DEBUG, EVVEC, __VA_ARGS__)
+#else
+#define EVVEC_LOG_DBG(...) /* No debug logging */
+#endif
+
+#define PTR_VALID_OR_ERR_RET(ptr, retval)                                                          \
+	do {                                                                                       \
+		if (ptr == NULL) {                                                                 \
+			rte_errno = EINVAL;                                                        \
+			return retval;                                                             \
+		}                                                                                  \
+	} while (0)
+
+static int
+validate_conf(const struct rte_event_vector_adapter_conf *conf,
+	      struct rte_event_vector_adapter_info *info)
+{
+	int rc = -EINVAL;
+
+	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(conf->event_dev_id, rc);
+
+	if (conf->vector_sz < info->min_vector_sz || conf->vector_sz > info->max_vector_sz) {
+		EVVEC_LOG_DBG("invalid vector size %u, should be between %u and %u",
+			      conf->vector_sz, info->min_vector_sz, info->max_vector_sz);
+		return rc;
+	}
+
+	if (conf->vector_timeout_ns < info->min_vector_timeout_ns ||
+	    conf->vector_timeout_ns > info->max_vector_timeout_ns) {
+		EVVEC_LOG_DBG("invalid vector timeout %u, should be between %u and %u",
+			      conf->vector_timeout_ns, info->min_vector_timeout_ns,
+			      info->max_vector_timeout_ns);
+		return rc;
+	}
+
+	if (conf->vector_mp == NULL) {
+		EVVEC_LOG_DBG("invalid mempool for vector adapter");
+		return rc;
+	}
+
+	if (info->log2_sz && rte_is_power_of_2(conf->vector_sz) != 0) {
+		EVVEC_LOG_DBG("invalid vector size %u, should be a power of 2", conf->vector_sz);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int
+default_port_conf_cb(uint8_t event_dev_id, uint8_t *event_port_id, void *conf_arg)
+{
+	struct rte_event_port_conf *port_conf, def_port_conf = {0};
+	struct rte_event_dev_config dev_conf;
+	struct rte_eventdev *dev;
+	uint8_t port_id;
+	uint8_t dev_id;
+	int started;
+	int ret;
+
+	dev = &rte_eventdevs[event_dev_id];
+	dev_id = dev->data->dev_id;
+	dev_conf = dev->data->dev_conf;
+
+	started = dev->data->dev_started;
+	if (started)
+		rte_event_dev_stop(dev_id);
+
+	port_id = dev_conf.nb_event_ports;
+	if (conf_arg != NULL)
+		port_conf = conf_arg;
+	else {
+		port_conf = &def_port_conf;
+		ret = rte_event_port_default_conf_get(dev_id, (port_id - 1), port_conf);
+		if (ret < 0)
+			return ret;
+	}
+
+	dev_conf.nb_event_ports += 1;
+	if (port_conf->event_port_cfg & RTE_EVENT_PORT_CFG_SINGLE_LINK)
+		dev_conf.nb_single_link_event_port_queues += 1;
+
+	ret = rte_event_dev_configure(dev_id, &dev_conf);
+	if (ret < 0) {
+		EVVEC_LOG_ERR("failed to configure event dev %u", dev_id);
+		if (started)
+			if (rte_event_dev_start(dev_id))
+				return -EIO;
+
+		return ret;
+	}
+
+	ret = rte_event_port_setup(dev_id, port_id, port_conf);
+	if (ret < 0) {
+		EVVEC_LOG_ERR("failed to setup event port %u on event dev %u", port_id, dev_id);
+		return ret;
+	}
+
+	*event_port_id = port_id;
+
+	if (started)
+		ret = rte_event_dev_start(dev_id);
+
+	return ret;
+}
+
+struct rte_event_vector_adapter *
+rte_event_vector_adapter_create(const struct rte_event_vector_adapter_conf *conf)
+{
+	return rte_event_vector_adapter_create_ext(conf, default_port_conf_cb, NULL);
+}
+
+struct rte_event_vector_adapter *
+rte_event_vector_adapter_create_ext(const struct rte_event_vector_adapter_conf *conf,
+				    rte_event_vector_adapter_port_conf_cb_t conf_cb, void *conf_arg)
+{
+	struct rte_event_vector_adapter *adapter = NULL;
+	struct rte_event_vector_adapter_info info;
+	char mz_name[MZ_NAME_MAX_LEN];
+	const struct rte_memzone *mz;
+	struct rte_eventdev *dev;
+	uint32_t caps;
+	int i, n, rc;
+
+	PTR_VALID_OR_ERR_RET(conf, NULL);
+
+	if (adapters[conf->event_dev_id][conf->ev.queue_id] == NULL) {
+		adapters[conf->event_dev_id][conf->ev.queue_id] =
+			rte_zmalloc("rte_event_vector_adapter",
+				    sizeof(struct rte_event_vector_adapter) *
+					    RTE_EVENT_VECTOR_ADAPTER_MAX_INSTANCE_PER_QUEUE,
+				    RTE_CACHE_LINE_SIZE);
+		if (adapters[conf->event_dev_id][conf->ev.queue_id] == NULL) {
+			EVVEC_LOG_DBG("failed to allocate memory for vector adapters");
+			rte_errno = ENOMEM;
+			return NULL;
+		}
+	}
+
+	for (i = 0; i < RTE_EVENT_VECTOR_ADAPTER_MAX_INSTANCE_PER_QUEUE; i++) {
+		if (adapters[conf->event_dev_id][conf->ev.queue_id][i].used == false) {
+			adapter = &adapters[conf->event_dev_id][conf->ev.queue_id][i];
+			adapter->adapter_id = ADAPTER_ID(conf->event_dev_id, conf->ev.queue_id, i);
+			adapter->used = true;
+			break;
+		}
+	}
+
+	if (adapter == NULL) {
+		EVVEC_LOG_DBG("no available vector adapters");
+		rte_errno = ENODEV;
+		return NULL;
+	}
+
+	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(conf->event_dev_id, NULL);
+
+	dev = &rte_eventdevs[conf->event_dev_id];
+	if (dev->dev_ops->vector_adapter_caps_get != NULL &&
+	    dev->dev_ops->vector_adapter_info_get != NULL) {
+		rc = dev->dev_ops->vector_adapter_caps_get(dev, &caps, &adapter->ops);
+		if (rc < 0) {
+			EVVEC_LOG_DBG("failed to get vector adapter capabilities rc = %d", rc);
+			rte_errno = ENOTSUP;
+			goto error;
+		}
+
+		rc = dev->dev_ops->vector_adapter_info_get(dev, &info);
+		if (rc < 0) {
+			adapter->ops = NULL;
+			EVVEC_LOG_DBG("failed to get vector adapter info rc = %d", rc);
+			rte_errno = ENOTSUP;
+			goto error;
+		}
+	}
+
+	if (conf->ev.sched_type != dev->data->queues_cfg[conf->ev.queue_id].schedule_type &&
+	    !(dev->data->event_dev_cap & RTE_EVENT_DEV_CAP_QUEUE_ALL_TYPES)) {
+		EVVEC_LOG_DBG("invalid event schedule type, eventdev doesn't support all types");
+		rte_errno = EINVAL;
+		goto error;
+	}
+
+	if (!(caps & RTE_EVENT_VECTOR_ADAPTER_CAP_INTERNAL_PORT)) {
+		if (conf_cb == NULL) {
+			EVVEC_LOG_DBG("port config callback is NULL");
+			rte_errno = EINVAL;
+			goto error;
+		}
+
+		rc = conf_cb(conf->event_dev_id, &adapter->data->event_port_id, conf_arg);
+		if (rc < 0) {
+			EVVEC_LOG_DBG("failed to create port for vector adapter");
+			rte_errno = EINVAL;
+			goto error;
+		}
+	}
+
+	rc = validate_conf(conf, &info);
+	if (rc < 0) {
+		adapter->ops = NULL;
+		rte_errno = EINVAL;
+		goto error;
+	}
+
+	n = snprintf(mz_name, MZ_NAME_MAX_LEN, DATA_MZ_NAME_FORMAT, conf->event_dev_id,
+		     conf->ev.queue_id, adapter->adapter_id);
+	if (n >= (int)sizeof(mz_name)) {
+		adapter->ops = NULL;
+		EVVEC_LOG_DBG("failed to create memzone name");
+		rte_errno = EINVAL;
+		goto error;
+	}
+	mz = rte_memzone_reserve(mz_name, sizeof(struct rte_event_vector_adapter_data),
+				 conf->socket_id, 0);
+	if (mz == NULL) {
+		adapter->ops = NULL;
+		EVVEC_LOG_DBG("failed to reserve memzone for vector adapter");
+		rte_errno = ENOMEM;
+		goto error;
+	}
+
+	adapter->data = mz->addr;
+	memset(adapter->data, 0, sizeof(struct rte_event_vector_adapter_data));
+
+	adapter->data->mz = mz;
+	adapter->data->event_dev_id = conf->event_dev_id;
+	adapter->data->id = adapter->adapter_id;
+	adapter->data->socket_id = conf->socket_id;
+	adapter->data->conf = *conf;
+
+	FUNC_PTR_OR_ERR_RET(adapter->ops->create, NULL);
+
+	rc = adapter->ops->create(adapter);
+	if (rc < 0) {
+		adapter->ops = NULL;
+		EVVEC_LOG_DBG("failed to create vector adapter");
+		rte_errno = EINVAL;
+		goto error;
+	}
+
+	adapter->enqueue = adapter->ops->enqueue;
+
+	return adapter;
+
+error:
+	adapter->used = false;
+	return NULL;
+}
+
+struct rte_event_vector_adapter *
+rte_event_vector_adapter_lookup(uint32_t adapter_id)
+{
+	uint8_t adapter_idx = ADAPTER_ID_FROM_ADAPTER_ID(adapter_id);
+	uint8_t queue_id = QUEUE_ID_FROM_ADAPTER_ID(adapter_id);
+	uint8_t dev_id = DEV_ID_FROM_ADAPTER_ID(adapter_id);
+	struct rte_event_vector_adapter *adapter;
+	const struct rte_memzone *mz;
+	char name[MZ_NAME_MAX_LEN];
+	struct rte_eventdev *dev;
+	int rc;
+
+	if (dev_id >= RTE_EVENT_MAX_DEVS || queue_id >= RTE_EVENT_MAX_QUEUES_PER_DEV ||
+	    adapter_idx >= RTE_EVENT_VECTOR_ADAPTER_MAX_INSTANCE_PER_QUEUE) {
+		EVVEC_LOG_ERR("invalid adapter id %u", adapter_id);
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	if (adapters[dev_id][queue_id] == NULL) {
+		adapters[dev_id][queue_id] =
+			rte_zmalloc("rte_event_vector_adapter",
+				    sizeof(struct rte_event_vector_adapter) *
+					    RTE_EVENT_VECTOR_ADAPTER_MAX_INSTANCE_PER_QUEUE,
+				    RTE_CACHE_LINE_SIZE);
+		if (adapters[dev_id][queue_id] == NULL) {
+			EVVEC_LOG_DBG("failed to allocate memory for vector adapters");
+			rte_errno = ENOMEM;
+			return NULL;
+		}
+	}
+
+	if (adapters[dev_id][queue_id][adapter_idx].used == true)
+		return &adapters[dev_id][queue_id][adapter_idx];
+
+	adapter = &adapters[dev_id][queue_id][adapter_idx];
+
+	snprintf(name, MZ_NAME_MAX_LEN, DATA_MZ_NAME_FORMAT, dev_id, queue_id, adapter_idx);
+	mz = rte_memzone_lookup(name);
+	if (mz == NULL) {
+		EVVEC_LOG_DBG("failed to lookup memzone for vector adapter");
+		rte_errno = ENOENT;
+		return NULL;
+	}
+
+	adapter->data = mz->addr;
+	dev = &rte_eventdevs[dev_id];
+
+	if (dev->dev_ops->vector_adapter_caps_get != NULL) {
+		rc = dev->dev_ops->vector_adapter_caps_get(dev, &adapter->data->caps,
+							   &adapter->ops);
+		if (rc < 0) {
+			EVVEC_LOG_DBG("failed to get vector adapter capabilities");
+			rte_errno = ENOTSUP;
+			return NULL;
+		}
+	}
+
+	adapter->enqueue = adapter->ops->enqueue;
+	adapter->adapter_id = adapter_id;
+	adapter->used = true;
+
+	return adapter;
+}
+
+int
+rte_event_vector_adapter_destroy(struct rte_event_vector_adapter *adapter)
+{
+	int rc;
+
+	PTR_VALID_OR_ERR_RET(adapter, -EINVAL);
+	if (adapter->used == false) {
+		EVVEC_LOG_ERR("event vector adapter is not allocated");
+		return -EINVAL;
+	}
+
+	FUNC_PTR_OR_ERR_RET(adapter->ops->destroy, -ENOTSUP);
+
+	rc = adapter->ops->destroy(adapter);
+	if (rc < 0) {
+		EVVEC_LOG_DBG("failed to destroy vector adapter");
+		return rc;
+	}
+
+	rte_memzone_free(adapter->data->mz);
+	adapter->ops = NULL;
+	adapter->enqueue = dummy_vector_adapter_enqueue;
+	adapter->data = NULL;
+	adapter->used = false;
+
+	return 0;
+}
+
+int
+rte_event_vector_adapter_info_get(uint8_t event_dev_id, struct rte_event_vector_adapter_info *info)
+{
+	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(event_dev_id, -EINVAL);
+	PTR_VALID_OR_ERR_RET(info, -EINVAL);
+
+	struct rte_eventdev *dev = &rte_eventdevs[event_dev_id];
+	if (dev->dev_ops->vector_adapter_info_get != NULL)
+		return dev->dev_ops->vector_adapter_info_get(dev, info);
+
+	return 0;
+}
+
+int
+rte_event_vector_adapter_conf_get(struct rte_event_vector_adapter *adapter,
+				  struct rte_event_vector_adapter_conf *conf)
+{
+	PTR_VALID_OR_ERR_RET(adapter, -EINVAL);
+	PTR_VALID_OR_ERR_RET(conf, -EINVAL);
+
+	*conf = adapter->data->conf;
+	return 0;
+}
+
+uint8_t
+rte_event_vector_adapter_remaining(uint8_t event_dev_id, uint8_t event_queue_id)
+{
+	uint8_t remaining = 0;
+	int i;
+
+	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(event_dev_id, 0);
+
+	if (event_queue_id >= RTE_EVENT_MAX_QUEUES_PER_DEV)
+		return 0;
+
+	for (i = 0; i < RTE_EVENT_VECTOR_ADAPTER_MAX_INSTANCE_PER_QUEUE; i++) {
+		if (adapters[event_dev_id][event_queue_id][i].used == false)
+			remaining++;
+	}
+
+	return remaining;
+}
+
+int
+rte_event_vector_adapter_stats_get(struct rte_event_vector_adapter *adapter,
+				   struct rte_event_vector_adapter_stats *stats)
+{
+	PTR_VALID_OR_ERR_RET(adapter, -EINVAL);
+	PTR_VALID_OR_ERR_RET(stats, -EINVAL);
+
+	FUNC_PTR_OR_ERR_RET(adapter->ops->stats_get, -ENOTSUP);
+
+	adapter->ops->stats_get(adapter, stats);
+
+	return 0;
+}
+
+int
+rte_event_vector_adapter_stats_reset(struct rte_event_vector_adapter *adapter)
+{
+	PTR_VALID_OR_ERR_RET(adapter, -EINVAL);
+
+	FUNC_PTR_OR_ERR_RET(adapter->ops->stats_reset, -ENOTSUP);
+
+	adapter->ops->stats_reset(adapter);
+
+	return 0;
+}
diff --git a/lib/eventdev/rte_event_vector_adapter.h b/lib/eventdev/rte_event_vector_adapter.h
new file mode 100644
index 0000000000..e7ecc26cdf
--- /dev/null
+++ b/lib/eventdev/rte_event_vector_adapter.h
@@ -0,0 +1,469 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Marvell International Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __RTE_EVENT_VECTOR_ADAPTER_H__
+#define __RTE_EVENT_VECTOR_ADAPTER_H__
+
+/**
+ * @file rte_event_vector_adapter.h
+ *
+ * @warning
+ * @b EXPERIMENTAL:
+ * All functions in this file may be changed or removed without prior notice.
+ *
+ * Event vector adapter API.
+ *
+ * An event vector adapter has the following working model:
+ *
+ *         ┌──────────┐
+ *         │  Vector  ├─┐
+ *         │ adapter0 │ │
+ *         └──────────┘ │
+ *         ┌──────────┐ │   ┌──────────┐
+ *         │  Vector  ├─┼──►│  Event   │
+ *         │ adapter1 │ │   │  Queue0  │
+ *         └──────────┘ │   └──────────┘
+ *         ┌──────────┐ │
+ *         │  Vector  ├─┘
+ *         │ adapter2 │
+ *         └──────────┘
+ *
+ *         ┌──────────┐
+ *         │  Vector  ├─┐
+ *         │ adapter0 │ │   ┌──────────┐
+ *         └──────────┘ ├──►│  Event   │
+ *         ┌──────────┐ │   │  Queue1  │
+ *         │  Vector  ├─┘   └──────────┘
+ *         │ adapter1 │
+ *         └──────────┘
+ *
+ * - A vector adapter can be seen as an extension to event queue. It helps in
+ *   aggregating ptrs and generating a vector event which is enqueued to the
+ *   event queue.
+ *
+ * - Multiple vector adapters can be created on an event queue, each with its
+ *   own unique properties such as event properties, vector size, and timeout.
+ *   Note: If the target event queue doesn't support RTE_EVENT_QUEUE_CFG_ALL_TYPES,
+ *         then the vector adapter should use the same schedule type as the event
+ *         queue.
+ *
+ * - Each vector adapter aggregates ptrs, generates a vector event and
+ *   enqueues it to the event queue with the event properties mentioned in
+ *   rte_event_vector_adapter_conf::ev.
+ *
+ * - After configuring the vector adapter, Application needs to use the
+ *   rte_event_vector_adapter_enqueue() function to enqueue ptrs i.e.,
+ *   mbufs/ptrs/u64s to the vector adapter.
+ *   On reaching the configured vector size or timeout, the vector adapter
+ *   enqueues the event vector to the event queue.
+ *   Note: Application should use the event_type and sub_event_type properly
+ *         identifying the contents of vector event on dequeue.
+ *
+ * - If the vector adapter advertises the RTE_EVENT_VECTOR_ADAPTER_CAP_SOV_EOV
+ *  capability, application can use the RTE_EVENT_VECTOR_ENQ_[S|E]OV flags
+ *  to indicate the start and end of a vector event.
+ *  * When RTE_EVENT_VECTOR_ENQ_SOV is set, the vector adapter will flush any
+ *    aggregation in progress as a vector event and start aggregating a new
+ *    vector event with the enqueued ptr.
+ *  * When RTE_EVENT_VECTOR_ENQ_EOV is set, the vector adapter will add the
+ *    current ptr enqueued to the aggregated event and enqueue the vector event
+ *    to the event queue.
+ *  * If both flags are set, the vector adapter will flush the current aggregation
+ *    as a vector event and enqueue the current ptr as a single event to the event
+ *    queue.
+ *
+ * - If the vector adapter reaches the configured vector size, it will enqueue
+ *   the aggregated vector event to the event queue.
+ *
+ * - If the vector adapter reaches the configured vector timeout, it will flush
+ *   the current aggregation as a vector event if the minimum vector size is
+ *   reached, if not it will enqueue the ptrs as single events to the event
+ *   queue.
+ *
+ * - If the vector adapter is unable to aggregate the ptrs into a vector event,
+ *   it will enqueue the ptrs as single events to the event queue with the event
+ *   properties mentioned in rte_event_vector_adapter_conf::ev_fallback.
+ *
+ * Before using the vector adapter, the application has to create and configure
+ * an event device and based on the event device capability it might require
+ * creating an additional event port.
+ *
+ * When the application creates the vector adapter using the
+ * ``rte_event_vector_adapter_create()`` function, the event device driver
+ * capabilities are checked. If an in-built port is absent, the application
+ * uses the default function to create a new event port.
+ * For finer control over event port creation, the application should use
+ * the ``rte_event_vector_adapter_create_ext()`` function.
+ *
+ * The application can enqueue one or more ptrs to the vector adapter using the
+ * ``rte_event_vector_adapter_enqueue()`` function and control the aggregation
+ * using the flags.
+ *
+ * Vector adapters report stats using the ``rte_event_vector_adapter_stats_get()``
+ * function and reset the stats using the ``rte_event_vector_adapter_stats_reset()``.
+ *
+ * The application can destroy the vector adapter using the
+ * ``rte_event_vector_adapter_destroy()`` function.
+ *
+ */
+
+#include <rte_eventdev.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define RTE_EVENT_VECTOR_ADAPTER_CAP_SOV_EOV (1ULL << 0)
+/**< Vector adapter supports Start of Vector (SOV) and End of Vector (EOV) flags
+ *  in the enqueue flags.
+ *
+ * @see RTE_EVENT_VECTOR_ENQ_SOV
+ * @see RTE_EVENT_VECTOR_ENQ_EOV
+ */
+
+#define RTE_EVENT_VECTOR_ENQ_SOV   (1ULL << 0)
+/**< Indicates the start of a vector event. When enqueue is called with
+ *  RTE_EVENT_VECTOR_ENQ_SOV, the vector adapter will flush any vector
+ *  aggregation in progress and start aggregating a new vector event with
+ *  the enqueued ptr.
+ */
+#define RTE_EVENT_VECTOR_ENQ_EOV   (1ULL << 1)
+/**< Indicates the end of a vector event. When enqueue is called with
+ *  RTE_EVENT_VECTOR_ENQ_EOV, the vector adapter will add the current ptr
+ *  to the aggregated event and flush the event vector.
+ */
+#define RTE_EVENT_VECTOR_ENQ_FLUSH (1ULL << 2)
+/**< Flush any in-progress vector aggregation. */
+
+/**
+ * Vector adapter configuration structure
+ */
+struct rte_event_vector_adapter_conf {
+	uint8_t event_dev_id;
+	/**< Event device identifier */
+	uint32_t socket_id;
+	/**< Identifier of socket from which to allocate memory for adapter */
+	struct rte_event ev;
+	/**<
+	 *  The values from the following event fields will be used when
+	 *  queuing work:
+	 *   - queue_id: Targeted event queue ID for vector event.
+	 *   - event_priority: Event priority of the vector event in
+	 *                     the event queue relative to other events.
+	 *   - sched_type: Scheduling type for events from this vector adapter.
+	 *   - event_type: Event type for the vector event.
+	 *   - sub_event_type: Sub event type for the vector event.
+	 *   - flow_id: Flow ID for the vectors enqueued to the event queue by
+	 *              the vector adapter.
+	 */
+	struct rte_event ev_fallback;
+	/**<
+	 * The values from the following event fields will be used when
+	 * aggregation fails and single event is enqueued:
+	 *   - event_type: Event type for the single event.
+	 *   - sub_event_type: Sub event type for the single event.
+	 *   - flow_id: Flow ID for the single event.
+	 *
+	 * Other fields are taken from rte_event_vector_adapter_conf::ev.
+	 */
+	uint16_t vector_sz;
+	/**<
+	 * Indicates the maximum number for enqueued work to combine and form a vector.
+	 * Should be within vectorization limits of the adapter.
+	 * @see rte_event_vector_adapter_info::min_vector_sz
+	 * @see rte_event_vector_adapter_info::max_vector_sz
+	 */
+	uint64_t vector_timeout_ns;
+	/**<
+	 * Indicates the maximum number of nanoseconds to wait for receiving
+	 * work. Should be within vectorization limits of the adapter.
+	 * @see rte_event_vector_adapter_info::min_vector_ns
+	 * @see rte_event_vector_adapter_info::max_vector_ns
+	 */
+	struct rte_mempool *vector_mp;
+	/**<
+	 * Indicates the mempool that should be used for allocating
+	 * rte_event_vector container.
+	 * @see rte_event_vector_pool_create
+	 */
+};
+
+/**
+ * Vector adapter vector info structure
+ */
+struct rte_event_vector_adapter_info {
+	uint8_t max_vector_adapters_per_event_queue;
+	/**< Maximum number of vector adapters configurable */
+	uint16_t min_vector_sz;
+	/**< Minimum vector size configurable */
+	uint16_t max_vector_sz;
+	/**< Maximum vector size configurable */
+	uint64_t min_vector_timeout_ns;
+	/**< Minimum vector timeout configurable */
+	uint64_t max_vector_timeout_ns;
+	/**< Maximum vector timeout configurable */
+	uint8_t log2_sz;
+	/**< True if the size configured should be in log2. */
+};
+
+/**
+ * Vector adapter statistics structure
+ */
+struct rte_event_vector_adapter_stats {
+	uint64_t vectorized;
+	/**< Number of events vectorized */
+	uint64_t vectors_timedout;
+	/**< Number of timeouts occurred */
+	uint64_t vectors_flushed;
+	/**< Number of vectors flushed */
+	uint64_t alloc_failures;
+	/**< Number of vector allocation failures */
+};
+
+struct rte_event_vector_adapter;
+
+typedef int (*rte_event_vector_adapter_enqueue_t)(struct rte_event_vector_adapter *adapter,
+						  uintptr_t ptrs[], uint16_t num_elem,
+						  uint64_t flags);
+/**< @internal Enqueue ptrs into the event vector adapter. */
+
+struct __rte_cache_aligned rte_event_vector_adapter {
+	rte_event_vector_adapter_enqueue_t enqueue;
+	/**< Pointer to driver enqueue function. */
+	struct rte_event_vector_adapter_data *data;
+	/**< Pointer to the adapter data */
+	const struct event_vector_adapter_ops *ops;
+	/**< Functions exported by adapter driver */
+
+	uint32_t adapter_id;
+	/**< Identifier of the adapter instance. */
+	uint8_t used : 1;
+	/**< Flag to indicate that this adapter is being used. */
+};
+
+/**
+ * Callback function type for producer port creation.
+ */
+typedef int (*rte_event_vector_adapter_port_conf_cb_t)(uint8_t event_dev_id, uint8_t *event_port_id,
+						       void *conf_arg);
+
+/**
+ * Create an event vector adapter.
+ *
+ * This function creates an event vector adapter based on the provided
+ * configuration. The adapter can be used to combine multiple mbufs/ptrs/u64s
+ * into a single vector event, i.e., rte_event_vector, which is then enqueued
+ * to the event queue provided.
+ * @see rte_event_vector_adapter_conf::ev::event_queue_id.
+ *
+ * @param conf
+ *   Configuration for the event vector adapter.
+ * @return
+ *   - Pointer to the created event vector adapter on success.
+ *   - NULL on failure with rte_errno set to the error code.
+ *     Possible rte_errno values include:
+ *    - EINVAL: Invalid event device identifier specified in config.
+ *    - ENOMEM: Unable to allocate sufficient memory for adapter instances.
+ *    - ENOSPC: Maximum number of adapters already created.
+ */
+struct rte_event_vector_adapter *
+rte_event_vector_adapter_create(const struct rte_event_vector_adapter_conf *conf);
+
+/**
+ * Create an event vector adapter with the supplied callback.
+ *
+ * This function can be used to have a more granular control over the event
+ * vector adapter creation. If a built-in port is absent, then the function uses
+ * the callback provided to create and get the port id to be used as a producer
+ * port.
+ *
+ * @param conf
+ *   The event vector adapter configuration structure.
+ * @param conf_cb
+ *   The port config callback function.
+ * @param conf_arg
+ *   Opaque pointer to the argument for the callback function.
+ * @return
+ *   - Pointer to the new allocated event vector adapter on success.
+ *   - NULL on error with rte_errno set appropriately.
+ *   Possible rte_errno values include:
+ *   - ERANGE: vector_timeout_ns is not in supported range.
+ *   - ENOMEM: Unable to allocate sufficient memory for adapter instances.
+ *   - EINVAL: Invalid event device identifier specified in config.
+ *   - ENOSPC: Maximum number of adapters already created.
+ */
+struct rte_event_vector_adapter *
+rte_event_vector_adapter_create_ext(const struct rte_event_vector_adapter_conf *conf,
+				    rte_event_vector_adapter_port_conf_cb_t conf_cb,
+				    void *conf_arg);
+
+/**
+ * Lookup an event vector adapter using its identifier.
+ *
+ * This function returns the event vector adapter based on the adapter_id.
+ * This is useful when the adapter is created in another process and the
+ * application wants to use the adapter in the current process.
+ *
+ * @param adapter_id
+ *   Identifier of the event vector adapter to look up.
+ * @return
+ *   - Pointer to the event vector adapter on success.
+ *   - NULL if the adapter is not found.
+ */
+struct rte_event_vector_adapter *
+rte_event_vector_adapter_lookup(uint32_t adapter_id);
+
+/**
+ * Destroy an event vector adapter.
+ *
+ * This function releases the resources associated with the event vector adapter.
+ *
+ * @param adapter
+ *   Pointer to the event vector adapter to be destroyed.
+ * @return
+ *   - 0 on success.
+ *   - Negative value on failure with rte_errno set to the error code.
+ */
+int
+rte_event_vector_adapter_destroy(struct rte_event_vector_adapter *adapter);
+
+/**
+ * Get the vector info of an event vector adapter.
+ *
+ * This function retrieves the vector info of the event vector adapter.
+ *
+ * @param event_dev_id
+ *   Event device identifier.
+ * @param info
+ *   Pointer to the structure where the vector info will be stored.
+ * @return
+ *   0 on success, negative value on failure.
+ *   - EINVAL if the event device identifier is invalid.
+ *   - ENOTSUP if the event device does not support vector adapters.
+ */
+int
+rte_event_vector_adapter_info_get(uint8_t event_dev_id,
+				  struct rte_event_vector_adapter_info *info);
+
+/**
+ * Get the configuration of an event vector adapter.
+ *
+ * This function retrieves the configuration of the event vector adapter.
+ *
+ * @param adapter
+ *   Pointer to the event vector adapter.
+ * @param conf
+ *   Pointer to the structure where the configuration will be stored.
+ * @return
+ *   0 on success, negative value on failure.
+ */
+int
+rte_event_vector_adapter_conf_get(struct rte_event_vector_adapter *adapter,
+				  struct rte_event_vector_adapter_conf *conf);
+
+/**
+ * Get the remaining event vector adapters.
+ *
+ * This function retrieves the number of remaining event vector adapters
+ * available for a given event device and event queue.
+ *
+ * @param event_dev_id
+ *   Event device identifier.
+ * @param event_queue_id
+ *   Event queue identifier.
+ * @return
+ *   Number of remaining slots available for enqueuing events.
+ */
+uint8_t
+rte_event_vector_adapter_remaining(uint8_t event_dev_id, uint8_t event_queue_id);
+
+/**
+ * Get the event vector adapter statistics.
+ *
+ * This function retrieves the statistics of the event vector adapter.
+ *
+ * @param adapter
+ *   Pointer to the event vector adapter.
+ * @param stats
+ *   Pointer to the structure where the statistics will be stored.
+ * @return
+ *   0 on success, negative value on failure.
+ */
+int
+rte_event_vector_adapter_stats_get(struct rte_event_vector_adapter *adapter,
+				   struct rte_event_vector_adapter_stats *stats);
+
+/**
+ * @brief Reset the event vector adapter statistics.
+ *
+ * This function resets the statistics of the event vector adapter to their default values.
+ *
+ * @param adapter
+ *   Pointer to the event vector adapter whose statistics are to be reset.
+ * @return
+ *   0 on success, negative value on failure.
+ */
+int
+rte_event_vector_adapter_stats_reset(struct rte_event_vector_adapter *adapter);
+
+/**
+ * Retrieve the service ID of the event vector adapter. If the adapter doesn't
+ * use an rte_service function, this function returns -ESRCH.
+ *
+ * @param adapter
+ *   A pointer to an event vector adapter.
+ * @param [out] service_id
+ *   A pointer to a uint32_t, to be filled in with the service id.
+ *
+ * @return
+ *   - 0: Success
+ *   - <0: Error code on failure
+ *   - -ESRCH: the adapter does not require a service to operate
+ */
+int
+rte_event_vector_adapter_service_id_get(struct rte_event_vector_adapter *adapter,
+					uint32_t *service_id);
+
+/**
+ * Enqueue ptrs into the event vector adapter.
+ *
+ * This function enqueues a specified number of ptrs into the event vector adapter.
+ * The ptrs are combined into a single vector event, i.e., rte_event_vector, which
+ * is then enqueued to the event queue configured in the adapter.
+ *
+ * @param adapter
+ *   Pointer to the event vector adapter.
+ * @param ptrs
+ *   Array of ptrs to be enqueued.
+ * @param num_elem
+ *   Number of ptrs to be enqueued.
+ * @param flags
+ *   Flags to be used for the enqueue operation.
+ * @return
+ *   Number of ptrs enqueued on success.
+ */
+static inline int
+rte_event_vector_adapter_enqueue(struct rte_event_vector_adapter *adapter, uintptr_t ptrs[],
+				 uint16_t num_elem, uint64_t flags)
+{
+#ifdef RTE_LIBRTE_EVENTDEV_DEBUG
+	if (adapter == NULL) {
+		rte_errno = EINVAL;
+		return 0;
+	}
+
+	if (adapter->used == false) {
+		rte_errno = EINVAL;
+		return 0;
+	}
+#endif
+	return adapter->enqueue(adapter, ptrs, num_elem, flags);
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __RTE_EVENT_VECTOR_ADAPTER_H__ */
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index 43cd95d765..0be1c0ba31 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -244,6 +244,27 @@ rte_event_dma_adapter_caps_get(uint8_t dev_id, uint8_t dma_dev_id, uint32_t *cap
 	return 0;
 }
 
+int
+rte_event_vector_adapter_caps_get(uint8_t dev_id, uint32_t *caps)
+{
+	const struct event_vector_adapter_ops *ops;
+	struct rte_eventdev *dev;
+
+	RTE_EVENTDEV_VALID_DEVID_OR_ERR_RET(dev_id, -EINVAL);
+
+	dev = &rte_eventdevs[dev_id];
+
+	if (caps == NULL)
+		return -EINVAL;
+
+	if (dev->dev_ops->vector_adapter_caps_get == NULL)
+		*caps = 0;
+
+	return dev->dev_ops->vector_adapter_caps_get ?
+		       dev->dev_ops->vector_adapter_caps_get(dev, caps, &ops) :
+		       0;
+}
+
 static inline int
 event_dev_queue_config(struct rte_eventdev *dev, uint8_t nb_queues)
 {
diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
index 6400d6109f..41c459feff 100644
--- a/lib/eventdev/rte_eventdev.h
+++ b/lib/eventdev/rte_eventdev.h
@@ -1985,6 +1985,14 @@ int
 rte_event_eth_tx_adapter_caps_get(uint8_t dev_id, uint16_t eth_port_id,
 				uint32_t *caps);
 
+/* Vector adapter capability bitmap flags */
+#define RTE_EVENT_VECTOR_ADAPTER_CAP_INTERNAL_PORT	0x1
+/**< This flag is set when the vector adapter is capable of generating events
+ * using an internal event port.
+ */
+
+int rte_event_vector_adapter_caps_get(uint8_t dev_id, uint32_t *caps);
+
 /**
  * Converts nanoseconds to *timeout_ticks* value for rte_event_dequeue_burst()
  *
diff --git a/lib/eventdev/version.map b/lib/eventdev/version.map
index 44687255cb..083e6c0d18 100644
--- a/lib/eventdev/version.map
+++ b/lib/eventdev/version.map
@@ -156,6 +156,19 @@ EXPERIMENTAL {
 
 	# added in 25.03
 	rte_event_eth_rx_adapter_queues_add;
+
+	#added in 25.05
+	rte_event_vector_adapter_create;
+	rte_event_vector_adapter_create_ext;
+	rte_event_vector_adapter_lookup;
+	rte_event_vector_adapter_destroy;
+	rte_event_vector_adapter_info_get;
+	rte_event_vector_adapter_conf_get;
+	rte_event_vector_adapter_remaining;
+	rte_event_vector_adapter_stats_get;
+	rte_event_vector_adapter_stats_reset;
+	rte_event_vector_adapter_service_id_get;
+	rte_event_vector_adapter_enqueue;
 };
 
 INTERNAL {
-- 
2.43.0

