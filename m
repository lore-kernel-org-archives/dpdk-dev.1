Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED70C4451C
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Jul 2026 09:18:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD3A04028E;
	Sat, 18 Jul 2026 11:18:15 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B821B4028B
 for <dev@dpdk.org>; Wed, 15 Jul 2026 10:45:54 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F7s4WA999567 for <dev@dpdk.org>; Wed, 15 Jul 2026 01:45:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=E3SygusUizsCkD4BdH73QEJ
 E1t5qmtwtkfyzb2opKx0=; b=DAaYX1qloALwfdFuTMjB8laxw/n8GLNOGwLK1ni
 TqZ5y0ONOmidLnhl+8ynKgfD8r51RD4R6fDKvLc8NDRPEoP0LBp7FnVGCpjKfHfD
 UN3ditnuH1HCpsspwo/TXdonTSy00dDPzG45TFzTuvfTq8g6H+2QHLd3PIZV/4dK
 KYXz5i/c/Fm0pMUpYD0nSaGz2UGtYhk6lkLhDB375agqdULcsTuA78en8suUIrkT
 WzsVoV05p1ZAhODcndh1cj0ZMvubPgXubn/jPOrTYm/mHaN91JIXTQwltLiYv0tP
 K+rwRgL/M/bueFNPfs3Ye3AdMn35hPGtvc2N2C0G0s+z77w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fdxve1eje-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 01:45:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 15 Jul 2026 01:45:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 15 Jul 2026 01:45:52 -0700
Received: from cavium-ThinkCentre-E73.. (unknown [10.28.34.33])
 by maili.marvell.com (Postfix) with ESMTP id 197E6626762;
 Wed, 15 Jul 2026 01:45:48 -0700 (PDT)
From: <ykanaujia@marvell.com>
To: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>
CC: <dev@dpdk.org>, Yashaswini Kanaujia <ykanaujia@marvell.com>
Subject: [PATCH 2/2] drivers: add support for async RTE FLOW APIs
Date: Wed, 15 Jul 2026 14:15:20 +0530
Message-ID: <20260715084545.301064-1-ykanaujia@marvell.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA4NCBTYWx0ZWRfX4a9s7+om9TFW
 jGzZXlrVZthkxZsQHhgXKDrE2tNV3hPxVccl+3aO+EMlOTdF89eKTJQHxoy5iJk0qaR7lE6YZI7
 tpO2Q8MD0DPzHxiey6Na7OHG8jtmtaGoHpa06vi2kuBuq/s+CWgHDwUY34POwcn7XPM02lZEp88
 D3nTl7LesJP5rcCCvTjALro0B8qzPvoqaJ0MYD8IdBw49u/fiNP/GwXeRk8HR/oH3v/z3PzPIXh
 4/B4HFPaBtiS1VyXT+WQW6zLuF5rc1pvmXz5CSQpPpB5jpYjNKBU3fneejokQpNDESKq+3Ri9T8
 kGFAAS8Kd1VorIOXY4VpUJRyweISnVtc4UMZhy5+n8n9xX2S2n0Pv9gsw1kZPQlzl7aojFRvb/L
 jmzxRBz4vWPNSxyE7rt/GojmvjSh24Ei1u3eNgczNbIfqtuxfPKqSjcmT79Yj0rI6yhMkDJaZSi
 NB7IljUN20gv6qK7f0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA4NCBTYWx0ZWRfX+uD2/Xl7ZQJp
 v1PvqH0WkmwUC0YIZimwBNhPdvq+lfGyVJYldzU8sX9BriHtxcdskam1KLSx8ITK1mRC0jhCvYz
 oF5Z8L42tzrKDz3ixfiFF9S05fLk1RU=
X-Proofpoint-GUID: BJawkKb6CMHu8i7Xh9QrrrxB2GrOp8KL
X-Proofpoint-ORIG-GUID: n1dTx-FWYTHOXLMRKUNZtIKI0iOemubI
X-Authority-Analysis: v=2.4 cv=dfCwG3Xe c=1 sm=1 tr=0 ts=6a5748c1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=_khRtAdMgpGYXxR-Bn4A:9 a=puLljgp0ygEqppnr:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Mailman-Approved-At: Sat, 18 Jul 2026 11:18:11 +0200
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

From: Yashaswini Kanaujia <ykanaujia@marvell.com>

added support for asynchronous rte_flow APIs
for cn10k device

Signed-off-by: Yashaswini Kanaujia <ykanaujia@marvell.com>
---
 drivers/common/cnxk/meson.build               |    1 +
 drivers/common/cnxk/roc_npc.h                 |   97 ++
 drivers/common/cnxk/roc_npc_flow_template.c   | 1326 ++++++++++++++++
 drivers/common/cnxk/roc_npc_mcam.c            |   45 +-
 drivers/common/cnxk/roc_npc_priv.h            |   98 ++
 drivers/common/cnxk/roc_npc_utils.c           |    4 +-
 .../common/cnxk/roc_platform_base_symbols.c   |   16 +
 drivers/net/cnxk/cn10k_ethdev.c               |   23 +
 drivers/net/cnxk/cn10k_flow.c                 |   43 +
 drivers/net/cnxk/cn10k_flow.h                 |    2 +
 drivers/net/cnxk/cn20k_ethdev.c               |   24 +-
 drivers/net/cnxk/cn20k_flow.c                 |   43 +
 drivers/net/cnxk/cn20k_flow.h                 |    2 +
 drivers/net/cnxk/cnxk_ethdev.h                |   44 +
 drivers/net/cnxk/cnxk_flow.c                  | 1338 ++++++++++++++++-
 drivers/net/cnxk/cnxk_flow.h                  |   77 +
 16 files changed, 3161 insertions(+), 22 deletions(-)
 create mode 100644 drivers/common/cnxk/roc_npc_flow_template.c

diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index 3303ad9354..68374ee135 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -59,6 +59,7 @@ sources = files(
         'roc_npa_type.c',
         'roc_npc.c',
         'roc_npc_aging.c',
+        'roc_npc_flow_template.c',
         'roc_npc_mcam.c',
         'roc_npc_mcam_dump.c',
         'roc_npc_parse.c',
diff --git a/drivers/common/cnxk/roc_npc.h b/drivers/common/cnxk/roc_npc.h
index a7254f35ca..21fa493c74 100644
--- a/drivers/common/cnxk/roc_npc.h
+++ b/drivers/common/cnxk/roc_npc.h
@@ -473,6 +473,9 @@ int __roc_api roc_npc_mcam_alloc_entries(struct roc_npc *roc_npc, int ref_entry,
 int __roc_api roc_npc_mcam_ena_dis_entry(struct roc_npc *roc_npc, struct roc_npc_flow *mcam,
 					 bool enable);
 int __roc_api roc_npc_mcam_write_entry(struct roc_npc *roc_npc, struct roc_npc_flow *mcam);
+
+void __roc_api roc_npc_mcam_write_rx_finalize(struct roc_npc *roc_npc, struct roc_npc_flow *flow);
+
 void __roc_api roc_npc_defrag_mcam_banks(struct roc_npc *roc_npc);
 uint8_t __roc_api roc_npc_get_key_type(struct roc_npc *roc_npc, struct roc_npc_flow *flow);
 uint8_t __roc_api roc_npc_kex_key_type_config_get(struct roc_npc *roc_npc);
@@ -508,4 +511,98 @@ void __roc_api roc_npc_sdp_channel_get(struct roc_npc *roc_npc, uint16_t *chan_b
 int __roc_api roc_npc_mcam_get_stats(struct roc_npc *roc_npc, struct roc_npc_flow *flow,
 				     uint64_t *count);
 int __roc_api roc_npc_skip_size_pkind_get(struct roc_npc *roc_npc);
+
+/*
+ * Queue-based (async) template flow API.
+ */
+enum roc_npc_template_table_insertion_type {
+	/* HW MCAM entry allocated per rule at create time (match based). */
+	ROC_NPC_TEMPLATE_INSERTION_PATTERN,
+	/* MCAM range reserved up front; rules placed at an app-chosen index. */
+	ROC_NPC_TEMPLATE_INSERTION_INDEX_WITH_PATTERN,
+};
+
+struct roc_npc_flow_queue_attr {
+	uint32_t size; /**< Number of in-flight async ops the queue can hold. */
+};
+
+struct roc_npc_pattern_template_attr {
+	uint32_t relaxed_matching : 1;
+	uint32_t ingress : 1;
+	uint32_t egress : 1;
+	uint32_t transfer : 1;
+	uint32_t reserved : 28;
+};
+
+struct roc_npc_actions_template_attr {
+	uint32_t ingress : 1;
+	uint32_t egress : 1;
+	uint32_t transfer : 1;
+	uint32_t reserved : 29;
+};
+
+struct roc_npc_template_table_attr {
+	struct roc_npc_attr flow_attr; /**< Priority / ingress / egress. */
+	uint32_t transfer : 1;	       /**< roc_npc_attr has no transfer bit. */
+	uint32_t reserved : 31;
+	enum roc_npc_template_table_insertion_type insertion_type;
+	uint32_t nb_flows; /**< Max rules the table can hold. */
+	void *cookie;	   /**< Opaque consumer context, retrievable per rule. */
+};
+
+/** Result of one completed async operation, returned by roc_npc_flow_pull. */
+struct roc_npc_flow_op_result {
+	void *user_data; /**< user_data passed at async_create/destroy time. */
+	int rc;		 /**< 0 on success, negative errno on failure. */
+};
+
+/* Opaque template/table/flow handles owned by the roc layer. */
+struct roc_npc_pattern_template;
+struct roc_npc_actions_template;
+struct roc_npc_template_table;
+struct roc_npc_template_flow;
+
+int __roc_api roc_npc_flow_configure(struct roc_npc *roc_npc, uint16_t nb_queues,
+				     const struct roc_npc_flow_queue_attr *queue_attr[]);
+
+struct roc_npc_pattern_template *__roc_api roc_npc_pattern_template_create(
+	struct roc_npc *roc_npc, const struct roc_npc_pattern_template_attr *attr,
+	const struct roc_npc_item_info pattern[], int *errcode);
+int __roc_api roc_npc_pattern_template_destroy(struct roc_npc *roc_npc,
+					       struct roc_npc_pattern_template *tmpl);
+
+struct roc_npc_actions_template *__roc_api roc_npc_actions_template_create(
+	struct roc_npc *roc_npc, const struct roc_npc_actions_template_attr *attr,
+	const struct roc_npc_action actions[], const struct roc_npc_action masks[], int *errcode);
+int __roc_api roc_npc_actions_template_destroy(struct roc_npc *roc_npc,
+					       struct roc_npc_actions_template *tmpl);
+
+struct roc_npc_template_table *__roc_api roc_npc_template_table_create(
+	struct roc_npc *roc_npc, const struct roc_npc_template_table_attr *attr,
+	struct roc_npc_pattern_template *pattern_templates[], uint8_t nb_pattern_templates,
+	struct roc_npc_actions_template *actions_templates[], uint8_t nb_actions_templates,
+	int *errcode);
+int __roc_api roc_npc_template_table_destroy(struct roc_npc *roc_npc,
+					     struct roc_npc_template_table *table);
+
+struct roc_npc_template_flow *__roc_api roc_npc_async_flow_create(
+	struct roc_npc *roc_npc, uint32_t queue_id, struct roc_npc_template_table *table,
+	const struct roc_npc_item_info pattern[], const struct roc_npc_action actions[],
+	uint16_t dst_pf_func, uint64_t npc_default_action, void *user_data, int *errcode);
+int __roc_api roc_npc_async_flow_destroy(struct roc_npc *roc_npc, uint32_t queue_id,
+					 struct roc_npc_template_flow *flow, void *user_data);
+struct roc_npc_template_flow *__roc_api roc_npc_async_flow_create_by_index_with_pattern(
+	struct roc_npc *roc_npc, uint32_t queue_id, struct roc_npc_template_table *table,
+	uint32_t rule_index, const struct roc_npc_item_info pattern[],
+	const struct roc_npc_action actions[], void *user_data, int *errcode);
+int __roc_api roc_npc_async_flow_actions_update(struct roc_npc *roc_npc, uint32_t queue_id,
+						struct roc_npc_template_flow *flow,
+						const struct roc_npc_action actions[],
+						void *user_data);
+int __roc_api roc_npc_flow_push(struct roc_npc *roc_npc, uint32_t queue_id);
+int __roc_api roc_npc_flow_pull(struct roc_npc *roc_npc, uint32_t queue_id,
+				struct roc_npc_flow_op_result res[], uint16_t n_res);
+bool __roc_api roc_npc_async_flow_resolve(struct roc_npc *roc_npc, void *handle,
+					  struct roc_npc_flow **flow);
+void *__roc_api roc_npc_async_flow_table_cookie(struct roc_npc_template_flow *flow);
 #endif /* _ROC_NPC_H_ */
diff --git a/drivers/common/cnxk/roc_npc_flow_template.c b/drivers/common/cnxk/roc_npc_flow_template.c
new file mode 100644
index 0000000000..5c10cfe39a
--- /dev/null
+++ b/drivers/common/cnxk/roc_npc_flow_template.c
@@ -0,0 +1,1326 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2024 Marvell.
+ */
+
+#include "roc_api.h"
+#include "roc_priv.h"
+
+/* Size of an action's conf for the supported set; -1 = nested/unsupported. */
+static int
+roc_npc_action_conf_size(enum roc_npc_action_type type)
+{
+	switch (type) {
+	case ROC_NPC_ACTION_TYPE_END:
+	case ROC_NPC_ACTION_TYPE_VOID:
+	case ROC_NPC_ACTION_TYPE_FLAG:
+	case ROC_NPC_ACTION_TYPE_DROP:
+	case ROC_NPC_ACTION_TYPE_COUNT:
+	case ROC_NPC_ACTION_TYPE_PF:
+	case ROC_NPC_ACTION_TYPE_VLAN_STRIP:
+		return 0; /* no conf */
+	case ROC_NPC_ACTION_TYPE_MARK:
+		return sizeof(struct roc_npc_action_mark);
+	case ROC_NPC_ACTION_TYPE_VF:
+		return sizeof(struct roc_npc_action_vf);
+	case ROC_NPC_ACTION_TYPE_PORT_ID:
+		return sizeof(struct roc_npc_action_port_id);
+	case ROC_NPC_ACTION_TYPE_QUEUE:
+		return sizeof(struct roc_npc_action_queue);
+	case ROC_NPC_ACTION_TYPE_VLAN_INSERT:
+		return sizeof(struct roc_npc_action_of_set_vlan_vid);
+	case ROC_NPC_ACTION_TYPE_VLAN_ETHTYPE_INSERT:
+		return sizeof(struct roc_npc_action_of_push_vlan);
+	case ROC_NPC_ACTION_TYPE_VLAN_PCP_INSERT:
+		return sizeof(struct roc_npc_action_of_set_vlan_pcp);
+	case ROC_NPC_ACTION_TYPE_AGE:
+		return sizeof(struct roc_npc_action_age);
+	default:
+		return -1; /* RSS handled separately; others unsupported */
+	}
+}
+
+/* Deep-copy an item spec/last/mask payload; *dst = NULL when nothing to copy. */
+static int
+roc_npc_dup_item_field(const void *src, uint32_t sz, const void **dst)
+{
+	void *copy;
+
+	*dst = NULL;
+	if (src == NULL || sz == 0)
+		return 0;
+	copy = plt_zmalloc(sz, 0);
+	if (copy == NULL)
+		return -ENOMEM;
+	memcpy(copy, src, sz);
+	*dst = copy;
+	return 0;
+}
+
+/* Deep-copy an action conf; RSS packs queue[]/key[] into one blob. */
+static void *
+roc_npc_dup_action_conf(const struct roc_npc_action *act)
+{
+	if (act->conf == NULL)
+		return NULL;
+
+	if (act->type == ROC_NPC_ACTION_TYPE_RSS) {
+		const struct roc_npc_action_rss *rss = act->conf;
+		size_t rss_queue_bytes = (size_t)rss->queue_num * sizeof(uint16_t);
+		size_t rss_key_bytes = rss->key_len;
+		size_t rss_blob_bytes = sizeof(*rss);
+		struct roc_npc_action_rss *rss_copy;
+		uint8_t *rss_blob;
+
+		if ((rss_queue_bytes && rss->queue == NULL) || (rss_key_bytes && rss->key == NULL))
+			return NULL;
+
+		rss_blob = plt_zmalloc(rss_blob_bytes + rss_queue_bytes + rss_key_bytes, 0);
+		if (rss_blob == NULL)
+			return NULL;
+		rss_copy = (struct roc_npc_action_rss *)rss_blob;
+		*rss_copy = *rss;
+		if (rss_queue_bytes) {
+			memcpy(rss_blob + rss_blob_bytes, rss->queue, rss_queue_bytes);
+			rss_copy->queue = (const uint16_t *)(rss_blob + rss_blob_bytes);
+		} else {
+			rss_copy->queue = NULL;
+		}
+		if (rss_key_bytes) {
+			memcpy(rss_blob + rss_blob_bytes + rss_queue_bytes, rss->key,
+			       rss_key_bytes);
+			rss_copy->key =
+				(const uint8_t *)(rss_blob + rss_blob_bytes + rss_queue_bytes);
+		} else {
+			rss_copy->key = NULL;
+		}
+		return rss_copy;
+	}
+
+	{
+		int conf_size = roc_npc_action_conf_size(act->type);
+		void *copy;
+
+		if (conf_size <= 0)
+			return NULL;
+		copy = plt_zmalloc(conf_size, 0);
+		if (copy != NULL)
+			memcpy(copy, act->conf, conf_size);
+		return copy;
+	}
+}
+
+/* Free the deep-copied items/actions arrays retained for a rule. */
+static void
+roc_npc_template_flow_free_rule(struct roc_npc_template_flow *flow)
+{
+	uint16_t k;
+
+	if (flow->items != NULL) {
+		for (k = 0; k < flow->nb_items; k++) {
+			plt_free((void *)(uintptr_t)flow->items[k].spec);
+			plt_free((void *)(uintptr_t)flow->items[k].last);
+			plt_free((void *)(uintptr_t)flow->items[k].mask);
+		}
+
+		plt_free(flow->items);
+		flow->items = NULL;
+	}
+	if (flow->actions != NULL) {
+		for (k = 0; k < flow->nb_actions; k++)
+			plt_free((void *)(uintptr_t)flow->actions[k].conf);
+
+		plt_free(flow->actions);
+		flow->actions = NULL;
+	}
+}
+
+int
+roc_npc_flow_configure(struct roc_npc *roc_npc, uint16_t nb_queues,
+		       const struct roc_npc_flow_queue_attr *queue_attr[])
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct roc_npc_flow_queue *queues;
+	int rc = -ENOMEM;
+	uint16_t i;
+
+	if (nb_queues == 0)
+		return 0;
+
+	if (queue_attr == NULL)
+		return -EINVAL;
+
+	if (npc->flow_queues != NULL) {
+		/* Don't tear down live queues while async ops are in flight. */
+		for (i = 0; i < npc->nb_flow_queues; i++) {
+			if (npc->flow_queues[i].head != npc->flow_queues[i].tail)
+				return -EBUSY;
+		}
+	}
+
+	if (npc->flow_queues != NULL) {
+		for (i = 0; i < npc->nb_flow_queues; i++)
+			plt_free(npc->flow_queues[i].ops);
+
+		plt_free(npc->flow_queues);
+		npc->flow_queues = NULL;
+		npc->nb_flow_queues = 0;
+	}
+
+	queues = plt_zmalloc(nb_queues * sizeof(struct roc_npc_flow_queue), 0);
+	if (queues == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < nb_queues; i++) {
+		if (queue_attr[i] == NULL || queue_attr[i]->size == 0) {
+			rc = -EINVAL;
+			goto err_free;
+		}
+		queues[i].size = plt_align32pow2(queue_attr[i]->size);
+		queues[i].ops = plt_zmalloc(queues[i].size * sizeof(struct roc_npc_async_op), 0);
+		if (queues[i].ops == NULL) {
+			rc = -ENOMEM;
+			goto err_free;
+		}
+		queues[i].head = 0;
+		queues[i].pushed = 0;
+		queues[i].tail = 0;
+	}
+
+	npc->flow_queues = queues;
+	npc->nb_flow_queues = nb_queues;
+	return 0;
+
+err_free:
+	for (i = 0; i < nb_queues; i++)
+		plt_free(queues[i].ops);
+
+	plt_free(queues);
+	return rc;
+}
+
+struct roc_npc_pattern_template *
+roc_npc_pattern_template_create(struct roc_npc *roc_npc,
+				const struct roc_npc_pattern_template_attr *attr,
+				const struct roc_npc_item_info pattern[], int *errcode)
+{
+	struct roc_npc_pattern_template *tmpl = NULL;
+	int i, nb_items = 0, rc = -ENOMEM;
+	uint16_t j;
+
+	PLT_SET_USED(roc_npc);
+
+	if (attr == NULL || pattern == NULL) {
+		*errcode = -EINVAL;
+		return NULL;
+	}
+
+	while (pattern[nb_items].type != ROC_NPC_ITEM_TYPE_END)
+		nb_items++;
+
+	/* Bound template size to the fixed-size rule arrays. */
+	if (nb_items > ROC_NPC_ITEM_TYPE_END) {
+		*errcode = -ENOTSUP;
+		return NULL;
+	}
+
+	tmpl = plt_zmalloc(sizeof(*tmpl), 0);
+	if (tmpl == NULL)
+		goto err;
+
+	tmpl->attr = *attr;
+	tmpl->nb_items = nb_items;
+
+	tmpl->pattern = plt_zmalloc((nb_items + 1) * sizeof(struct roc_npc_item_info), 0);
+	if (tmpl->pattern == NULL)
+		goto err;
+
+	/* Reserve up to 3 payload copies per item. */
+	tmpl->copies = plt_zmalloc(3 * (nb_items + 1) * sizeof(void *), 0);
+	if (tmpl->copies == NULL)
+		goto err;
+
+	for (i = 0; i < nb_items; i++) {
+		enum roc_npc_item_type t = pattern[i].type;
+		uint32_t sz = pattern[i].size;
+
+		/* RAW is not flat-copyable. */
+		if (t == ROC_NPC_ITEM_TYPE_RAW) {
+			rc = -ENOTSUP;
+			goto err;
+		}
+
+		tmpl->pattern[i].type = t;
+		tmpl->pattern[i].size = sz;
+		/* Track each copy for the error path. */
+		if (roc_npc_dup_item_field(pattern[i].spec, sz, &tmpl->pattern[i].spec))
+			goto err;
+		if (tmpl->pattern[i].spec != NULL)
+			tmpl->copies[tmpl->nb_copies++] = (void *)(uintptr_t)tmpl->pattern[i].spec;
+		if (roc_npc_dup_item_field(pattern[i].last, sz, &tmpl->pattern[i].last))
+			goto err;
+		if (tmpl->pattern[i].last != NULL)
+			tmpl->copies[tmpl->nb_copies++] = (void *)(uintptr_t)tmpl->pattern[i].last;
+		if (roc_npc_dup_item_field(pattern[i].mask, sz, &tmpl->pattern[i].mask))
+			goto err;
+		if (tmpl->pattern[i].mask != NULL)
+			tmpl->copies[tmpl->nb_copies++] = (void *)(uintptr_t)tmpl->pattern[i].mask;
+	}
+	tmpl->pattern[nb_items].type = ROC_NPC_ITEM_TYPE_END;
+	tmpl->refcnt = 0;
+
+	return tmpl;
+
+err:
+	if (tmpl != NULL) {
+		for (j = 0; j < tmpl->nb_copies; j++)
+			plt_free(tmpl->copies[j]);
+		plt_free(tmpl->copies);
+		plt_free(tmpl->pattern);
+		plt_free(tmpl);
+	}
+	*errcode = rc;
+	return NULL;
+}
+
+int
+roc_npc_pattern_template_destroy(struct roc_npc *roc_npc, struct roc_npc_pattern_template *tmpl)
+{
+	uint16_t i;
+
+	PLT_SET_USED(roc_npc);
+
+	if (tmpl == NULL)
+		return 0;
+
+	if (tmpl->refcnt != 0)
+		return -EBUSY;
+
+	for (i = 0; i < tmpl->nb_copies; i++)
+		plt_free(tmpl->copies[i]);
+
+	plt_free(tmpl->copies);
+	plt_free(tmpl->pattern);
+	plt_free(tmpl);
+	return 0;
+}
+
+struct roc_npc_actions_template *
+roc_npc_actions_template_create(struct roc_npc *roc_npc,
+				const struct roc_npc_actions_template_attr *attr,
+				const struct roc_npc_action actions[],
+				const struct roc_npc_action masks[], int *errcode)
+{
+	struct roc_npc_actions_template *tmpl = NULL;
+	int i, nb_actions = 0, rc = -ENOMEM;
+	uint16_t j;
+
+	PLT_SET_USED(roc_npc);
+
+	if (attr == NULL || actions == NULL) {
+		*errcode = -EINVAL;
+		return NULL;
+	}
+
+	while (actions[nb_actions].type != ROC_NPC_ACTION_TYPE_END)
+		nb_actions++;
+
+	/* Bound template size to the fixed-size rule arrays. */
+	if (nb_actions > ROC_NPC_MAX_ACTION_COUNT - 1) {
+		*errcode = -ENOTSUP;
+		return NULL;
+	}
+
+	tmpl = plt_zmalloc(sizeof(*tmpl), 0);
+	if (tmpl == NULL)
+		goto err;
+
+	tmpl->attr = *attr;
+	tmpl->nb_actions = nb_actions;
+
+	tmpl->actions = plt_zmalloc((nb_actions + 1) * sizeof(struct roc_npc_action), 0);
+	if (tmpl->actions == NULL)
+		goto err;
+
+	tmpl->masks = plt_zmalloc((nb_actions + 1) * sizeof(struct roc_npc_action), 0);
+	if (tmpl->masks == NULL)
+		goto err;
+
+	/* Reserve up to 2 conf copies per action. */
+	tmpl->copies = plt_zmalloc(2 * (nb_actions + 1) * sizeof(void *), 0);
+	if (tmpl->copies == NULL)
+		goto err;
+
+	for (i = 0; i < nb_actions; i++) {
+		enum roc_npc_action_type t = actions[i].type;
+		int sz = roc_npc_action_conf_size(t);
+
+		if (sz < 0 && t != ROC_NPC_ACTION_TYPE_RSS) {
+			rc = -ENOTSUP;
+			goto err;
+		}
+
+		tmpl->actions[i].type = t;
+		tmpl->actions[i].rss_repte_pf_func = actions[i].rss_repte_pf_func;
+
+		/* A malformed RSS conf is invalid input, not an allocation failure. */
+		if (t == ROC_NPC_ACTION_TYPE_RSS && actions[i].conf != NULL) {
+			const struct roc_npc_action_rss *rss = actions[i].conf;
+
+			if ((rss->queue_num && rss->queue == NULL) ||
+			    (rss->key_len && rss->key == NULL)) {
+				rc = -EINVAL;
+				goto err;
+			}
+		}
+
+		tmpl->actions[i].conf = roc_npc_dup_action_conf(&actions[i]);
+		if (tmpl->actions[i].conf == NULL && actions[i].conf != NULL &&
+		    (sz > 0 || t == ROC_NPC_ACTION_TYPE_RSS))
+			goto err;
+		if (tmpl->actions[i].conf != NULL)
+			tmpl->copies[tmpl->nb_copies++] = (void *)(uintptr_t)tmpl->actions[i].conf;
+
+		if (masks != NULL) {
+			if (masks[i].type != t) {
+				rc = -EINVAL;
+				goto err;
+			}
+			tmpl->masks[i].type = t;
+			/* RSS masks cannot carry a nested pointer. */
+			if (t == ROC_NPC_ACTION_TYPE_RSS) {
+				if (masks[i].conf != NULL) {
+					rc = -ENOTSUP;
+					goto err;
+				}
+				tmpl->masks[i].conf = NULL;
+			} else {
+				tmpl->masks[i].conf = roc_npc_dup_action_conf(&masks[i]);
+				if (tmpl->masks[i].conf == NULL && masks[i].conf != NULL && sz > 0)
+					goto err;
+				if (tmpl->masks[i].conf != NULL)
+					tmpl->copies[tmpl->nb_copies++] =
+						(void *)(uintptr_t)tmpl->masks[i].conf;
+			}
+		}
+	}
+
+	tmpl->actions[nb_actions].type = ROC_NPC_ACTION_TYPE_END;
+	tmpl->masks[nb_actions].type = ROC_NPC_ACTION_TYPE_END;
+	tmpl->refcnt = 0;
+
+	return tmpl;
+
+err:
+	if (tmpl != NULL) {
+		for (j = 0; j < tmpl->nb_copies; j++)
+			plt_free(tmpl->copies[j]);
+		plt_free(tmpl->copies);
+		plt_free(tmpl->masks);
+		plt_free(tmpl->actions);
+		plt_free(tmpl);
+	}
+	*errcode = rc;
+	return NULL;
+}
+
+int
+roc_npc_actions_template_destroy(struct roc_npc *roc_npc, struct roc_npc_actions_template *tmpl)
+{
+	uint16_t i;
+
+	PLT_SET_USED(roc_npc);
+
+	if (tmpl == NULL)
+		return 0;
+
+	if (tmpl->refcnt != 0)
+		return -EBUSY;
+
+	for (i = 0; i < tmpl->nb_copies; i++)
+		plt_free(tmpl->copies[i]);
+
+	plt_free(tmpl->copies);
+	plt_free(tmpl->masks);
+	plt_free(tmpl->actions);
+	plt_free(tmpl);
+	return 0;
+}
+
+struct roc_npc_template_table *
+roc_npc_template_table_create(struct roc_npc *roc_npc,
+			      const struct roc_npc_template_table_attr *attr,
+			      struct roc_npc_pattern_template *pattern_templates[],
+			      uint8_t nb_pattern_templates,
+			      struct roc_npc_actions_template *actions_templates[],
+			      uint8_t nb_actions_templates, int *errcode)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct roc_npc_template_table *table;
+	uint32_t nb_flows;
+	uint8_t i;
+
+	if (attr == NULL) {
+		*errcode = -EINVAL;
+		return NULL;
+	}
+
+	nb_flows = attr->nb_flows;
+
+	table = plt_zmalloc(sizeof(*table), 0);
+	if (table == NULL)
+		goto enomem;
+
+	table->insertion_type = attr->insertion_type;
+	table->nb_flows = nb_flows;
+	table->nb_live = 0;
+	table->cookie = attr->cookie;
+	plt_spinlock_init(&table->lock);
+
+	table->flow_attr = attr->flow_attr;
+	table->transfer = attr->transfer;
+
+	if (attr->insertion_type == ROC_NPC_TEMPLATE_INSERTION_INDEX_WITH_PATTERN) {
+		int resp_count = 0;
+		uint32_t j;
+		int rc;
+
+		table->mcam_ids = plt_zmalloc(nb_flows * sizeof(int), 0);
+		if (table->mcam_ids == NULL)
+			goto free_index;
+		for (j = 0; j < nb_flows; j++)
+			table->mcam_ids[j] = -1;
+
+		table->flow_pool = plt_zmalloc(nb_flows * sizeof(struct roc_npc_template_flow), 0);
+		if (table->flow_pool == NULL)
+			goto free_index;
+
+		rc = roc_npc_mcam_alloc_entries(roc_npc, 0, table->mcam_ids, nb_flows,
+						NPC_MCAM_ANY_PRIO, &resp_count, false);
+		if (rc != 0 || resp_count < (int)nb_flows) {
+			for (j = 0; j < (uint32_t)resp_count; j++) {
+				if (table->mcam_ids[j] != -1)
+					roc_npc_mcam_free_entry(roc_npc, table->mcam_ids[j]);
+			}
+
+			*errcode = -ENOSPC;
+			goto free_index;
+		}
+
+		for (j = 0; j < nb_flows; j++) {
+			table->flow_pool[j].table = table;
+			table->flow_pool[j].nb_items = 0;
+			table->flow_pool[j].nb_actions = 0;
+		}
+	}
+	/* PATTERN: nothing reserved; each push allocates at the right priority. */
+
+	if (nb_pattern_templates != 0) {
+		table->pattern_templates =
+			plt_zmalloc(nb_pattern_templates * sizeof(*table->pattern_templates), 0);
+		if (table->pattern_templates == NULL)
+			goto free_table;
+	}
+	if (nb_actions_templates != 0) {
+		table->actions_templates =
+			plt_zmalloc(nb_actions_templates * sizeof(*table->actions_templates), 0);
+		if (table->actions_templates == NULL)
+			goto free_table;
+	}
+
+	for (i = 0; i < nb_pattern_templates; i++) {
+		table->pattern_templates[i] = pattern_templates[i];
+		table->pattern_templates[i]->refcnt++;
+	}
+	table->nb_pattern_templates = nb_pattern_templates;
+	for (i = 0; i < nb_actions_templates; i++) {
+		table->actions_templates[i] = actions_templates[i];
+		table->actions_templates[i]->refcnt++;
+	}
+	table->nb_actions_templates = nb_actions_templates;
+
+	/* Track the table on the port so a flush can reconcile it. */
+	TAILQ_INIT(&table->live_flows);
+	table->next = npc->flow_tables;
+	npc->flow_tables = table;
+
+	return table;
+
+free_index:
+	plt_free(table->mcam_ids);
+	plt_free(table->flow_pool);
+	table->mcam_ids = NULL;
+	table->flow_pool = NULL;
+	plt_free(table->pattern_templates);
+	plt_free(table->actions_templates);
+	plt_free(table);
+	if (*errcode == 0)
+		*errcode = -ENOMEM;
+	return NULL;
+
+free_table:
+	if (attr->insertion_type == ROC_NPC_TEMPLATE_INSERTION_INDEX_WITH_PATTERN) {
+		uint32_t j;
+
+		if (table->mcam_ids != NULL) {
+			for (j = 0; j < nb_flows; j++) {
+				if (table->mcam_ids[j] != -1)
+					roc_npc_mcam_free_entry(roc_npc, table->mcam_ids[j]);
+			}
+
+			plt_free(table->mcam_ids);
+		}
+		plt_free(table->flow_pool);
+	}
+	plt_free(table->pattern_templates);
+	plt_free(table->actions_templates);
+	plt_free(table);
+
+enomem:
+	*errcode = -ENOMEM;
+	return NULL;
+}
+
+int
+roc_npc_template_table_destroy(struct roc_npc *roc_npc, struct roc_npc_template_table *table)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct roc_npc_template_table **pp;
+	uint8_t i;
+
+	if (table == NULL)
+		return 0;
+
+	if (table->insertion_type == ROC_NPC_TEMPLATE_INSERTION_PATTERN) {
+		if (table->nb_live != 0)
+			return -EBUSY;
+	} else {
+		uint32_t j;
+
+		/* A live (enabled) index rule still owns its MCAM entry. */
+		if (!table->hw_released && table->flow_pool != NULL) {
+			for (j = 0; j < table->nb_flows; j++) {
+				if (table->flow_pool[j].flow.enable != 0)
+					return -EBUSY;
+			}
+		}
+
+		if (table->mcam_ids != NULL) {
+			/* Skip if a flush already freed the entries. */
+			if (!table->hw_released) {
+				for (j = 0; j < table->nb_flows; j++) {
+					int mcam_id = table->mcam_ids[j];
+
+					if (mcam_id != -1)
+						roc_npc_mcam_free_entry(roc_npc, mcam_id);
+				}
+			}
+			plt_free(table->mcam_ids);
+		}
+		plt_free(table->flow_pool);
+	}
+
+	for (i = 0; i < table->nb_pattern_templates; i++)
+		table->pattern_templates[i]->refcnt--;
+
+	for (i = 0; i < table->nb_actions_templates; i++)
+		table->actions_templates[i]->refcnt--;
+
+	/* Unlink from the port's table list. */
+	pp = &npc->flow_tables;
+	while (*pp != NULL) {
+		if (*pp == table) {
+			*pp = table->next;
+			break;
+		}
+		pp = &(*pp)->next;
+	}
+
+	plt_free(table->pattern_templates);
+	plt_free(table->actions_templates);
+	plt_free(table);
+	return 0;
+}
+
+struct roc_npc_template_flow *
+roc_npc_async_flow_create(struct roc_npc *roc_npc, uint32_t queue_id,
+			  struct roc_npc_template_table *table,
+			  const struct roc_npc_item_info pattern[],
+			  const struct roc_npc_action actions[], uint16_t dst_pf_func,
+			  uint64_t npc_default_action, void *user_data, int *errcode)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct roc_npc_template_flow *flow = NULL;
+	int nb_items = 0, nb_actions = 0;
+	struct roc_npc_flow_queue *q;
+	struct roc_npc_async_op *op;
+	int k;
+
+	if (table == NULL || pattern == NULL || actions == NULL || npc->flow_queues == NULL ||
+	    queue_id >= npc->nb_flow_queues) {
+		*errcode = -EINVAL;
+		return NULL;
+	}
+	if (table->insertion_type != ROC_NPC_TEMPLATE_INSERTION_PATTERN) {
+		*errcode = -EINVAL;
+		return NULL;
+	}
+
+	while (pattern[nb_items].type != ROC_NPC_ITEM_TYPE_END)
+		nb_items++;
+	while (actions[nb_actions].type != ROC_NPC_ACTION_TYPE_END)
+		nb_actions++;
+	if (nb_items > ROC_NPC_ITEM_TYPE_END || nb_actions > ROC_NPC_MAX_ACTION_COUNT - 1) {
+		*errcode = -ENOTSUP;
+		return NULL;
+	}
+
+	q = &npc->flow_queues[queue_id];
+	if (q->head - q->tail >= q->size) {
+		*errcode = -ENOSPC;
+		return NULL;
+	}
+
+	flow = plt_zmalloc(sizeof(*flow), 0);
+	if (flow == NULL) {
+		*errcode = -ENOMEM;
+		return NULL;
+	}
+	flow->table = table;
+	flow->nb_items = nb_items;
+	flow->nb_actions = nb_actions;
+	flow->items = plt_zmalloc((nb_items + 1) * sizeof(struct roc_npc_item_info), 0);
+	if (flow->items == NULL) {
+		*errcode = -ENOMEM;
+		goto err;
+	}
+
+	flow->actions = plt_zmalloc((nb_actions + 1) * sizeof(struct roc_npc_action), 0);
+	if (flow->actions == NULL) {
+		*errcode = -ENOMEM;
+		goto err;
+	}
+
+	/* Deep-copy each item so push() owns a self-contained rule. */
+	for (k = 0; k < nb_items; k++) {
+		uint32_t sz = pattern[k].size;
+
+		flow->items[k].type = pattern[k].type;
+		flow->items[k].size = sz;
+		if (roc_npc_dup_item_field(pattern[k].spec, sz, &flow->items[k].spec) ||
+		    roc_npc_dup_item_field(pattern[k].last, sz, &flow->items[k].last) ||
+		    roc_npc_dup_item_field(pattern[k].mask, sz, &flow->items[k].mask)) {
+			*errcode = -ENOMEM;
+			goto err;
+		}
+	}
+	flow->items[nb_items].type = ROC_NPC_ITEM_TYPE_END;
+
+	/* Deep-copy each action conf. */
+	for (k = 0; k < nb_actions; k++) {
+		int sz = roc_npc_action_conf_size(actions[k].type);
+
+		flow->actions[k].type = actions[k].type;
+		flow->actions[k].rss_repte_pf_func = actions[k].rss_repte_pf_func;
+
+		/* A malformed RSS conf (non-zero length with a NULL nested
+		 * pointer) is invalid input, not an allocation failure.
+		 */
+		if (actions[k].type == ROC_NPC_ACTION_TYPE_RSS && actions[k].conf != NULL) {
+			const struct roc_npc_action_rss *rss = actions[k].conf;
+
+			if ((rss->queue_num && rss->queue == NULL) ||
+			    (rss->key_len && rss->key == NULL)) {
+				*errcode = -EINVAL;
+				goto err;
+			}
+		}
+
+		flow->actions[k].conf = roc_npc_dup_action_conf(&actions[k]);
+		/* A NULL copy from a non-NULL conf now means the deep copy failed. */
+		if (flow->actions[k].conf == NULL && actions[k].conf != NULL &&
+		    (sz > 0 || actions[k].type == ROC_NPC_ACTION_TYPE_RSS)) {
+			*errcode = -ENOMEM;
+			goto err;
+		}
+	}
+	flow->actions[nb_actions].type = ROC_NPC_ACTION_TYPE_END;
+
+	/* Capture the rule attributes used by push() to program hardware. */
+	flow->attr = table->flow_attr;
+	if (table->transfer)
+		flow->attr.ingress = 1;
+	flow->dst_pf_func = dst_pf_func;
+	flow->npc_default_action = npc_default_action;
+	/* Capture the caller's RSS flow key so batched rules keep their own. */
+	flow->flowkey_cfg = roc_npc->flowkey_cfg_state;
+
+	op = &q->ops[q->head & (q->size - 1)];
+	op->flow = flow;
+	op->is_create = true;
+	op->is_update = false;
+	op->user_data = user_data;
+	op->done = false;
+	op->rc = 0;
+	q->head++;
+
+	return flow;
+
+err:
+	roc_npc_template_flow_free_rule(flow);
+	plt_free(flow);
+	return NULL;
+}
+
+int
+roc_npc_async_flow_destroy(struct roc_npc *roc_npc, uint32_t queue_id,
+			   struct roc_npc_template_flow *flow, void *user_data)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct roc_npc_flow_queue *q;
+	struct roc_npc_async_op *op;
+
+	if (flow == NULL || npc->flow_queues == NULL || queue_id >= npc->nb_flow_queues)
+		return -EINVAL;
+
+	q = &npc->flow_queues[queue_id];
+	if (q->head - q->tail >= q->size)
+		return -ENOSPC;
+
+	op = &q->ops[q->head & (q->size - 1)];
+	op->flow = flow;
+	op->is_create = false;
+	op->is_update = false;
+	op->user_data = user_data;
+	op->done = false;
+	op->rc = 0;
+	q->head++;
+
+	return 0;
+}
+
+/* Create a rule at an app-chosen index in an INDEX_WITH_PATTERN table. */
+struct roc_npc_template_flow *
+roc_npc_async_flow_create_by_index_with_pattern(struct roc_npc *roc_npc, uint32_t queue_id,
+						struct roc_npc_template_table *table,
+						uint32_t rule_index,
+						const struct roc_npc_item_info pattern[],
+						const struct roc_npc_action actions[],
+						void *user_data, int *errcode)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct roc_npc_template_flow *flow;
+	uint32_t mark_save, vtag_save;
+	struct roc_npc_flow_queue *q;
+	struct roc_npc_async_op *op;
+	struct roc_npc_attr attr;
+	int rc;
+
+	if (table == NULL || pattern == NULL || actions == NULL || npc->flow_queues == NULL ||
+	    queue_id >= npc->nb_flow_queues) {
+		*errcode = -EINVAL;
+		return NULL;
+	}
+	if (table->insertion_type != ROC_NPC_TEMPLATE_INSERTION_INDEX_WITH_PATTERN) {
+		*errcode = -EINVAL;
+		return NULL;
+	}
+	if (rule_index >= table->nb_flows) {
+		*errcode = -EINVAL;
+		return NULL;
+	}
+
+	/* Reject creates into a flushed table. */
+	if (table->hw_released) {
+		*errcode = -EINVAL;
+		return NULL;
+	}
+
+	q = &npc->flow_queues[queue_id];
+	if (q->head - q->tail >= q->size) {
+		*errcode = -ENOSPC;
+		return NULL;
+	}
+
+	/* App owns the index: use the reserved pool slot directly. */
+	flow = &table->flow_pool[rule_index];
+	flow->table = table;
+	flow->slot = rule_index;
+	memset(&flow->flow, 0, sizeof(flow->flow));
+
+	attr = table->flow_attr;
+	if (table->transfer)
+		attr.ingress = 1;
+
+	/* Snapshot MARK/VLAN refcounts before parsing. */
+	mark_save = npc->mark_actions;
+	vtag_save = npc->vtag_strip_actions;
+
+	rc = roc_npc_flow_parse(roc_npc, &attr, pattern, actions, &flow->flow);
+	if (rc != 0) {
+		npc->mark_actions = mark_save;
+		npc->vtag_strip_actions = vtag_save;
+		*errcode = rc;
+		return NULL;
+	}
+
+	roc_npc_mcam_write_rx_finalize(roc_npc, &flow->flow);
+	flow->flow.mcam_id = table->mcam_ids[rule_index];
+	flow->flow.enable = 1;
+
+	op = &q->ops[q->head & (q->size - 1)];
+	op->flow = flow;
+	op->is_create = true;
+	op->is_update = false;
+	op->user_data = user_data;
+	op->done = false;
+	op->rc = 0;
+	q->head++;
+
+	return flow;
+}
+
+/* Update a rule's actions in place and swap them in at push. */
+int
+roc_npc_async_flow_actions_update(struct roc_npc *roc_npc, uint32_t queue_id,
+				  struct roc_npc_template_flow *flow,
+				  const struct roc_npc_action actions[], void *user_data)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct roc_npc_item_info end_pattern[1];
+	struct roc_npc_template_table *table;
+	struct roc_npc_flow *fptr, tmpflow;
+	uint32_t mark_save, vtag_save;
+	struct roc_npc_flow_queue *q;
+	struct roc_npc_async_op *op;
+	struct roc_npc_attr attr;
+	uint16_t old_match_id;
+	bool old_vtag;
+	int rc;
+
+	if (flow == NULL || actions == NULL || npc->flow_queues == NULL ||
+	    queue_id >= npc->nb_flow_queues)
+		return -EINVAL;
+
+	table = flow->table;
+	if (table == NULL)
+		return -EINVAL;
+	/* PATTERN rules have roc_flow only after create commit. */
+	if (table->insertion_type == ROC_NPC_TEMPLATE_INSERTION_PATTERN && flow->roc_flow == NULL)
+		return -EINVAL;
+
+	/* Reject a second update until the pending one is flushed. */
+	if (flow->pending_update.pending)
+		return -EBUSY;
+
+	q = &npc->flow_queues[queue_id];
+	if (q->head - q->tail >= q->size)
+		return -ENOSPC;
+
+	end_pattern[0].type = ROC_NPC_ITEM_TYPE_END;
+
+	attr = table->flow_attr;
+	if (table->transfer)
+		attr.ingress = 1;
+
+	memset(&tmpflow, 0, sizeof(tmpflow));
+
+	/* Resolve the live flow before parsing the new actions. */
+	fptr = flow->roc_flow ? flow->roc_flow : &flow->flow;
+	old_match_id = (fptr->npc_action >> NPC_RX_ACT_MATCH_OFFSET) & NPC_RX_ACT_MATCH_MASK;
+	old_vtag = fptr->nix_intf == ROC_NPC_INTF_RX && fptr->vtag_action != 0;
+	mark_save = npc->mark_actions;
+	vtag_save = npc->vtag_strip_actions;
+
+	rc = roc_npc_flow_parse(roc_npc, &attr, end_pattern, actions, &tmpflow);
+	if (rc != 0) {
+		/* Undo any refcount bumps a partial parse made on failure. */
+		npc->mark_actions = mark_save;
+		npc->vtag_strip_actions = vtag_save;
+		return rc;
+	}
+
+	/* Stash the parsed update so push can commit or roll it back. */
+	flow->pending_update.npc_action = tmpflow.npc_action;
+	flow->pending_update.npc_action2 = tmpflow.npc_action2;
+	flow->pending_update.vtag_action = tmpflow.vtag_action;
+	flow->pending_update.recv_queue = tmpflow.recv_queue;
+	flow->pending_update.old_match_id = old_match_id != 0;
+	flow->pending_update.old_vtag = old_vtag;
+	flow->pending_update.new_match_id =
+		((tmpflow.npc_action >> NPC_RX_ACT_MATCH_OFFSET) & NPC_RX_ACT_MATCH_MASK) != 0;
+	flow->pending_update.new_vtag =
+		tmpflow.nix_intf == ROC_NPC_INTF_RX && tmpflow.vtag_action != 0;
+	flow->pending_update.pending = true;
+
+	op = &q->ops[q->head & (q->size - 1)];
+	op->flow = flow;
+	op->is_create = false;
+	op->is_update = true;
+	op->user_data = user_data;
+	op->done = false;
+	op->rc = 0;
+	q->head++;
+
+	return 0;
+}
+
+/* Commit one retained create to hardware. */
+static int
+roc_npc_flow_commit_create(struct roc_npc *roc_npc, struct roc_npc_template_flow *flow)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	uint32_t mark_save, vtag_save;
+	struct roc_npc_flow *rflow;
+	int errcode = 0;
+
+	/* Restore this rule's RSS flow key before programming (see create). */
+	roc_npc->flowkey_cfg_state = flow->flowkey_cfg;
+
+	/* Restore MARK/VLAN refcounts if create fails. */
+	mark_save = npc->mark_actions;
+	vtag_save = npc->vtag_strip_actions;
+
+	rflow = roc_npc_flow_create(roc_npc, &flow->attr, flow->items, flow->actions,
+				    flow->dst_pf_func, flow->npc_default_action, &errcode);
+	if (rflow == NULL) {
+		npc->mark_actions = mark_save;
+		npc->vtag_strip_actions = vtag_save;
+		return errcode ? errcode : -EINVAL;
+	}
+
+	flow->roc_flow = rflow;
+	return 0;
+}
+
+/* Apply a pending actions update and roll it back on failure. */
+static int
+roc_npc_flow_apply_pattern_update(struct roc_npc *roc_npc, struct npc *npc,
+				  struct roc_npc_template_flow *flow)
+{
+	struct roc_npc_flow *fptr = flow->roc_flow;
+	uint64_t save_action2, save_action, save_vtag;
+	uint32_t save_rq;
+	int rc;
+
+	if (fptr == NULL)
+		return -EINVAL;
+
+	save_action2 = fptr->npc_action2;
+	save_action = fptr->npc_action;
+	save_vtag = fptr->vtag_action;
+	save_rq = fptr->recv_queue;
+
+	fptr->npc_action = flow->pending_update.npc_action;
+	fptr->npc_action2 = flow->pending_update.npc_action2;
+	fptr->vtag_action = flow->pending_update.vtag_action;
+	fptr->recv_queue = flow->pending_update.recv_queue;
+	fptr->enable = 1;
+	roc_npc_mcam_write_rx_finalize(roc_npc, fptr);
+	rc = roc_npc_mcam_write_entry(roc_npc, fptr);
+	if (rc == 0) {
+		/* Drop the old action set's refcount contribution. */
+		if (flow->pending_update.old_match_id && npc->mark_actions > 0)
+			npc->mark_actions--;
+		if (flow->pending_update.old_vtag && npc->vtag_strip_actions > 0)
+			npc->vtag_strip_actions--;
+	} else {
+		/* Restore the live entry and undo the new contribution. */
+		fptr->npc_action = save_action;
+		fptr->npc_action2 = save_action2;
+		fptr->vtag_action = save_vtag;
+		fptr->recv_queue = save_rq;
+		if (flow->pending_update.new_match_id && npc->mark_actions > 0)
+			npc->mark_actions--;
+		if (flow->pending_update.new_vtag && npc->vtag_strip_actions > 0)
+			npc->vtag_strip_actions--;
+	}
+	return rc;
+}
+
+int
+roc_npc_flow_push(struct roc_npc *roc_npc, uint32_t queue_id)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct roc_npc_flow_queue *q;
+	uint32_t i;
+
+	if (npc->flow_queues == NULL || queue_id >= npc->nb_flow_queues)
+		return -EINVAL;
+
+	q = &npc->flow_queues[queue_id];
+
+	for (i = q->pushed; i != q->head; i++) {
+		struct roc_npc_async_op *op = &q->ops[i & (q->size - 1)];
+		struct roc_npc_template_flow *flow = op->flow;
+		struct roc_npc_template_table *table = flow->table;
+		int rc;
+
+		if (table->insertion_type == ROC_NPC_TEMPLATE_INSERTION_PATTERN) {
+			if (op->is_update) {
+				rc = roc_npc_flow_apply_pattern_update(roc_npc, npc, flow);
+				/* Clear the pending update after push. */
+				flow->pending_update.pending = false;
+			} else if (op->is_create) {
+				rc = roc_npc_flow_commit_create(roc_npc, flow);
+				/* Rule arrays are consumed on push. */
+				roc_npc_template_flow_free_rule(flow);
+				if (rc == 0) {
+					plt_spinlock_lock(&table->lock);
+					table->nb_live++;
+					TAILQ_INSERT_TAIL(&table->live_flows, flow, link);
+					plt_spinlock_unlock(&table->lock);
+				}
+				/* Keep the handle valid on failure. */
+			} else if (flow->roc_flow == NULL) {
+				/* Never committed (or a failed create): just free it. */
+				rc = 0;
+				roc_npc_template_flow_free_rule(flow);
+				plt_free(flow);
+			} else {
+				uint16_t match_id;
+				uint8_t nix_intf;
+				bool had_vtag;
+
+				/* Capture match_id and interface before destroy. */
+				match_id = (flow->roc_flow->npc_action >> NPC_RX_ACT_MATCH_OFFSET) &
+					   NPC_RX_ACT_MATCH_MASK;
+				nix_intf = flow->roc_flow->nix_intf;
+				had_vtag = flow->roc_flow->vtag_action != 0;
+
+				rc = roc_npc_flow_destroy(roc_npc, flow->roc_flow);
+				if (rc == 0 && match_id)
+					roc_npc_mark_actions_sub_return(roc_npc, 1);
+				if (rc == 0 && nix_intf == ROC_NPC_INTF_RX && had_vtag)
+					roc_npc_vtag_actions_sub_return(roc_npc, 1);
+				if (rc == 0) {
+					plt_spinlock_lock(&table->lock);
+					table->nb_live--;
+					TAILQ_REMOVE(&table->live_flows, flow, link);
+					plt_spinlock_unlock(&table->lock);
+					flow->roc_flow = NULL;
+					roc_npc_template_flow_free_rule(flow);
+					plt_free(flow);
+				}
+				/* Keep the handle on failure so the caller can retry. */
+			}
+		} else {
+			/* INDEX_WITH_PATTERN: entry fixed at the app-chosen index. */
+			struct roc_npc_flow *fptr = &flow->flow;
+			bool destroy = !op->is_create && !op->is_update;
+			uint16_t match_id = (fptr->npc_action >> NPC_RX_ACT_MATCH_OFFSET) &
+					    NPC_RX_ACT_MATCH_MASK;
+			uint64_t save_action2 = fptr->npc_action2;
+			uint64_t save_action = fptr->npc_action;
+			uint64_t save_vtag = fptr->vtag_action;
+			uint32_t save_rq = fptr->recv_queue;
+
+			/* Swap in the stashed update before writing hardware. */
+			if (op->is_update) {
+				fptr->npc_action = flow->pending_update.npc_action;
+				fptr->npc_action2 = flow->pending_update.npc_action2;
+				fptr->vtag_action = flow->pending_update.vtag_action;
+				fptr->recv_queue = flow->pending_update.recv_queue;
+			}
+
+			/* Set enable before writing hardware. */
+			fptr->enable = destroy ? 0 : 1;
+			if (op->is_update)
+				roc_npc_mcam_write_rx_finalize(roc_npc, fptr);
+			rc = roc_npc_mcam_write_entry(roc_npc, fptr);
+			if (rc != 0) {
+				/* Restore the previous enable state on failure. */
+				fptr->enable = destroy ? 1 : 0;
+				/* Roll back the swapped-in action words too. */
+				if (op->is_update) {
+					fptr->npc_action = save_action;
+					fptr->npc_action2 = save_action2;
+					fptr->vtag_action = save_vtag;
+					fptr->recv_queue = save_rq;
+				}
+			}
+
+			/* Commit or roll back the update refcount change. */
+			if (op->is_update) {
+				if (rc == 0) {
+					if (flow->pending_update.old_match_id &&
+					    npc->mark_actions > 0)
+						npc->mark_actions--;
+					if (flow->pending_update.old_vtag &&
+					    npc->vtag_strip_actions > 0)
+						npc->vtag_strip_actions--;
+				} else {
+					if (flow->pending_update.new_match_id &&
+					    npc->mark_actions > 0)
+						npc->mark_actions--;
+					if (flow->pending_update.new_vtag &&
+					    npc->vtag_strip_actions > 0)
+						npc->vtag_strip_actions--;
+				}
+				flow->pending_update.pending = false;
+			}
+
+			/* Release the COUNT counter on destroy. */
+			if (destroy && rc == 0 && fptr->use_ctr &&
+			    fptr->ctr_id != NPC_COUNTER_NONE) {
+				roc_npc_mcam_free_counter(roc_npc, fptr->ctr_id);
+				fptr->ctr_id = NPC_COUNTER_NONE;
+			}
+
+			/* Balance the mark_actions refcount for MARK/FLAG rules. */
+			if (destroy && rc == 0 && match_id)
+				roc_npc_mark_actions_sub_return(roc_npc, 1);
+
+			/* Balance the vtag_strip_actions refcount for RX VLAN strip rules. */
+			if (destroy && rc == 0 && fptr->nix_intf == ROC_NPC_INTF_RX &&
+			    fptr->vtag_action != 0)
+				roc_npc_vtag_actions_sub_return(roc_npc, 1);
+		}
+
+		op->rc = rc;
+		op->done = true;
+	}
+
+	q->pushed = q->head;
+	return 0;
+}
+
+int
+roc_npc_flow_pull(struct roc_npc *roc_npc, uint32_t queue_id, struct roc_npc_flow_op_result res[],
+		  uint16_t n_res)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct roc_npc_flow_queue *q;
+	uint16_t cnt = 0;
+
+	if (npc->flow_queues == NULL || queue_id >= npc->nb_flow_queues)
+		return -EINVAL;
+
+	q = &npc->flow_queues[queue_id];
+
+	/* Return ops that were pushed but not yet reported. */
+	while (q->tail != q->pushed && cnt < n_res) {
+		struct roc_npc_async_op *op = &q->ops[q->tail & (q->size - 1)];
+
+		res[cnt].user_data = op->user_data;
+		res[cnt].rc = op->rc;
+		cnt++;
+		q->tail++;
+	}
+
+	return cnt;
+}
+
+/* Resolve a candidate handle to a template flow or a sync flow. */
+bool
+roc_npc_async_flow_resolve(struct roc_npc *roc_npc, void *handle, struct roc_npc_flow **flow)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	struct roc_npc_template_flow *cand = handle;
+	struct roc_npc_template_table *table;
+	uint16_t i;
+
+	if (handle == NULL || flow == NULL)
+		return false;
+
+	for (table = npc->flow_tables; table != NULL; table = table->next) {
+		struct roc_npc_template_flow *match;
+
+		/* Integer range check: pointer comparison across objects is UB. */
+		if (table->flow_pool != NULL) {
+			uintptr_t p = (uintptr_t)cand;
+			uintptr_t base = (uintptr_t)table->flow_pool;
+			uintptr_t end = (uintptr_t)(table->flow_pool + table->nb_flows);
+
+			if (p >= base && p < end) {
+				*flow = &cand->flow;
+				return true;
+			}
+		}
+
+		plt_spinlock_lock(&table->lock);
+		/* clang-format off */
+		TAILQ_FOREACH(match, &table->live_flows, link) {
+			if (match == cand) {
+				plt_spinlock_unlock(&table->lock);
+				*flow = cand->roc_flow;
+				return true;
+			}
+		}
+		/* clang-format on */
+		plt_spinlock_unlock(&table->lock);
+	}
+
+	/* Handle still queued: a PATTERN rule not yet committed. */
+	for (i = 0; i < npc->nb_flow_queues; i++) {
+		struct roc_npc_flow_queue *q = &npc->flow_queues[i];
+		uint32_t j;
+
+		for (j = q->tail; j != q->head; j++) {
+			struct roc_npc_async_op *op = &q->ops[j & (q->size - 1)];
+
+			if (op->flow == cand) {
+				*flow = cand->roc_flow;
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+/* Return the table cookie used to recover update context. */
+void *
+roc_npc_async_flow_table_cookie(struct roc_npc_template_flow *flow)
+{
+	if (flow == NULL || flow->table == NULL)
+		return NULL;
+
+	return flow->table->cookie;
+}
+
+/* Reconcile template-table bookkeeping after flush or port close. */
+void
+npc_template_tables_flush_reconcile(struct npc *npc)
+{
+	struct roc_npc_template_table *table;
+	struct roc_npc_template_flow *flow;
+	struct roc_npc_flow *fptr;
+	uint16_t match_id;
+	uint32_t j;
+
+	for (table = npc->flow_tables; table != NULL; table = table->next) {
+		plt_spinlock_lock(&table->lock);
+		while ((flow = TAILQ_FIRST(&table->live_flows)) != NULL) {
+			TAILQ_REMOVE(&table->live_flows, flow, link);
+			/* roc_flow is already freed by free_all_resources. */
+			roc_npc_template_flow_free_rule(flow);
+			plt_free(flow);
+		}
+
+		/* INDEX_WITH_PATTERN rules live in flow_pool[]; clear stale state. */
+		if (table->flow_pool != NULL) {
+			for (j = 0; j < table->nb_flows; j++) {
+				fptr = &table->flow_pool[j].flow;
+
+				if (fptr->enable == 0)
+					continue;
+
+				match_id = (fptr->npc_action >> NPC_RX_ACT_MATCH_OFFSET) &
+					   NPC_RX_ACT_MATCH_MASK;
+				if (match_id && npc->mark_actions > 0)
+					npc->mark_actions--;
+
+				if (fptr->nix_intf == ROC_NPC_INTF_RX && fptr->vtag_action != 0 &&
+				    npc->vtag_strip_actions > 0)
+					npc->vtag_strip_actions--;
+
+				memset(fptr, 0, sizeof(*fptr));
+				fptr->ctr_id = NPC_COUNTER_NONE;
+			}
+		}
+
+		table->nb_live = 0;
+		table->hw_released = true;
+		plt_spinlock_unlock(&table->lock);
+	}
+}
diff --git a/drivers/common/cnxk/roc_npc_mcam.c b/drivers/common/cnxk/roc_npc_mcam.c
index 286cfd2dbd..34665f1bc3 100644
--- a/drivers/common/cnxk/roc_npc_mcam.c
+++ b/drivers/common/cnxk/roc_npc_mcam.c
@@ -714,7 +714,6 @@ npc_mcam_fetch_kex_cfg(struct npc *npc)
 	struct mbox *mbox = mbox_get(npc->mbox);
 	int rc = 0;
 
-
 	if (!roc_model_is_cn20k()) {
 		mbox_alloc_msg_npc_get_kex_cfg(mbox);
 		rc = mbox_process_msg(mbox, (void *)&kex_rsp);
@@ -786,6 +785,46 @@ npc_mcam_set_channel(struct roc_npc_flow *flow, struct npc_cn20k_mcam_write_entr
 	flow->mcam_mask[0] |= (uint64_t)mask;
 }
 
+/* Fold RQ into the action word and program the RX channel into kw[0],
+ * matching the RX steps the sync path does in npc_mcam_alloc_and_write().
+ */
+void
+roc_npc_mcam_write_rx_finalize(struct roc_npc *roc_npc, struct roc_npc_flow *flow)
+{
+	struct npc *npc = roc_npc_to_npc_priv(roc_npc);
+	uint16_t chan, mask;
+	uint64_t op;
+
+	if (flow->nix_intf != NIX_INTF_RX)
+		return;
+
+	/* Set the RQ in the action index field, but only for UCAST* ops that
+	 * use it as a receive queue. Clear then set so a re-finalize on an
+	 * async QUEUE update leaves no stale bits.
+	 */
+	op = flow->npc_action & 0xFULL;
+	if (op == NIX_RX_ACTIONOP_UCAST || op == NIX_RX_ACTIONOP_UCAST_IPSEC ||
+	    op == NIX_RX_ACTIONOP_UCAST_CPT) {
+		flow->npc_action &= ~GENMASK_ULL(39, 20);
+		flow->npc_action |= ((uint64_t)flow->recv_queue << 20) & GENMASK_ULL(39, 20);
+	}
+
+	/* Program the RX channel into kw[0]. */
+	chan = npc->channel;
+	mask = BIT_ULL(12) - 1;
+
+	flow->mcam_data[0] &= ~(GENMASK(11, 0));
+	flow->mcam_mask[0] &= ~(GENMASK(11, 0));
+
+	if (roc_model_runtime_is_cn10k() && !roc_npc_action_is_rx_inline(flow->npc_action)) {
+		chan = (chan & NIX_CHAN_CPT_X2P_MASK);
+		mask = (mask & NIX_CHAN_CPT_X2P_MASK);
+	}
+
+	flow->mcam_data[0] |= (uint64_t)chan;
+	flow->mcam_mask[0] |= (uint64_t)mask;
+}
+
 #define NPC_PF_FUNC_WIDTH    2
 #define NPC_KEX_PF_FUNC_MASK 0xFFFF
 
@@ -1430,5 +1469,9 @@ npc_flow_free_all_resources(struct npc *npc)
 			plt_free(flow);
 		}
 	}
+
+	/* Reconcile template-table bookkeeping for all teardown paths. */
+	npc_template_tables_flush_reconcile(npc);
+
 	return rc;
 }
diff --git a/drivers/common/cnxk/roc_npc_priv.h b/drivers/common/cnxk/roc_npc_priv.h
index c7e7d2d8f6..c6ab033d9f 100644
--- a/drivers/common/cnxk/roc_npc_priv.h
+++ b/drivers/common/cnxk/roc_npc_priv.h
@@ -427,6 +427,99 @@ struct npc_age_flow_entry {
 
 TAILQ_HEAD(npc_age_flow_list_head, npc_age_flow_entry);
 
+/* Queue-based async template flow engine types. */
+
+/* One in-flight async op in a queue ring. */
+struct roc_npc_async_op {
+	struct roc_npc_template_flow *flow; /**< Rule the op acts on. */
+	void *user_data;		    /**< Echoed back by flow_pull. */
+	bool is_create;			    /**< true = create, false = destroy. */
+	bool is_update;			    /**< true = in-place actions rewrite. */
+	bool done;			    /**< Set once pushed to hardware. */
+	int rc;				    /**< Result captured at push time. */
+};
+
+/* Fixed-size op ring; head/pushed/tail are free-running indices. */
+struct roc_npc_flow_queue {
+	struct roc_npc_async_op *ops; /**< size entries, power-of-two. */
+	uint32_t size;		      /**< Ring capacity (power of two). */
+	uint32_t head;		      /**< Next slot to enqueue into. */
+	uint32_t pushed;	      /**< Ops up to here are committed. */
+	uint32_t tail;		      /**< Next slot to return via pull. */
+};
+
+/* A deep-copied, retained rule awaiting (or holding) a hardware entry. */
+struct roc_npc_template_flow {
+	struct roc_npc_template_table *table; /**< Owning table. */
+	struct roc_npc_flow *roc_flow;	      /**< HW flow (PATTERN, once committed). */
+	struct roc_npc_item_info *items;      /**< Deep-copied merged pattern. */
+	struct roc_npc_action *actions;	      /**< Deep-copied merged actions. */
+	struct roc_npc_flow flow;	      /**< Embedded HW flow (INDEX path). */
+	struct roc_npc_attr attr;	      /**< Priority / ingress / egress. */
+	uint64_t npc_default_action;	      /**< Resolved port default action. */
+	uint32_t flowkey_cfg;		      /**< RSS flow key captured at create. */
+	uint32_t slot;			      /**< Pre-reserved index (INDEX path). */
+	uint16_t dst_pf_func;		      /**< Resolved destination pf_func. */
+	uint16_t nb_items;		      /**< Item count (excluding END). */
+	uint16_t nb_actions;		      /**< Action count (excluding END). */
+	/* Pending in-place actions update, applied at push. */
+	struct {
+		uint64_t npc_action;
+		uint64_t npc_action2;
+		uint64_t vtag_action;
+		uint32_t recv_queue;
+		bool pending;	   /**< An update is enqueued, awaiting push. */
+		bool old_match_id; /**< Old action set carried a mark/match_id. */
+		bool old_vtag;	   /**< Old action set carried RX vtag strip. */
+		bool new_match_id; /**< New action set carries a mark/match_id. */
+		bool new_vtag;	   /**< New action set carries RX vtag strip. */
+	} pending_update;
+	TAILQ_ENTRY(roc_npc_template_flow) link;
+};
+
+TAILQ_HEAD(roc_npc_template_flow_list, roc_npc_template_flow);
+
+/* Pattern template blueprint. */
+struct roc_npc_pattern_template {
+	struct roc_npc_pattern_template_attr attr;
+	struct roc_npc_item_info *pattern; /**< nb_items + END terminator. */
+	void **copies;			   /**< Tracked payload allocations. */
+	uint16_t nb_copies;		   /**< Entries used in copies[]. */
+	uint16_t nb_items;		   /**< Item count (excluding END). */
+	uint32_t refcnt;		   /**< Tables referencing this template. */
+};
+
+/* Actions template blueprint. */
+struct roc_npc_actions_template {
+	struct roc_npc_actions_template_attr attr;
+	struct roc_npc_action *actions; /**< nb_actions + END terminator. */
+	struct roc_npc_action *masks;	/**< Per-action masks (optional). */
+	void **copies;			/**< Tracked conf allocations. */
+	uint16_t nb_copies;		/**< Entries used in copies[]. */
+	uint16_t nb_actions;		/**< Action count (excluding END). */
+	uint32_t refcnt;		/**< Tables referencing this template. */
+};
+
+/* Template table and rule storage. */
+struct roc_npc_template_table {
+	int *mcam_ids;				 /**< Reserved entries (index). */
+	struct roc_npc_template_flow *flow_pool; /**< Per-index rule slots. */
+	struct roc_npc_pattern_template **pattern_templates;
+	struct roc_npc_actions_template **actions_templates;
+	struct roc_npc_template_flow_list live_flows; /**< Live pattern rules. */
+	struct roc_npc_template_table *next;	      /**< Port table list link. */
+	void *cookie;				      /**< Opaque consumer context. */
+	struct roc_npc_attr flow_attr;		      /**< Priority/ingress/egress. */
+	enum roc_npc_template_table_insertion_type insertion_type;
+	plt_spinlock_t lock;	      /**< Guards live_flows/nb_live. */
+	uint32_t nb_flows;	      /**< Max rules the table holds. */
+	uint32_t nb_live;	      /**< Live pattern rules count. */
+	uint32_t transfer;	      /**< Transfer (port) rule. */
+	uint8_t nb_pattern_templates; /**< pattern_templates entries. */
+	uint8_t nb_actions_templates; /**< actions_templates entries. */
+	bool hw_released;	      /**< Entries freed by a flush. */
+};
+
 struct npc {
 	struct mbox *mbox;			/* Mbox */
 	uint64_t keyx_supp_nmask[NPC_MAX_INTF]; /* nibble mask */
@@ -459,6 +552,10 @@ struct npc {
 	struct plt_bitmap *rss_grp_entries;
 	struct npc_flow_list ipsec_list;
 	uint8_t enable_debug;
+	/* Queue-based async template flow state owned by roc. */
+	struct roc_npc_flow_queue *flow_queues;
+	uint16_t nb_flow_queues;
+	struct roc_npc_template_table *flow_tables;
 };
 
 #define NPC_HASH_FIELD_LEN 16
@@ -533,6 +630,7 @@ int npc_mcam_fetch_hw_cap(struct npc *npc, uint8_t *npc_hw_cap);
 int npc_get_free_mcam_entry(struct mbox *mbox, struct roc_npc_flow *flow, struct npc *npc);
 void npc_delete_prio_list_entry(struct npc *npc, struct roc_npc_flow *flow);
 int npc_flow_free_all_resources(struct npc *npc);
+void npc_template_tables_flush_reconcile(struct npc *npc);
 const struct roc_npc_item_info *
 npc_parse_skip_void_and_any_items(const struct roc_npc_item_info *pattern);
 int npc_program_mcam(struct npc *npc, struct npc_parse_state *pst, bool mcam_alloc);
diff --git a/drivers/common/cnxk/roc_npc_utils.c b/drivers/common/cnxk/roc_npc_utils.c
index 8e83b8662d..7ae877aa98 100644
--- a/drivers/common/cnxk/roc_npc_utils.c
+++ b/drivers/common/cnxk/roc_npc_utils.c
@@ -1088,7 +1088,7 @@ npc_get_free_mcam_entry(struct mbox *mbox, struct roc_npc_flow *flow, struct npc
 					     flow->key_type);
 		if (rc) {
 			plt_npc_dbg("npc: failed to allocate MCAM entry.");
-			return rc;
+			goto err;
 		}
 
 		new_entry->flow = flow;
@@ -1096,7 +1096,7 @@ npc_get_free_mcam_entry(struct mbox *mbox, struct roc_npc_flow *flow, struct npc
 		rc = npc_alloc_mcam_by_ref_entry(mbox, flow, npc, &rsp_local);
 
 		if (rc)
-			return rc;
+			goto err;
 
 		new_entry->flow = flow;
 
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 00746abc06..de8de910f6 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -487,6 +487,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_enable_all_entries)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_alloc_entry)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_ena_dis_entry)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_write_entry)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_write_rx_finalize)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_low_priority_mcam)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_profile_name_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_kex_capa_get)
@@ -505,6 +506,21 @@ RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_aged_flow_ctx_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_defrag_mcam_banks)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_key_type)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_mcam_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_configure)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_pattern_template_create)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_pattern_template_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_actions_template_create)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_actions_template_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_template_table_create)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_template_table_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_async_flow_create)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_async_flow_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_async_flow_create_by_index_with_pattern)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_async_flow_actions_update)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_push)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_pull)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_async_flow_resolve)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_async_flow_table_cookie)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_re_ml_zeta_get)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_re_ml_zeta_put)
 RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_queues_attach)
diff --git a/drivers/net/cnxk/cn10k_ethdev.c b/drivers/net/cnxk/cn10k_ethdev.c
index 23a2341c8b..bcf4e23286 100644
--- a/drivers/net/cnxk/cn10k_ethdev.c
+++ b/drivers/net/cnxk/cn10k_ethdev.c
@@ -5,6 +5,7 @@
 #include "cn10k_flow.h"
 #include "cn10k_rx.h"
 #include "cn10k_tx.h"
+#include "cnxk_flow.h"
 
 static uint16_t
 nix_rx_offload_flags(struct rte_eth_dev *eth_dev)
@@ -916,8 +917,27 @@ npc_flow_ops_override(void)
 	cnxk_flow_ops.create = cn10k_flow_create;
 	cnxk_flow_ops.destroy = cn10k_flow_destroy;
 	cnxk_flow_ops.info_get = cn10k_flow_info_get;
+
+	cnxk_flow_ops.configure = cnxk_flow_configure;
+	cnxk_flow_ops.pattern_template_create = cnxk_flow_pattern_template_create;
+	cnxk_flow_ops.pattern_template_destroy = cnxk_flow_pattern_template_destroy;
+	cnxk_flow_ops.actions_template_create = cnxk_flow_actions_template_create;
+	cnxk_flow_ops.actions_template_destroy = cnxk_flow_actions_template_destroy;
+	cnxk_flow_ops.template_table_create = cnxk_flow_template_table_create;
+	cnxk_flow_ops.template_table_destroy = cnxk_flow_template_table_destroy;
 }
 
+/* Fast-path (async) flow ops. Installed per-port in cn10k_nix_probe(). */
+static const struct rte_flow_fp_ops cn10k_flow_fp_ops = {
+	.async_create = cnxk_flow_async_create,
+	.async_create_by_index = cnxk_flow_async_create_by_index,
+	.async_create_by_index_with_pattern = cnxk_flow_async_create_by_index_with_pattern,
+	.async_actions_update = cnxk_flow_async_actions_update,
+	.async_destroy = cnxk_flow_async_destroy,
+	.push = cn10k_flow_push,
+	.pull = cnxk_flow_pull,
+};
+
 static int
 cn10k_nix_remove(struct rte_pci_device *pci_dev)
 {
@@ -966,6 +986,9 @@ cn10k_nix_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 
 	dev = cnxk_eth_pmd_priv(eth_dev);
 
+	/* Install fast-path (async) flow ops for this port. */
+	eth_dev->flow_fp_ops = &cn10k_flow_fp_ops;
+
 	/* DROP_RE is not supported with inline IPSec for CN10K A0 and
 	 * when vector mode is enabled.
 	 */
diff --git a/drivers/net/cnxk/cn10k_flow.c b/drivers/net/cnxk/cn10k_flow.c
index b95fb83f08..02bc002507 100644
--- a/drivers/net/cnxk/cn10k_flow.c
+++ b/drivers/net/cnxk/cn10k_flow.c
@@ -48,6 +48,49 @@ cn10k_flow_info_get(struct rte_eth_dev *dev, struct rte_flow_port_info *port_inf
 	return cnxk_flow_info_get_common(dev, port_info, queue_info, err);
 }
 
+int
+cn10k_flow_push(struct rte_eth_dev *eth_dev, uint32_t queue, struct rte_flow_error *error)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc *npc = &dev->npc;
+	bool reset_rx = false;
+	int rc;
+
+	/* Flush the pending async ops to hardware first. */
+	rc = cnxk_flow_push(eth_dev, queue, error);
+	if (rc)
+		return rc;
+
+	/* Async push, unlike sync create/destroy, does not toggle the MARK and
+	 * VLAN-strip RX offloads; reconcile each with its refcount so the Rx
+	 * function matches the live rules.
+	 */
+	if (roc_npc_mark_actions_get(npc) &&
+	    !(dev->rx_offload_flags & NIX_RX_OFFLOAD_MARK_UPDATE_F)) {
+		dev->rx_offload_flags |= NIX_RX_OFFLOAD_MARK_UPDATE_F;
+		reset_rx = true;
+	} else if (!roc_npc_mark_actions_get(npc) &&
+		   (dev->rx_offload_flags & NIX_RX_OFFLOAD_MARK_UPDATE_F)) {
+		dev->rx_offload_flags &= ~NIX_RX_OFFLOAD_MARK_UPDATE_F;
+		reset_rx = true;
+	}
+
+	if (roc_npc_vtag_actions_get(npc) &&
+	    !(dev->rx_offload_flags & NIX_RX_OFFLOAD_VLAN_STRIP_F)) {
+		dev->rx_offload_flags |= NIX_RX_OFFLOAD_VLAN_STRIP_F;
+		reset_rx = true;
+	} else if (!roc_npc_vtag_actions_get(npc) &&
+		   (dev->rx_offload_flags & NIX_RX_OFFLOAD_VLAN_STRIP_F)) {
+		dev->rx_offload_flags &= ~NIX_RX_OFFLOAD_VLAN_STRIP_F;
+		reset_rx = true;
+	}
+
+	if (reset_rx)
+		cn10k_eth_set_rx_function(eth_dev);
+
+	return 0;
+}
+
 int
 cn10k_flow_destroy(struct rte_eth_dev *eth_dev, struct rte_flow *rte_flow,
 		   struct rte_flow_error *error)
diff --git a/drivers/net/cnxk/cn10k_flow.h b/drivers/net/cnxk/cn10k_flow.h
index c9e8c86e96..c0d239c20f 100644
--- a/drivers/net/cnxk/cn10k_flow.h
+++ b/drivers/net/cnxk/cn10k_flow.h
@@ -16,6 +16,8 @@ int cn10k_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *flow,
 int cn10k_flow_info_get(struct rte_eth_dev *dev, struct rte_flow_port_info *port_info,
 			struct rte_flow_queue_info *queue_info, struct rte_flow_error *err);
 
+int cn10k_flow_push(struct rte_eth_dev *dev, uint32_t queue, struct rte_flow_error *error);
+
 #define CNXK_NPC_COUNTERS_MAX 512
 
 #endif /* __CN10K_FLOW_H__ */
diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index f08079f612..9fac027650 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -5,7 +5,7 @@
 #include "cn20k_flow.h"
 #include "cn20k_rx.h"
 #include "cn20k_tx.h"
-
+#include "cnxk_flow.h"
 static uint16_t
 nix_rx_offload_flags(struct rte_eth_dev *eth_dev)
 {
@@ -962,8 +962,27 @@ npc_flow_ops_override(void)
 	cnxk_flow_ops.create = cn20k_flow_create;
 	cnxk_flow_ops.destroy = cn20k_flow_destroy;
 	cnxk_flow_ops.info_get = cn20k_flow_info_get;
+
+	cnxk_flow_ops.configure = cnxk_flow_configure;
+	cnxk_flow_ops.pattern_template_create = cnxk_flow_pattern_template_create;
+	cnxk_flow_ops.pattern_template_destroy = cnxk_flow_pattern_template_destroy;
+	cnxk_flow_ops.actions_template_create = cnxk_flow_actions_template_create;
+	cnxk_flow_ops.actions_template_destroy = cnxk_flow_actions_template_destroy;
+	cnxk_flow_ops.template_table_create = cnxk_flow_template_table_create;
+	cnxk_flow_ops.template_table_destroy = cnxk_flow_template_table_destroy;
 }
 
+/* Fast-path (async) flow ops. Installed per-port in cn20k_nix_probe(). */
+static const struct rte_flow_fp_ops cn20k_flow_fp_ops = {
+	.async_create = cnxk_flow_async_create,
+	.async_create_by_index = cnxk_flow_async_create_by_index,
+	.async_create_by_index_with_pattern = cnxk_flow_async_create_by_index_with_pattern,
+	.async_actions_update = cnxk_flow_async_actions_update,
+	.async_destroy = cnxk_flow_async_destroy,
+	.push = cn20k_flow_push,
+	.pull = cnxk_flow_pull,
+};
+
 static int
 cn20k_nix_remove(struct rte_pci_device *pci_dev)
 {
@@ -1012,6 +1031,9 @@ cn20k_nix_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 
 	dev = cnxk_eth_pmd_priv(eth_dev);
 
+	/* Install fast-path (async) flow ops for this port. */
+	eth_dev->flow_fp_ops = &cn20k_flow_fp_ops;
+
 	/* Register up msg callbacks for PTP information */
 	roc_nix_ptp_info_cb_register(&dev->nix, cn20k_nix_ptp_info_update_cb);
 
diff --git a/drivers/net/cnxk/cn20k_flow.c b/drivers/net/cnxk/cn20k_flow.c
index fd50f516ee..ff6e220103 100644
--- a/drivers/net/cnxk/cn20k_flow.c
+++ b/drivers/net/cnxk/cn20k_flow.c
@@ -48,6 +48,49 @@ cn20k_flow_info_get(struct rte_eth_dev *dev, struct rte_flow_port_info *port_inf
 	return cnxk_flow_info_get_common(dev, port_info, queue_info, err);
 }
 
+int
+cn20k_flow_push(struct rte_eth_dev *eth_dev, uint32_t queue, struct rte_flow_error *error)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc *npc = &dev->npc;
+	bool reset_rx = false;
+	int rc;
+
+	/* Flush the pending async ops to hardware first. */
+	rc = cnxk_flow_push(eth_dev, queue, error);
+	if (rc)
+		return rc;
+
+	/* Async push, unlike sync create/destroy, does not toggle the MARK and
+	 * VLAN-strip RX offloads; reconcile each with its refcount so the Rx
+	 * function matches the live rules.
+	 */
+	if (roc_npc_mark_actions_get(npc) &&
+	    !(dev->rx_offload_flags & NIX_RX_OFFLOAD_MARK_UPDATE_F)) {
+		dev->rx_offload_flags |= NIX_RX_OFFLOAD_MARK_UPDATE_F;
+		reset_rx = true;
+	} else if (!roc_npc_mark_actions_get(npc) &&
+		   (dev->rx_offload_flags & NIX_RX_OFFLOAD_MARK_UPDATE_F)) {
+		dev->rx_offload_flags &= ~NIX_RX_OFFLOAD_MARK_UPDATE_F;
+		reset_rx = true;
+	}
+
+	if (roc_npc_vtag_actions_get(npc) &&
+	    !(dev->rx_offload_flags & NIX_RX_OFFLOAD_VLAN_STRIP_F)) {
+		dev->rx_offload_flags |= NIX_RX_OFFLOAD_VLAN_STRIP_F;
+		reset_rx = true;
+	} else if (!roc_npc_vtag_actions_get(npc) &&
+		   (dev->rx_offload_flags & NIX_RX_OFFLOAD_VLAN_STRIP_F)) {
+		dev->rx_offload_flags &= ~NIX_RX_OFFLOAD_VLAN_STRIP_F;
+		reset_rx = true;
+	}
+
+	if (reset_rx)
+		cn20k_eth_set_rx_function(eth_dev);
+
+	return 0;
+}
+
 int
 cn20k_flow_destroy(struct rte_eth_dev *eth_dev, struct rte_flow *rte_flow,
 		   struct rte_flow_error *error)
diff --git a/drivers/net/cnxk/cn20k_flow.h b/drivers/net/cnxk/cn20k_flow.h
index 1e4bd6214a..ed8a2aa1f3 100644
--- a/drivers/net/cnxk/cn20k_flow.h
+++ b/drivers/net/cnxk/cn20k_flow.h
@@ -16,6 +16,8 @@ int cn20k_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *flow,
 int cn20k_flow_info_get(struct rte_eth_dev *dev, struct rte_flow_port_info *port_info,
 			struct rte_flow_queue_info *queue_info, struct rte_flow_error *err);
 
+int cn20k_flow_push(struct rte_eth_dev *dev, uint32_t queue, struct rte_flow_error *error);
+
 #define CNXK_NPC_COUNTERS_MAX 512
 
 #endif /* __CN20K_FLOW_H__ */
diff --git a/drivers/net/cnxk/cnxk_ethdev.h b/drivers/net/cnxk/cnxk_ethdev.h
index fc66135c66..342d249cf4 100644
--- a/drivers/net/cnxk/cnxk_ethdev.h
+++ b/drivers/net/cnxk/cnxk_ethdev.h
@@ -328,6 +328,50 @@ struct cnxk_macsec_sess {
 };
 TAILQ_HEAD(cnxk_macsec_sess_list, cnxk_macsec_sess);
 
+/* Pattern template: owns deep copies tracked in copies[]. */
+struct cnxk_flow_pattern_template {
+	struct rte_flow_pattern_template_attr attr;
+	struct rte_flow_item *pattern;
+	/* Mirrored roc handle for table-level ownership/lifecycle in roc. */
+	struct roc_npc_pattern_template *roc_tmpl;
+	uint16_t nb_items;
+	void **copies;
+	uint16_t nb_copies;
+	uint32_t refcnt;
+};
+
+/* Actions template: owns deep copies tracked in copies[]. */
+struct cnxk_flow_actions_template {
+	struct rte_flow_actions_template_attr attr;
+	struct rte_flow_action *actions;
+	struct rte_flow_action *masks;
+	/* Mirrored roc handle for table-level ownership/lifecycle in roc. */
+	struct roc_npc_actions_template *roc_tmpl;
+	uint16_t nb_actions;
+	void **copies;
+	uint16_t nb_copies;
+	uint32_t refcnt;
+};
+
+/* Template table wrapper. The roc layer owns rule storage, MCAM reservation
+ * and rule lifecycle; cnxk keeps rte templates for per-rule translation.
+ */
+struct cnxk_flow_table {
+	/* roc engine table handle: storage, MCAM, rule lifecycle. */
+	struct roc_npc_template_table *roc_table;
+
+	struct cnxk_flow_pattern_template **pattern_templates;
+	struct cnxk_flow_actions_template **actions_templates;
+	uint8_t nb_pattern_templates;
+	uint8_t nb_actions_templates;
+
+	uint32_t nb_flows;
+	struct roc_npc_attr flow_attr;
+	/* roc_npc_attr has no transfer field; replay it into each rule attr. */
+	bool transfer;
+	enum rte_flow_table_insertion_type insertion_type;
+};
+
 struct cnxk_eth_dev {
 	/* ROC NIX */
 	struct roc_nix nix;
diff --git a/drivers/net/cnxk/cnxk_flow.c b/drivers/net/cnxk/cnxk_flow.c
index c1c48eb7ab..1562b7389e 100644
--- a/drivers/net/cnxk/cnxk_flow.c
+++ b/drivers/net/cnxk/cnxk_flow.c
@@ -8,6 +8,7 @@
 
 #define TNL_DCP_MATCH_ID 5
 #define NRML_MATCH_ID	 1
+
 const struct cnxk_rte_flow_term_info term[] = {
 	[RTE_FLOW_ITEM_TYPE_ETH] = {ROC_NPC_ITEM_TYPE_ETH, sizeof(struct rte_flow_item_eth)},
 	[RTE_FLOW_ITEM_TYPE_VLAN] = {ROC_NPC_ITEM_TYPE_VLAN, sizeof(struct rte_flow_item_vlan)},
@@ -49,8 +50,7 @@ const struct cnxk_rte_flow_term_info term[] = {
 	[RTE_FLOW_ITEM_TYPE_REPRESENTED_PORT] = {ROC_NPC_ITEM_TYPE_REPRESENTED_PORT,
 						 sizeof(struct rte_flow_item_ethdev)},
 	[RTE_FLOW_ITEM_TYPE_PPPOES] = {ROC_NPC_ITEM_TYPE_PPPOES,
-				       sizeof(struct rte_flow_item_pppoe)}
-};
+				       sizeof(struct rte_flow_item_pppoe)}};
 
 static int
 npc_rss_action_validate(struct rte_eth_dev *eth_dev, const struct rte_flow_attr *attr,
@@ -239,7 +239,7 @@ append_rss_action(struct cnxk_eth_dev *dev, struct roc_npc_action *in_actions, u
 
 	/* Add RSS action */
 	rss_conf->queue_num = nb_rxq;
-	queue_arr = calloc(1, rss_conf->queue_num * sizeof(uint16_t));
+	queue_arr = plt_zmalloc(rss_conf->queue_num * sizeof(uint16_t), 0);
 	if (!queue_arr) {
 		plt_err("Failed to allocate memory for rss queue");
 		rc = -ENOMEM;
@@ -266,10 +266,12 @@ append_rss_action(struct cnxk_eth_dev *dev, struct roc_npc_action *in_actions, u
 	while (free_allocs[j] != 0)
 		j++;
 	free_allocs[j] = (uint64_t)rss_conf;
+	j++;
+	free_allocs[j] = (uint64_t)queue_arr;
 
 	return 0;
 free_rss:
-	rte_free(rss_conf);
+	plt_free(rss_conf);
 fail:
 	return rc;
 }
@@ -1070,22 +1072,18 @@ cnxk_flow_query_common(struct rte_eth_dev *eth_dev, struct rte_flow *flow,
 		       const struct rte_flow_action *action, void *data,
 		       struct rte_flow_error *error, bool is_rep)
 {
-	struct roc_npc_flow *in_flow = (struct roc_npc_flow *)flow;
 	struct rte_flow_query_count *query = data;
+	struct roc_npc_flow *in_flow;
 	struct cnxk_rep_dev *rep_dev;
-	struct cnxk_eth_dev *dev;
-	struct roc_npc *npc;
 	const char *errmsg = NULL;
+	struct cnxk_eth_dev *dev;
 	int errcode = ENOTSUP;
+	struct roc_npc *npc;
 	int rc;
 
-	if (action->type != RTE_FLOW_ACTION_TYPE_COUNT) {
-		errmsg = "Only COUNT is supported in query";
-		goto err_exit;
-	}
-
-	if (in_flow->ctr_id == NPC_COUNTER_NONE) {
-		errmsg = "Counter is not available";
+	if (flow == NULL) {
+		errmsg = "Invalid flow handle";
+		errcode = EINVAL;
 		goto err_exit;
 	}
 
@@ -1098,6 +1096,29 @@ cnxk_flow_query_common(struct rte_eth_dev *eth_dev, struct rte_flow *flow,
 		npc = &rep_dev->parent_dev->npc;
 	}
 
+	/* Let the roc layer resolve async/template handles to the underlying
+	 * roc_npc_flow (NULL until committed); else treat as a sync flow.
+	 */
+	in_flow = (struct roc_npc_flow *)flow;
+	if (!is_rep)
+		roc_npc_async_flow_resolve(npc, flow, &in_flow);
+
+	if (in_flow == NULL) {
+		errmsg = "Flow is not committed yet";
+		errcode = EINVAL;
+		goto err_exit;
+	}
+
+	if (action->type != RTE_FLOW_ACTION_TYPE_COUNT) {
+		errmsg = "Only COUNT is supported in query";
+		goto err_exit;
+	}
+
+	if (in_flow->ctr_id == NPC_COUNTER_NONE) {
+		errmsg = "Counter is not available";
+		goto err_exit;
+	}
+
 	if (in_flow->use_pre_alloc) {
 		rc = roc_npc_inl_mcam_read_counter(in_flow->ctr_id, &query->hits);
 	} else {
@@ -1149,8 +1170,8 @@ cnxk_flow_isolate(struct rte_eth_dev *eth_dev __rte_unused, int enable __rte_unu
 	 * entry for this port.
 	 */
 
-	rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-			   NULL, "Flow isolation not supported");
+	rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			   "Flow isolation not supported");
 
 	return -rte_errno;
 }
@@ -1159,8 +1180,9 @@ int
 cnxk_flow_dev_dump_common(struct rte_eth_dev *eth_dev, struct rte_flow *flow, FILE *file,
 			  struct rte_flow_error *error, bool is_rep)
 {
+	struct roc_npc_flow *in_flow = NULL;
+	struct cnxk_eth_dev *dev = NULL;
 	struct cnxk_rep_dev *rep_dev;
-	struct cnxk_eth_dev *dev;
 	struct roc_npc *npc;
 
 	/* is_rep set for operation performed via representor ports */
@@ -1179,7 +1201,17 @@ cnxk_flow_dev_dump_common(struct rte_eth_dev *eth_dev, struct rte_flow *flow, FI
 	}
 
 	if (flow != NULL) {
-		roc_npc_flow_mcam_dump(file, npc, (struct roc_npc_flow *)flow);
+		/* Resolve async/template handles to the underlying roc_npc_flow;
+		 * else treat as a sync flow.
+		 */
+		if (is_rep || !roc_npc_async_flow_resolve(npc, flow, &in_flow))
+			in_flow = (struct roc_npc_flow *)flow;
+
+		if (in_flow == NULL)
+			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+						  "flow is not committed yet");
+
+		roc_npc_flow_mcam_dump(file, npc, in_flow);
 		return 0;
 	}
 
@@ -1187,6 +1219,1276 @@ cnxk_flow_dev_dump_common(struct rte_eth_dev *eth_dev, struct rte_flow *flow, FI
 
 	return 0;
 }
+/* Configure async flow queues for the port. */
+int
+cnxk_flow_configure(struct rte_eth_dev *eth_dev, const struct rte_flow_port_attr *port_attr,
+		    uint16_t nb_queue, const struct rte_flow_queue_attr *queue_attr[],
+		    struct rte_flow_error *err)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	const struct roc_npc_flow_queue_attr **rptrs = NULL;
+	struct roc_npc_flow_queue_attr *rattr = NULL;
+	struct roc_npc *npc = &dev->npc;
+	uint16_t i;
+	int rc;
+
+	RTE_SET_USED(port_attr);
+
+	/* Translate the rte queue attributes into roc_npc types; the roc
+	 * engine validates nb_queue == 0 and a NULL queue_attr.
+	 */
+	if (nb_queue != 0 && queue_attr != NULL) {
+		rattr = plt_zmalloc(nb_queue * sizeof(*rattr), 0);
+		if (rattr == NULL)
+			return rte_flow_error_set(err, ENOMEM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+						  NULL, "Failed to allocate flow queues");
+
+		rptrs = plt_zmalloc(nb_queue * sizeof(*rptrs), 0);
+		if (rptrs == NULL) {
+			plt_free(rattr);
+			return rte_flow_error_set(err, ENOMEM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+						  NULL, "Failed to allocate flow queues");
+		}
+		for (i = 0; i < nb_queue; i++) {
+			if (queue_attr[i] != NULL) {
+				rattr[i].size = queue_attr[i]->size;
+				rptrs[i] = &rattr[i];
+			} else {
+				rptrs[i] = NULL;
+			}
+		}
+	}
+
+	rc = roc_npc_flow_configure(npc, nb_queue, rptrs);
+
+	plt_free(rattr);
+	plt_free(rptrs);
+
+	if (rc)
+		return rte_flow_error_set(err, -rc, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "Failed to configure flow queues");
+	return 0;
+}
+
+/* Deep-copy a spec/last/mask/conf payload into template-owned memory. */
+static int
+cnxk_flow_dup_conf(void **copies, uint16_t *nb_copies, const void *src, size_t sz, const void **dst)
+{
+	void *copy;
+
+	if (src == NULL || sz == 0) {
+		*dst = NULL;
+		return 0;
+	}
+	copy = plt_zmalloc(sz, 0);
+	if (copy == NULL)
+		return -ENOMEM;
+	memcpy(copy, src, sz);
+	copies[(*nb_copies)++] = copy;
+	*dst = copy;
+	return 0;
+}
+
+struct rte_flow_pattern_template *
+cnxk_flow_pattern_template_create(struct rte_eth_dev *eth_dev,
+				  const struct rte_flow_pattern_template_attr *attr,
+				  const struct rte_flow_item pattern[],
+				  struct rte_flow_error *error)
+{
+	const char *errmsg = "Failed to allocate pattern template";
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct cnxk_flow_pattern_template *tmpl = NULL;
+	struct roc_npc_pattern_template_attr roc_attr;
+	struct roc_npc_item_info *roc_pattern = NULL;
+	int i, nb_items = 0, errcode = ENOMEM;
+	struct roc_npc *npc = &dev->npc;
+	int roc_err;
+
+	if (attr == NULL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "NULL template attr");
+		return NULL;
+	}
+
+	if (pattern == NULL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "NULL pattern");
+		return NULL;
+	}
+
+	while (pattern[nb_items].type != RTE_FLOW_ITEM_TYPE_END)
+		nb_items++;
+
+	/* Reject oversized templates; rules are built into fixed-size stack
+	 * arrays (combined_items[ROC_NPC_ITEM_TYPE_END + 1]).
+	 */
+	if (nb_items > ROC_NPC_ITEM_TYPE_END) {
+		errcode = ENOTSUP;
+		errmsg = "too many pattern items for hardware";
+		goto err_nomem;
+	}
+
+	tmpl = plt_zmalloc(sizeof(*tmpl), 0);
+	if (tmpl == NULL)
+		goto err_nomem;
+
+	tmpl->attr = *attr;
+	tmpl->nb_items = nb_items;
+
+	tmpl->pattern = plt_zmalloc((nb_items + 1) * sizeof(struct rte_flow_item), 0);
+	if (tmpl->pattern == NULL)
+		goto err_free;
+
+	/* At most 3 payload copies (spec/last/mask) per item. */
+	tmpl->copies = plt_zmalloc(3 * (nb_items + 1) * sizeof(void *), 0);
+	if (tmpl->copies == NULL)
+		goto err_free;
+
+	for (i = 0; i < nb_items; i++) {
+		enum rte_flow_item_type t = pattern[i].type;
+		size_t sz = (t < (int)RTE_DIM(term)) ? term[t].item_size : 0;
+
+		/* Reject unrepresentable item types (sz 0), which would drop
+		 * spec/last/mask. VOID/ANY legitimately carry no payload.
+		 */
+		if (t != RTE_FLOW_ITEM_TYPE_VOID && t != RTE_FLOW_ITEM_TYPE_ANY && sz == 0) {
+			errcode = ENOTSUP;
+			errmsg = "unsupported pattern item type in template";
+			goto err_free;
+		}
+
+		/* Reject items with nested variable-length payloads; a flat
+		 * memcpy would retain a dangling pointer into caller memory.
+		 */
+		if (t == RTE_FLOW_ITEM_TYPE_RAW) {
+			errcode = ENOTSUP;
+			errmsg = "Item type with nested pointers is not supported "
+				 "in pattern template (e.g. RAW)";
+			goto err_free;
+		}
+
+		tmpl->pattern[i].type = t;
+		if (cnxk_flow_dup_conf(tmpl->copies, &tmpl->nb_copies, pattern[i].spec, sz,
+				       &tmpl->pattern[i].spec) ||
+		    cnxk_flow_dup_conf(tmpl->copies, &tmpl->nb_copies, pattern[i].last, sz,
+				       &tmpl->pattern[i].last) ||
+		    cnxk_flow_dup_conf(tmpl->copies, &tmpl->nb_copies, pattern[i].mask, sz,
+				       &tmpl->pattern[i].mask))
+			goto err_free;
+	}
+	tmpl->pattern[nb_items].type = RTE_FLOW_ITEM_TYPE_END;
+	tmpl->roc_tmpl = NULL;
+	tmpl->refcnt = 0;
+
+	roc_pattern = plt_zmalloc((nb_items + 1) * sizeof(*roc_pattern), 0);
+	if (roc_pattern == NULL)
+		goto err_free;
+
+	for (i = 0; i < nb_items; i++) {
+		enum rte_flow_item_type t = tmpl->pattern[i].type;
+		size_t sz = (t < (int)RTE_DIM(term)) ? term[t].item_size : 0;
+
+		roc_pattern[i].type =
+			(t < (int)RTE_DIM(term)) ? term[t].item_type : ROC_NPC_ITEM_TYPE_VOID;
+		roc_pattern[i].size = sz;
+		roc_pattern[i].spec = tmpl->pattern[i].spec;
+		roc_pattern[i].last = tmpl->pattern[i].last;
+		roc_pattern[i].mask = tmpl->pattern[i].mask;
+	}
+	roc_pattern[nb_items].type = ROC_NPC_ITEM_TYPE_END;
+
+	memset(&roc_attr, 0, sizeof(roc_attr));
+	roc_attr.relaxed_matching = attr->relaxed_matching;
+	roc_attr.ingress = attr->ingress;
+	roc_attr.egress = attr->egress;
+	roc_attr.transfer = attr->transfer;
+
+	roc_err = 0;
+	tmpl->roc_tmpl = roc_npc_pattern_template_create(npc, &roc_attr, roc_pattern, &roc_err);
+	if (tmpl->roc_tmpl == NULL) {
+		errcode = (roc_err < 0) ? -roc_err : ENOMEM;
+		errmsg = "Failed to create ROC pattern template";
+		goto err_free;
+	}
+
+	plt_free(roc_pattern);
+
+	return (struct rte_flow_pattern_template *)tmpl;
+
+err_free:
+	plt_free(roc_pattern);
+	if (tmpl != NULL) {
+		uint16_t j;
+		if (tmpl->roc_tmpl != NULL)
+			roc_npc_pattern_template_destroy(npc, tmpl->roc_tmpl);
+		for (j = 0; j < tmpl->nb_copies; j++)
+			plt_free(tmpl->copies[j]);
+		plt_free(tmpl->copies);
+		plt_free(tmpl->pattern);
+		plt_free(tmpl);
+	}
+err_nomem:
+	rte_flow_error_set(error, errcode, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL, errmsg);
+	return NULL;
+}
+
+int
+cnxk_flow_pattern_template_destroy(struct rte_eth_dev *eth_dev,
+				   struct rte_flow_pattern_template *templ,
+				   struct rte_flow_error *error)
+{
+	struct cnxk_flow_pattern_template *tmpl = (struct cnxk_flow_pattern_template *)templ;
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc *npc = &dev->npc;
+	uint16_t i;
+	int rc;
+
+	if (tmpl == NULL)
+		return 0;
+
+	if (tmpl->refcnt != 0)
+		return rte_flow_error_set(error, EBUSY, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "pattern template still in use by a table");
+
+	rc = roc_npc_pattern_template_destroy(npc, tmpl->roc_tmpl);
+	if (rc)
+		return rte_flow_error_set(error, -rc, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "failed to destroy ROC pattern template");
+
+	for (i = 0; i < tmpl->nb_copies; i++)
+		plt_free(tmpl->copies[i]);
+	plt_free(tmpl->copies);
+	plt_free(tmpl->pattern);
+	plt_free(tmpl);
+	return 0;
+}
+/* Size of an action's conf for the v1-supported set; -1 = unsupported. */
+static int
+cnxk_flow_action_conf_size(enum rte_flow_action_type type)
+{
+	switch (type) {
+	case RTE_FLOW_ACTION_TYPE_VOID:
+	case RTE_FLOW_ACTION_TYPE_DROP:
+	case RTE_FLOW_ACTION_TYPE_PF:
+	case RTE_FLOW_ACTION_TYPE_FLAG:
+	case RTE_FLOW_ACTION_TYPE_OF_POP_VLAN:
+	case RTE_FLOW_ACTION_TYPE_VXLAN_DECAP:
+		return 0; /* no conf */
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+		return sizeof(struct rte_flow_action_queue);
+	case RTE_FLOW_ACTION_TYPE_VF:
+		return sizeof(struct rte_flow_action_vf);
+	case RTE_FLOW_ACTION_TYPE_MARK:
+		return sizeof(struct rte_flow_action_mark);
+	case RTE_FLOW_ACTION_TYPE_COUNT:
+		return sizeof(struct rte_flow_action_count);
+	case RTE_FLOW_ACTION_TYPE_OF_PUSH_VLAN:
+		return sizeof(struct rte_flow_action_of_push_vlan);
+	case RTE_FLOW_ACTION_TYPE_OF_SET_VLAN_VID:
+		return sizeof(struct rte_flow_action_of_set_vlan_vid);
+	case RTE_FLOW_ACTION_TYPE_OF_SET_VLAN_PCP:
+		return sizeof(struct rte_flow_action_of_set_vlan_pcp);
+	case RTE_FLOW_ACTION_TYPE_AGE:
+		return sizeof(struct rte_flow_action_age);
+	case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
+	case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
+		return sizeof(struct rte_flow_action_ethdev);
+	case RTE_FLOW_ACTION_TYPE_PORT_ID:
+		return sizeof(struct rte_flow_action_port_id);
+	default:
+		return -1;
+	}
+}
+
+/* Deep-copy an action conf. RSS nests queue[]/key[] pointers, so pack them
+ * into one blob and fix the pointers; other confs use a flat memcpy.
+ */
+static void *
+cnxk_flow_dup_action_conf(const struct rte_flow_action *act)
+{
+	if (act->conf == NULL)
+		return NULL;
+
+	if (act->type == RTE_FLOW_ACTION_TYPE_RSS) {
+		const struct rte_flow_action_rss *rss = act->conf;
+		size_t rss_blob_bytes = sizeof(*rss);
+		size_t rss_queue_bytes = (size_t)rss->queue_num * sizeof(uint16_t);
+		size_t rss_key_bytes = rss->key_len;
+		struct rte_flow_action_rss *rss_copy;
+		uint8_t *rss_blob;
+
+		/* Reject a non-zero length paired with a NULL pointer, which
+		 * would make the memcpy below dereference NULL.
+		 */
+		if ((rss_queue_bytes && rss->queue == NULL) || (rss_key_bytes && rss->key == NULL))
+			return NULL;
+
+		rss_blob = plt_zmalloc(rss_blob_bytes + rss_queue_bytes + rss_key_bytes, 0);
+		if (rss_blob == NULL)
+			return NULL;
+		rss_copy = (struct rte_flow_action_rss *)rss_blob;
+		*rss_copy = *rss;
+		if (rss_queue_bytes) {
+			memcpy(rss_blob + rss_blob_bytes, rss->queue, rss_queue_bytes);
+			rss_copy->queue = (const uint16_t *)(rss_blob + rss_blob_bytes);
+		} else {
+			rss_copy->queue = NULL;
+		}
+		if (rss_key_bytes) {
+			memcpy(rss_blob + rss_blob_bytes + rss_queue_bytes, rss->key,
+			       rss_key_bytes);
+			rss_copy->key =
+				(const uint8_t *)(rss_blob + rss_blob_bytes + rss_queue_bytes);
+		} else {
+			rss_copy->key = NULL;
+		}
+		return rss_copy;
+	}
+
+	{
+		int conf_size = cnxk_flow_action_conf_size(act->type);
+		void *copy;
+
+		if (conf_size <= 0)
+			return NULL;
+		copy = plt_zmalloc(conf_size, 0);
+		if (copy != NULL)
+			memcpy(copy, act->conf, conf_size);
+		return copy;
+	}
+}
+
+/* Map a supported rte_flow action type to its roc_npc action type, to mirror
+ * the actions template into the roc engine for lifecycle/refcount ownership.
+ */
+static int
+cnxk_flow_roc_action_type(enum rte_flow_action_type type, enum roc_npc_action_type *roc_type)
+{
+	switch (type) {
+	case RTE_FLOW_ACTION_TYPE_VOID:
+	case RTE_FLOW_ACTION_TYPE_VXLAN_DECAP:
+		*roc_type = ROC_NPC_ACTION_TYPE_VOID;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_DROP:
+		*roc_type = ROC_NPC_ACTION_TYPE_DROP;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_PF:
+		*roc_type = ROC_NPC_ACTION_TYPE_PF;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_VF:
+		*roc_type = ROC_NPC_ACTION_TYPE_VF;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_FLAG:
+		*roc_type = ROC_NPC_ACTION_TYPE_FLAG;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_MARK:
+		*roc_type = ROC_NPC_ACTION_TYPE_MARK;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_COUNT:
+		*roc_type = ROC_NPC_ACTION_TYPE_COUNT;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+		*roc_type = ROC_NPC_ACTION_TYPE_QUEUE;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_RSS:
+		*roc_type = ROC_NPC_ACTION_TYPE_RSS;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_OF_POP_VLAN:
+		*roc_type = ROC_NPC_ACTION_TYPE_VLAN_STRIP;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_OF_PUSH_VLAN:
+		*roc_type = ROC_NPC_ACTION_TYPE_VLAN_ETHTYPE_INSERT;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_OF_SET_VLAN_VID:
+		*roc_type = ROC_NPC_ACTION_TYPE_VLAN_INSERT;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_OF_SET_VLAN_PCP:
+		*roc_type = ROC_NPC_ACTION_TYPE_VLAN_PCP_INSERT;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_AGE:
+		*roc_type = ROC_NPC_ACTION_TYPE_AGE;
+		return 0;
+	case RTE_FLOW_ACTION_TYPE_PORT_ID:
+	case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
+	case RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR:
+		*roc_type = ROC_NPC_ACTION_TYPE_PORT_ID;
+		return 0;
+	default:
+		return -1;
+	}
+}
+
+struct rte_flow_actions_template *
+cnxk_flow_actions_template_create(struct rte_eth_dev *eth_dev,
+				  const struct rte_flow_actions_template_attr *attr,
+				  const struct rte_flow_action actions[],
+				  const struct rte_flow_action masks[],
+				  struct rte_flow_error *error)
+{
+	const char *errmsg = "Failed to allocate actions template";
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct cnxk_flow_actions_template *tmpl = NULL;
+	struct roc_npc_actions_template_attr roc_attr;
+	struct roc_npc_action *roc_actions = NULL;
+	int i, nb_actions = 0, errcode = ENOMEM;
+	struct roc_npc *npc = &dev->npc;
+	int roc_err = 0;
+
+	if (attr == NULL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "NULL template attr");
+		return NULL;
+	}
+
+	if (actions == NULL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "NULL actions");
+		return NULL;
+	}
+
+	while (actions[nb_actions].type != RTE_FLOW_ACTION_TYPE_END)
+		nb_actions++;
+
+	/* Reject oversized templates; rules are built into fixed-size stack
+	 * arrays (combined_actions[ROC_NPC_MAX_ACTION_COUNT] plus END).
+	 */
+	if (nb_actions > ROC_NPC_MAX_ACTION_COUNT - 1) {
+		errcode = ENOTSUP;
+		errmsg = "too many actions for hardware";
+		goto err;
+	}
+
+	tmpl = plt_zmalloc(sizeof(*tmpl), 0);
+	if (tmpl == NULL)
+		goto err;
+
+	tmpl->attr = *attr;
+	tmpl->nb_actions = nb_actions;
+
+	tmpl->actions = plt_zmalloc((nb_actions + 1) * sizeof(struct rte_flow_action), 0);
+	if (tmpl->actions == NULL)
+		goto err;
+
+	tmpl->masks = plt_zmalloc((nb_actions + 1) * sizeof(struct rte_flow_action), 0);
+	if (tmpl->masks == NULL)
+		goto err;
+
+	/* up to 2 conf copies (action + mask) per action */
+	tmpl->copies = plt_zmalloc(2 * (nb_actions + 1) * sizeof(void *), 0);
+	if (tmpl->copies == NULL)
+		goto err;
+
+	for (i = 0; i < nb_actions; i++) {
+		enum rte_flow_action_type t = actions[i].type;
+		int sz = cnxk_flow_action_conf_size(t);
+
+		if (sz < 0 && t != RTE_FLOW_ACTION_TYPE_RSS) {
+			errcode = ENOTSUP;
+			errmsg = "Unsupported action in template "
+				 "(supports VOID/DROP/QUEUE/PF/VF/MARK/FLAG/COUNT/RSS/"
+				 "OF_POP_VLAN/OF_PUSH_VLAN/OF_SET_VLAN_VID/"
+				 "OF_SET_VLAN_PCP/AGE/REPRESENTED_PORT/"
+				 "PORT_REPRESENTOR/PORT_ID/VXLAN_DECAP)";
+			goto err;
+		}
+
+		tmpl->actions[i].type = t;
+
+		if (t == RTE_FLOW_ACTION_TYPE_RSS) {
+			/* RSS has nested pointers — use deep-copy helper. */
+			void *copy = cnxk_flow_dup_action_conf(&actions[i]);
+
+			if (copy == NULL && actions[i].conf != NULL) {
+				const struct rte_flow_action_rss *rss = actions[i].conf;
+
+				/* Malformed conf vs allocation failure: report a
+				 * precise errno instead of the default ENOMEM.
+				 */
+				if ((rss->queue_num && rss->queue == NULL) ||
+				    (rss->key_len && rss->key == NULL)) {
+					errcode = EINVAL;
+					errmsg = "Malformed RSS action conf in template";
+				}
+				goto err;
+			}
+			tmpl->actions[i].conf = copy;
+			if (copy)
+				tmpl->copies[tmpl->nb_copies++] = copy;
+		} else {
+			if (cnxk_flow_dup_conf(tmpl->copies, &tmpl->nb_copies, actions[i].conf, sz,
+					       &tmpl->actions[i].conf))
+				goto err;
+		}
+
+		if (masks != NULL) {
+			if (masks[i].type != t) {
+				errcode = EINVAL;
+				errmsg = "actions/masks type mismatch in template";
+				goto err;
+			}
+			tmpl->masks[i].type = t;
+			if (t == RTE_FLOW_ACTION_TYPE_RSS) {
+				/* RSS nests pointers and cannot be copied by the flat
+				 * helper; reject a non-NULL RSS mask.
+				 */
+				if (masks[i].conf != NULL) {
+					errcode = ENOTSUP;
+					errmsg = "Non-NULL RSS mask conf is not "
+						 "supported in template";
+					goto err;
+				}
+				tmpl->masks[i].conf = NULL;
+			} else if (cnxk_flow_dup_conf(tmpl->copies, &tmpl->nb_copies, masks[i].conf,
+						      sz > 0 ? sz : 0, &tmpl->masks[i].conf)) {
+				goto err;
+			}
+		}
+	}
+
+	tmpl->actions[nb_actions].type = RTE_FLOW_ACTION_TYPE_END;
+	tmpl->masks[nb_actions].type = RTE_FLOW_ACTION_TYPE_END;
+	tmpl->roc_tmpl = NULL;
+	tmpl->refcnt = 0;
+
+	/* Mirror only action types into the roc engine for template lifecycle
+	 * and refcount ownership; per-rule conf translation stays in cnxk.
+	 */
+	roc_actions = plt_zmalloc((nb_actions + 1) * sizeof(*roc_actions), 0);
+	if (roc_actions == NULL)
+		goto err;
+
+	for (i = 0; i < nb_actions; i++) {
+		enum roc_npc_action_type rt;
+
+		if (cnxk_flow_roc_action_type(tmpl->actions[i].type, &rt)) {
+			errcode = ENOTSUP;
+			errmsg = "Unsupported action in template";
+			goto err;
+		}
+		roc_actions[i].type = rt;
+		roc_actions[i].conf = NULL;
+	}
+	roc_actions[nb_actions].type = ROC_NPC_ACTION_TYPE_END;
+
+	memset(&roc_attr, 0, sizeof(roc_attr));
+	roc_attr.ingress = attr->ingress;
+	roc_attr.egress = attr->egress;
+	roc_attr.transfer = attr->transfer;
+
+	tmpl->roc_tmpl =
+		roc_npc_actions_template_create(npc, &roc_attr, roc_actions, NULL, &roc_err);
+	plt_free(roc_actions);
+	roc_actions = NULL;
+	if (tmpl->roc_tmpl == NULL) {
+		errcode = (roc_err < 0) ? -roc_err : ENOMEM;
+		errmsg = "Failed to create ROC actions template";
+		goto err;
+	}
+
+	return (struct rte_flow_actions_template *)tmpl;
+
+err:
+	plt_free(roc_actions);
+	if (tmpl != NULL) {
+		uint16_t j;
+		if (tmpl->roc_tmpl != NULL)
+			roc_npc_actions_template_destroy(npc, tmpl->roc_tmpl);
+		for (j = 0; j < tmpl->nb_copies; j++)
+			plt_free(tmpl->copies[j]);
+		plt_free(tmpl->copies);
+		plt_free(tmpl->masks);
+		plt_free(tmpl->actions);
+		plt_free(tmpl);
+	}
+	rte_flow_error_set(error, errcode, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL, errmsg);
+	return NULL;
+}
+
+int
+cnxk_flow_actions_template_destroy(struct rte_eth_dev *eth_dev,
+				   struct rte_flow_actions_template *templ,
+				   struct rte_flow_error *error)
+{
+	struct cnxk_flow_actions_template *tmpl = (struct cnxk_flow_actions_template *)templ;
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc *npc = &dev->npc;
+	uint16_t i;
+	int rc;
+
+	if (tmpl == NULL)
+		return 0;
+
+	if (tmpl->refcnt != 0)
+		return rte_flow_error_set(error, EBUSY, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "actions template still in use by a table");
+
+	rc = roc_npc_actions_template_destroy(npc, tmpl->roc_tmpl);
+	if (rc)
+		return rte_flow_error_set(error, -rc, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "failed to destroy ROC actions template");
+
+	for (i = 0; i < tmpl->nb_copies; i++)
+		plt_free(tmpl->copies[i]);
+	plt_free(tmpl->copies);
+	plt_free(tmpl->masks);
+	plt_free(tmpl->actions);
+	plt_free(tmpl);
+	return 0;
+}
+
+struct rte_flow_template_table *
+cnxk_flow_template_table_create(struct rte_eth_dev *eth_dev,
+				const struct rte_flow_template_table_attr *table_attr,
+				struct rte_flow_pattern_template *pattern_templates[],
+				uint8_t nb_pattern_templates,
+				struct rte_flow_actions_template *actions_templates[],
+				uint8_t nb_actions_templates, struct rte_flow_error *error)
+{
+	struct roc_npc_pattern_template **roc_pattern_templates = NULL;
+	struct roc_npc_actions_template **roc_actions_templates = NULL;
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc_template_table_attr roc_attr;
+	enum rte_flow_table_insertion_type itype;
+	const struct rte_flow_attr *fattr;
+	struct roc_npc *npc = &dev->npc;
+	struct cnxk_flow_table *table;
+	uint32_t nb_flows;
+	int errcode = 0;
+	uint8_t i;
+
+	if (table_attr == NULL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "NULL table_attr");
+		return NULL;
+	}
+
+	itype = table_attr->insertion_type;
+	fattr = &table_attr->flow_attr;
+	nb_flows = table_attr->nb_flows;
+
+	if (itype == RTE_FLOW_TABLE_INSERTION_TYPE_INDEX) {
+		rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "pure-index insertion not supported; NPC is match-based");
+		return NULL;
+	}
+
+	/* Validate the template handles before allocating anything. */
+	for (i = 0; i < nb_pattern_templates; i++) {
+		if (pattern_templates[i] == NULL) {
+			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					   "invalid template handle");
+			return NULL;
+		}
+	}
+	for (i = 0; i < nb_actions_templates; i++) {
+		if (actions_templates[i] == NULL) {
+			rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					   "invalid template handle");
+			return NULL;
+		}
+	}
+
+	table = plt_zmalloc(sizeof(*table), 0);
+	if (table == NULL)
+		goto enomem;
+
+	table->insertion_type = itype;
+	table->nb_flows = nb_flows;
+
+	memset(&table->flow_attr, 0, sizeof(table->flow_attr));
+	table->flow_attr.priority = fattr->priority;
+	table->flow_attr.ingress = fattr->ingress;
+	table->flow_attr.egress = fattr->egress;
+	table->transfer = fattr->transfer;
+
+	if (nb_pattern_templates != 0) {
+		table->pattern_templates =
+			plt_zmalloc(nb_pattern_templates * sizeof(*table->pattern_templates), 0);
+		if (table->pattern_templates == NULL)
+			goto free_table;
+		roc_pattern_templates =
+			plt_zmalloc(nb_pattern_templates * sizeof(*roc_pattern_templates), 0);
+		if (roc_pattern_templates == NULL)
+			goto free_table;
+	}
+	if (nb_actions_templates != 0) {
+		table->actions_templates =
+			plt_zmalloc(nb_actions_templates * sizeof(*table->actions_templates), 0);
+		if (table->actions_templates == NULL)
+			goto free_table;
+		roc_actions_templates =
+			plt_zmalloc(nb_actions_templates * sizeof(*roc_actions_templates), 0);
+		if (roc_actions_templates == NULL)
+			goto free_table;
+	}
+
+	/* Hand the table to the roc engine, which owns rule storage, MCAM
+	 * reservation and the rule lifecycle; cnxk keeps per-rule translation.
+	 */
+	memset(&roc_attr, 0, sizeof(roc_attr));
+	roc_attr.flow_attr = table->flow_attr;
+	roc_attr.transfer = table->transfer;
+	roc_attr.nb_flows = nb_flows;
+	roc_attr.insertion_type = (itype == RTE_FLOW_TABLE_INSERTION_TYPE_INDEX_WITH_PATTERN) ?
+					  ROC_NPC_TEMPLATE_INSERTION_INDEX_WITH_PATTERN :
+					  ROC_NPC_TEMPLATE_INSERTION_PATTERN;
+	/* Stash this wrapper as the table cookie so async_actions_update can
+	 * recover the rte templates from just the flow handle.
+	 */
+	roc_attr.cookie = table;
+
+	for (i = 0; i < nb_pattern_templates; i++) {
+		table->pattern_templates[i] =
+			(struct cnxk_flow_pattern_template *)pattern_templates[i];
+		roc_pattern_templates[i] = table->pattern_templates[i]->roc_tmpl;
+		if (roc_pattern_templates[i] == NULL)
+			goto bad_handle;
+	}
+	for (i = 0; i < nb_actions_templates; i++) {
+		table->actions_templates[i] =
+			(struct cnxk_flow_actions_template *)actions_templates[i];
+		roc_actions_templates[i] = table->actions_templates[i]->roc_tmpl;
+		if (roc_actions_templates[i] == NULL)
+			goto bad_handle;
+	}
+
+	/* clang-format off */
+	table->roc_table = roc_npc_template_table_create(npc, &roc_attr,
+			roc_pattern_templates, nb_pattern_templates,
+			roc_actions_templates, nb_actions_templates, &errcode);
+	/* clang-format on */
+	plt_free(roc_pattern_templates);
+	plt_free(roc_actions_templates);
+	roc_pattern_templates = NULL;
+	roc_actions_templates = NULL;
+	if (table->roc_table == NULL) {
+		plt_free(table->pattern_templates);
+		plt_free(table->actions_templates);
+		plt_free(table);
+		rte_flow_error_set(error, errcode < 0 ? -errcode : ENOMEM,
+				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "could not create template table");
+		return NULL;
+	}
+
+	for (i = 0; i < nb_pattern_templates; i++)
+		table->pattern_templates[i]->refcnt++;
+	table->nb_pattern_templates = nb_pattern_templates;
+	for (i = 0; i < nb_actions_templates; i++)
+		table->actions_templates[i]->refcnt++;
+	table->nb_actions_templates = nb_actions_templates;
+
+	return (struct rte_flow_template_table *)table;
+
+bad_handle:
+	plt_free(roc_pattern_templates);
+	plt_free(roc_actions_templates);
+	plt_free(table->pattern_templates);
+	plt_free(table->actions_templates);
+	plt_free(table);
+	rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			   "invalid template handle");
+	return NULL;
+
+free_table:
+	plt_free(roc_pattern_templates);
+	plt_free(roc_actions_templates);
+	plt_free(table->pattern_templates);
+	plt_free(table->actions_templates);
+	plt_free(table);
+
+enomem:
+	rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL, "out of memory");
+	return NULL;
+}
+
+int
+cnxk_flow_template_table_destroy(struct rte_eth_dev *eth_dev,
+				 struct rte_flow_template_table *tbl_handle,
+				 struct rte_flow_error *error)
+{
+	struct cnxk_flow_table *table = (struct cnxk_flow_table *)tbl_handle;
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc *npc = &dev->npc;
+	uint8_t i;
+	int rc;
+
+	if (table == NULL)
+		return 0;
+
+	/* The roc engine guards teardown: a busy table returns -EBUSY and
+	 * nothing is freed, so the cnxk wrapper and refcounts stay intact.
+	 */
+	rc = roc_npc_template_table_destroy(npc, table->roc_table);
+	if (rc == -EBUSY)
+		return rte_flow_error_set(error, EBUSY, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "table still has live flows; destroy them first");
+	if (rc)
+		return rte_flow_error_set(error, -rc, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "failed to destroy template table");
+
+	for (i = 0; i < table->nb_pattern_templates; i++)
+		table->pattern_templates[i]->refcnt--;
+	for (i = 0; i < table->nb_actions_templates; i++)
+		table->actions_templates[i]->refcnt--;
+
+	plt_free(table->pattern_templates);
+	plt_free(table->actions_templates);
+	plt_free(table);
+	return 0;
+}
+
+/* Reject per-rule pattern/actions arrays whose types/order do not mirror the
+ * chosen templates; the merge takes the type from the template but the
+ * spec/conf from the per-rule array. A NULL array uses template defaults.
+ */
+static int
+cnxk_flow_check_items(const struct cnxk_flow_pattern_template *pt,
+		      const struct rte_flow_item items[])
+{
+	uint16_t k;
+
+	if (items == NULL)
+		return 0;
+	for (k = 0; k < pt->nb_items; k++)
+		if (items[k].type != pt->pattern[k].type)
+			return -EINVAL;
+	if (items[pt->nb_items].type != RTE_FLOW_ITEM_TYPE_END)
+		return -EINVAL;
+	return 0;
+}
+
+static int
+cnxk_flow_check_actions(const struct cnxk_flow_actions_template *at,
+			const struct rte_flow_action actions[])
+{
+	uint16_t k;
+
+	if (actions == NULL)
+		return 0;
+	for (k = 0; k < at->nb_actions; k++)
+		if (actions[k].type != at->actions[k].type)
+			return -EINVAL;
+	if (actions[at->nb_actions].type != RTE_FLOW_ACTION_TYPE_END)
+		return -EINVAL;
+	return 0;
+}
+
+/* Enqueue a PATTERN create: merge the per-rule spec with the templates,
+ * translate to roc_npc types, and hand to the roc engine (programmed at push).
+ */
+struct rte_flow *
+cnxk_flow_async_create(struct rte_eth_dev *eth_dev, uint32_t queue,
+		       const struct rte_flow_op_attr *attr,
+		       struct rte_flow_template_table *tbl_handle,
+		       const struct rte_flow_item items[], uint8_t pattern_template_index,
+		       const struct rte_flow_action actions[], uint8_t action_template_index,
+		       void *user_data, struct rte_flow_error *error)
+{
+	struct cnxk_flow_table *table = (struct cnxk_flow_table *)tbl_handle;
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct cnxk_flow_pattern_template *pt;
+	struct cnxk_flow_actions_template *at;
+	struct roc_npc_template_flow *flow;
+	struct roc_npc *npc = &dev->npc;
+
+	uint64_t free_allocs[ROC_NPC_MAX_ACTION_COUNT + ROC_NPC_ITEM_TYPE_END + 1] = {0};
+	struct roc_npc_item_info in_pattern[ROC_NPC_ITEM_TYPE_END + 1] = {0};
+	struct rte_flow_action combined_actions[ROC_NPC_MAX_ACTION_COUNT];
+	struct roc_npc_action in_actions[ROC_NPC_MAX_ACTION_COUNT] = {0};
+	struct rte_flow_item combined_items[ROC_NPC_ITEM_TYPE_END + 1];
+	struct roc_npc_action_sample in_sample = {0};
+	struct rte_flow_attr rte_attr;
+	struct roc_npc_attr in_attr;
+	uint16_t dst_pf_func = 0;
+	uint64_t def_action = 0;
+	int errcode = 0;
+	uint16_t k;
+	int rc, j;
+
+	RTE_SET_USED(attr);
+
+	if (table == NULL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "bad table");
+		return NULL;
+	}
+	if (table->insertion_type != RTE_FLOW_TABLE_INSERTION_TYPE_PATTERN) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "table is index-insertion; use create_by_index_with_pattern");
+		return NULL;
+	}
+	if (pattern_template_index >= table->nb_pattern_templates ||
+	    action_template_index >= table->nb_actions_templates) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "template index out of range");
+		return NULL;
+	}
+
+	pt = table->pattern_templates[pattern_template_index];
+	at = table->actions_templates[action_template_index];
+
+	if (cnxk_flow_check_items(pt, items) != 0 || cnxk_flow_check_actions(at, actions) != 0) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "pattern/actions do not match the selected templates");
+		return NULL;
+	}
+
+	/* Merge: spec comes from the per-rule call, last/mask from the template. */
+	for (k = 0; k < pt->nb_items; k++) {
+		combined_items[k].type = pt->pattern[k].type;
+		combined_items[k].spec = items ? items[k].spec : NULL;
+		combined_items[k].last = pt->pattern[k].last;
+		combined_items[k].mask = pt->pattern[k].mask;
+	}
+	combined_items[pt->nb_items].type = RTE_FLOW_ITEM_TYPE_END;
+
+	/* Merge: per-rule conf overrides the template conf. */
+	for (k = 0; k < at->nb_actions; k++) {
+		combined_actions[k].type = at->actions[k].type;
+		combined_actions[k].conf =
+			(actions && actions[k].conf) ? actions[k].conf : at->actions[k].conf;
+	}
+	combined_actions[at->nb_actions].type = RTE_FLOW_ACTION_TYPE_END;
+
+	memset(&rte_attr, 0, sizeof(rte_attr));
+	rte_attr.priority = table->flow_attr.priority;
+	rte_attr.ingress = table->flow_attr.ingress;
+	rte_attr.egress = table->flow_attr.egress;
+	rte_attr.transfer = table->transfer;
+
+	/* Translate into roc_npc types. The RSS flow key is stashed in
+	 * npc->flowkey_cfg_state so the engine can restore it at push().
+	 */
+	memset(&in_attr, 0, sizeof(in_attr));
+	rc = cnxk_map_flow_data(eth_dev, &rte_attr, combined_items, combined_actions, &in_attr,
+				in_pattern, in_actions, &in_sample, &npc->flowkey_cfg_state,
+				&dst_pf_func, &def_action, false, free_allocs, 0);
+	if (rc == 0)
+		flow = roc_npc_async_flow_create(npc, queue, table->roc_table, in_pattern,
+						 in_actions, dst_pf_func, def_action, user_data,
+						 &errcode);
+	else
+		flow = NULL;
+
+	for (j = 0; j < (int)RTE_DIM(free_allocs) && free_allocs[j]; j++)
+		plt_free((void *)free_allocs[j]);
+
+	if (rc != 0) {
+		rte_flow_error_set(error, rc < 0 ? -rc : rc, RTE_FLOW_ERROR_TYPE_ACTION_NUM, NULL,
+				   "Failed to map flow data");
+		return NULL;
+	}
+	if (flow == NULL) {
+		rte_flow_error_set(error, errcode < 0 ? -errcode : EINVAL,
+				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "async flow create failed");
+		return NULL;
+	}
+
+	return (struct rte_flow *)flow;
+}
+
+/* Enqueue a destroy operation. */
+int
+cnxk_flow_async_destroy(struct rte_eth_dev *eth_dev, uint32_t queue,
+			const struct rte_flow_op_attr *attr, struct rte_flow *flow, void *user_data,
+			struct rte_flow_error *error)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc *npc = &dev->npc;
+	int rc;
+
+	RTE_SET_USED(attr);
+
+	rc = roc_npc_async_flow_destroy(npc, queue, (struct roc_npc_template_flow *)flow,
+					user_data);
+	if (rc)
+		return rte_flow_error_set(error, -rc, RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					  "bad queue or flow handle");
+	return 0;
+}
+
+/* Flush all pending async operations to hardware in one batch. */
+int
+cnxk_flow_push(struct rte_eth_dev *eth_dev, uint32_t queue, struct rte_flow_error *error)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc *npc = &dev->npc;
+	int rc;
+
+	rc = roc_npc_flow_push(npc, queue);
+	if (rc)
+		return rte_flow_error_set(error, -rc, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "bad queue");
+	return 0;
+}
+
+/* Return results for completed ops back to the application. */
+int
+cnxk_flow_pull(struct rte_eth_dev *eth_dev, uint32_t queue, struct rte_flow_op_result res[],
+	       uint16_t n_res, struct rte_flow_error *error)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct roc_npc *npc = &dev->npc;
+	uint16_t done = 0;
+
+	/* Drain roc engine results in fixed-size batches, translating each
+	 * roc op result into the rte op result without a per-pull allocation.
+	 */
+	while (done < n_res) {
+		struct roc_npc_flow_op_result rres[64];
+		uint16_t batch = RTE_MIN((uint16_t)(n_res - done), (uint16_t)RTE_DIM(rres));
+		int got = roc_npc_flow_pull(npc, queue, rres, batch);
+		uint16_t k;
+
+		if (got < 0) {
+			if (done != 0)
+				break;
+			return rte_flow_error_set(error, -got, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+						  NULL, "bad queue");
+		}
+
+		for (k = 0; k < (uint16_t)got; k++) {
+			res[done + k].status =
+				(rres[k].rc == 0) ? RTE_FLOW_OP_SUCCESS : RTE_FLOW_OP_ERROR;
+			res[done + k].user_data = rres[k].user_data;
+		}
+		done += (uint16_t)got;
+
+		if (got < batch)
+			break;
+	}
+
+	return done;
+}
+
+struct rte_flow *
+cnxk_flow_async_create_by_index(struct rte_eth_dev *eth_dev, uint32_t queue,
+				const struct rte_flow_op_attr *attr,
+				struct rte_flow_template_table *table, uint32_t rule_index,
+				const struct rte_flow_action actions[],
+				uint8_t action_template_index, void *user_data,
+				struct rte_flow_error *error)
+{
+	RTE_SET_USED(eth_dev);
+	RTE_SET_USED(queue);
+	RTE_SET_USED(attr);
+	RTE_SET_USED(table);
+	RTE_SET_USED(rule_index);
+	RTE_SET_USED(actions);
+	RTE_SET_USED(action_template_index);
+	RTE_SET_USED(user_data);
+
+	rte_flow_error_set(error, ENOTSUP, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+			   "index-only insertion needs a match key; NPC is match-based");
+	return NULL;
+}
+
+/* Like async_create but with an app-specified index; the app must avoid
+ * concurrent creates to the same index and use a valid table index.
+ */
+struct rte_flow *
+/* clang-format off */
+cnxk_flow_async_create_by_index_with_pattern(struct rte_eth_dev *eth_dev,
+		uint32_t queue, const struct rte_flow_op_attr *attr,
+		struct rte_flow_template_table *tbl_handle, uint32_t rule_index,
+		const struct rte_flow_item items[], uint8_t pattern_template_index,
+		const struct rte_flow_action actions[],
+		uint8_t action_template_index, void *user_data,
+		struct rte_flow_error *error)
+/* clang-format on */
+{
+	struct cnxk_flow_table *table = (struct cnxk_flow_table *)tbl_handle;
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct cnxk_flow_pattern_template *pt;
+	struct cnxk_flow_actions_template *at;
+	struct roc_npc_template_flow *flow;
+	struct roc_npc *npc = &dev->npc;
+
+	uint64_t free_allocs[ROC_NPC_MAX_ACTION_COUNT + ROC_NPC_ITEM_TYPE_END + 1] = {0};
+	struct roc_npc_item_info in_pattern[ROC_NPC_ITEM_TYPE_END + 1] = {0};
+	struct rte_flow_action combined_actions[ROC_NPC_MAX_ACTION_COUNT];
+	struct roc_npc_action in_actions[ROC_NPC_MAX_ACTION_COUNT] = {0};
+	struct rte_flow_item combined_items[ROC_NPC_ITEM_TYPE_END + 1];
+	struct roc_npc_action_sample in_sample = {0};
+	struct rte_flow_attr rte_attr;
+	struct roc_npc_attr in_attr;
+	uint32_t flowkey_cfg = 0;
+	uint16_t dst_pf_func = 0;
+	uint64_t def_action = 0;
+	int errcode = 0;
+	uint16_t k;
+	int rc, j;
+
+	RTE_SET_USED(attr);
+
+	if (table == NULL) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "bad table");
+		return NULL;
+	}
+	if (table->insertion_type != RTE_FLOW_TABLE_INSERTION_TYPE_INDEX_WITH_PATTERN) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "table is not index-with-pattern insertion");
+		return NULL;
+	}
+	if (pattern_template_index >= table->nb_pattern_templates ||
+	    action_template_index >= table->nb_actions_templates) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "template index out of range");
+		return NULL;
+	}
+	if (rule_index >= table->nb_flows) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "rule_index out of range");
+		return NULL;
+	}
+
+	pt = table->pattern_templates[pattern_template_index];
+	at = table->actions_templates[action_template_index];
+
+	if (cnxk_flow_check_items(pt, items) != 0 || cnxk_flow_check_actions(at, actions) != 0) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "pattern/actions do not match the selected templates");
+		return NULL;
+	}
+
+	for (k = 0; k < pt->nb_items; k++) {
+		combined_items[k].type = pt->pattern[k].type;
+		combined_items[k].spec = items ? items[k].spec : NULL;
+		combined_items[k].last = pt->pattern[k].last;
+		combined_items[k].mask = pt->pattern[k].mask;
+	}
+	combined_items[pt->nb_items].type = RTE_FLOW_ITEM_TYPE_END;
+
+	for (k = 0; k < at->nb_actions; k++) {
+		combined_actions[k].type = at->actions[k].type;
+		combined_actions[k].conf =
+			(actions && actions[k].conf) ? actions[k].conf : at->actions[k].conf;
+	}
+	combined_actions[at->nb_actions].type = RTE_FLOW_ACTION_TYPE_END;
+
+	memset(&rte_attr, 0, sizeof(rte_attr));
+	rte_attr.priority = table->flow_attr.priority;
+	rte_attr.ingress = table->flow_attr.ingress;
+	rte_attr.egress = table->flow_attr.egress;
+	rte_attr.transfer = table->transfer;
+
+	memset(&in_attr, 0, sizeof(in_attr));
+	rc = cnxk_map_flow_data(eth_dev, &rte_attr, combined_items, combined_actions, &in_attr,
+				in_pattern, in_actions, &in_sample, &flowkey_cfg, &dst_pf_func,
+				&def_action, false, free_allocs, 0);
+	if (rc == 0)
+		/* clang-format off */
+		flow = roc_npc_async_flow_create_by_index_with_pattern(npc, queue,
+				table->roc_table, rule_index, in_pattern, in_actions,
+				user_data, &errcode);
+	/* clang-format on */
+	else
+		flow = NULL;
+
+	for (j = 0; j < (int)RTE_DIM(free_allocs) && free_allocs[j]; j++)
+		plt_free((void *)free_allocs[j]);
+
+	if (rc != 0) {
+		rte_flow_error_set(error, rc < 0 ? -rc : rc, RTE_FLOW_ERROR_TYPE_ACTION_NUM, NULL,
+				   "Failed to map flow data");
+		return NULL;
+	}
+	if (flow == NULL) {
+		rte_flow_error_set(error, errcode < 0 ? -errcode : EINVAL,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL, "flow parse failed");
+		return NULL;
+	}
+
+	return (struct rte_flow *)flow;
+}
+
+/* Update the actions of an existing flow, keeping key/mask/mcam_id/enable. */
+int
+cnxk_flow_async_actions_update(struct rte_eth_dev *eth_dev, uint32_t queue,
+			       const struct rte_flow_op_attr *attr, struct rte_flow *flow,
+			       const struct rte_flow_action actions[],
+			       uint8_t action_template_index, void *user_data,
+			       struct rte_flow_error *error)
+{
+	struct cnxk_eth_dev *dev = cnxk_eth_pmd_priv(eth_dev);
+	struct cnxk_flow_actions_template *at;
+	struct roc_npc *npc = &dev->npc;
+	struct cnxk_flow_table *table;
+
+	uint64_t free_allocs[ROC_NPC_MAX_ACTION_COUNT + ROC_NPC_ITEM_TYPE_END + 1] = {0};
+	struct roc_npc_item_info in_pattern[ROC_NPC_ITEM_TYPE_END + 1] = {0};
+	struct rte_flow_action combined_actions[ROC_NPC_MAX_ACTION_COUNT];
+	struct roc_npc_action in_actions[ROC_NPC_MAX_ACTION_COUNT] = {0};
+	struct roc_npc_action_sample in_sample = {0};
+	struct rte_flow_item end_pattern[1];
+	struct rte_flow_attr rte_attr;
+	struct roc_npc_attr in_attr;
+	uint32_t flowkey_cfg = 0;
+	uint16_t dst_pf_func = 0;
+	uint64_t def_action = 0;
+	uint16_t k;
+	int rc, j;
+
+	RTE_SET_USED(attr);
+
+	if (flow == NULL)
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					  "bad flow handle");
+
+	/* Recover the cnxk table context from the cookie the engine kept for
+	 * this rule's table.
+	 */
+	table = roc_npc_async_flow_table_cookie((struct roc_npc_template_flow *)flow);
+	if (table == NULL)
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					  "flow handle has no associated table");
+	if (action_template_index >= table->nb_actions_templates)
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+					  "actions template index out of range");
+
+	at = table->actions_templates[action_template_index];
+
+	if (cnxk_flow_check_actions(at, actions) != 0)
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+					  "actions do not match the selected template");
+
+	for (k = 0; k < at->nb_actions; k++) {
+		combined_actions[k].type = at->actions[k].type;
+		combined_actions[k].conf =
+			(actions && actions[k].conf) ? actions[k].conf : at->actions[k].conf;
+	}
+	combined_actions[at->nb_actions].type = RTE_FLOW_ACTION_TYPE_END;
+
+	end_pattern[0].type = RTE_FLOW_ITEM_TYPE_END;
+
+	memset(&rte_attr, 0, sizeof(rte_attr));
+	rte_attr.priority = table->flow_attr.priority;
+	rte_attr.ingress = table->flow_attr.ingress;
+	rte_attr.egress = table->flow_attr.egress;
+	rte_attr.transfer = table->transfer;
+
+	memset(&in_attr, 0, sizeof(in_attr));
+	rc = cnxk_map_flow_data(eth_dev, &rte_attr, end_pattern, combined_actions, &in_attr,
+				in_pattern, in_actions, &in_sample, &flowkey_cfg, &dst_pf_func,
+				&def_action, false, free_allocs, 0);
+	if (rc == 0)
+		/* clang-format off */
+		rc = roc_npc_async_flow_actions_update(npc, queue,
+				(struct roc_npc_template_flow *)flow, in_actions, user_data);
+	/* clang-format on */
+
+	for (j = 0; j < (int)RTE_DIM(free_allocs) && free_allocs[j]; j++)
+		plt_free((void *)free_allocs[j]);
+
+	if (rc != 0)
+		return rte_flow_error_set(error, rc < 0 ? -rc : EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+					  NULL, "failed to update flow actions");
+
+	return 0;
+}
 
 static int
 cnxk_flow_dev_dump(struct rte_eth_dev *eth_dev, struct rte_flow *flow, FILE *file,
diff --git a/drivers/net/cnxk/cnxk_flow.h b/drivers/net/cnxk/cnxk_flow.h
index 2986ea81d1..2202f4f3b8 100644
--- a/drivers/net/cnxk/cnxk_flow.h
+++ b/drivers/net/cnxk/cnxk_flow.h
@@ -48,4 +48,81 @@ int cnxk_flow_dev_dump_common(struct rte_eth_dev *eth_dev, struct rte_flow *flow
 			      struct rte_flow_error *error, bool is_rep);
 int cnxk_mtr_destroy(struct rte_eth_dev *eth_dev, uint32_t mtr_id);
 
+int cnxk_flow_configure(struct rte_eth_dev *eth_dev, const struct rte_flow_port_attr *port_attr,
+			uint16_t nb_queue, const struct rte_flow_queue_attr *queue_attr[],
+			struct rte_flow_error *err);
+
+/* clang-format off */
+struct rte_flow_pattern_template *cnxk_flow_pattern_template_create(struct rte_eth_dev *eth_dev,
+		const struct rte_flow_pattern_template_attr *attr,
+		const struct rte_flow_item pattern[],
+		struct rte_flow_error *error);
+/* clang-format on */
+
+int cnxk_flow_pattern_template_destroy(struct rte_eth_dev *eth_dev,
+				       struct rte_flow_pattern_template *templ,
+				       struct rte_flow_error *error);
+
+/* clang-format off */
+struct rte_flow_actions_template *cnxk_flow_actions_template_create(struct rte_eth_dev *eth_dev,
+		const struct rte_flow_actions_template_attr *attr,
+		const struct rte_flow_action actions[],
+		const struct rte_flow_action masks[],
+		struct rte_flow_error *error);
+/* clang-format on */
+
+int cnxk_flow_actions_template_destroy(struct rte_eth_dev *eth_dev,
+				       struct rte_flow_actions_template *templ,
+				       struct rte_flow_error *error);
+
+/* clang-format off */
+struct rte_flow_template_table *cnxk_flow_template_table_create(struct rte_eth_dev *eth_dev,
+		const struct rte_flow_template_table_attr *table_attr,
+		struct rte_flow_pattern_template *pattern_templates[],
+		uint8_t nb_pattern_templates,
+		struct rte_flow_actions_template *actions_templates[],
+		uint8_t nb_actions_templates,
+		struct rte_flow_error *error);
+/* clang-format on */
+
+int cnxk_flow_template_table_destroy(struct rte_eth_dev *eth_dev,
+				     struct rte_flow_template_table *tbl_handle,
+				     struct rte_flow_error *error);
+struct rte_flow *
+cnxk_flow_async_create(struct rte_eth_dev *eth_dev, uint32_t queue,
+		       const struct rte_flow_op_attr *attr, struct rte_flow_template_table *table,
+		       const struct rte_flow_item items[], uint8_t pattern_template_index,
+		       const struct rte_flow_action actions[], uint8_t action_template_index,
+		       void *user_data, struct rte_flow_error *error);
+int cnxk_flow_async_destroy(struct rte_eth_dev *eth_dev, uint32_t queue,
+			    const struct rte_flow_op_attr *attr, struct rte_flow *flow,
+			    void *user_data, struct rte_flow_error *error);
+
+int cnxk_flow_push(struct rte_eth_dev *eth_dev, uint32_t queue, struct rte_flow_error *error);
+int cnxk_flow_pull(struct rte_eth_dev *eth_dev, uint32_t queue, struct rte_flow_op_result res[],
+		   uint16_t n_res, struct rte_flow_error *error);
+
+struct rte_flow *cnxk_flow_async_create_by_index(struct rte_eth_dev *eth_dev, uint32_t queue,
+						 const struct rte_flow_op_attr *attr,
+						 struct rte_flow_template_table *table,
+						 uint32_t rule_index,
+						 const struct rte_flow_action actions[],
+						 uint8_t action_template_index, void *user_data,
+						 struct rte_flow_error *error);
+
+/* clang-format off */
+struct rte_flow *cnxk_flow_async_create_by_index_with_pattern(struct rte_eth_dev *eth_dev,
+		uint32_t queue, const struct rte_flow_op_attr *attr,
+		struct rte_flow_template_table *tbl_handle, uint32_t rule_index,
+		const struct rte_flow_item items[], uint8_t pattern_template_index,
+		const struct rte_flow_action actions[],
+		uint8_t action_template_index, void *user_data,
+		struct rte_flow_error *error);
+/* clang-format on */
+
+int cnxk_flow_async_actions_update(struct rte_eth_dev *eth_dev, uint32_t queue,
+				   const struct rte_flow_op_attr *attr, struct rte_flow *flow,
+				   const struct rte_flow_action actions[],
+				   uint8_t action_template_index, void *user_data,
+				   struct rte_flow_error *error);
 #endif /* __CNXK_RTE_FLOW_H__ */
-- 
2.43.0

