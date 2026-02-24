Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B4FD375F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 13:58:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 455744027F;
	Wed, 25 Feb 2026 14:58:30 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id 57386400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 11:58:20 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b885e8c6727so941008466b.1
 for <dev@dpdk.org>; Tue, 24 Feb 2026 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771930700; x=1772535500; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bRtjTRzI9cngdjtQhMq/+QPcmMIKfD+w1x6CUgT43mY=;
 b=F6LVltjWnc0Pwk9BQwSA/HtN4U+w7LCcU1WUY7Net+YaZx50QpGYZ9OI8GXzKfkeK9
 6iZiap+JHnRNXRPdO/2Rxiubx77zBlovdLa899G1hnu48IdpCYI2ZTireWr6mL+UU1qr
 III4ysWD+XX0ff930ogq/dqj87je/lQ7lDNfTfV79vW1EVxd6Dy358iPkhgMTrNv5miH
 ZLrKCgPe5ff4L9zycgyRvvGjb4QFedtWgPW+v/45chyNF5W78QwLe4vSCGvOM7LkbUNQ
 A8SFYPLagSI4sYVOGQZpnDDbNsoVOtK9yVu8r6q2XvyCi8dk1SIDsEdqTtwG+SnnMEFp
 lSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771930700; x=1772535500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRtjTRzI9cngdjtQhMq/+QPcmMIKfD+w1x6CUgT43mY=;
 b=o8VHMSbZCfz8WfoLtTcF/1f8rq30BHztWqEcABuY2rANCZ/6DMtD8soTMbAUX48syH
 74/S0imEZP4iEb9lNP1N18ng0Vu+AR6dw+IQ+30vpq1CAutVaTQUU8MYzHjjMKOKcmFd
 NqD/+4mUOT4ZWj4OBfdll3UxIme58L020kOdSmyH3G905zN4KSMkVWjkawg9JTfUx+uS
 yV17F2mgrjMto0uDG2iC6QpBfRumVDT6rY70ZkfM5Qh9kY06TOJToLXJtzbahRuUtvQv
 mevx/YsLFMEvCH1MBMSodbPf8SzE9tLVH2NPpEoNP549+IHs/Gxfba3QFZ0xvyTjBOYw
 kVpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOP86L4XQAPKW0OKWEIZkqr/DbF/6nrVnVZpisLORPIk4xQT+NjtcgSVjPo1H99uM5Gek=@dpdk.org
X-Gm-Message-State: AOJu0YxRDnf2nh2zHGRipXFJwAhbJ29xnj/KHc/OiaXwlQjTP7bgt73p
 4XhSHICPGnkj7shTDRMlUwvPxR3iT9uepUhysBAaGyCUuEn95MH+BpK/hsVrTZ2K+q+eyQ==
X-Gm-Gg: ATEYQzzE5BouSesBp6PK2urv8+UOJgiV6eLWsEmFOFLhnP7Qi1UKzSTmuaBtTNTlk7n
 7wmB3MlN/d6QiUAsrelw1j4pM44Dij2JJr3fptIbfe5hZE+Yuz0OL1d6HP3tXAIkV2u/RImDT53
 /beJFhRjMUhrLjlZoepP0IKHY4jI9/AaeN+dhxlMRB+Y1KDR+Qn/nkKYgoGH0MCfMyLNcpP07a5
 o0loEGuOBcP0rcZ+hg8XDwGYM5hYHFdES9HRE1nq5hg4y+MBvSlsGlZMoqv1PoeWD1J+I8XdkhG
 fxSmwjsZNfri+XHY2I4cBi+9gOF44pfQKUrmJqUrghpP2lraRsLejFS4GJJKOG8K0MejwJAzzfN
 /5lOT2VoFb+uGrGBTm+Stg8Zl0cxCUCHSI3T5lpEt4GZobdq/31NyyAs818FN0iGKCNeUq35tTi
 JBC6f8S8waJeIfsYJBekhN6qt6kQnJ5xLRqgrwEzRtaL5fR4EME9WrcfHTtUAr7zj2hG5EEl2Nc
 w==
X-Received: by 2002:a17:907:9602:b0:b8f:c684:db37 with SMTP id
 a640c23a62f3a-b9080f13fafmr727744366b.9.1771930699333; 
 Tue, 24 Feb 2026 02:58:19 -0800 (PST)
Received: from work.cisco.com ([2603:5004:20a0:100c:48a2:56cc:e25:25dc])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084e4bfe6sm410674866b.44.2026.02.24.02.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 02:58:18 -0800 (PST)
From: Maxime Peim <maxime.peim@gmail.com>
To: Wisam Jaddo <wisamm@nvidia.com>
Cc: Maxime Peim <maxime.peim@gmail.com>,
	dev@dpdk.org
Subject: [PATCH] test/flow: add support for async API
Date: Tue, 24 Feb 2026 11:56:47 +0100
Message-ID: <20260224105712.937285-2-maxime.peim@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:58:29 +0100
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

Add async flow API mode to test-flow-perf application for improved
flow rule insertion performance. The async API allows batching flow
rule creation operations and processing completions in bulk, reducing
per-rule overhead.

New command line options:
  --async: enable async flow API mode
  --async-queue-size=N: size of async queues (default: 1024)
  --async-push-batch=N: flows to batch before push (default: 256)

Signed-off-by: Maxime Peim <maxime.peim@gmail.com>
---
 app/test-flow-perf/actions_gen.c | 172 +++++++++++++
 app/test-flow-perf/actions_gen.h |   4 +
 app/test-flow-perf/async_flow.c  | 239 ++++++++++++++++++
 app/test-flow-perf/async_flow.h  |  41 ++++
 app/test-flow-perf/items_gen.c   |  13 +
 app/test-flow-perf/items_gen.h   |   4 +
 app/test-flow-perf/main.c        | 410 ++++++++++++++++++++++++-------
 app/test-flow-perf/meson.build   |   1 +
 8 files changed, 798 insertions(+), 86 deletions(-)
 create mode 100644 app/test-flow-perf/async_flow.c
 create mode 100644 app/test-flow-perf/async_flow.h

diff --git a/app/test-flow-perf/actions_gen.c b/app/test-flow-perf/actions_gen.c
index 9d102e3af4..af5ed2b30a 100644
--- a/app/test-flow-perf/actions_gen.c
+++ b/app/test-flow-perf/actions_gen.c
@@ -1165,3 +1165,175 @@ fill_actions(struct rte_flow_action *actions, uint64_t *flow_actions,
 	free(queues);
 	free(hairpin_queues);
 }
+
+void
+fill_actions_template(struct rte_flow_action *actions, struct rte_flow_action *masks,
+		      uint64_t *flow_actions, bool *need_wire_orig_table)
+{
+	uint8_t actions_counter = 0;
+	uint8_t i, j;
+
+	*need_wire_orig_table = false;
+
+	/* Static configurations for actions that need them in templates */
+	static struct rte_flow_action_mark mark_conf = {
+		.id = 1,
+	};
+	static struct rte_flow_action_queue queue_conf = {
+		.index = 0,
+	};
+	static struct rte_flow_action_port_id port_id_conf = {
+		.id = 0,
+	};
+	static struct rte_flow_action_jump jump_conf = {
+		.group = 1,
+	};
+	static struct rte_flow_action_modify_field set_meta_conf = {
+		.operation = RTE_FLOW_MODIFY_SET,
+		.dst =
+			{
+				.field = RTE_FLOW_FIELD_META,
+			},
+		.src =
+			{
+				.field = RTE_FLOW_FIELD_VALUE,
+				.value = {0, 0, 0, META_DATA},
+			},
+		.width = 32,
+	};
+
+	/* Static mask configurations for each action type */
+	static struct rte_flow_action_mark mark_mask = {
+		.id = UINT32_MAX,
+	};
+	static struct rte_flow_action_queue queue_mask = {
+		.index = UINT16_MAX,
+	};
+	static struct rte_flow_action_jump jump_mask = {
+		.group = UINT32_MAX,
+	};
+	static struct rte_flow_action_rss rss_mask = {
+		.level = UINT32_MAX,
+		.types = UINT64_MAX,
+	};
+	static struct rte_flow_action_set_meta set_meta_mask = {
+		.data = UINT32_MAX,
+		.mask = UINT32_MAX,
+	};
+	static struct rte_flow_action_set_tag set_tag_mask = {
+		.data = UINT32_MAX,
+		.mask = UINT32_MAX,
+		.index = UINT8_MAX,
+	};
+	static struct rte_flow_action_port_id port_id_mask = {
+		.id = UINT32_MAX,
+	};
+	static struct rte_flow_action_count count_mask;
+	static struct rte_flow_action_set_mac set_mac_mask = {
+		.mac_addr = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff},
+	};
+	static struct rte_flow_action_set_ipv4 set_ipv4_mask = {
+		.ipv4_addr = UINT32_MAX,
+	};
+	static struct rte_flow_action_set_ipv6 set_ipv6_mask;
+	static struct rte_flow_action_set_tp set_tp_mask = {
+		.port = UINT16_MAX,
+	};
+	static rte_be32_t tcp_seq_ack_mask = UINT32_MAX;
+	static struct rte_flow_action_set_ttl set_ttl_mask = {
+		.ttl_value = UINT8_MAX,
+	};
+	static struct rte_flow_action_set_dscp set_dscp_mask = {
+		.dscp = UINT8_MAX,
+	};
+	static struct rte_flow_action_meter meter_mask = {
+		.mtr_id = UINT32_MAX,
+	};
+
+	/* Initialize ipv6 mask */
+	memset(set_ipv6_mask.ipv6_addr.a, 0xff, 16);
+
+	static const struct {
+		uint64_t flow_mask;
+		enum rte_flow_action_type type;
+		const void *action_conf;
+		const void *action_mask;
+		const bool need_wire_orig_table;
+	} template_actions[] = {
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_MARK), RTE_FLOW_ACTION_TYPE_MARK, &mark_conf,
+		 &mark_mask, true},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_COUNT), RTE_FLOW_ACTION_TYPE_COUNT, NULL,
+		 &count_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_MODIFY_FIELD),
+		 RTE_FLOW_ACTION_TYPE_MODIFY_FIELD, &set_meta_conf, &set_meta_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_TAG), RTE_FLOW_ACTION_TYPE_SET_TAG, NULL,
+		 &set_tag_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_FLAG), RTE_FLOW_ACTION_TYPE_FLAG, NULL, NULL,
+		 false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_MAC_SRC),
+		 RTE_FLOW_ACTION_TYPE_SET_MAC_SRC, NULL, &set_mac_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_MAC_DST),
+		 RTE_FLOW_ACTION_TYPE_SET_MAC_DST, NULL, &set_mac_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV4_SRC),
+		 RTE_FLOW_ACTION_TYPE_SET_IPV4_SRC, NULL, &set_ipv4_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV4_DST),
+		 RTE_FLOW_ACTION_TYPE_SET_IPV4_DST, NULL, &set_ipv4_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV6_SRC),
+		 RTE_FLOW_ACTION_TYPE_SET_IPV6_SRC, NULL, &set_ipv6_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV6_DST),
+		 RTE_FLOW_ACTION_TYPE_SET_IPV6_DST, NULL, &set_ipv6_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_TP_SRC), RTE_FLOW_ACTION_TYPE_SET_TP_SRC,
+		 NULL, &set_tp_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_TP_DST), RTE_FLOW_ACTION_TYPE_SET_TP_DST,
+		 NULL, &set_tp_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_INC_TCP_ACK),
+		 RTE_FLOW_ACTION_TYPE_INC_TCP_ACK, NULL, &tcp_seq_ack_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_DEC_TCP_ACK),
+		 RTE_FLOW_ACTION_TYPE_DEC_TCP_ACK, NULL, &tcp_seq_ack_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_INC_TCP_SEQ),
+		 RTE_FLOW_ACTION_TYPE_INC_TCP_SEQ, NULL, &tcp_seq_ack_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_DEC_TCP_SEQ),
+		 RTE_FLOW_ACTION_TYPE_DEC_TCP_SEQ, NULL, &tcp_seq_ack_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_TTL), RTE_FLOW_ACTION_TYPE_SET_TTL, NULL,
+		 &set_ttl_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_DEC_TTL), RTE_FLOW_ACTION_TYPE_DEC_TTL, NULL,
+		 NULL, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV4_DSCP),
+		 RTE_FLOW_ACTION_TYPE_SET_IPV4_DSCP, NULL, &set_dscp_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_SET_IPV6_DSCP),
+		 RTE_FLOW_ACTION_TYPE_SET_IPV6_DSCP, NULL, &set_dscp_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_QUEUE), RTE_FLOW_ACTION_TYPE_QUEUE,
+		 &queue_conf, &queue_mask, true},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_RSS), RTE_FLOW_ACTION_TYPE_RSS, NULL,
+		 &rss_mask, true},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_JUMP), RTE_FLOW_ACTION_TYPE_JUMP, &jump_conf,
+		 &jump_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_PORT_ID), RTE_FLOW_ACTION_TYPE_PORT_ID,
+		 &port_id_conf, &port_id_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_DROP), RTE_FLOW_ACTION_TYPE_DROP, NULL, NULL,
+		 false},
+		{HAIRPIN_QUEUE_ACTION, RTE_FLOW_ACTION_TYPE_QUEUE, &queue_conf, &queue_mask, false},
+		{HAIRPIN_RSS_ACTION, RTE_FLOW_ACTION_TYPE_RSS, NULL, &rss_mask, false},
+		{FLOW_ACTION_MASK(RTE_FLOW_ACTION_TYPE_METER), RTE_FLOW_ACTION_TYPE_METER, NULL,
+		 &meter_mask, false},
+	};
+
+	for (j = 0; j < MAX_ACTIONS_NUM; j++) {
+		if (flow_actions[j] == 0)
+			break;
+		for (i = 0; i < RTE_DIM(template_actions); i++) {
+			if ((flow_actions[j] & template_actions[i].flow_mask) == 0)
+				continue;
+			actions[actions_counter].type = template_actions[i].type;
+			actions[actions_counter].conf = template_actions[i].action_conf;
+			masks[actions_counter].type = template_actions[i].type;
+			masks[actions_counter].conf = template_actions[i].action_mask;
+			*need_wire_orig_table |= template_actions[i].need_wire_orig_table;
+			actions_counter++;
+			break;
+		}
+	}
+
+	actions[actions_counter].type = RTE_FLOW_ACTION_TYPE_END;
+	masks[actions_counter].type = RTE_FLOW_ACTION_TYPE_END;
+}
diff --git a/app/test-flow-perf/actions_gen.h b/app/test-flow-perf/actions_gen.h
index 9e13b164f9..7450d45ef7 100644
--- a/app/test-flow-perf/actions_gen.h
+++ b/app/test-flow-perf/actions_gen.h
@@ -22,4 +22,8 @@ void fill_actions(struct rte_flow_action *actions, uint64_t *flow_actions,
 	uint64_t encap_data, uint64_t decap_data, uint8_t core_idx,
 	bool unique_data, uint8_t rx_queues_count, uint16_t dst_port);
 
+/* Fill actions template for async flow API (types only, no values) */
+void fill_actions_template(struct rte_flow_action *actions, struct rte_flow_action *masks,
+			   uint64_t *flow_actions, bool *need_wire_orig_table);
+
 #endif /* FLOW_PERF_ACTION_GEN */
diff --git a/app/test-flow-perf/async_flow.c b/app/test-flow-perf/async_flow.c
new file mode 100644
index 0000000000..ba12012c85
--- /dev/null
+++ b/app/test-flow-perf/async_flow.c
@@ -0,0 +1,239 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 Mellanox Technologies, Ltd
+ *
+ * This file contains the async flow API implementation
+ * for the flow-perf application.
+ */
+
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_ethdev.h>
+#include <rte_flow.h>
+#include <rte_malloc.h>
+
+#include "actions_gen.h"
+#include "async_flow.h"
+#include "flow_gen.h"
+#include "items_gen.h"
+
+/* Per-port async flow resources */
+static struct async_flow_resources port_resources[MAX_PORTS];
+
+int
+async_flow_init_port(uint16_t port_id, uint32_t nb_queues, uint32_t queue_size,
+		     uint64_t *flow_items, uint64_t *flow_actions, uint64_t *flow_attrs,
+		     uint8_t flow_group, uint32_t rules_count)
+{
+	struct rte_flow_port_info port_info = {0};
+	struct rte_flow_queue_info queue_info = {0};
+	struct rte_flow_error error = {0};
+	struct rte_flow_port_attr port_attr = {0};
+	struct rte_flow_queue_attr *queue_attr = alloca(sizeof(struct rte_flow_queue_attr));
+	const struct rte_flow_queue_attr **queue_attr_list =
+		alloca(sizeof(struct rte_flow_queue_attr) * nb_queues);
+	struct rte_flow_pattern_template_attr pt_attr = {0};
+	struct rte_flow_actions_template_attr at_attr = {0};
+	struct rte_flow_template_table_attr table_attr = {0};
+	struct rte_flow_item pattern[MAX_ITEMS_NUM];
+	struct rte_flow_action actions[MAX_ACTIONS_NUM];
+	struct rte_flow_action action_masks[MAX_ACTIONS_NUM];
+	struct async_flow_resources *res;
+	bool need_wire_orig_table = false;
+	uint32_t i;
+	int ret;
+
+	if (port_id >= MAX_PORTS)
+		return -1;
+
+	res = &port_resources[port_id];
+	memset(res, 0, sizeof(*res));
+
+	/* Query port flow info */
+	ret = rte_flow_info_get(port_id, &port_info, &queue_info, &error);
+	if (ret != 0) {
+		fprintf(stderr, "Port %u: rte_flow_info_get failed: %s\n", port_id,
+			error.message ? error.message : "(no message)");
+		return ret;
+	}
+
+	/* Limit to device capabilities if reported */
+	if (port_info.max_nb_queues != 0 && port_info.max_nb_queues != UINT32_MAX &&
+	    nb_queues > port_info.max_nb_queues)
+		nb_queues = port_info.max_nb_queues;
+	if (queue_info.max_size != 0 && queue_info.max_size != UINT32_MAX &&
+	    queue_size > queue_info.max_size)
+		queue_size = queue_info.max_size;
+
+	queue_attr->size = queue_size;
+	for (i = 0; i < nb_queues; i++)
+		queue_attr_list[i] = queue_attr;
+
+	ret = rte_flow_configure(port_id, &port_attr, nb_queues, queue_attr_list, &error);
+	if (ret != 0) {
+		fprintf(stderr, "Port %u: rte_flow_configure failed (ret=%d, type=%d): %s\n",
+			port_id, ret, error.type, error.message ? error.message : "(no message)");
+		return ret;
+	}
+
+	/* Create pattern template */
+	for (i = 0; i < MAX_ATTRS_NUM; i++) {
+		if (flow_attrs[i] == 0)
+			break;
+		if (flow_attrs[i] & INGRESS)
+			pt_attr.ingress = 1;
+		else if (flow_attrs[i] & EGRESS)
+			pt_attr.egress = 1;
+		else if (flow_attrs[i] & TRANSFER)
+			pt_attr.transfer = 1;
+	}
+	/* Enable relaxed matching for better performance */
+	pt_attr.relaxed_matching = 1;
+
+	memset(pattern, 0, sizeof(pattern));
+	memset(actions, 0, sizeof(actions));
+	memset(action_masks, 0, sizeof(action_masks));
+
+	fill_items_template(pattern, flow_items, 0, 0);
+
+	res->pattern_template =
+		rte_flow_pattern_template_create(port_id, &pt_attr, pattern, &error);
+	if (res->pattern_template == NULL) {
+		fprintf(stderr, "Port %u: pattern template create failed: %s\n", port_id,
+			error.message ? error.message : "(no message)");
+		return -1;
+	}
+
+	/* Create actions template */
+	at_attr.ingress = pt_attr.ingress;
+	at_attr.egress = pt_attr.egress;
+	at_attr.transfer = pt_attr.transfer;
+
+	fill_actions_template(actions, action_masks, flow_actions, &need_wire_orig_table);
+
+	res->actions_template =
+		rte_flow_actions_template_create(port_id, &at_attr, actions, action_masks, &error);
+	if (res->actions_template == NULL) {
+		fprintf(stderr, "Port %u: actions template create failed: %s\n", port_id,
+			error.message ? error.message : "(no message)");
+		rte_flow_pattern_template_destroy(port_id, res->pattern_template, &error);
+		res->pattern_template = NULL;
+		return -1;
+	}
+
+	/* Create template table */
+	table_attr.flow_attr.group = flow_group;
+	table_attr.flow_attr.priority = 0;
+	table_attr.flow_attr.ingress = pt_attr.ingress;
+	table_attr.flow_attr.egress = pt_attr.egress;
+	table_attr.flow_attr.transfer = pt_attr.transfer;
+	table_attr.nb_flows = rules_count;
+
+	if (pt_attr.transfer && need_wire_orig_table)
+		table_attr.specialize = RTE_FLOW_TABLE_SPECIALIZE_TRANSFER_WIRE_ORIG;
+
+	res->table = rte_flow_template_table_create(port_id, &table_attr, &res->pattern_template, 1,
+						    &res->actions_template, 1, &error);
+	if (res->table == NULL) {
+		fprintf(stderr, "Port %u: template table create failed: %s\n", port_id,
+			error.message ? error.message : "(no message)");
+		rte_flow_actions_template_destroy(port_id, res->actions_template, &error);
+		rte_flow_pattern_template_destroy(port_id, res->pattern_template, &error);
+		res->pattern_template = NULL;
+		res->actions_template = NULL;
+		return -1;
+	}
+
+	res->table_capacity = rules_count;
+	res->initialized = true;
+
+	printf("Port %u: Async flow engine initialized (queues=%u, queue_size=%u)\n", port_id,
+	       nb_queues, queue_size);
+
+	return 0;
+}
+
+struct rte_flow *
+async_generate_flow(uint16_t port_id, uint32_t queue_id, uint64_t *flow_items,
+		    uint64_t *flow_actions, uint32_t counter, uint16_t hairpinq,
+		    uint64_t encap_data, uint64_t decap_data, uint16_t dst_port, uint8_t core_idx,
+		    uint8_t rx_queues_count, bool unique_data, bool postpone,
+		    struct rte_flow_error *error)
+{
+	struct async_flow_resources *res;
+	struct rte_flow_item items[MAX_ITEMS_NUM];
+	struct rte_flow_action actions[MAX_ACTIONS_NUM];
+	struct rte_flow_op_attr op_attr = {
+		.postpone = postpone,
+	};
+	struct rte_flow *flow;
+
+	if (port_id >= MAX_PORTS) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "Invalid port ID");
+		return NULL;
+	}
+
+	res = &port_resources[port_id];
+	if (!res->initialized) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "Async flow resources not initialized");
+		return NULL;
+	}
+
+	/* Fill pattern items with actual values */
+	memset(items, 0, sizeof(items));
+	fill_items(items, flow_items, counter, core_idx);
+
+	/* Fill actions with actual values */
+	memset(actions, 0, sizeof(actions));
+	fill_actions(actions, flow_actions, counter, JUMP_ACTION_TABLE, hairpinq, encap_data,
+		     decap_data, core_idx, unique_data, rx_queues_count, dst_port);
+
+	/* Create flow asynchronously */
+	flow = rte_flow_async_create(port_id, queue_id, &op_attr, res->table, items, 0, actions, 0,
+				     NULL, error);
+
+	return flow;
+}
+
+void
+async_flow_cleanup_port(uint16_t port_id)
+{
+	struct async_flow_resources *res;
+	struct rte_flow_error error;
+	struct rte_flow_op_result results[64];
+	int ret, i;
+
+	if (port_id >= MAX_PORTS)
+		return;
+
+	res = &port_resources[port_id];
+	if (!res->initialized)
+		return;
+
+	/* Drain any pending async completions from flow flush */
+	for (i = 0; i < 100; i++) { /* Max iterations to avoid infinite loop */
+		rte_flow_push(port_id, 0, &error);
+		ret = rte_flow_pull(port_id, 0, results, 64, &error);
+		if (ret <= 0)
+			break;
+	}
+
+	if (res->table != NULL) {
+		rte_flow_template_table_destroy(port_id, res->table, &error);
+		res->table = NULL;
+	}
+
+	if (res->actions_template != NULL) {
+		rte_flow_actions_template_destroy(port_id, res->actions_template, &error);
+		res->actions_template = NULL;
+	}
+
+	if (res->pattern_template != NULL) {
+		rte_flow_pattern_template_destroy(port_id, res->pattern_template, &error);
+		res->pattern_template = NULL;
+	}
+
+	res->initialized = false;
+}
diff --git a/app/test-flow-perf/async_flow.h b/app/test-flow-perf/async_flow.h
new file mode 100644
index 0000000000..2684fc4156
--- /dev/null
+++ b/app/test-flow-perf/async_flow.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 Mellanox Technologies, Ltd
+ *
+ * This file contains the async flow API related definitions
+ * and function declarations.
+ */
+
+#ifndef FLOW_PERF_ASYNC_FLOW
+#define FLOW_PERF_ASYNC_FLOW
+
+#include <rte_flow.h>
+#include <stdbool.h>
+#include <stdint.h>
+
+#include "config.h"
+
+/* Per-port async flow resources */
+struct async_flow_resources {
+	struct rte_flow_pattern_template *pattern_template;
+	struct rte_flow_actions_template *actions_template;
+	struct rte_flow_template_table *table;
+	uint32_t table_capacity;
+	bool initialized;
+};
+
+/* Initialize async flow engine for a port */
+int async_flow_init_port(uint16_t port_id, uint32_t nb_queues, uint32_t queue_size,
+			 uint64_t *flow_items, uint64_t *flow_actions, uint64_t *flow_attrs,
+			 uint8_t flow_group, uint32_t rules_count);
+
+/* Create a flow rule asynchronously */
+struct rte_flow *async_generate_flow(uint16_t port_id, uint32_t queue_id, uint64_t *flow_items,
+				     uint64_t *flow_actions, uint32_t counter, uint16_t hairpinq,
+				     uint64_t encap_data, uint64_t decap_data, uint16_t dst_port,
+				     uint8_t core_idx, uint8_t rx_queues_count, bool unique_data,
+				     bool postpone, struct rte_flow_error *error);
+
+/* Cleanup async flow resources for a port */
+void async_flow_cleanup_port(uint16_t port_id);
+
+#endif /* FLOW_PERF_ASYNC_FLOW */
diff --git a/app/test-flow-perf/items_gen.c b/app/test-flow-perf/items_gen.c
index c740e1838f..4f20175f01 100644
--- a/app/test-flow-perf/items_gen.c
+++ b/app/test-flow-perf/items_gen.c
@@ -389,3 +389,16 @@ fill_items(struct rte_flow_item *items,
 
 	items[items_counter].type = RTE_FLOW_ITEM_TYPE_END;
 }
+
+void
+fill_items_template(struct rte_flow_item *items, uint64_t *flow_items, uint32_t outer_ip_src,
+		    uint8_t core_idx)
+{
+	uint8_t i;
+
+	fill_items(items, flow_items, outer_ip_src, core_idx);
+
+	/* For templates, set spec to NULL - only mask matters for template matching */
+	for (i = 0; items[i].type != RTE_FLOW_ITEM_TYPE_END; i++)
+		items[i].spec = NULL;
+}
diff --git a/app/test-flow-perf/items_gen.h b/app/test-flow-perf/items_gen.h
index f4b0e9a981..50bb4d9fd0 100644
--- a/app/test-flow-perf/items_gen.h
+++ b/app/test-flow-perf/items_gen.h
@@ -15,4 +15,8 @@
 void fill_items(struct rte_flow_item *items, uint64_t *flow_items,
 	uint32_t outer_ip_src, uint8_t core_idx);
 
+/* Fill items template for async flow API (masks only, no spec values) */
+void fill_items_template(struct rte_flow_item *items, uint64_t *flow_items, uint32_t outer_ip_src,
+			 uint8_t core_idx);
+
 #endif /* FLOW_PERF_ITEMS_GEN */
diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index 6636d1517f..32f2260ba0 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -37,9 +37,11 @@
 #include <rte_mtr.h>
 #include <rte_os_shim.h>
 
-#include "config.h"
 #include "actions_gen.h"
+#include "async_flow.h"
+#include "config.h"
 #include "flow_gen.h"
+#include "rte_common.h"
 
 #define MAX_BATCHES_COUNT          100
 #define DEFAULT_RULES_COUNT    4000000
@@ -81,6 +83,9 @@ static bool enable_fwd;
 static bool unique_data;
 static bool policy_mtr;
 static bool packet_mode;
+static bool async_mode;
+static uint32_t async_queue_size = 1024;
+static uint32_t async_push_batch = 256;
 
 static uint8_t rx_queues_count;
 static uint8_t tx_queues_count;
@@ -598,6 +603,13 @@ usage(char *progname)
 		"Encapped data is fixed with pattern: ether,ipv4,udp,vxlan\n"
 		"With fixed values\n");
 	printf("  --vxlan-decap: add vxlan_decap action to flow actions\n");
+
+	printf("\nAsync flow API options:\n");
+	printf("  --async: enable async flow API mode\n");
+	printf("  --async-queue-size=N: size of each async queue,"
+	       " default is 1024\n");
+	printf("  --async-push-batch=N: flows to batch before push,"
+	       " default is 256\n");
 }
 
 static void
@@ -655,86 +667,90 @@ args_parse(int argc, char **argv)
 
 	static const struct option lgopts[] = {
 		/* Control */
-		{ "help",                       0, 0, 0 },
-		{ "rules-count",                1, 0, 0 },
-		{ "rules-batch",                1, 0, 0 },
-		{ "dump-iterations",            0, 0, 0 },
-		{ "deletion-rate",              0, 0, 0 },
-		{ "query-rate",                 0, 0, 0 },
-		{ "dump-socket-mem",            0, 0, 0 },
-		{ "enable-fwd",                 0, 0, 0 },
-		{ "unique-data",                0, 0, 0 },
-		{ "portmask",                   1, 0, 0 },
-		{ "hairpin-conf",               1, 0, 0 },
-		{ "cores",                      1, 0, 0 },
-		{ "random-priority",            1, 0, 0 },
-		{ "meter-profile-alg",          1, 0, 0 },
-		{ "rxq",                        1, 0, 0 },
-		{ "txq",                        1, 0, 0 },
-		{ "rxd",                        1, 0, 0 },
-		{ "txd",                        1, 0, 0 },
-		{ "mbuf-size",                  1, 0, 0 },
-		{ "mbuf-cache-size",            1, 0, 0 },
-		{ "total-mbuf-count",           1, 0, 0 },
+		{"help", 0, 0, 0},
+		{"rules-count", 1, 0, 0},
+		{"rules-batch", 1, 0, 0},
+		{"dump-iterations", 0, 0, 0},
+		{"deletion-rate", 0, 0, 0},
+		{"query-rate", 0, 0, 0},
+		{"dump-socket-mem", 0, 0, 0},
+		{"enable-fwd", 0, 0, 0},
+		{"unique-data", 0, 0, 0},
+		{"portmask", 1, 0, 0},
+		{"hairpin-conf", 1, 0, 0},
+		{"cores", 1, 0, 0},
+		{"random-priority", 1, 0, 0},
+		{"meter-profile-alg", 1, 0, 0},
+		{"rxq", 1, 0, 0},
+		{"txq", 1, 0, 0},
+		{"rxd", 1, 0, 0},
+		{"txd", 1, 0, 0},
+		{"mbuf-size", 1, 0, 0},
+		{"mbuf-cache-size", 1, 0, 0},
+		{"total-mbuf-count", 1, 0, 0},
 		/* Attributes */
-		{ "ingress",                    0, 0, 0 },
-		{ "egress",                     0, 0, 0 },
-		{ "transfer",                   0, 0, 0 },
-		{ "group",                      1, 0, 0 },
+		{"ingress", 0, 0, 0},
+		{"egress", 0, 0, 0},
+		{"transfer", 0, 0, 0},
+		{"group", 1, 0, 0},
 		/* Items */
-		{ "ether",                      0, 0, 0 },
-		{ "vlan",                       0, 0, 0 },
-		{ "ipv4",                       0, 0, 0 },
-		{ "ipv6",                       0, 0, 0 },
-		{ "tcp",                        0, 0, 0 },
-		{ "udp",                        0, 0, 0 },
-		{ "vxlan",                      0, 0, 0 },
-		{ "vxlan-gpe",                  0, 0, 0 },
-		{ "gre",                        0, 0, 0 },
-		{ "geneve",                     0, 0, 0 },
-		{ "gtp",                        0, 0, 0 },
-		{ "meta",                       0, 0, 0 },
-		{ "tag",                        0, 0, 0 },
-		{ "icmpv4",                     0, 0, 0 },
-		{ "icmpv6",                     0, 0, 0 },
+		{"ether", 0, 0, 0},
+		{"vlan", 0, 0, 0},
+		{"ipv4", 0, 0, 0},
+		{"ipv6", 0, 0, 0},
+		{"tcp", 0, 0, 0},
+		{"udp", 0, 0, 0},
+		{"vxlan", 0, 0, 0},
+		{"vxlan-gpe", 0, 0, 0},
+		{"gre", 0, 0, 0},
+		{"geneve", 0, 0, 0},
+		{"gtp", 0, 0, 0},
+		{"meta", 0, 0, 0},
+		{"tag", 0, 0, 0},
+		{"icmpv4", 0, 0, 0},
+		{"icmpv6", 0, 0, 0},
 		/* Actions */
-		{ "port-id",                    2, 0, 0 },
-		{ "rss",                        0, 0, 0 },
-		{ "queue",                      0, 0, 0 },
-		{ "jump",                       0, 0, 0 },
-		{ "mark",                       0, 0, 0 },
-		{ "count",                      0, 0, 0 },
-		{ "set-meta",                   0, 0, 0 },
-		{ "set-tag",                    0, 0, 0 },
-		{ "drop",                       0, 0, 0 },
-		{ "hairpin-queue",              1, 0, 0 },
-		{ "hairpin-rss",                1, 0, 0 },
-		{ "set-src-mac",                0, 0, 0 },
-		{ "set-dst-mac",                0, 0, 0 },
-		{ "set-src-ipv4",               0, 0, 0 },
-		{ "set-dst-ipv4",               0, 0, 0 },
-		{ "set-src-ipv6",               0, 0, 0 },
-		{ "set-dst-ipv6",               0, 0, 0 },
-		{ "set-src-tp",                 0, 0, 0 },
-		{ "set-dst-tp",                 0, 0, 0 },
-		{ "inc-tcp-ack",                0, 0, 0 },
-		{ "dec-tcp-ack",                0, 0, 0 },
-		{ "inc-tcp-seq",                0, 0, 0 },
-		{ "dec-tcp-seq",                0, 0, 0 },
-		{ "set-ttl",                    0, 0, 0 },
-		{ "dec-ttl",                    0, 0, 0 },
-		{ "set-ipv4-dscp",              0, 0, 0 },
-		{ "set-ipv6-dscp",              0, 0, 0 },
-		{ "flag",                       0, 0, 0 },
-		{ "meter",                      0, 0, 0 },
-		{ "raw-encap",                  1, 0, 0 },
-		{ "raw-decap",                  1, 0, 0 },
-		{ "vxlan-encap",                0, 0, 0 },
-		{ "vxlan-decap",                0, 0, 0 },
-		{ "policy-mtr",                 1, 0, 0 },
-		{ "meter-profile",              1, 0, 0 },
-		{ "packet-mode",                0, 0, 0 },
-		{ 0, 0, 0, 0 },
+		{"port-id", 2, 0, 0},
+		{"rss", 0, 0, 0},
+		{"queue", 0, 0, 0},
+		{"jump", 0, 0, 0},
+		{"mark", 0, 0, 0},
+		{"count", 0, 0, 0},
+		{"set-meta", 0, 0, 0},
+		{"set-tag", 0, 0, 0},
+		{"drop", 0, 0, 0},
+		{"hairpin-queue", 1, 0, 0},
+		{"hairpin-rss", 1, 0, 0},
+		{"set-src-mac", 0, 0, 0},
+		{"set-dst-mac", 0, 0, 0},
+		{"set-src-ipv4", 0, 0, 0},
+		{"set-dst-ipv4", 0, 0, 0},
+		{"set-src-ipv6", 0, 0, 0},
+		{"set-dst-ipv6", 0, 0, 0},
+		{"set-src-tp", 0, 0, 0},
+		{"set-dst-tp", 0, 0, 0},
+		{"inc-tcp-ack", 0, 0, 0},
+		{"dec-tcp-ack", 0, 0, 0},
+		{"inc-tcp-seq", 0, 0, 0},
+		{"dec-tcp-seq", 0, 0, 0},
+		{"set-ttl", 0, 0, 0},
+		{"dec-ttl", 0, 0, 0},
+		{"set-ipv4-dscp", 0, 0, 0},
+		{"set-ipv6-dscp", 0, 0, 0},
+		{"flag", 0, 0, 0},
+		{"meter", 0, 0, 0},
+		{"raw-encap", 1, 0, 0},
+		{"raw-decap", 1, 0, 0},
+		{"vxlan-encap", 0, 0, 0},
+		{"vxlan-decap", 0, 0, 0},
+		{"policy-mtr", 1, 0, 0},
+		{"meter-profile", 1, 0, 0},
+		{"packet-mode", 0, 0, 0},
+		/* Async flow API options */
+		{"async", 0, 0, 0},
+		{"async-queue-size", 1, 0, 0},
+		{"async-push-batch", 1, 0, 0},
+		{0, 0, 0, 0},
 	};
 
 	RTE_ETH_FOREACH_DEV(i)
@@ -913,14 +929,15 @@ args_parse(int argc, char **argv)
 					rte_exit(EXIT_FAILURE, "Invalid hairpin config mask\n");
 				hairpin_conf_mask = hp_conf;
 			}
-			if (strcmp(lgopts[opt_idx].name,
-					"port-id") == 0) {
+			if (strcmp(lgopts[opt_idx].name, "port-id") == 0) {
 				uint16_t port_idx = 0;
 
-				token = strtok(optarg, ",");
-				while (token != NULL) {
-					dst_ports[port_idx++] = atoi(token);
-					token = strtok(NULL, ",");
+				if (optarg != NULL) {
+					token = strtok(optarg, ",");
+					while (token != NULL) {
+						dst_ports[port_idx++] = atoi(token);
+						token = strtok(NULL, ",");
+					}
 				}
 			}
 			if (strcmp(lgopts[opt_idx].name, "rxq") == 0) {
@@ -981,6 +998,22 @@ args_parse(int argc, char **argv)
 			}
 			if (strcmp(lgopts[opt_idx].name, "packet-mode") == 0)
 				packet_mode = true;
+			if (strcmp(lgopts[opt_idx].name, "async") == 0)
+				async_mode = true;
+			if (strcmp(lgopts[opt_idx].name, "async-queue-size") == 0) {
+				n = atoi(optarg);
+				if (n > 0)
+					async_queue_size = n;
+				else
+					rte_exit(EXIT_FAILURE, "async-queue-size should be > 0\n");
+			}
+			if (strcmp(lgopts[opt_idx].name, "async-push-batch") == 0) {
+				n = atoi(optarg);
+				if (n > 0)
+					async_push_batch = n;
+				else
+					rte_exit(EXIT_FAILURE, "async-push-batch should be > 0\n");
+			}
 			break;
 		default:
 			usage(argv[0]);
@@ -1578,6 +1611,197 @@ insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
 	return flows_list;
 }
 
+static inline int
+push_pull_flows_async(int port_id, int queue_id, uint64_t enqueued, uint64_t *in_flight,
+		      bool force_push, bool force_pull, bool check_op_status,
+		      struct rte_flow_op_result *results, struct rte_flow_error *error)
+{
+	/* Keep queue at most 75% full to avoid overflow */
+	uint32_t max_in_flight = (async_queue_size * 3) / 4;
+	int pulled, i;
+	int ret = 0;
+	bool do_pull = force_pull || *in_flight >= max_in_flight;
+	/* If we need to pull, we want all the in fligt work to have been pushed */
+	bool do_push = do_pull || force_push || (enqueued % async_push_batch) == 0;
+
+	/* Push periodically to give HW work to do */
+	if (do_push) {
+		ret = rte_flow_push(port_id, queue_id, error);
+		if (ret)
+			return ret;
+	}
+
+	/* Check if queue is getting full, if so push and drain completions */
+	if (do_pull) {
+		do {
+			pulled = rte_flow_pull(port_id, queue_id, results, async_push_batch, error);
+			if (pulled < 0) {
+				return -1;
+			} else if (pulled == 0) {
+				rte_pause();
+				continue;
+			}
+
+			*in_flight -= pulled;
+			if (!check_op_status)
+				continue;
+
+			for (i = 0; i < pulled; i++) {
+				if (results[i].status != RTE_FLOW_OP_SUCCESS) {
+					rte_flow_error_set(error, EINVAL,
+							   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+							   "Some flow rule insertion failed");
+					return -1;
+				}
+			}
+		} while (*in_flight >= max_in_flight);
+	}
+
+	return 0;
+}
+
+static struct rte_flow **
+insert_flows_async(int port_id, uint8_t core_id, uint16_t dst_port_id)
+{
+	struct rte_flow **flows_list;
+	struct rte_flow_error error;
+	struct rte_flow_op_result *results;
+	clock_t start_batch, end_batch;
+	double first_flow_latency;
+	double cpu_time_used;
+	double insertion_rate;
+	double cpu_time_per_batch[MAX_BATCHES_COUNT] = {0};
+	double delta;
+	uint32_t flow_index;
+	uint32_t counter, start_counter = 0, end_counter;
+	int rules_batch_idx;
+	int rules_count_per_core;
+	uint64_t total_enqueued = 0;
+	uint64_t in_flight = 0;
+	uint32_t queue_id = core_id;
+
+	rules_count_per_core = rules_count / mc_pool.cores_count;
+
+	/* Set boundaries of rules for each core. */
+	if (core_id)
+		start_counter = core_id * rules_count_per_core;
+	end_counter = (core_id + 1) * rules_count_per_core;
+
+	flows_list = rte_zmalloc("flows_list",
+				 (sizeof(struct rte_flow *) * (rules_count_per_core + 1)), 0);
+	if (flows_list == NULL)
+		rte_exit(EXIT_FAILURE, "No Memory available!\n");
+
+	results = rte_zmalloc("results", sizeof(struct rte_flow_op_result) * async_push_batch, 0);
+	if (results == NULL) {
+		rte_free(flows_list);
+		rte_exit(EXIT_FAILURE, "No Memory available!\n");
+	}
+
+	cpu_time_used = 0;
+	flow_index = 0;
+	if (flow_group > 0 && core_id == 0) {
+		/*
+		 * Create global rule to jump into flow_group,
+		 * this way the app will avoid the default rules.
+		 *
+		 * This rule will be created only once.
+		 *
+		 * Global rule:
+		 * group 0 eth / end actions jump group <flow_group>
+		 */
+
+		uint64_t global_items[MAX_ITEMS_NUM] = {0};
+		uint64_t global_actions[MAX_ACTIONS_NUM] = {0};
+		global_items[0] = FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_ETH);
+		global_actions[0] = FLOW_ITEM_MASK(RTE_FLOW_ACTION_TYPE_JUMP);
+		flow = generate_flow(port_id, 0, flow_attrs, global_items, global_actions,
+				     flow_group, 0, 0, 0, 0, dst_port_id, core_id, rx_queues_count,
+				     unique_data, max_priority, &error);
+
+		if (flow == NULL) {
+			print_flow_error(error);
+			rte_exit(EXIT_FAILURE, "Error in creating flow\n");
+		}
+		flows_list[flow_index++] = flow;
+	}
+
+	start_batch = rte_get_timer_cycles();
+	for (counter = start_counter; counter < end_counter; counter++) {
+		if (push_pull_flows_async(port_id, queue_id, total_enqueued, &in_flight, false,
+					  false, false, results, &error)) {
+			print_flow_error(error);
+			rte_exit(EXIT_FAILURE, "Error push/pull async operations\n");
+		}
+
+		/* Create flow with postpone=true to batch operations */
+		flow = async_generate_flow(port_id, queue_id, flow_items, flow_actions, counter,
+					   hairpin_queues_num, encap_data, decap_data, dst_port_id,
+					   core_id, rx_queues_count, unique_data, true, &error);
+
+		if (counter == start_counter) {
+			first_flow_latency = (double)(rte_get_timer_cycles() - start_batch);
+			first_flow_latency /= rte_get_timer_hz();
+			/* In millisecond */
+			first_flow_latency *= 1000;
+			printf(":: First Flow Latency (Async) :: Port %d :: First flow "
+			       "installed in %f milliseconds\n",
+			       port_id, first_flow_latency);
+		}
+
+		if (force_quit)
+			break;
+
+		if (!flow) {
+			print_flow_error(error);
+			rte_exit(EXIT_FAILURE, "Error in creating async flow\n");
+		}
+
+		flows_list[flow_index++] = flow;
+		total_enqueued++;
+		in_flight++;
+
+		/*
+		 * Save the insertion rate for rules batch.
+		 * Check if the insertion reached the rules
+		 * patch counter, then save the insertion rate
+		 * for this batch.
+		 */
+		if (!((counter + 1) % rules_batch)) {
+			end_batch = rte_get_timer_cycles();
+			delta = (double)(end_batch - start_batch);
+			rules_batch_idx = ((counter + 1) / rules_batch) - 1;
+			cpu_time_per_batch[rules_batch_idx] = delta / rte_get_timer_hz();
+			cpu_time_used += cpu_time_per_batch[rules_batch_idx];
+			start_batch = rte_get_timer_cycles();
+		}
+	}
+
+	if (push_pull_flows_async(port_id, queue_id, total_enqueued, &in_flight, true, true, true,
+				  results, &error)) {
+		print_flow_error(error);
+		rte_exit(EXIT_FAILURE, "Error final push/pull async operations\n");
+	}
+
+	/* Print insertion rates for all batches */
+	if (dump_iterations)
+		print_rules_batches(cpu_time_per_batch);
+
+	printf(":: Port %d :: Core %d boundaries (Async) :: start @[%d] - end @[%d]\n", port_id,
+	       core_id, start_counter, end_counter - 1);
+
+	/* Insertion rate for all rules in one core */
+	insertion_rate = ((double)(rules_count_per_core / cpu_time_used) / 1000);
+	printf(":: Port %d :: Core %d :: Async rules insertion rate -> %f K Rule/Sec\n", port_id,
+	       core_id, insertion_rate);
+	printf(":: Port %d :: Core %d :: The time for creating %d async rules is %f seconds\n",
+	       port_id, core_id, rules_count_per_core, cpu_time_used);
+
+	rte_free(results);
+	mc_pool.flows_record.insertion[port_id][core_id] = cpu_time_used;
+	return flows_list;
+}
+
 static void
 flows_handler(uint8_t core_id)
 {
@@ -1602,8 +1826,10 @@ flows_handler(uint8_t core_id)
 		mc_pool.last_alloc[core_id] = (int64_t)dump_socket_mem(stdout);
 		if (has_meter())
 			meters_handler(port_id, core_id, METER_CREATE);
-		flows_list = insert_flows(port_id, core_id,
-						dst_ports[port_idx++]);
+		if (async_mode)
+			flows_list = insert_flows_async(port_id, core_id, dst_ports[port_idx++]);
+		else
+			flows_list = insert_flows(port_id, core_id, dst_ports[port_idx++]);
 		if (flows_list == NULL)
 			rte_exit(EXIT_FAILURE, "Error: Insertion Failed!\n");
 		mc_pool.current_alloc[core_id] = (int64_t)dump_socket_mem(stdout);
@@ -2212,6 +2438,16 @@ init_port(void)
 			}
 		}
 
+		/* Configure async flow engine before device start */
+		if (async_mode) {
+			ret = async_flow_init_port(port_id, mc_pool.cores_count, async_queue_size,
+						   flow_items, flow_actions, flow_attrs, flow_group,
+						   rules_count);
+			if (ret != 0)
+				rte_exit(EXIT_FAILURE, "Failed to init async flow on port %d\n",
+					 port_id);
+		}
+
 		ret = rte_eth_dev_start(port_id);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE,
@@ -2291,6 +2527,8 @@ main(int argc, char **argv)
 
 	RTE_ETH_FOREACH_DEV(port) {
 		rte_flow_flush(port, &error);
+		if (async_mode)
+			async_flow_cleanup_port(port);
 		if (rte_eth_dev_stop(port) != 0)
 			printf("Failed to stop device on port %u\n", port);
 		rte_eth_dev_close(port);
diff --git a/app/test-flow-perf/meson.build b/app/test-flow-perf/meson.build
index e101449e32..2f820a7597 100644
--- a/app/test-flow-perf/meson.build
+++ b/app/test-flow-perf/meson.build
@@ -3,6 +3,7 @@
 
 sources = files(
         'actions_gen.c',
+        'async_flow.c',
         'flow_gen.c',
         'items_gen.c',
         'main.c',
-- 
2.43.0

