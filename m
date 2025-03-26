Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF911C3600B
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 13:15:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF73C40656;
	Wed, 26 Mar 2025 14:15:14 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 360E2402DA
 for <dev@dpdk.org>; Wed, 26 Mar 2025 14:15:12 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q5TAkc005736
 for <dev@dpdk.org>; Wed, 26 Mar 2025 06:15:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 fnFf3QE/V0SgJLw+3FQHe5+0NTH2/OJM6eQ0G/tcu4=; b=XrfhClrQwkG3tbR8U
 wqCDUMxLCLRJJ1EiSF7LNmT2Zq/iD44hbh86DFSC2isedH0zBIc99eQxR/Jmw55+
 MDiAsNJdmMf5mofc+3xZdLBKpF4Qr299tUwdWMFXYAB/M+njMb+3EQilvlzMIfX3
 eHeMcRLt41JREPBfNL8kIxG5yXNy0k8awIVhQoLVty2yxmi8F0DwSlLy/nb1JK4y
 ltMob5sFMiT8nSL4XQIvYwxUH362LabulT82XZInCB6xBpizXK+hB2iS6RVK/vIN
 N9Yd7J3YY7yIdouOfsTrSciE3Oev6pYx76W4HldtNbsuMGI/1yPeE0gDD1aeeI8E
 9DoXA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45mbfj8tjp-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 26 Mar 2025 06:15:11 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 26 Mar 2025 06:14:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Mar 2025 06:14:54 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 3E7D85B6932;
 Wed, 26 Mar 2025 06:14:52 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [RFC 2/2] eventdev: add default software vector adapter
Date: Wed, 26 Mar 2025 18:44:36 +0530
Message-ID: <20250326131441.5965-3-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326131441.5965-1-pbhagavatula@marvell.com>
References: <20250326131441.5965-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ryFhq4h76XIE8jcf1LquALd9uvJXBeTp
X-Authority-Analysis: v=2.4 cv=auuyCTZV c=1 sm=1 tr=0 ts=67e3fddf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=GZO1JjcZeHyYiOzNpfEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ryFhq4h76XIE8jcf1LquALd9uvJXBeTp
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

When event device PMD doesn't support vector adapter,
the library will fallback to software implementation
which relies on service core to check for timeouts
and vectorizes the objects on enqueue.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 lib/eventdev/eventdev_pmd.h             |   2 +
 lib/eventdev/rte_event_vector_adapter.c | 318 ++++++++++++++++++++++++
 lib/eventdev/rte_eventdev.c             |   2 +
 3 files changed, 322 insertions(+)

diff --git a/lib/eventdev/eventdev_pmd.h b/lib/eventdev/eventdev_pmd.h
index d03461316b..dda8ad82c9 100644
--- a/lib/eventdev/eventdev_pmd.h
+++ b/lib/eventdev/eventdev_pmd.h
@@ -87,6 +87,8 @@ extern int rte_event_logtype;
 #define RTE_EVENT_TIMER_ADAPTER_SW_CAP \
 		RTE_EVENT_TIMER_ADAPTER_CAP_PERIODIC
 
+#define RTE_EVENT_VECTOR_ADAPTER_SW_CAP RTE_EVENT_VECTOR_ADAPTER_CAP_SOV_EOV
+
 #define RTE_EVENTDEV_DETACHED  (0)
 #define RTE_EVENTDEV_ATTACHED  (1)
 
diff --git a/lib/eventdev/rte_event_vector_adapter.c b/lib/eventdev/rte_event_vector_adapter.c
index 5f38a9a40b..c1d29530be 100644
--- a/lib/eventdev/rte_event_vector_adapter.c
+++ b/lib/eventdev/rte_event_vector_adapter.c
@@ -21,6 +21,10 @@
 
 #define MZ_NAME_MAX_LEN	    64
 #define DATA_MZ_NAME_FORMAT "rte_event_vector_adapter_data_%d_%d_%d"
+#define MAX_VECTOR_SIZE	    1024
+#define MIN_VECTOR_SIZE	    1
+#define MAX_VECTOR_NS	    1E9
+#define MIN_VECTOR_NS	    1E5
 
 RTE_LOG_REGISTER_SUFFIX(ev_vector_logtype, adapter.vector, NOTICE);
 #define RTE_LOGTYPE_EVVEC ev_vector_logtype
@@ -46,6 +50,9 @@ struct rte_event_vector_adapter *adapters[RTE_EVENT_MAX_DEVS][RTE_EVENT_MAX_QUEU
 		}                                                                                  \
 	} while (0)
 
+static const struct event_vector_adapter_ops sw_ops;
+static const struct rte_event_vector_adapter_info sw_info;
+
 static int
 validate_conf(const struct rte_event_vector_adapter_conf *conf,
 	      struct rte_event_vector_adapter_info *info)
@@ -229,6 +236,11 @@ rte_event_vector_adapter_create_ext(const struct rte_event_vector_adapter_conf *
 		}
 	}
 
+	if (adapter->ops == NULL) {
+		adapter->ops = &sw_ops;
+		info = sw_info;
+	}
+
 	rc = validate_conf(conf, &info);
 	if (rc < 0) {
 		adapter->ops = NULL;
@@ -338,6 +350,8 @@ rte_event_vector_adapter_lookup(uint32_t adapter_id)
 			return NULL;
 		}
 	}
+	if (adapter->ops == NULL)
+		adapter->ops = &sw_ops;
 
 	adapter->enqueue = adapter->ops->enqueue;
 	adapter->adapter_id = adapter_id;
@@ -384,6 +398,7 @@ rte_event_vector_adapter_info_get(uint8_t event_dev_id, struct rte_event_vector_
 	if (dev->dev_ops->vector_adapter_info_get != NULL)
 		return dev->dev_ops->vector_adapter_info_get(dev, info);
 
+	*info = sw_info;
 	return 0;
 }
 
@@ -442,3 +457,306 @@ rte_event_vector_adapter_stats_reset(struct rte_event_vector_adapter *adapter)
 
 	return 0;
 }
+
+/* Software vector adapter implementation. */
+
+struct sw_vector_adapter_service_data;
+struct sw_vector_adapter_data {
+	uint8_t dev_id;
+	uint8_t port_id;
+	uint16_t vector_sz;
+	uint64_t timestamp;
+	uint64_t event_meta;
+	uint64_t vector_tmo_ticks;
+	uint64_t fallback_event_meta;
+	struct rte_mempool *vector_mp;
+	struct rte_event_vector *vector;
+	RTE_ATOMIC(rte_mcslock_t *) lock;
+	struct rte_event_vector_adapter *adapter;
+	struct rte_event_vector_adapter_stats stats;
+	struct sw_vector_adapter_service_data *service_data;
+	RTE_TAILQ_ENTRY(sw_vector_adapter_data) next;
+};
+
+struct sw_vector_adapter_service_data {
+	uint32_t service_id;
+	RTE_ATOMIC(rte_mcslock_t *) lock;
+	RTE_TAILQ_HEAD(, sw_vector_adapter_data) adapter_list;
+};
+
+static inline struct sw_vector_adapter_data *
+sw_vector_adapter_priv(const struct rte_event_vector_adapter *adapter)
+{
+	return adapter->data->adapter_priv;
+}
+
+static int
+sw_vector_adapter_flush(struct sw_vector_adapter_data *sw)
+{
+	struct rte_event ev;
+
+	if (sw->vector == NULL)
+		return -ENOBUFS;
+
+	ev.event = sw->event_meta;
+	ev.vec = sw->vector;
+	if (rte_event_enqueue_burst(sw->dev_id, sw->port_id, &ev, 1) != 1)
+		return -ENOSPC;
+
+	sw->vector = NULL;
+	sw->timestamp = 0;
+	return 0;
+}
+
+static int
+sw_vector_adapter_service_func(void *arg)
+{
+	struct sw_vector_adapter_service_data *service_data = arg;
+	struct sw_vector_adapter_data *sw, *nextsw;
+	rte_mcslock_t me, me_adptr;
+	int ret;
+
+	rte_mcslock_lock(&service_data->lock, &me);
+	RTE_TAILQ_FOREACH_SAFE(sw, &service_data->adapter_list, next, nextsw)
+	{
+		if (!rte_mcslock_trylock(&sw->lock, &me_adptr))
+			continue;
+		if (sw->vector == NULL) {
+			TAILQ_REMOVE(&service_data->adapter_list, sw, next);
+			rte_mcslock_unlock(&sw->lock, &me_adptr);
+			continue;
+		}
+		if (rte_get_timer_cycles() - sw->timestamp < sw->vector_tmo_ticks) {
+			rte_mcslock_unlock(&sw->lock, &me_adptr);
+			continue;
+		}
+		ret = sw_vector_adapter_flush(sw);
+		if (ret) {
+			rte_mcslock_unlock(&sw->lock, &me_adptr);
+			continue;
+		}
+		sw->stats.vectors_timedout++;
+		TAILQ_REMOVE(&service_data->adapter_list, sw, next);
+		rte_mcslock_unlock(&sw->lock, &me_adptr);
+	}
+	rte_mcslock_unlock(&service_data->lock, &me);
+
+	return 0;
+}
+
+static int
+sw_vector_adapter_service_init(struct sw_vector_adapter_data *sw)
+{
+#define SW_VECTOR_ADAPTER_SERVICE_FMT "sw_vector_adapter_service"
+	struct sw_vector_adapter_service_data *service_data;
+	struct rte_service_spec service;
+	const struct rte_memzone *mz;
+	int ret;
+
+	mz = rte_memzone_lookup(SW_VECTOR_ADAPTER_SERVICE_FMT);
+	if (mz == NULL) {
+		mz = rte_memzone_reserve(SW_VECTOR_ADAPTER_SERVICE_FMT,
+					 sizeof(struct sw_vector_adapter_service_data),
+					 sw->adapter->data->socket_id, 0);
+		if (mz == NULL) {
+			EVVEC_LOG_DBG("failed to reserve memzone for service");
+			return -ENOMEM;
+		}
+		service_data = (struct sw_vector_adapter_service_data *)mz->addr;
+
+		service.callback = sw_vector_adapter_service_func;
+		service.callback_userdata = service_data;
+		service.socket_id = sw->adapter->data->socket_id;
+
+		ret = rte_service_component_register(&service, &service_data->service_id);
+		if (ret < 0) {
+			EVVEC_LOG_ERR("failed to register service");
+			return -ENOTSUP;
+		}
+		TAILQ_INIT(&service_data->adapter_list);
+	}
+	service_data = (struct sw_vector_adapter_service_data *)mz->addr;
+
+	sw->service_data = service_data;
+	sw->adapter->data->unified_service_id = service_data->service_id;
+	return 0;
+}
+
+static int
+sw_vector_adapter_create(struct rte_event_vector_adapter *adapter)
+{
+#define NSEC2TICK(__ns, __freq) (((__ns) * (__freq)) / 1E9)
+#define SW_VECTOR_ADAPTER_NAME	64
+	char name[SW_VECTOR_ADAPTER_NAME];
+	struct sw_vector_adapter_data *sw;
+	struct rte_event ev;
+
+	snprintf(name, SW_VECTOR_ADAPTER_NAME, "sw_vector_%" PRIx32, adapter->data->id);
+	sw = rte_zmalloc_socket(name, sizeof(*sw), RTE_CACHE_LINE_SIZE, adapter->data->socket_id);
+	if (sw == NULL) {
+		EVVEC_LOG_ERR("failed to allocate space for private data");
+		rte_errno = ENOMEM;
+		return -1;
+	}
+
+	/* Connect storage to adapter instance */
+	adapter->data->adapter_priv = sw;
+	sw->adapter = adapter;
+	sw->dev_id = adapter->data->event_dev_id;
+	sw->port_id = adapter->data->event_port_id;
+
+	sw->vector_sz = adapter->data->conf.vector_sz;
+	sw->vector_mp = adapter->data->conf.vector_mp;
+	sw->vector_tmo_ticks = NSEC2TICK(adapter->data->conf.vector_timeout_ns, rte_get_timer_hz());
+
+	ev = adapter->data->conf.ev;
+	ev.op = RTE_EVENT_OP_NEW;
+	sw->event_meta = ev.event;
+
+	ev = adapter->data->conf.ev_fallback;
+	ev.op = RTE_EVENT_OP_NEW;
+	ev.priority = adapter->data->conf.ev.priority;
+	ev.queue_id = adapter->data->conf.ev.queue_id;
+	ev.sched_type = adapter->data->conf.ev.sched_type;
+	sw->fallback_event_meta = ev.event;
+
+	sw_vector_adapter_service_init(sw);
+
+	return 0;
+}
+
+static int
+sw_vector_adapter_destroy(struct rte_event_vector_adapter *adapter)
+{
+	struct sw_vector_adapter_data *sw = sw_vector_adapter_priv(adapter);
+
+	rte_free(sw);
+	adapter->data->adapter_priv = NULL;
+
+	return 0;
+}
+
+static int
+sw_vector_adapter_flush_single_event(struct sw_vector_adapter_data *sw, uintptr_t ptr)
+{
+	struct rte_event ev;
+
+	ev.event = sw->fallback_event_meta;
+	ev.u64 = ptr;
+	if (rte_event_enqueue_burst(sw->dev_id, sw->port_id, &ev, 1) != 1)
+		return -ENOSPC;
+
+	return 0;
+}
+
+static int
+sw_vector_adapter_enqueue(struct rte_event_vector_adapter *adapter, uintptr_t ptrs[],
+			  uint16_t num_elem, uint64_t flags)
+{
+	struct sw_vector_adapter_data *sw = sw_vector_adapter_priv(adapter);
+	uint16_t cnt = num_elem, n;
+	rte_mcslock_t me, me_s;
+	int ret;
+
+	rte_mcslock_lock(&sw->lock, &me);
+	if (flags & RTE_EVENT_VECTOR_ENQ_FLUSH) {
+		sw_vector_adapter_flush(sw);
+		sw->stats.vectors_flushed++;
+		rte_mcslock_unlock(&sw->lock, &me);
+		return 0;
+	}
+
+	if (num_elem == 0) {
+		rte_mcslock_unlock(&sw->lock, &me);
+		return 0;
+	}
+
+	if (flags & RTE_EVENT_VECTOR_ENQ_SOV) {
+		while (sw_vector_adapter_flush(sw) != 0)
+			;
+		sw->stats.vectors_flushed++;
+	}
+
+	while (num_elem) {
+		if (sw->vector == NULL) {
+			ret = rte_mempool_get(sw->vector_mp, (void **)&sw->vector);
+			if (ret) {
+				if (sw_vector_adapter_flush_single_event(sw, *ptrs) == 0) {
+					sw->stats.alloc_failures++;
+					num_elem--;
+					ptrs++;
+					continue;
+				}
+				rte_errno = -ENOSPC;
+				goto done;
+			}
+			sw->vector->nb_elem = 0;
+			sw->vector->attr_valid = 0;
+			sw->vector->elem_offset = 0;
+		}
+		n = RTE_MIN(sw->vector_sz - sw->vector->nb_elem, num_elem);
+		memcpy(&sw->vector->u64s[sw->vector->nb_elem], ptrs, n * sizeof(uintptr_t));
+		sw->vector->nb_elem += n;
+		num_elem -= n;
+		ptrs += n;
+
+		if (sw->vector_sz == sw->vector->nb_elem) {
+			ret = sw_vector_adapter_flush(sw);
+			if (ret)
+				goto done;
+			sw->stats.vectorized++;
+		}
+	}
+
+	if (flags & RTE_EVENT_VECTOR_ENQ_EOV) {
+		while (sw_vector_adapter_flush(sw) != 0)
+			;
+		sw->stats.vectors_flushed++;
+	}
+
+	if (sw->vector != NULL && sw->vector->nb_elem) {
+		sw->timestamp = rte_get_timer_cycles();
+		rte_mcslock_lock(&sw->service_data->lock, &me_s);
+		TAILQ_INSERT_TAIL(&sw->service_data->adapter_list, sw, next);
+		rte_mcslock_unlock(&sw->service_data->lock, &me_s);
+	}
+
+done:
+	rte_mcslock_unlock(&sw->lock, &me);
+	return cnt - num_elem;
+}
+
+static int
+sw_vector_adapter_stats_get(const struct rte_event_vector_adapter *adapter,
+			    struct rte_event_vector_adapter_stats *stats)
+{
+	struct sw_vector_adapter_data *sw = sw_vector_adapter_priv(adapter);
+
+	*stats = sw->stats;
+	return 0;
+}
+
+static int
+sw_vector_adapter_stats_reset(const struct rte_event_vector_adapter *adapter)
+{
+	struct sw_vector_adapter_data *sw = sw_vector_adapter_priv(adapter);
+
+	memset(&sw->stats, 0, sizeof(sw->stats));
+	return 0;
+}
+
+static const struct event_vector_adapter_ops sw_ops = {
+	.create = sw_vector_adapter_create,
+	.destroy = sw_vector_adapter_destroy,
+	.enqueue = sw_vector_adapter_enqueue,
+	.stats_get = sw_vector_adapter_stats_get,
+	.stats_reset = sw_vector_adapter_stats_reset,
+};
+
+static const struct rte_event_vector_adapter_info sw_info = {
+	.min_vector_sz = MIN_VECTOR_SIZE,
+	.max_vector_sz = MAX_VECTOR_SIZE,
+	.min_vector_timeout_ns = MIN_VECTOR_NS,
+	.max_vector_timeout_ns = MAX_VECTOR_NS,
+	.log2_sz = 0,
+};
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index 0be1c0ba31..e452a469d3 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -258,6 +258,8 @@ rte_event_vector_adapter_caps_get(uint8_t dev_id, uint32_t *caps)
 		return -EINVAL;
 
 	if (dev->dev_ops->vector_adapter_caps_get == NULL)
+		*caps = RTE_EVENT_VECTOR_ADAPTER_SW_CAP;
+	else
 		*caps = 0;
 
 	return dev->dev_ops->vector_adapter_caps_get ?
-- 
2.43.0

