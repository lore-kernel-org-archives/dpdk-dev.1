Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FADAC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 12:43:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2617B42D80;
	Wed,  4 Jun 2025 14:43:18 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 81ACB402D8
 for <dev@dpdk.org>; Wed,  4 Jun 2025 14:43:16 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553NW6fn019380
 for <dev@dpdk.org>; Wed, 4 Jun 2025 05:43:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
 3LXLZ2YIQKwMIK0zQLrT7QidukiO2UeJkR9JKbk0O8=; b=GN3b59nHrJMrMMWcV
 sa8PBWaGweaMbJHTzMsNYyjR4lb2PLtkvYy7BrH5e6h3cFMX0vWpOjmj2fBhaunW
 ScsOgV/q48zXuSlmXaYy5ZWf/LqXkQu5KgQOS5Er0GWccLdl9WIG1ZmQoFJkm5Uw
 +E/mckyMObAUtVqNttibz7DlOukanP5Apw7ar4nMJPMJNoWrVrIPMAvfct2TW3SL
 WVoJftfF9B6W/lUeS/9E+Dc+UXl3s3BNnaVvIU1BrGczL1nEhSR2vAnj5Xl+5jZ8
 HfmOyHN8ksyKnWRxXGTBeS3Qtbf7Lcylg6EAB2CfcOWtmunfrmL38dkWHbz+ZWhL
 LiOSQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 472at51dsu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 04 Jun 2025 05:43:15 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Jun 2025 05:43:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Jun 2025 05:43:14 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.164.240])
 by maili.marvell.com (Postfix) with ESMTP id 2C6443F7040;
 Wed,  4 Jun 2025 05:43:10 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, "Kiran
 Kumar K" <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>,
 "Pavan Nikhilesh" <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v3] event/cnxk: add event vector adapter support
Date: Wed, 4 Jun 2025 18:13:05 +0530
Message-ID: <20250604124305.80579-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250601204626.98998-1-pbhagavatula@marvell.com>
References: <20250601204626.98998-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WnUTdLced_REn7iUePm40dOhlZnuZWiu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA5NiBTYWx0ZWRfXy/eCnXWoVYkL
 zjpc2iEsA+x/MrHw186AKsVlLJhkYwXQ9jelVlGEfeM9X2fzFhiP/ethbbYjBkYiY/KNqWLVi8B
 q8pnpWRjaTqZrKpoRfG/3rHCG2Osd/QWyPKHqp4MjhwjmuOO2VuPyU33t9jTheFp+6g+MjHQja3
 7wpIzaWuRTqF1AjJHyRBQauQXXsX45hJxRLDIqN63bCd056Ij2Ll91S5yiWAmdoBsVMqrBFkxM2
 LT03goB8JCeLznVjPyQmonSM+6M4uYUJSTQ0HFsMGOFUfP6C5hth4bSdGKYm3dWI9rULC7lRpL5
 8AVJIB0ih+J2Sur+qnTlgEoHrt7pFrTt0qIKUqmaGWkcjqVjdCSNNeZuzR/07XvJeHrp13Es8RX
 fS5zBYGFG3fVG9/fG7uIBvcxH1/igi3xRiT0Iusea8hAGuwFIfbj+V5YO6OQS5FUhTCorL/E
X-Authority-Analysis: v=2.4 cv=F9dXdrhN c=1 sm=1 tr=0 ts=68403f63 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=sXgmuBsvd_0s3Wv3ioQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: WnUTdLced_REn7iUePm40dOhlZnuZWiu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
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

Add event vector adapter support to CN20K event device.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
v2 Changes:
 - Add depends on series tag.
 - Fix compilation.
v3 Changes:
 - Rebase.
 - Fix errors from check-meson.py

 drivers/common/cnxk/roc_sso.c          |   4 +-
 drivers/common/cnxk/roc_sso.h          |   2 +-
 drivers/event/cnxk/cn20k_eventdev.c    |   8 +-
 drivers/event/cnxk/cnxk_vector_adptr.c | 148 +++++++++++++++++++++++++
 drivers/event/cnxk/cnxk_vector_adptr.h |  22 ++++
 drivers/event/cnxk/meson.build         |   1 +
 6 files changed, 181 insertions(+), 4 deletions(-)
 create mode 100644 drivers/event/cnxk/cnxk_vector_adptr.c
 create mode 100644 drivers/event/cnxk/cnxk_vector_adptr.h

diff --git a/drivers/common/cnxk/roc_sso.c b/drivers/common/cnxk/roc_sso.c
index 4996329018fb..1d82e5b9782c 100644
--- a/drivers/common/cnxk/roc_sso.c
+++ b/drivers/common/cnxk/roc_sso.c
@@ -514,7 +514,8 @@ sso_agq_op_wait(struct roc_sso *roc_sso, uint16_t hwgrp)
 }

 int
-roc_sso_hwgrp_agq_alloc(struct roc_sso *roc_sso, uint16_t hwgrp, struct roc_sso_agq_data *data)
+roc_sso_hwgrp_agq_alloc(struct roc_sso *roc_sso, uint16_t hwgrp, struct roc_sso_agq_data *data,
+			uint32_t *agq_id)
 {
 	struct sso *sso = roc_sso_to_sso_priv(roc_sso);
 	struct sso_aggr_setconfig *req;
@@ -621,6 +622,7 @@ roc_sso_hwgrp_agq_alloc(struct roc_sso *roc_sso, uint16_t hwgrp, struct roc_sso_

 	plt_wmb();
 	sso->agg_used[hwgrp]++;
+	*agq_id = off;

 	return 0;
 }
diff --git a/drivers/common/cnxk/roc_sso.h b/drivers/common/cnxk/roc_sso.h
index f73128087a53..f1ad34bcc745 100644
--- a/drivers/common/cnxk/roc_sso.h
+++ b/drivers/common/cnxk/roc_sso.h
@@ -112,7 +112,7 @@ int __roc_api roc_sso_hwgrp_stash_config(struct roc_sso *roc_sso,
 void __roc_api roc_sso_hws_gwc_invalidate(struct roc_sso *roc_sso, uint8_t *hws,
 					  uint8_t nb_hws);
 int __roc_api roc_sso_hwgrp_agq_alloc(struct roc_sso *roc_sso, uint16_t hwgrp,
-				      struct roc_sso_agq_data *data);
+				      struct roc_sso_agq_data *data, uint32_t *agq_id);
 void __roc_api roc_sso_hwgrp_agq_free(struct roc_sso *roc_sso, uint16_t hwgrp, uint32_t agq_id);
 void __roc_api roc_sso_hwgrp_agq_release(struct roc_sso *roc_sso, uint16_t hwgrp);
 uint32_t __roc_api roc_sso_hwgrp_agq_from_tag(struct roc_sso *roc_sso, uint16_t hwgrp, uint32_t tag,
diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn20k_eventdev.c
index 0688cf97e5d6..9d68397b88a4 100644
--- a/drivers/event/cnxk/cn20k_eventdev.c
+++ b/drivers/event/cnxk/cn20k_eventdev.c
@@ -10,6 +10,7 @@
 #include "cn20k_worker.h"
 #include "cnxk_common.h"
 #include "cnxk_eventdev.h"
+#include "cnxk_vector_adptr.h"
 #include "cnxk_worker.h"

 #define CN20K_SET_EVDEV_DEQ_OP(dev, deq_op, deq_ops)                                               \
@@ -708,11 +709,11 @@ cn20k_sso_rx_adapter_vwqe_enable(struct cnxk_sso_evdev *dev, uint16_t port_id, u
 	data.vwqe_wait_tmo = queue_conf->vector_timeout_ns / ((SSO_AGGR_DEF_TMO + 1) * 100);
 	data.xqe_type = 0;

-	rc = roc_sso_hwgrp_agq_alloc(&dev->sso, queue_conf->ev.queue_id, &data);
+	agq = UINT32_MAX;
+	rc = roc_sso_hwgrp_agq_alloc(&dev->sso, queue_conf->ev.queue_id, &data, &agq);
 	if (rc < 0)
 		return rc;

-	agq = roc_sso_hwgrp_agq_from_tag(&dev->sso, queue_conf->ev.queue_id, tag_mask, 0);
 	return agq;
 }

@@ -1081,6 +1082,9 @@ static struct eventdev_ops cn20k_sso_dev_ops = {

 	.timer_adapter_caps_get = cn20k_tim_caps_get,

+	.vector_adapter_caps_get = cnxk_vector_caps_get,
+	.vector_adapter_info_get = cnxk_vector_info_get,
+
 	.xstats_get = cnxk_sso_xstats_get,
 	.xstats_reset = cnxk_sso_xstats_reset,
 	.xstats_get_names = cnxk_sso_xstats_get_names,
diff --git a/drivers/event/cnxk/cnxk_vector_adptr.c b/drivers/event/cnxk/cnxk_vector_adptr.c
new file mode 100644
index 000000000000..0495258cbb5c
--- /dev/null
+++ b/drivers/event/cnxk/cnxk_vector_adptr.c
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+#include <event_vector_adapter_pmd.h>
+#include <eventdev_pmd.h>
+
+#include "roc_api.h"
+
+#include "cnxk_eventdev.h"
+#include "cnxk_vector_adptr.h"
+#include "cnxk_worker.h"
+
+static int
+cnxk_sso_vector_adapter_create(struct rte_event_vector_adapter *adapter)
+{
+	struct rte_event_vector_adapter_conf *conf;
+	struct cnxk_event_vector_adapter *adptr;
+	uint32_t agq, tag_mask, stag_mask;
+	struct roc_sso_agq_data data;
+	struct cnxk_sso_evdev *dev;
+	uint8_t queue_id;
+	int rc;
+
+	adptr = rte_zmalloc("cnxk_event_vector_adapter", sizeof(struct cnxk_event_vector_adapter),
+			    RTE_CACHE_LINE_SIZE);
+	if (adptr == NULL) {
+		plt_err("Failed to allocate memory for vector adapter");
+		return -ENOMEM;
+	}
+
+	conf = &adapter->data->conf;
+
+	queue_id = adapter->data->conf.ev.queue_id;
+	dev = cnxk_sso_pmd_priv(&rte_eventdevs[conf->event_dev_id]);
+	adapter->data->adapter_priv = adptr;
+
+	tag_mask = conf->ev.event & 0xFFFFFFFF;
+	stag_mask = (conf->ev_fallback.event & 0xFFFFFFFF) >> 20;
+
+	memset(&data, 0, sizeof(struct roc_sso_agq_data));
+	data.tag = tag_mask;
+	data.tt = conf->ev.sched_type;
+	data.stag = stag_mask;
+	data.vwqe_aura = roc_npa_aura_handle_to_aura(conf->vector_mp->pool_id);
+	data.vwqe_max_sz_exp = rte_log2_u32(conf->vector_sz);
+	data.vwqe_wait_tmo = conf->vector_timeout_ns / ((SSO_AGGR_DEF_TMO + 1) * 100);
+	data.xqe_type = 0;
+
+	agq = UINT32_MAX;
+	rc = roc_sso_hwgrp_agq_alloc(&dev->sso, queue_id, &data, &agq);
+	if (rc < 0 || agq == UINT32_MAX) {
+		plt_err("Failed to allocate aggregation queue for queue_id=%d", queue_id);
+		adapter->data->adapter_priv = NULL;
+		rte_free(adptr);
+		return rc;
+	}
+
+	adptr->agq = agq;
+	adptr->tt = SSO_TT_AGG;
+	adptr->base = roc_sso_hwgrp_base_get(&dev->sso, queue_id);
+
+	return 0;
+}
+
+static int
+cnxk_sso_vector_adapter_destroy(struct rte_event_vector_adapter *adapter)
+{
+	struct cnxk_event_vector_adapter *adptr;
+	struct cnxk_sso_evdev *dev;
+	uint16_t queue_id;
+
+	if (adapter == NULL || adapter->data == NULL)
+		return -EINVAL;
+
+	adptr = adapter->data->adapter_priv;
+	if (adptr == NULL)
+		return -EINVAL;
+
+	queue_id = adapter->data->conf.ev.queue_id;
+	dev = cnxk_sso_pmd_priv(&rte_eventdevs[adapter->data->conf.event_dev_id]);
+
+	roc_sso_hwgrp_agq_free(&dev->sso, queue_id, adptr->agq);
+	rte_free(adptr);
+	adapter->data->adapter_priv = NULL;
+
+	return 0;
+}
+
+static int
+cnxk_sso_vector_adapter_enqueue(struct rte_event_vector_adapter *adapter, uint64_t objs[],
+				uint16_t num_elem, uint64_t flags)
+{
+	struct cnxk_event_vector_adapter *adptr;
+	uint16_t n = num_elem;
+	uint64_t add_work0;
+
+	adptr = adapter->data->adapter_priv;
+	plt_wmb();
+
+	add_work0 = adptr->agq | ((uint64_t)(adptr->tt) << 32);
+	roc_store_pair(add_work0 | ((uint64_t)!!(flags & RTE_EVENT_VECTOR_ENQ_SOV) << 34),
+		       objs[num_elem - n], adptr->base);
+	while (--n > 1)
+		roc_store_pair(add_work0, objs[num_elem - n], adptr->base);
+	if (n)
+		roc_store_pair(add_work0 | ((uint64_t)!!(flags & RTE_EVENT_VECTOR_ENQ_EOV) << 35),
+			       objs[num_elem - n], adptr->base);
+
+	return num_elem;
+}
+
+static struct event_vector_adapter_ops vector_ops = {
+	.create = cnxk_sso_vector_adapter_create,
+	.destroy = cnxk_sso_vector_adapter_destroy,
+	.enqueue = cnxk_sso_vector_adapter_enqueue,
+};
+
+int
+cnxk_vector_caps_get(const struct rte_eventdev *evdev, uint32_t *caps,
+		     const struct event_vector_adapter_ops **ops)
+{
+	RTE_SET_USED(evdev);
+
+	*caps = RTE_EVENT_VECTOR_ADAPTER_CAP_INTERNAL_PORT;
+	*ops = &vector_ops;
+
+	return 0;
+}
+
+int
+cnxk_vector_info_get(const struct rte_eventdev *evdev, struct rte_event_vector_adapter_info *info)
+{
+	RTE_SET_USED(evdev);
+	if (info == NULL)
+		return -EINVAL;
+
+	info->max_vector_adapters_per_event_queue =
+		SSO_AGGR_MAX_CTX > UINT8_MAX ? UINT8_MAX : SSO_AGGR_MAX_CTX;
+	info->log2_sz = true;
+	info->min_vector_sz = RTE_BIT32(ROC_NIX_VWQE_MIN_SIZE_LOG2);
+	info->max_vector_sz = RTE_BIT32(ROC_NIX_VWQE_MAX_SIZE_LOG2);
+	info->min_vector_timeout_ns = (SSO_AGGR_DEF_TMO + 1) * 100;
+	info->max_vector_timeout_ns = (BITMASK_ULL(11, 0) + 1) * info->min_vector_timeout_ns;
+
+	info->log2_sz = true;
+
+	return 0;
+}
diff --git a/drivers/event/cnxk/cnxk_vector_adptr.h b/drivers/event/cnxk/cnxk_vector_adptr.h
new file mode 100644
index 000000000000..f60b0f4edd89
--- /dev/null
+++ b/drivers/event/cnxk/cnxk_vector_adptr.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2025 Marvell.
+ */
+
+#ifndef __CNXK_VECTOR_ADPTR_H__
+#define __CNXK_VECTOR_ADPTR_H__
+
+#include <rte_event_vector_adapter.h>
+#include <rte_eventdev.h>
+
+struct cnxk_event_vector_adapter {
+	uint8_t tt;
+	uint32_t agq;  /**< Aggregation queue ID */
+	uint64_t base; /**< Base address of the adapter */
+};
+
+int cnxk_vector_caps_get(const struct rte_eventdev *evdev, uint32_t *caps,
+			 const struct event_vector_adapter_ops **ops);
+int cnxk_vector_info_get(const struct rte_eventdev *evdev,
+			 struct rte_event_vector_adapter_info *info);
+
+#endif /* __CNXK_VECTOR_ADPTR_H__ */
diff --git a/drivers/event/cnxk/meson.build b/drivers/event/cnxk/meson.build
index 9461ae33e443..677ebc9e2814 100644
--- a/drivers/event/cnxk/meson.build
+++ b/drivers/event/cnxk/meson.build
@@ -26,6 +26,7 @@ sources = files(
         'cnxk_eventdev_stats.c',
         'cnxk_tim_evdev.c',
         'cnxk_tim_worker.c',
+        'cnxk_vector_adptr.c',
 )

 disable_template = false
--
2.39.5 (Apple Git-154)

