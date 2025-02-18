Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BB8C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 09:16:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A9B4402D8;
	Tue, 18 Feb 2025 10:16:22 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id DF962402A0
 for <dev@dpdk.org>; Tue, 18 Feb 2025 10:16:19 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HN0X1b022653;
 Tue, 18 Feb 2025 01:16:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
 Cmf4DJ1n9C24ekZB/GUHibP2ll3kAN5HwWkt0kXeBU=; b=hPX2t6kYT3jMYDun2
 km47YBP4bAUdzQMlMkVRd/gHL9KdKLciD7f1Ul96BA01fU/X9/p+Aysy5Qwnhg8z
 rAA6d15CBWUjoCRrFddNbJNUgISwDRPddjZsSGATIXLZMIKURGq41RC5kWRU39ab
 sFQ1+JPYi72bMZaUI3i9cC+aNQWHtGC52XhLhLKfDqDemWcXY4Bn0l1r5I1xXvzS
 +SV7tnz/hYeOcGu8Zt37QvLVFY5t/gXiRLGIArym5Ypz2VcihRejRU5K+3pInbUd
 8Dt5dkHeVGVsv0hFHrqGco61GBxe/dSH8CRf6KVrtH8pM5Fa9B6McHfCQrZ/G7wM
 T9QBA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44u5rdm8vd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 01:16:18 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 18 Feb 2025 01:16:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 18 Feb 2025 01:16:18 -0800
Received: from localhost.localdomain (unknown [10.28.34.29])
 by maili.marvell.com (Postfix) with ESMTP id 9024D3F707A;
 Tue, 18 Feb 2025 01:16:13 -0800 (PST)
From: Shijith Thotton <sthotton@marvell.com>
To: <s.v.naga.harish.k@intel.com>, <jerinj@marvell.com>
CC: Shijith Thotton <sthotton@marvell.com>, <dev@dpdk.org>,
 <pbhagavatula@marvell.com>, Pravin Pathak <pravin.pathak@intel.com>,
 "Hemant Agrawal" <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Mattias R_nnblom <mattias.ronnblom@ericsson.com>, Liang Ma
 <liangma@liangbit.com>, Peter Mccarthy <peter.mccarthy@intel.com>,
 "Harry van Haaren" <harry.van.haaren@intel.com>, Erik Gabriel Carrillo
 <erik.g.carrillo@intel.com>,
 Abhinandan Gujjar <abhinandan.gujjar@intel.com>,
 Amit Prakash Shukla <amitprakashs@marvell.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>
Subject: [PATCH v2 1/3] eventdev/eth_rx: add API to burst add queues to Rx
 adapter
Date: Tue, 18 Feb 2025 14:45:40 +0530
Message-ID: <20250218091543.282270-2-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250207140910.721374-1-sthotton@marvell.com>
References: <20250207140910.721374-1-sthotton@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mytPfwhTU9zsMKE0dgXGul9nGUyAnFea
X-Proofpoint-GUID: mytPfwhTU9zsMKE0dgXGul9nGUyAnFea
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
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

This patch introduces a new API, rte_event_eth_rx_adapter_queues_add(),
to allow bulk addition of multiple Rx queues in the eventdev Rx adapter.

The existing rte_event_eth_rx_adapter_queue_add() API supports adding
multiple queues by specifying rx_queue_id = -1, but it lacks the ability
to apply specific configurations to each of the added queues.

A new internal PMD operation, eventdev_eth_rx_adapter_queues_add_t, has
been introduced to enable this functionality. It takes an array of
receive queue IDs along with their corresponding queue configurations.

Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 .../eventdev/event_ethernet_rx_adapter.rst    |  60 +++++--
 lib/eventdev/eventdev_pmd.h                   |  34 ++++
 lib/eventdev/eventdev_trace.h                 |  14 ++
 lib/eventdev/eventdev_trace_points.c          |   3 +
 lib/eventdev/rte_event_eth_rx_adapter.c       | 155 ++++++++++++++++++
 lib/eventdev/rte_event_eth_rx_adapter.h       |  33 ++++
 lib/eventdev/version.map                      |   3 +
 7 files changed, 292 insertions(+), 10 deletions(-)

diff --git a/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst b/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
index 2e68cca798..bae46cc7d7 100644
--- a/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
+++ b/doc/guides/prog_guide/eventdev/event_ethernet_rx_adapter.rst
@@ -96,16 +96,23 @@ when the adapter is created using the above-mentioned APIs.
 Adding Rx Queues to the Adapter Instance
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Ethdev Rx queues are added to the instance using the
-``rte_event_eth_rx_adapter_queue_add()`` function. Configuration for the Rx
-queue is passed in using a ``struct rte_event_eth_rx_adapter_queue_conf``
-parameter. Event information for packets from this Rx queue is encoded in the
-``ev`` field of ``struct rte_event_eth_rx_adapter_queue_conf``. The
-servicing_weight member of the struct  rte_event_eth_rx_adapter_queue_conf
-is the relative polling frequency of the Rx queue and is applicable when the
-adapter uses a service core function. The applications can configure queue
-event buffer size in ``struct rte_event_eth_rx_adapter_queue_conf::event_buf_size``
-parameter.
+Ethdev Rx queues can be added to the instance using either the
+``rte_event_eth_rx_adapter_queue_add()`` function or
+``rte_event_eth_rx_adapter_queues_add()``. The former is used to add a single Rx
+queue at a time, while the latter allows adding multiple Rx queues in a single
+call.
+
+Single Queue Addition
+^^^^^^^^^^^^^^^^^^^^^
+
+The ``rte_event_eth_rx_adapter_queue_add()`` API allows adding a single Rx queue
+to the adapter instance. Configuration for the Rx queue is passed using a
+``struct rte_event_eth_rx_adapter_queue_conf`` parameter. Event information for
+packets from this Rx queue is encoded in the ``ev`` field of this struct. The
+``servicing_weight`` member of the struct determines the relative polling
+frequency of the Rx queue and is applicable when the adapter uses a service core
+function. Applications can also configure the queue event buffer size using the
+``event_buf_size`` parameter in ``struct rte_event_eth_rx_adapter_queue_conf``.
 
 .. code-block:: c
 
@@ -122,6 +129,39 @@ parameter.
                                                 eth_dev_id,
                                                 0, &queue_config);
 
+Bulk Queue Addition
+^^^^^^^^^^^^^^^^^^^
+
+The ``rte_event_eth_rx_adapter_queues_add()`` API allows the addition of
+multiple Rx queues in a single call. While
+``rte_event_eth_rx_adapter_queue_add()`` supports adding multiple queues by
+specifying ``rx_queue_id = -1``, it does not allow applying specific
+configurations to each queue individually.  The
+``rte_event_eth_rx_adapter_queues_add()`` API accepts an array of receive queue
+IDs along with their corresponding configurations, enabling control over each Rx
+queue's settings.
+
+.. code-block:: c
+
+        struct rte_event_eth_rx_adapter_queue_conf queue_config[nb_rx_queues];
+        int rx_queue_id[nb_rx_queues];
+
+        for (int i = 0; i < nb_rx_queues; i++) {
+            rx_queue_id[i] = i;
+            queue_config[i].rx_queue_flags = 0;
+            queue_config[i].ev.queue_id = i;
+            queue_config[i].ev.sched_type = RTE_SCHED_TYPE_ATOMIC;
+            queue_config[i].ev.priority = 0;
+            queue_config[i].servicing_weight = 1;
+            queue_config[i].event_buf_size = 1024;
+        }
+
+        err = rte_event_eth_rx_adapter_queues_add(id,
+                                                 eth_dev_id,
+                                                 rx_queue_id,
+                                                 queue_config,
+                                                 nb_rx_queues);
+
 Querying Adapter Capabilities
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
index 36148f8d86..ad13ba5b03 100644
--- a/lib/eventdev/eventdev_pmd.h
+++ b/lib/eventdev/eventdev_pmd.h
@@ -25,6 +25,7 @@
 #include <rte_mbuf_dyn.h>
 
 #include "event_timer_adapter_pmd.h"
+#include "rte_event_eth_rx_adapter.h"
 #include "rte_eventdev.h"
 
 #ifdef __cplusplus
@@ -708,6 +709,37 @@ typedef int (*eventdev_eth_rx_adapter_queue_add_t)(
 		int32_t rx_queue_id,
 		const struct rte_event_eth_rx_adapter_queue_conf *queue_conf);
 
+/**
+ * Add ethernet Rx queues to event device in burst. This callback is invoked if
+ * the caps returned from rte_eventdev_eth_rx_adapter_caps_get(, eth_port_id)
+ * has RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT set.
+ *
+ * @param dev
+ *   Event device pointer
+ *
+ * @param eth_dev
+ *   Ethernet device pointer
+ *
+ * @param rx_queue_id
+ *   Ethernet device receive queue index array
+ *
+ * @param queue_conf
+ *   Additional configuration structure array
+ *
+ * @param nb_rx_queues
+ *   Number of ethernet device receive queues
+ *
+ * @return
+ *   - 0: Success, ethernet receive queues added successfully.
+ *   - <0: Error code returned by the driver function.
+ */
+typedef int (*eventdev_eth_rx_adapter_queues_add_t)(
+		const struct rte_eventdev *dev,
+		const struct rte_eth_dev *eth_dev,
+		int32_t rx_queue_id[],
+		const struct rte_event_eth_rx_adapter_queue_conf queue_conf[],
+		uint16_t nb_rx_queues);
+
 /**
  * Delete ethernet Rx queues from event device. This callback is invoked if
  * the caps returned from eventdev_eth_rx_adapter_caps_get(, eth_port_id)
@@ -1578,6 +1610,8 @@ struct eventdev_ops {
 	/**< Get ethernet Rx adapter capabilities */
 	eventdev_eth_rx_adapter_queue_add_t eth_rx_adapter_queue_add;
 	/**< Add Rx queues to ethernet Rx adapter */
+	eventdev_eth_rx_adapter_queues_add_t eth_rx_adapter_queues_add;
+	/**< Add Rx queues to ethernet Rx adapter in burst */
 	eventdev_eth_rx_adapter_queue_del_t eth_rx_adapter_queue_del;
 	/**< Delete Rx queues from ethernet Rx adapter */
 	eventdev_eth_rx_adapter_queue_conf_get_t eth_rx_adapter_queue_conf_get;
diff --git a/lib/eventdev/eventdev_trace.h b/lib/eventdev/eventdev_trace.h
index 8ff8841729..6b334d8bd1 100644
--- a/lib/eventdev/eventdev_trace.h
+++ b/lib/eventdev/eventdev_trace.h
@@ -159,6 +159,20 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(rc);
 )
 
+RTE_TRACE_POINT(
+	rte_eventdev_trace_eth_rx_adapter_queues_add,
+	RTE_TRACE_POINT_ARGS(uint8_t adptr_id, uint16_t eth_dev_id,
+		uint16_t nb_rx_queues, void *rx_queue_id,
+		const void *queue_conf,
+		int rc),
+	rte_trace_point_emit_u8(adptr_id);
+	rte_trace_point_emit_u16(eth_dev_id);
+	rte_trace_point_emit_u16(nb_rx_queues);
+	rte_trace_point_emit_ptr(rx_queue_id);
+	rte_trace_point_emit_ptr(queue_conf);
+	rte_trace_point_emit_int(rc);
+)
+
 RTE_TRACE_POINT(
 	rte_eventdev_trace_eth_rx_adapter_queue_del,
 	RTE_TRACE_POINT_ARGS(uint8_t adptr_id, uint16_t eth_dev_id,
diff --git a/lib/eventdev/eventdev_trace_points.c b/lib/eventdev/eventdev_trace_points.c
index e7af1591f7..8caf6353a1 100644
--- a/lib/eventdev/eventdev_trace_points.c
+++ b/lib/eventdev/eventdev_trace_points.c
@@ -65,6 +65,9 @@ RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_free,
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queue_add,
 	lib.eventdev.rx.adapter.queue.add)
 
+RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queues_add,
+	lib.eventdev.rx.adapter.queues.add)
+
 RTE_TRACE_POINT_REGISTER(rte_eventdev_trace_eth_rx_adapter_queue_del,
 	lib.eventdev.rx.adapter.queue.del)
 
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index 39674c4604..87bb64bcd5 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -2793,6 +2793,161 @@ rte_event_eth_rx_adapter_queue_add(uint8_t id,
 	return 0;
 }
 
+int
+rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id, int32_t rx_queue_id[],
+				    const struct rte_event_eth_rx_adapter_queue_conf queue_conf[],
+				    uint16_t nb_rx_queues)
+{
+	struct rte_event_eth_rx_adapter_vector_limits limits;
+	struct event_eth_rx_adapter *rx_adapter;
+	struct eth_device_info *dev_info;
+	struct rte_eventdev *dev;
+	uint32_t cap, i;
+	int ret;
+
+	if (rxa_memzone_lookup())
+		return -ENOMEM;
+
+	RTE_EVENT_ETH_RX_ADAPTER_ID_VALID_OR_ERR_RET(id, -EINVAL);
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(eth_dev_id, -EINVAL);
+
+	rx_adapter = rxa_id_to_adapter(id);
+	if ((rx_adapter == NULL) || (queue_conf == NULL))
+		return -EINVAL;
+
+	if (nb_rx_queues && rx_queue_id == NULL)
+		return -EINVAL;
+
+	if (nb_rx_queues > rte_eth_devices[eth_dev_id].data->nb_rx_queues) {
+		RTE_EDEV_LOG_ERR("Invalid number of rx queues %" PRIu16, nb_rx_queues);
+		return -EINVAL;
+	}
+
+	ret = rte_event_eth_rx_adapter_caps_get(rx_adapter->eventdev_id, eth_dev_id, &cap);
+	if (ret) {
+		RTE_EDEV_LOG_ERR("Failed to get adapter caps edev %" PRIu8 "eth port %" PRIu16, id,
+				 eth_dev_id);
+		return ret;
+	}
+
+	if ((cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ) == 0 && nb_rx_queues) {
+		RTE_EDEV_LOG_ERR("Rx queues can only be connected to single "
+				 "event queue, eth port: %" PRIu16 " adapter id: %" PRIu8,
+				 eth_dev_id, id);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < (nb_rx_queues ? nb_rx_queues : 1); i++) {
+		const struct rte_event_eth_rx_adapter_queue_conf *conf;
+
+		conf = &queue_conf[i];
+		if ((cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_OVERRIDE_FLOW_ID) == 0 &&
+		    (conf->rx_queue_flags & RTE_EVENT_ETH_RX_ADAPTER_QUEUE_FLOW_ID_VALID)) {
+			RTE_EDEV_LOG_ERR("Flow ID override is not supported in queue_conf[%" PRIu32
+					 "], eth port: %" PRIu16 " adapter id: %" PRIu8,
+					 i, eth_dev_id, id);
+			return -EINVAL;
+		}
+
+		if (conf->rx_queue_flags & RTE_EVENT_ETH_RX_ADAPTER_QUEUE_EVENT_VECTOR) {
+			if ((cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_EVENT_VECTOR) == 0) {
+				RTE_EDEV_LOG_ERR(
+					"Event vectorization is unsupported in queue_conf[%" PRIu32
+					"], eth port: %" PRIu16 " adapter id: %" PRIu8,
+					i, eth_dev_id, id);
+				return -EINVAL;
+			}
+
+			ret = rte_event_eth_rx_adapter_vector_limits_get(rx_adapter->eventdev_id,
+									 eth_dev_id, &limits);
+			if (ret < 0) {
+				RTE_EDEV_LOG_ERR("Failed to get event device vector limits,"
+						 " eth port: %" PRIu16 " adapter id: %" PRIu8,
+						 eth_dev_id, id);
+				return -EINVAL;
+			}
+
+			if (conf->vector_sz < limits.min_sz || conf->vector_sz > limits.max_sz ||
+			    conf->vector_timeout_ns < limits.min_timeout_ns ||
+			    conf->vector_timeout_ns > limits.max_timeout_ns ||
+			    conf->vector_mp == NULL) {
+				RTE_EDEV_LOG_ERR(
+					"Invalid event vector configuration in queue_conf[%" PRIu32
+					"], eth port: %" PRIu16 " adapter id: %" PRIu8,
+					i, eth_dev_id, id);
+				return -EINVAL;
+			}
+
+			if (conf->vector_mp->elt_size < (sizeof(struct rte_event_vector) +
+							 (sizeof(uintptr_t) * conf->vector_sz))) {
+				RTE_EDEV_LOG_ERR(
+					"Invalid event vector configuration in queue_conf[%" PRIu32
+					"], eth port: %" PRIu16 " adapter id: %" PRIu8,
+					i, eth_dev_id, id);
+				return -EINVAL;
+			}
+		}
+
+		if ((rx_adapter->use_queue_event_buf && conf->event_buf_size == 0) ||
+		    (!rx_adapter->use_queue_event_buf && conf->event_buf_size != 0)) {
+			RTE_EDEV_LOG_ERR("Invalid Event buffer size in queue_conf[%" PRIu32 "]", i);
+			return -EINVAL;
+		}
+	}
+
+	dev = &rte_eventdevs[rx_adapter->eventdev_id];
+	dev_info = &rx_adapter->eth_devices[eth_dev_id];
+
+	if (cap & RTE_EVENT_ETH_RX_ADAPTER_CAP_INTERNAL_PORT) {
+		if (*dev->dev_ops->eth_rx_adapter_queues_add == NULL)
+			return -ENOTSUP;
+
+		if (dev_info->rx_queue == NULL) {
+			dev_info->rx_queue =
+				rte_zmalloc_socket(rx_adapter->mem_name,
+						   dev_info->dev->data->nb_rx_queues *
+							   sizeof(struct eth_rx_queue_info),
+						   0, rx_adapter->socket_id);
+			if (dev_info->rx_queue == NULL)
+				return -ENOMEM;
+		}
+
+		ret = (*dev->dev_ops->eth_rx_adapter_queues_add)(
+			dev, &rte_eth_devices[eth_dev_id], rx_queue_id, queue_conf, nb_rx_queues);
+		if (ret == 0) {
+			dev_info->internal_event_port = 1;
+
+			if (nb_rx_queues == 0)
+				rxa_update_queue(rx_adapter, dev_info, -1, 1);
+
+			for (i = 0; i < nb_rx_queues; i++)
+				rxa_update_queue(rx_adapter, dev_info, rx_queue_id[i], 1);
+		}
+	} else {
+		rte_spinlock_lock(&rx_adapter->rx_lock);
+		dev_info->internal_event_port = 0;
+		ret = rxa_init_service(rx_adapter, id);
+		if (ret == 0) {
+			uint32_t service_id = rx_adapter->service_id;
+
+			if (nb_rx_queues == 0)
+				ret = rxa_sw_add(rx_adapter, eth_dev_id, -1, &queue_conf[0]);
+
+			for (i = 0; i < nb_rx_queues; i++)
+				ret = rxa_sw_add(rx_adapter, eth_dev_id, rx_queue_id[i],
+						 &queue_conf[i]);
+
+			rte_service_component_runstate_set(service_id,
+							   rxa_sw_adapter_queue_count(rx_adapter));
+		}
+		rte_spinlock_unlock(&rx_adapter->rx_lock);
+	}
+
+	rte_eventdev_trace_eth_rx_adapter_queues_add(id, eth_dev_id, nb_rx_queues, rx_queue_id,
+						     queue_conf, ret);
+	return ret;
+}
+
 static int
 rxa_sw_vector_limits(struct rte_event_eth_rx_adapter_vector_limits *limits)
 {
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.h b/lib/eventdev/rte_event_eth_rx_adapter.h
index 9237e198a7..758e1c5f56 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.h
+++ b/lib/eventdev/rte_event_eth_rx_adapter.h
@@ -553,6 +553,39 @@ int rte_event_eth_rx_adapter_queue_add(uint8_t id,
 			int32_t rx_queue_id,
 			const struct rte_event_eth_rx_adapter_queue_conf *conf);
 
+/**
+ * Add multiple receive queues to an event adapter.
+ *
+ * @param id
+ *  Adapter identifier.
+ *
+ * @param eth_dev_id
+ *  Port identifier of Ethernet device.
+ *
+ * @param rx_queue_id
+ *  Array of Ethernet device receive queue indices.
+ *  If nb_rx_queues is 0, then rx_queue_id is ignored.
+ *
+ * @param conf
+ *  Array of additional configuration structures of type
+ *  *rte_event_eth_rx_adapter_queue_conf*. conf[i] is used for rx_queue_id[i].
+ *  If nb_rx_queues is 0, then conf[0] is used for all Rx queues.
+ *
+ * @param nb_rx_queues
+ *  Number of receive queues to add.
+ *  If nb_rx_queues is 0, then all Rx queues configured for
+ *  the device are added with the same configuration in conf[0].
+ * @see RTE_EVENT_ETH_RX_ADAPTER_CAP_MULTI_EVENTQ
+ *
+ * @return
+ *  - 0: Success, Receive queues added correctly.
+ *  - <0: Error code on failure.
+ */
+__rte_experimental
+int rte_event_eth_rx_adapter_queues_add(uint8_t id, uint16_t eth_dev_id, int32_t rx_queue_id[],
+					const struct rte_event_eth_rx_adapter_queue_conf conf[],
+					uint16_t nb_rx_queues);
+
 /**
  * Delete receive queue from an event adapter.
  *
diff --git a/lib/eventdev/version.map b/lib/eventdev/version.map
index 42a5867aba..44687255cb 100644
--- a/lib/eventdev/version.map
+++ b/lib/eventdev/version.map
@@ -153,6 +153,9 @@ EXPERIMENTAL {
 	__rte_eventdev_trace_port_preschedule_modify;
 	rte_event_port_preschedule;
 	__rte_eventdev_trace_port_preschedule;
+
+	# added in 25.03
+	rte_event_eth_rx_adapter_queues_add;
 };
 
 INTERNAL {
-- 
2.25.1

