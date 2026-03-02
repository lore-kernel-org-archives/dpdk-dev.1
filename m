Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AFDEC1438
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 13:22:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0440F40E2F;
	Tue,  3 Mar 2026 14:22:11 +0100 (CET)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43]) by mails.dpdk.org (Postfix) with ESMTP id 73B9E400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 15:35:39 +0100 (CET)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-65c0d2f5fe1so9049246a12.3
 for <dev@dpdk.org>; Mon, 02 Mar 2026 06:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772462139; x=1773066939; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqlAyZPBjU1EO/hHaV9P7ZwZCHmlxOWclAaF6Vq09O8=;
 b=FWIRVqJaGmGqu9OrqD+O6Q00T1fbSiI2flPIzs9qbJq2ThrlGLkpTgR0OEZrIV/P67
 /LucN5AWK/Dw9J0mND3QUI/3ilSM8GGwEk/pYA+lmtbqD2y9Y7RrPGKessaEtNWkQmGk
 gLU850+9iL6msaMwWzLYI2Kmf0IYVqCh2xtjXMmjUPNncip/w2OthCSbShR9eCedic3z
 WDgEoE25bBvr7f8SSDR9gR+GRH9aBrTThwdMVBfY4I6j5p9NXDbCzorV652xKHzEDyUG
 MPYAhr/cVSnsFUNGmCKMCARFCmBWjz4ReRyzq0EfJz8KxwiuY4QKtBhdpTgL/TWSV9RU
 dgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772462139; x=1773066939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hqlAyZPBjU1EO/hHaV9P7ZwZCHmlxOWclAaF6Vq09O8=;
 b=Y0H8CltculByQ57i60rNt5j1uE0tUNIPQsFwMsqQCHBbdVIjgyhAv/E/et5zc/NTgY
 gd2rMemf0hcC66AexvlIQ+Sc7aydI0rmYECND4TDZIF+6d7TqxWc+yg5Bzd4T5rWQbnZ
 2NtGBLrtOHjnZfM9tlwNaluiN5Gde1u8/0+1Lpnya+ZvbJzrAZFCsJg0g+mKiW0rx3X1
 SmFjk/duh1Mb7oeDRyQ08cohl0uCeNPsz0rvyQ/dWhWaze0icO7AypJ2ewzcJ1sjSPC/
 G3+IYUZ1qDOdlHIF5wcbAo6HZ1Wly6r8miBr96LvkezWL7szgYLt307Ax9bfUN4hE1Br
 Fstw==
X-Gm-Message-State: AOJu0Yx+If5RwUwF7NShppUUh2OGOgwi9xJOP7nOVr4eVVfFYQixl+T9
 4ncORouzUnIKu6zNswuvDBD3EbiM9hvyUqR8vqU65by85arAZjQxhn9P
X-Gm-Gg: ATEYQzwoiAKEU+ecA+SXRlY1hWqZDOf2pwcmSuV2yeoMXklR33BJexHFFUFsrV4y/ke
 ovWzddxRWTu9b8mZcuTs5wSiFC1/dXqHJIHYkMJIU0OwWsTXZqsCMVcf01Bl2EXuGXj36Ddeh4a
 j9RmBsxA6LlZMjD+cru0ozaF5YoifTx1Fapp2+8Y1WbXfTVMWOVX1zxHMtGjyh9zHVwtiZs+VIC
 /uTp/GD41ut4OHJ5AwMpn+/TsbQzHYYudjRZZJD+jwdjNhBwWcuS3kIUsj4m9m4pTEKXR404hb5
 +ucvuG4270GpOq2CMMSQ6unYKPICGCrzeOAOAkk5WDp+PxuVCYZJBfz8tHvkfYPfBPLJdr4T2Ls
 /S2FGaoXrf8SluE8VFAK/Mgk1eh/8Sn04eMAdZSIQOqGv3D0sCCqS+OBr/a9I+WsfFHjSmpjbu5
 yMknhIoYERsMveTuKsPpl4O4HJIPDZe7kTk65QMC4cShbWKZ7bORkaC5v1u0uFa4+2
X-Received: by 2002:a05:6402:440a:b0:65f:aa20:23d1 with SMTP id
 4fb4d7f45d1cf-65fdd4cafd2mr7940215a12.4.1772462138213; 
 Mon, 02 Mar 2026 06:35:38 -0800 (PST)
Received: from work.cisco.com ([2001:420:44f5:1250:14a7:2a07:58ff:b5b4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fac07c09fsm3515678a12.32.2026.03.02.06.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 06:35:37 -0800 (PST)
From: Maxime Peim <maxime.peim@gmail.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v4] test/flow: add support for async API
Date: Mon,  2 Mar 2026 15:35:12 +0100
Message-ID: <20260302143513.1702071-1-maxime.peim@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225142310.51f75f4d@phoenix.local>
References: <20260225142310.51f75f4d@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Mar 2026 14:22:08 +0100
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
v2:
  - Replace per-flow stack allocation with pre-allocated slot pool;
    flat buffers are initialized once at init time and the hot path
    only patches per-flow item/action values into a pre-set slot
  - Fix alloca misuse: use heap allocation for queue_attr_list, round
    queue_size to power of 2 for bitmask wrapping, add bounds checks
  - Fix race on file-scope flow variable, premature latency
    measurement, and integer division in rate calculation
  - Drop unrelated lgopts reformatting
  - Use malloc instead of rte_zmalloc for non-dataplane allocations
  - Various robustness and style fixes

v3:
  - Update meson.build to exclude Windows build for flow perf test
  - Fix checkstyle
  - Remove cast from void* to uintptr_t
  - Add name to mailmap and maintainers

v4:
  - Use RTE_CAST_PTR for void pointer casts (const-correctness)
  - Simplify init_slot_pool, fill_items_template, and
    fill_actions_template signatures; export item_spec_size and
    action_conf_size helpers
  - Use goto-based centralized error cleanup
  - Remove redundant queue_id variable, use core_id directly
  - Make push_counter a function-local static
  - Narrow n_items/n_actions from uint32_t to uint8_t
  - Consistent conf variable naming in action slot-fill handlers

 .mailmap                         |   1 +
 MAINTAINERS                      |   1 +
 app/test-flow-perf/actions_gen.c | 276 ++++++++++-
 app/test-flow-perf/actions_gen.h |  31 ++
 app/test-flow-perf/async_flow.c  | 783 +++++++++++++++++++++++++++++++
 app/test-flow-perf/async_flow.h  |  54 +++
 app/test-flow-perf/items_gen.c   |  56 +++
 app/test-flow-perf/items_gen.h   |   6 +
 app/test-flow-perf/main.c        | 283 ++++++++++-
 app/test-flow-perf/meson.build   |   7 +
 10 files changed, 1458 insertions(+), 40 deletions(-)
 create mode 100644 app/test-flow-perf/async_flow.c
 create mode 100644 app/test-flow-perf/async_flow.h

diff --git a/.mailmap b/.mailmap
index 6c4c977dde..a0141402c3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1044,6 +1044,7 @@ Mauro Annarumma <mauroannarumma@hotmail.it>
 Maxime Coquelin <maxime.coquelin@redhat.com>
 Maxime Gouin <maxime.gouin@6wind.com>
 Maxime Leroy <maxime@leroys.fr> <maxime.leroy@6wind.com>
+Maxime Peim <maxime.peim@gmail.com>
 Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
 Megha Ajmera <megha.ajmera@intel.com>
 Meijuan Zhao <meijuanx.zhao@intel.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1b2f1ed2ba..d4c01037c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1964,6 +1964,7 @@ F: doc/guides/tools/dmaperf.rst
 
 Flow performance tool
 M: Wisam Jaddo <wisamm@nvidia.com>
+M: Maxime Peim <maxime.peim@gmail.com>
 F: app/test-flow-perf/
 F: doc/guides/tools/flow-perf.rst
 
diff --git a/app/test-flow-perf/actions_gen.c b/app/test-flow-perf/actions_gen.c
index 9d102e3af4..624ecfdf43 100644
--- a/app/test-flow-perf/actions_gen.c
+++ b/app/test-flow-perf/actions_gen.c
@@ -36,27 +36,7 @@ struct additional_para {
 	bool unique_data;
 };
 
-/* Storage for struct rte_flow_action_raw_encap including external data. */
-struct action_raw_encap_data {
-	struct rte_flow_action_raw_encap conf;
-	uint8_t data[128];
-	uint8_t preserve[128];
-	uint16_t idx;
-};
-
-/* Storage for struct rte_flow_action_raw_decap including external data. */
-struct action_raw_decap_data {
-	struct rte_flow_action_raw_decap conf;
-	uint8_t data[128];
-	uint16_t idx;
-};
-
-/* Storage for struct rte_flow_action_rss including external data. */
-struct action_rss_data {
-	struct rte_flow_action_rss conf;
-	uint8_t key[40];
-	uint16_t queue[128];
-};
+/* Compound action data structs defined in actions_gen.h */
 
 static void
 add_mark(struct rte_flow_action *actions,
@@ -1165,3 +1145,257 @@ fill_actions(struct rte_flow_action *actions, uint64_t *flow_actions,
 	free(queues);
 	free(hairpin_queues);
 }
+
+size_t
+action_conf_size(enum rte_flow_action_type type)
+{
+	switch (type) {
+	case RTE_FLOW_ACTION_TYPE_MARK:
+		return sizeof(struct rte_flow_action_mark);
+	case RTE_FLOW_ACTION_TYPE_QUEUE:
+		return sizeof(struct rte_flow_action_queue);
+	case RTE_FLOW_ACTION_TYPE_JUMP:
+		return sizeof(struct rte_flow_action_jump);
+	case RTE_FLOW_ACTION_TYPE_RSS:
+		return sizeof(struct action_rss_data);
+	case RTE_FLOW_ACTION_TYPE_SET_META:
+		return sizeof(struct rte_flow_action_set_meta);
+	case RTE_FLOW_ACTION_TYPE_SET_TAG:
+		return sizeof(struct rte_flow_action_set_tag);
+	case RTE_FLOW_ACTION_TYPE_PORT_ID:
+		return sizeof(struct rte_flow_action_port_id);
+	case RTE_FLOW_ACTION_TYPE_COUNT:
+		return sizeof(struct rte_flow_action_count);
+	case RTE_FLOW_ACTION_TYPE_SET_MAC_SRC:
+	case RTE_FLOW_ACTION_TYPE_SET_MAC_DST:
+		return sizeof(struct rte_flow_action_set_mac);
+	case RTE_FLOW_ACTION_TYPE_SET_IPV4_SRC:
+	case RTE_FLOW_ACTION_TYPE_SET_IPV4_DST:
+		return sizeof(struct rte_flow_action_set_ipv4);
+	case RTE_FLOW_ACTION_TYPE_SET_IPV6_SRC:
+	case RTE_FLOW_ACTION_TYPE_SET_IPV6_DST:
+		return sizeof(struct rte_flow_action_set_ipv6);
+	case RTE_FLOW_ACTION_TYPE_SET_TP_SRC:
+	case RTE_FLOW_ACTION_TYPE_SET_TP_DST:
+		return sizeof(struct rte_flow_action_set_tp);
+	case RTE_FLOW_ACTION_TYPE_INC_TCP_ACK:
+	case RTE_FLOW_ACTION_TYPE_DEC_TCP_ACK:
+	case RTE_FLOW_ACTION_TYPE_INC_TCP_SEQ:
+	case RTE_FLOW_ACTION_TYPE_DEC_TCP_SEQ:
+		return sizeof(rte_be32_t);
+	case RTE_FLOW_ACTION_TYPE_SET_TTL:
+		return sizeof(struct rte_flow_action_set_ttl);
+	case RTE_FLOW_ACTION_TYPE_SET_IPV4_DSCP:
+	case RTE_FLOW_ACTION_TYPE_SET_IPV6_DSCP:
+		return sizeof(struct rte_flow_action_set_dscp);
+	case RTE_FLOW_ACTION_TYPE_METER:
+		return sizeof(struct rte_flow_action_meter);
+	case RTE_FLOW_ACTION_TYPE_RAW_ENCAP:
+		return sizeof(struct action_raw_encap_data);
+	case RTE_FLOW_ACTION_TYPE_RAW_DECAP:
+		return sizeof(struct action_raw_decap_data);
+	case RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP:
+		return sizeof(struct rte_flow_action_vxlan_encap) +
+		       5 * sizeof(struct rte_flow_item) + sizeof(struct rte_flow_item_eth) +
+		       sizeof(struct rte_flow_item_ipv4) + sizeof(struct rte_flow_item_udp) +
+		       sizeof(struct rte_flow_item_vxlan);
+	case RTE_FLOW_ACTION_TYPE_MODIFY_FIELD:
+		return sizeof(struct rte_flow_action_modify_field);
+	/* Zero-conf types */
+	case RTE_FLOW_ACTION_TYPE_DROP:
+	case RTE_FLOW_ACTION_TYPE_FLAG:
+	case RTE_FLOW_ACTION_TYPE_DEC_TTL:
+	case RTE_FLOW_ACTION_TYPE_VXLAN_DECAP:
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+void
+fill_actions_template(struct rte_flow_action *actions, struct rte_flow_action *masks,
+		      uint64_t *flow_actions, struct rte_flow_port_attr *port_attr,
+		      bool *need_wire_orig_table)
+{
+	uint8_t actions_counter = 0;
+	uint8_t i, j;
+
+	*need_wire_orig_table = false;
+	memset(port_attr, 0, sizeof(*port_attr));
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
+		.dst = {.field = RTE_FLOW_FIELD_META},
+		.src = {
+			.field = RTE_FLOW_FIELD_VALUE,
+			.value = {0, 0, 0, META_DATA},
+		},
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
+	static struct rte_flow_action_set_ipv6 set_ipv6_mask = {
+		.ipv6_addr.a = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				0xff, 0xff, 0xff, 0xff, 0xff}};
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
+
+			switch (template_actions[i].type) {
+			case RTE_FLOW_ACTION_TYPE_COUNT:
+				port_attr->nb_counters++;
+				break;
+			case RTE_FLOW_ACTION_TYPE_AGE:
+				port_attr->nb_aging_objects++;
+				break;
+			case RTE_FLOW_ACTION_TYPE_METER:
+				port_attr->nb_meters++;
+				break;
+			case RTE_FLOW_ACTION_TYPE_CONNTRACK:
+				port_attr->nb_conn_tracks++;
+				break;
+			case RTE_FLOW_ACTION_TYPE_QUOTA:
+				port_attr->nb_quotas++;
+			default:
+				break;
+			}
+
+			actions[actions_counter].type = template_actions[i].type;
+			actions[actions_counter].conf = template_actions[i].action_conf;
+			masks[actions_counter].type = template_actions[i].type;
+			masks[actions_counter].conf = template_actions[i].action_mask;
+			*need_wire_orig_table |= template_actions[i].need_wire_orig_table;
+			break;
+		}
+	}
+
+	actions[actions_counter].type = RTE_FLOW_ACTION_TYPE_END;
+	masks[actions_counter].type = RTE_FLOW_ACTION_TYPE_END;
+}
diff --git a/app/test-flow-perf/actions_gen.h b/app/test-flow-perf/actions_gen.h
index 9e13b164f9..cd4d1753bc 100644
--- a/app/test-flow-perf/actions_gen.h
+++ b/app/test-flow-perf/actions_gen.h
@@ -17,9 +17,40 @@
 #define RTE_VXLAN_GPE_UDP_PORT 250
 #define RTE_GENEVE_UDP_PORT 6081
 
+/* Compound action data structures (needed by async_flow.c for slot init) */
+
+/* Storage for struct rte_flow_action_raw_encap including external data. */
+struct action_raw_encap_data {
+	struct rte_flow_action_raw_encap conf;
+	uint8_t data[128];
+	uint8_t preserve[128];
+	uint16_t idx;
+};
+
+/* Storage for struct rte_flow_action_raw_decap including external data. */
+struct action_raw_decap_data {
+	struct rte_flow_action_raw_decap conf;
+	uint8_t data[128];
+	uint16_t idx;
+};
+
+/* Storage for struct rte_flow_action_rss including external data. */
+struct action_rss_data {
+	struct rte_flow_action_rss conf;
+	uint8_t key[40];
+	uint16_t queue[128];
+};
+
 void fill_actions(struct rte_flow_action *actions, uint64_t *flow_actions,
 	uint32_t counter, uint16_t next_table, uint16_t hairpinq,
 	uint64_t encap_data, uint64_t decap_data, uint8_t core_idx,
 	bool unique_data, uint8_t rx_queues_count, uint16_t dst_port);
 
+/* Fill actions template for async flow API (types only, no values) */
+void fill_actions_template(struct rte_flow_action *actions, struct rte_flow_action *masks,
+			   uint64_t *flow_actions, struct rte_flow_port_attr *port_attr,
+			   bool *need_wire_orig_table);
+
+size_t action_conf_size(enum rte_flow_action_type type);
+
 #endif /* FLOW_PERF_ACTION_GEN */
diff --git a/app/test-flow-perf/async_flow.c b/app/test-flow-perf/async_flow.c
new file mode 100644
index 0000000000..3ead41393c
--- /dev/null
+++ b/app/test-flow-perf/async_flow.c
@@ -0,0 +1,783 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 Maxime Peim <maxime.peim@gmail.com>
+ *
+ * This file contains the async flow API implementation
+ * for the flow-perf application.
+ */
+
+#include <stdlib.h>
+#include <string.h>
+
+#include <rte_bitops.h>
+#include <rte_common.h>
+#include <rte_ethdev.h>
+#include <rte_flow.h>
+#include <rte_vxlan.h>
+
+#include "actions_gen.h"
+#include "async_flow.h"
+#include "flow_gen.h"
+#include "items_gen.h"
+
+/* Max iterations when draining pending async completions during cleanup */
+#define DRAIN_MAX_ITERATIONS 100
+
+/* Per-port async flow resources */
+static struct async_flow_resources port_resources[MAX_PORTS];
+
+/*
+ * Initialize compound action types within a pre-allocated slot.
+ * Called once per slot during pool init to set up internal pointers
+ * for RSS, RAW_ENCAP, RAW_DECAP and VXLAN_ENCAP actions.
+ */
+static void
+init_slot_compound_actions(struct rte_flow_action *actions, uint32_t n_actions,
+			   const size_t *action_conf_sizes)
+{
+	uint32_t i;
+
+	for (i = 0; i < n_actions; i++) {
+		if (action_conf_sizes[i] == 0)
+			continue;
+
+		switch (actions[i].type) {
+		case RTE_FLOW_ACTION_TYPE_RSS: {
+			struct action_rss_data *rss = RTE_CAST_PTR(typeof(rss), actions[i].conf);
+			rss->conf.func = RTE_ETH_HASH_FUNCTION_DEFAULT;
+			rss->conf.level = 0;
+			rss->conf.types = GET_RSS_HF();
+			rss->conf.key_len = sizeof(rss->key);
+			rss->conf.key = rss->key;
+			rss->conf.queue = rss->queue;
+			rss->key[0] = 1;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_RAW_ENCAP: {
+			struct action_raw_encap_data *encap =
+				RTE_CAST_PTR(typeof(encap), actions[i].conf);
+			encap->conf.data = encap->data;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_RAW_DECAP: {
+			struct action_raw_decap_data *decap =
+				RTE_CAST_PTR(typeof(decap), actions[i].conf);
+			decap->conf.data = decap->data;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP: {
+			/*
+			 * Layout within the conf area:
+			 *   struct rte_flow_action_vxlan_encap
+			 *   struct rte_flow_item[5]
+			 *   struct rte_flow_item_eth
+			 *   struct rte_flow_item_ipv4
+			 *   struct rte_flow_item_udp
+			 *   struct rte_flow_item_vxlan
+			 */
+			uint8_t *base = RTE_CAST_PTR(typeof(base), actions[i].conf);
+			struct rte_flow_action_vxlan_encap *ve =
+				(struct rte_flow_action_vxlan_encap *)base;
+			struct rte_flow_item *items =
+				(struct rte_flow_item
+					 *)(base + sizeof(struct rte_flow_action_vxlan_encap));
+			uint8_t *data = (uint8_t *)(items + 5);
+
+			struct rte_flow_item_eth *item_eth = (struct rte_flow_item_eth *)data;
+			data += sizeof(struct rte_flow_item_eth);
+			struct rte_flow_item_ipv4 *item_ipv4 = (struct rte_flow_item_ipv4 *)data;
+			data += sizeof(struct rte_flow_item_ipv4);
+			struct rte_flow_item_udp *item_udp = (struct rte_flow_item_udp *)data;
+			data += sizeof(struct rte_flow_item_udp);
+			struct rte_flow_item_vxlan *item_vxlan = (struct rte_flow_item_vxlan *)data;
+
+			memset(item_eth, 0, sizeof(*item_eth));
+			memset(item_ipv4, 0, sizeof(*item_ipv4));
+			memset(item_udp, 0, sizeof(*item_udp));
+			memset(item_vxlan, 0, sizeof(*item_vxlan));
+
+			item_ipv4->hdr.src_addr = RTE_IPV4(127, 0, 0, 1);
+			item_ipv4->hdr.version_ihl = RTE_IPV4_VHL_DEF;
+			item_udp->hdr.dst_port = RTE_BE16(RTE_VXLAN_DEFAULT_PORT);
+			item_vxlan->hdr.vni[2] = 1;
+
+			items[0].type = RTE_FLOW_ITEM_TYPE_ETH;
+			items[0].spec = item_eth;
+			items[0].mask = item_eth;
+			items[1].type = RTE_FLOW_ITEM_TYPE_IPV4;
+			items[1].spec = item_ipv4;
+			items[1].mask = item_ipv4;
+			items[2].type = RTE_FLOW_ITEM_TYPE_UDP;
+			items[2].spec = item_udp;
+			items[2].mask = item_udp;
+			items[3].type = RTE_FLOW_ITEM_TYPE_VXLAN;
+			items[3].spec = item_vxlan;
+			items[3].mask = item_vxlan;
+			items[4].type = RTE_FLOW_ITEM_TYPE_END;
+
+			ve->definition = items;
+			break;
+		}
+		default:
+			break;
+		}
+	}
+}
+
+/*
+ * Allocate and pre-initialize all per-slot flat buffers.
+ * Returns 0 on success.
+ */
+static int
+init_slot_pool(struct async_flow_resources *res, uint32_t nb_queues, uint32_t queue_size,
+	       const struct rte_flow_item *pattern, const struct rte_flow_action *template_actions)
+{
+	size_t item_spec_sizes[MAX_ITEMS_NUM], action_conf_sizes[MAX_ACTIONS_NUM];
+	uint32_t items_array_bytes, actions_array_bytes;
+	uint32_t spec_data_bytes, conf_data_bytes;
+	uint32_t slot_size, num_slots;
+	uint32_t s, i;
+	uint8_t n_items, n_actions;
+	uint8_t *mptr;
+	int ret = 0;
+
+	/* Compute shared mask size */
+	spec_data_bytes = 0;
+	for (n_items = 0; pattern[n_items].type != RTE_FLOW_ITEM_TYPE_END; n_items++) {
+		item_spec_sizes[n_items] = item_spec_size(pattern[n_items].type);
+		spec_data_bytes += item_spec_sizes[n_items];
+	}
+
+	/* END */
+	item_spec_sizes[n_items++] = 0;
+
+	conf_data_bytes = 0;
+	for (n_actions = 0; template_actions[n_actions].type != RTE_FLOW_ACTION_TYPE_END;
+	     n_actions++) {
+		action_conf_sizes[n_actions] = action_conf_size(template_actions[n_actions].type);
+		conf_data_bytes += action_conf_sizes[n_actions];
+	}
+
+	/* END */
+	action_conf_sizes[n_actions++] = 0;
+
+	/* Compute per-slot layout sizes */
+	items_array_bytes = n_items * sizeof(struct rte_flow_item);
+	actions_array_bytes = n_actions * sizeof(struct rte_flow_action);
+
+	slot_size = RTE_ALIGN_CEIL(items_array_bytes + actions_array_bytes + spec_data_bytes +
+					   conf_data_bytes,
+				   RTE_CACHE_LINE_SIZE);
+
+	num_slots = queue_size * nb_queues;
+
+	/* Store layout info */
+	res->slot_size = slot_size;
+	res->slots_per_queue = queue_size;
+	res->nb_queues = nb_queues;
+	res->n_items = n_items;
+	res->n_actions = n_actions;
+
+	/* Allocate shared masks */
+	if (spec_data_bytes > 0) {
+		res->shared_masks = aligned_alloc(RTE_CACHE_LINE_SIZE, spec_data_bytes);
+		if (res->shared_masks == NULL) {
+			fprintf(stderr, "Failed to allocate shared masks (%u bytes)\n",
+				spec_data_bytes);
+			return -ENOMEM;
+		}
+		memset(res->shared_masks, 0, spec_data_bytes);
+
+		/* Copy mask data from template pattern */
+		mptr = res->shared_masks;
+		for (i = 0; i < n_items; i++) {
+			if (item_spec_sizes[i] > 0 && pattern[i].mask != NULL)
+				memcpy(mptr, pattern[i].mask, item_spec_sizes[i]);
+			mptr += item_spec_sizes[i];
+		}
+	}
+
+	/* Allocate per-slot pool */
+	/* slot_size is already cache-line aligned, so total is a multiple */
+	res->slot_pool = aligned_alloc(RTE_CACHE_LINE_SIZE, (size_t)num_slots * slot_size);
+	if (res->slot_pool == NULL) {
+		fprintf(stderr, "Failed to allocate slot pool (%u slots * %u bytes)\n", num_slots,
+			slot_size);
+		ret = -ENOMEM;
+		goto free_shared_masks;
+	}
+	memset(res->slot_pool, 0, (size_t)num_slots * slot_size);
+
+	/* Pre-initialize every slot */
+	for (s = 0; s < num_slots; s++) {
+		uint8_t *slot = res->slot_pool + (size_t)s * slot_size;
+		struct rte_flow_item *items = (struct rte_flow_item *)slot;
+		struct rte_flow_action *actions =
+			(struct rte_flow_action *)(slot + items_array_bytes);
+		uint8_t *data = slot + items_array_bytes + actions_array_bytes;
+
+		/* Pre-set items: spec → per-slot data, mask → shared masks */
+		mptr = res->shared_masks;
+		for (i = 0; i < n_items; i++) {
+			items[i].type = pattern[i].type;
+			if (item_spec_sizes[i] > 0) {
+				items[i].spec = data;
+				items[i].mask = mptr;
+				data += item_spec_sizes[i];
+				mptr += item_spec_sizes[i];
+			}
+		}
+
+		/* Pre-set actions: conf → per-slot data */
+		for (i = 0; i < n_actions; i++) {
+			actions[i].type = template_actions[i].type;
+			if (action_conf_sizes[i] > 0) {
+				actions[i].conf = data;
+				data += action_conf_sizes[i];
+			}
+		}
+
+		/* Initialize compound action types (RSS, RAW_ENCAP, etc.) */
+		init_slot_compound_actions(actions, n_actions, action_conf_sizes);
+	}
+
+	/* Allocate and initialize per-queue slot tracking */
+	res->queues =
+		aligned_alloc(RTE_CACHE_LINE_SIZE, nb_queues * sizeof(struct async_flow_queue));
+	if (res->queues == NULL) {
+		fprintf(stderr, "Failed to allocate queue structs (%u queues)\n", nb_queues);
+		ret = -ENOMEM;
+		goto free_slot_pool;
+	}
+	memset(res->queues, 0, nb_queues * sizeof(struct async_flow_queue));
+	for (s = 0; s < nb_queues; s++) {
+		res->queues[s].slots = res->slot_pool + (size_t)s * queue_size * slot_size;
+		res->queues[s].head = 0;
+	}
+
+	printf(":: Slot pool: %u slots * %u bytes = %u KB (shared masks: %u bytes)\n", num_slots,
+	       slot_size, (num_slots * slot_size) / 1024, spec_data_bytes);
+
+	return 0;
+
+free_slot_pool:
+	free(res->slot_pool);
+	res->slot_pool = NULL;
+free_shared_masks:
+	if (res->shared_masks) {
+		free(res->shared_masks);
+		res->shared_masks = NULL;
+	}
+	return ret;
+}
+
+/*
+ * Hot-path: update per-flow item values through pre-set pointers.
+ * Only IPv4/IPv6 src_addr varies per flow (based on counter).
+ */
+static void
+update_item_values(struct rte_flow_item *items, uint32_t counter)
+{
+	uint8_t i;
+
+	for (i = 0; items[i].type != RTE_FLOW_ITEM_TYPE_END; i++) {
+		switch (items[i].type) {
+		case RTE_FLOW_ITEM_TYPE_IPV4: {
+			struct rte_flow_item_ipv4 *spec = RTE_CAST_PTR(typeof(spec), items[i].spec);
+			spec->hdr.src_addr = RTE_BE32(counter);
+			break;
+		}
+		case RTE_FLOW_ITEM_TYPE_IPV6: {
+			struct rte_flow_item_ipv6 *spec = RTE_CAST_PTR(typeof(spec), items[i].spec);
+			uint8_t j;
+			for (j = 0; j < 4; j++)
+				spec->hdr.src_addr.a[15 - j] = counter >> (j * 8);
+			break;
+		}
+		default:
+			break;
+		}
+	}
+}
+
+/*
+ * Hot-path: update per-flow action values through pre-set pointers.
+ */
+static void
+update_action_values(struct rte_flow_action *actions, uint32_t counter, uint16_t hairpinq,
+		     uint64_t encap_data, uint64_t decap_data, __rte_unused uint8_t core_idx,
+		     bool unique_data, uint8_t rx_queues_count, uint16_t dst_port)
+{
+	uint8_t i;
+
+	for (i = 0; actions[i].type != RTE_FLOW_ACTION_TYPE_END; i++) {
+		switch (actions[i].type) {
+		case RTE_FLOW_ACTION_TYPE_MARK: {
+			struct rte_flow_action_mark *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			conf->id = (counter % 255) + 1;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_QUEUE: {
+			struct rte_flow_action_queue *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			conf->index = hairpinq ? (counter % hairpinq) + rx_queues_count :
+						 counter % rx_queues_count;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_METER: {
+			struct rte_flow_action_meter *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			conf->mtr_id = counter;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_RSS: {
+			struct action_rss_data *conf = RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			uint16_t q;
+			if (hairpinq) {
+				conf->conf.queue_num = hairpinq;
+				for (q = 0; q < hairpinq; q++)
+					conf->queue[q] = q + rx_queues_count;
+			} else {
+				conf->conf.queue_num = rx_queues_count;
+				for (q = 0; q < rx_queues_count; q++)
+					conf->queue[q] = q;
+			}
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_SET_MAC_SRC:
+		case RTE_FLOW_ACTION_TYPE_SET_MAC_DST: {
+			struct rte_flow_action_set_mac *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			uint32_t val = unique_data ? counter : 1;
+			uint8_t j;
+			for (j = 0; j < RTE_ETHER_ADDR_LEN; j++) {
+				conf->mac_addr[j] = val & 0xff;
+				val >>= 8;
+			}
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_SET_IPV4_SRC:
+		case RTE_FLOW_ACTION_TYPE_SET_IPV4_DST: {
+			struct rte_flow_action_set_ipv4 *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			uint32_t ip = unique_data ? counter : 1;
+			conf->ipv4_addr = RTE_BE32(ip + 1);
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_SET_IPV6_SRC:
+		case RTE_FLOW_ACTION_TYPE_SET_IPV6_DST: {
+			struct rte_flow_action_set_ipv6 *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			uint32_t val = unique_data ? counter : 1;
+			uint8_t j;
+			for (j = 0; j < 16; j++) {
+				conf->ipv6_addr.a[j] = val & 0xff;
+				val >>= 8;
+			}
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_SET_TP_SRC: {
+			struct rte_flow_action_set_tp *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			uint32_t tp = unique_data ? counter : 100;
+			tp = tp % 0xffff;
+			conf->port = RTE_BE16(tp & 0xffff);
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_SET_TP_DST: {
+			struct rte_flow_action_set_tp *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			uint32_t tp = unique_data ? counter : 100;
+			if (tp > 0xffff)
+				tp >>= 16;
+			conf->port = RTE_BE16(tp & 0xffff);
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_INC_TCP_ACK:
+		case RTE_FLOW_ACTION_TYPE_DEC_TCP_ACK:
+		case RTE_FLOW_ACTION_TYPE_INC_TCP_SEQ:
+		case RTE_FLOW_ACTION_TYPE_DEC_TCP_SEQ: {
+			rte_be32_t *conf = RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			uint32_t val = unique_data ? counter : 1;
+			*conf = RTE_BE32(val);
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_SET_TTL: {
+			struct rte_flow_action_set_ttl *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			uint32_t val = unique_data ? counter : 1;
+			conf->ttl_value = val % 0xff;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_SET_IPV4_DSCP:
+		case RTE_FLOW_ACTION_TYPE_SET_IPV6_DSCP: {
+			struct rte_flow_action_set_dscp *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			uint32_t val = unique_data ? counter : 1;
+			conf->dscp = val % 0xff;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_PORT_ID: {
+			struct rte_flow_action_port_id *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			conf->id = dst_port;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_RAW_ENCAP: {
+			struct action_raw_encap_data *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			uint8_t *header = conf->data;
+			struct rte_ether_hdr eth_hdr;
+			struct rte_ipv4_hdr ipv4_hdr;
+			struct rte_udp_hdr udp_hdr;
+
+			memset(&eth_hdr, 0, sizeof(eth_hdr));
+			if (encap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_ETH)) {
+				if (encap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_VLAN))
+					eth_hdr.ether_type = RTE_BE16(RTE_ETHER_TYPE_VLAN);
+				else if (encap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_IPV4))
+					eth_hdr.ether_type = RTE_BE16(RTE_ETHER_TYPE_IPV4);
+				else if (encap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_IPV6))
+					eth_hdr.ether_type = RTE_BE16(RTE_ETHER_TYPE_IPV6);
+				memcpy(header, &eth_hdr, sizeof(eth_hdr));
+				header += sizeof(eth_hdr);
+			}
+			if (encap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_IPV4)) {
+				uint32_t ip_dst = unique_data ? counter : 1;
+				memset(&ipv4_hdr, 0, sizeof(ipv4_hdr));
+				ipv4_hdr.src_addr = RTE_IPV4(127, 0, 0, 1);
+				ipv4_hdr.dst_addr = RTE_BE32(ip_dst);
+				ipv4_hdr.version_ihl = RTE_IPV4_VHL_DEF;
+				if (encap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_UDP))
+					ipv4_hdr.next_proto_id = 17; /* UDP */
+				if (encap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_GRE))
+					ipv4_hdr.next_proto_id = 47; /* GRE */
+				memcpy(header, &ipv4_hdr, sizeof(ipv4_hdr));
+				header += sizeof(ipv4_hdr);
+			}
+			if (encap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_UDP)) {
+				memset(&udp_hdr, 0, sizeof(udp_hdr));
+				if (encap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_VXLAN))
+					udp_hdr.dst_port = RTE_BE16(RTE_VXLAN_DEFAULT_PORT);
+				memcpy(header, &udp_hdr, sizeof(udp_hdr));
+				header += sizeof(udp_hdr);
+			}
+			conf->conf.size = header - conf->data;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_RAW_DECAP: {
+			struct action_raw_decap_data *conf =
+				RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			uint8_t *header = conf->data;
+			struct rte_ether_hdr eth_hdr;
+
+			memset(&eth_hdr, 0, sizeof(eth_hdr));
+			if (decap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_ETH)) {
+				if (decap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_IPV4))
+					eth_hdr.ether_type = RTE_BE16(RTE_ETHER_TYPE_IPV4);
+				else if (decap_data & FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_IPV6))
+					eth_hdr.ether_type = RTE_BE16(RTE_ETHER_TYPE_IPV6);
+				memcpy(header, &eth_hdr, sizeof(eth_hdr));
+				header += sizeof(eth_hdr);
+			}
+			conf->conf.size = header - conf->data;
+			break;
+		}
+		case RTE_FLOW_ACTION_TYPE_VXLAN_ENCAP: {
+			uint8_t *conf = RTE_CAST_PTR(typeof(conf), actions[i].conf);
+			struct rte_flow_item *vitems =
+				(struct rte_flow_item
+					 *)(conf + sizeof(struct rte_flow_action_vxlan_encap));
+			struct rte_flow_item_ipv4 *spec =
+				RTE_CAST_PTR(typeof(spec), vitems[1].spec);
+			uint32_t ip_dst = unique_data ? counter : 1;
+			/* vitems[1] is IPV4 */
+			spec->hdr.dst_addr = RTE_BE32(ip_dst);
+			break;
+		}
+		default:
+			break;
+		}
+	}
+}
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
+	struct rte_flow_queue_attr queue_attr;
+	const struct rte_flow_queue_attr **queue_attr_list;
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
+	if (port_info.max_nb_queues == 0 || queue_info.max_size == 0) {
+		fprintf(stderr, "Port %u: rte_flow_info_get reports that no queues are supported\n",
+			port_id);
+		return -1;
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
+	/* Slot ring uses bitmask wrapping, so queue_size must be power of 2 */
+	queue_size = rte_align32prevpow2(queue_size);
+	if (queue_size == 0) {
+		fprintf(stderr, "Port %u: queue_size is 0 after rounding\n", port_id);
+		return -EINVAL;
+	}
+
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
+	/* Fill templates and gather per-item/action sizes */
+	fill_items_template(pattern, flow_items, 0, 0);
+
+	at_attr.ingress = pt_attr.ingress;
+	at_attr.egress = pt_attr.egress;
+	at_attr.transfer = pt_attr.transfer;
+
+	fill_actions_template(actions, action_masks, flow_actions, &port_attr,
+			      &need_wire_orig_table);
+
+	/*
+	 * fill_actions_template count the number of actions that require each kind of object,
+	 * so we multiply by the number of rules to have correct number
+	 */
+	port_attr.nb_counters *= rules_count;
+	port_attr.nb_aging_objects *= rules_count;
+	port_attr.nb_meters *= rules_count;
+	port_attr.nb_conn_tracks *= rules_count;
+	port_attr.nb_quotas *= rules_count;
+
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
+	queue_attr_list = malloc(sizeof(*queue_attr_list) * nb_queues);
+	if (queue_attr_list == NULL) {
+		fprintf(stderr, "Port %u: failed to allocate queue_attr_list\n", port_id);
+		return -ENOMEM;
+	}
+
+	queue_attr.size = queue_size;
+	for (i = 0; i < nb_queues; i++)
+		queue_attr_list[i] = &queue_attr;
+
+	ret = rte_flow_configure(port_id, &port_attr, nb_queues, queue_attr_list, &error);
+
+	free(queue_attr_list);
+
+	if (ret != 0) {
+		fprintf(stderr, "Port %u: rte_flow_configure failed (ret=%d, type=%d): %s\n",
+			port_id, ret, error.type, error.message ? error.message : "(no message)");
+		return ret;
+	}
+
+	/* Create pattern template */
+	res->pattern_template =
+		rte_flow_pattern_template_create(port_id, &pt_attr, pattern, &error);
+	if (res->pattern_template == NULL) {
+		fprintf(stderr, "Port %u: pattern template create failed: %s\n", port_id,
+			error.message ? error.message : "(no message)");
+		return -1;
+	}
+
+	/* Create actions template */
+	res->actions_template =
+		rte_flow_actions_template_create(port_id, &at_attr, actions, action_masks, &error);
+	if (res->actions_template == NULL) {
+		fprintf(stderr, "Port %u: actions template create failed: %s\n", port_id,
+			error.message ? error.message : "(no message)");
+		ret = -1;
+		goto free_pattern;
+	}
+
+	/* Create template table */
+	res->table = rte_flow_template_table_create(port_id, &table_attr, &res->pattern_template, 1,
+						    &res->actions_template, 1, &error);
+	if (res->table == NULL) {
+		fprintf(stderr, "Port %u: template table create failed: %s\n", port_id,
+			error.message ? error.message : "(no message)");
+		ret = -1;
+		goto free_actions;
+	}
+
+	/* Allocate and pre-initialize per-slot flat buffers */
+	ret = init_slot_pool(res, nb_queues, queue_size, pattern, actions);
+	if (ret != 0) {
+		fprintf(stderr, "Port %u: slot pool init failed\n", port_id);
+		goto free_table;
+	}
+
+	res->table_capacity = rules_count;
+	res->initialized = true;
+
+	printf(":: Port %u: Async flow engine initialized (queues=%u, queue_size=%u)\n", port_id,
+	       nb_queues, queue_size);
+
+	return 0;
+
+free_table:
+	rte_flow_template_table_destroy(port_id, res->table, &error);
+	res->table = NULL;
+free_actions:
+	rte_flow_actions_template_destroy(port_id, res->actions_template, &error);
+	res->actions_template = NULL;
+free_pattern:
+	rte_flow_pattern_template_destroy(port_id, res->pattern_template, &error);
+	res->pattern_template = NULL;
+	return ret;
+}
+
+struct rte_flow *
+async_generate_flow(uint16_t port_id, uint32_t queue_id, uint32_t counter, uint16_t hairpinq,
+		    uint64_t encap_data, uint64_t decap_data, uint16_t dst_port, uint8_t core_idx,
+		    uint8_t rx_queues_count, bool unique_data, bool postpone,
+		    struct rte_flow_error *error)
+{
+	struct async_flow_resources *res;
+	struct async_flow_queue *q;
+	uint8_t *slot;
+	uint32_t idx, items_array_bytes;
+	struct rte_flow_item *items;
+	struct rte_flow_action *actions;
+	struct rte_flow_op_attr op_attr = {
+		.postpone = postpone,
+	};
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
+	if (queue_id >= res->nb_queues) {
+		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+				   "Invalid queue ID");
+		return NULL;
+	}
+
+	/* Pick the next slot from this queue's ring */
+	q = &res->queues[queue_id];
+	idx = q->head;
+	q->head = (idx + 1) & (res->slots_per_queue - 1);
+	slot = q->slots + (size_t)idx * res->slot_size;
+	items_array_bytes = res->n_items * sizeof(struct rte_flow_item);
+	items = (struct rte_flow_item *)slot;
+	actions = (struct rte_flow_action *)(slot + items_array_bytes);
+
+	/* Update only per-flow varying values */
+	update_item_values(items, counter);
+	update_action_values(actions, counter, hairpinq, encap_data, decap_data, core_idx,
+			     unique_data, rx_queues_count, dst_port);
+
+	return rte_flow_async_create(port_id, queue_id, &op_attr, res->table, items, 0, actions, 0,
+				     NULL, error);
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
+	for (i = 0; i < DRAIN_MAX_ITERATIONS; i++) {
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
+	free(res->queues);
+	res->queues = NULL;
+	free(res->slot_pool);
+	res->slot_pool = NULL;
+	free(res->shared_masks);
+	res->shared_masks = NULL;
+
+	res->initialized = false;
+}
diff --git a/app/test-flow-perf/async_flow.h b/app/test-flow-perf/async_flow.h
new file mode 100644
index 0000000000..8ef8883107
--- /dev/null
+++ b/app/test-flow-perf/async_flow.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 Maxime Peim <maxime.peim@gmail.com>
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
+/* Per-queue slot ring — tracks which slot to use next */
+struct async_flow_queue {
+	uint8_t *slots; /* pointer to this queue's region within slot_pool */
+	uint32_t head;	/* next slot index (wraps mod slots_per_queue) */
+};
+
+/* Per-port async flow resources */
+struct async_flow_resources {
+	struct rte_flow_pattern_template *pattern_template;
+	struct rte_flow_actions_template *actions_template;
+	struct rte_flow_template_table *table;
+	uint8_t *slot_pool;    /* flat buffer pool for all slots */
+	uint8_t *shared_masks; /* shared item mask data (one copy for all slots) */
+	struct async_flow_queue *queues;
+	uint32_t slot_size;	  /* bytes per slot (cache-line aligned) */
+	uint32_t slots_per_queue; /* = queue_size */
+	uint32_t nb_queues;
+	uint32_t table_capacity;
+	uint8_t n_items;   /* item count (excl. END) */
+	uint8_t n_actions; /* action count (excl. END) */
+	bool initialized;
+};
+
+/* Initialize async flow engine for a port */
+int async_flow_init_port(uint16_t port_id, uint32_t nb_queues, uint32_t queue_size,
+			 uint64_t *flow_items, uint64_t *flow_actions, uint64_t *flow_attrs,
+			 uint8_t flow_group, uint32_t rules_count);
+
+/* Create a flow rule asynchronously using pre-allocated slot */
+struct rte_flow *async_generate_flow(uint16_t port_id, uint32_t queue_id, uint32_t counter,
+				     uint16_t hairpinq, uint64_t encap_data, uint64_t decap_data,
+				     uint16_t dst_port, uint8_t core_idx, uint8_t rx_queues_count,
+				     bool unique_data, bool postpone, struct rte_flow_error *error);
+
+/* Cleanup async flow resources for a port */
+void async_flow_cleanup_port(uint16_t port_id);
+
+#endif /* FLOW_PERF_ASYNC_FLOW */
diff --git a/app/test-flow-perf/items_gen.c b/app/test-flow-perf/items_gen.c
index c740e1838f..13af05cbb5 100644
--- a/app/test-flow-perf/items_gen.c
+++ b/app/test-flow-perf/items_gen.c
@@ -389,3 +389,59 @@ fill_items(struct rte_flow_item *items,
 
 	items[items_counter].type = RTE_FLOW_ITEM_TYPE_END;
 }
+
+size_t
+item_spec_size(enum rte_flow_item_type type)
+{
+	switch (type) {
+	case RTE_FLOW_ITEM_TYPE_ETH:
+		return sizeof(struct rte_flow_item_eth);
+	case RTE_FLOW_ITEM_TYPE_VLAN:
+		return sizeof(struct rte_flow_item_vlan);
+	case RTE_FLOW_ITEM_TYPE_IPV4:
+		return sizeof(struct rte_flow_item_ipv4);
+	case RTE_FLOW_ITEM_TYPE_IPV6:
+		return sizeof(struct rte_flow_item_ipv6);
+	case RTE_FLOW_ITEM_TYPE_TCP:
+		return sizeof(struct rte_flow_item_tcp);
+	case RTE_FLOW_ITEM_TYPE_UDP:
+		return sizeof(struct rte_flow_item_udp);
+	case RTE_FLOW_ITEM_TYPE_VXLAN:
+		return sizeof(struct rte_flow_item_vxlan);
+	case RTE_FLOW_ITEM_TYPE_VXLAN_GPE:
+		return sizeof(struct rte_flow_item_vxlan_gpe);
+	case RTE_FLOW_ITEM_TYPE_GRE:
+		return sizeof(struct rte_flow_item_gre);
+	case RTE_FLOW_ITEM_TYPE_GENEVE:
+		return sizeof(struct rte_flow_item_geneve);
+	case RTE_FLOW_ITEM_TYPE_GTP:
+		return sizeof(struct rte_flow_item_gtp);
+	case RTE_FLOW_ITEM_TYPE_META:
+		return sizeof(struct rte_flow_item_meta);
+	case RTE_FLOW_ITEM_TYPE_TAG:
+		return sizeof(struct rte_flow_item_tag);
+	case RTE_FLOW_ITEM_TYPE_ICMP:
+		return sizeof(struct rte_flow_item_icmp);
+	case RTE_FLOW_ITEM_TYPE_ICMP6:
+		return sizeof(struct rte_flow_item_icmp6);
+	default:
+		return 0;
+	}
+}
+
+void
+fill_items_template(struct rte_flow_item *items, uint64_t *flow_items, uint32_t outer_ip_src,
+		    uint8_t core_idx)
+{
+	uint32_t i;
+
+	fill_items(items, flow_items, outer_ip_src, core_idx);
+
+	/* For templates, set spec to NULL - only mask matters for template matching */
+	for (i = 0; items[i].type != RTE_FLOW_ITEM_TYPE_END; i++) {
+		items[i].spec = NULL;
+	}
+
+	/* END */
+	items[i].spec = NULL;
+}
diff --git a/app/test-flow-perf/items_gen.h b/app/test-flow-perf/items_gen.h
index f4b0e9a981..85d08ef35b 100644
--- a/app/test-flow-perf/items_gen.h
+++ b/app/test-flow-perf/items_gen.h
@@ -15,4 +15,10 @@
 void fill_items(struct rte_flow_item *items, uint64_t *flow_items,
 	uint32_t outer_ip_src, uint8_t core_idx);
 
+/* Fill items template for async flow API (masks only, no spec values) */
+void fill_items_template(struct rte_flow_item *items, uint64_t *flow_items, uint32_t outer_ip_src,
+			 uint8_t core_idx);
+
+size_t item_spec_size(enum rte_flow_item_type type);
+
 #endif /* FLOW_PERF_ITEMS_GEN */
diff --git a/app/test-flow-perf/main.c b/app/test-flow-perf/main.c
index 6636d1517f..691020c719 100644
--- a/app/test-flow-perf/main.c
+++ b/app/test-flow-perf/main.c
@@ -37,11 +37,15 @@
 #include <rte_mtr.h>
 #include <rte_os_shim.h>
 
-#include "config.h"
 #include "actions_gen.h"
+#include "async_flow.h"
+#include "config.h"
 #include "flow_gen.h"
+#include "rte_build_config.h"
 
 #define MAX_BATCHES_COUNT          100
+#define MAX_ASYNC_QUEUE_SIZE	     (1 << 14)
+#define MAX_PULL_RETRIES	     (1 << 20)
 #define DEFAULT_RULES_COUNT    4000000
 #define DEFAULT_RULES_BATCH     100000
 #define DEFAULT_GROUP                0
@@ -55,7 +59,6 @@
 #define HAIRPIN_TX_CONF_LOCKED_MEMORY (0x0100)
 #define HAIRPIN_TX_CONF_RTE_MEMORY    (0x0200)
 
-struct rte_flow *flow;
 static uint8_t flow_group;
 
 static uint64_t encap_data;
@@ -81,6 +84,9 @@ static bool enable_fwd;
 static bool unique_data;
 static bool policy_mtr;
 static bool packet_mode;
+static bool async_mode;
+static uint32_t async_queue_size = 1024;
+static uint32_t async_push_batch = 256;
 
 static uint8_t rx_queues_count;
 static uint8_t tx_queues_count;
@@ -598,6 +604,13 @@ usage(char *progname)
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
@@ -734,6 +747,9 @@ args_parse(int argc, char **argv)
 		{ "policy-mtr",                 1, 0, 0 },
 		{ "meter-profile",              1, 0, 0 },
 		{ "packet-mode",                0, 0, 0 },
+		{ "async",                      0, 0, 0 },
+		{ "async-queue-size",           1, 0, 0 },
+		{ "async-push-batch",           1, 0, 0 },
 		{ 0, 0, 0, 0 },
 	};
 
@@ -913,8 +929,7 @@ args_parse(int argc, char **argv)
 					rte_exit(EXIT_FAILURE, "Invalid hairpin config mask\n");
 				hairpin_conf_mask = hp_conf;
 			}
-			if (strcmp(lgopts[opt_idx].name,
-					"port-id") == 0) {
+			if (strcmp(lgopts[opt_idx].name, "port-id") == 0) {
 				uint16_t port_idx = 0;
 
 				token = strtok(optarg, ",");
@@ -981,6 +996,26 @@ args_parse(int argc, char **argv)
 			}
 			if (strcmp(lgopts[opt_idx].name, "packet-mode") == 0)
 				packet_mode = true;
+			if (strcmp(lgopts[opt_idx].name, "async") == 0)
+				async_mode = true;
+			if (strcmp(lgopts[opt_idx].name, "async-queue-size") == 0) {
+				n = atoi(optarg);
+				if (n >= MAX_ASYNC_QUEUE_SIZE)
+					async_queue_size = MAX_ASYNC_QUEUE_SIZE;
+				else if (n > 0)
+					async_queue_size = rte_align32prevpow2(n);
+				else
+					rte_exit(EXIT_FAILURE, "async-queue-size should be > 0\n");
+			}
+			if (strcmp(lgopts[opt_idx].name, "async-push-batch") == 0) {
+				n = atoi(optarg);
+				if (n >= MAX_ASYNC_QUEUE_SIZE >> 1)
+					async_push_batch = MAX_ASYNC_QUEUE_SIZE >> 1;
+				else if (n > 0)
+					async_push_batch = rte_align32prevpow2(n);
+				else
+					rte_exit(EXIT_FAILURE, "async-push-batch should be > 0\n");
+			}
 			break;
 		default:
 			usage(argv[0]);
@@ -1457,10 +1492,10 @@ query_flows(int port_id, uint8_t core_id, struct rte_flow **flows_list)
 	mc_pool.flows_record.query[port_id][core_id] = cpu_time_used;
 }
 
-static struct rte_flow **
-insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
+static void
+insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id, struct rte_flow **flows_list)
 {
-	struct rte_flow **flows_list;
+	struct rte_flow *flow;
 	struct rte_flow_error error;
 	clock_t start_batch, end_batch;
 	double first_flow_latency;
@@ -1485,8 +1520,7 @@ insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
 	global_items[0] = FLOW_ITEM_MASK(RTE_FLOW_ITEM_TYPE_ETH);
 	global_actions[0] = FLOW_ITEM_MASK(RTE_FLOW_ACTION_TYPE_JUMP);
 
-	flows_list = rte_zmalloc("flows_list",
-		(sizeof(struct rte_flow *) * (rules_count_per_core + 1)), 0);
+	flows_list = malloc(sizeof(struct rte_flow *) * (rules_count_per_core + 1));
 	if (flows_list == NULL)
 		rte_exit(EXIT_FAILURE, "No Memory available!\n");
 
@@ -1524,6 +1558,11 @@ insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
 			core_id, rx_queues_count,
 			unique_data, max_priority, &error);
 
+		if (!flow) {
+			print_flow_error(error);
+			rte_exit(EXIT_FAILURE, "Error in creating flow\n");
+		}
+
 		if (!counter) {
 			first_flow_latency = (double) (rte_get_timer_cycles() - start_batch);
 			first_flow_latency /= rte_get_timer_hz();
@@ -1537,11 +1576,6 @@ insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
 		if (force_quit)
 			counter = end_counter;
 
-		if (!flow) {
-			print_flow_error(error);
-			rte_exit(EXIT_FAILURE, "Error in creating flow\n");
-		}
-
 		flows_list[flow_index++] = flow;
 
 		/*
@@ -1575,7 +1609,200 @@ insert_flows(int port_id, uint8_t core_id, uint16_t dst_port_id)
 		port_id, core_id, rules_count_per_core, cpu_time_used);
 
 	mc_pool.flows_record.insertion[port_id][core_id] = cpu_time_used;
-	return flows_list;
+}
+
+static inline int
+push_pull_flows_async(int port_id, int core_id, uint32_t enqueued, bool empty, bool check_op_status,
+		      struct rte_flow_error *error)
+{
+	static struct rte_flow_op_result results[RTE_MAX_LCORE][MAX_ASYNC_QUEUE_SIZE];
+	static uint32_t push_counter[RTE_MAX_LCORE] = {0};
+	uint32_t to_pull = (empty || async_push_batch > enqueued) ? enqueued : async_push_batch;
+	uint32_t pulled_complete = 0;
+	uint32_t retries = 0;
+	int pulled, i;
+	int ret = 0;
+
+	/* Push periodically to give HW work to do */
+	ret = rte_flow_push(port_id, core_id, error);
+	if (ret)
+		return ret;
+	push_counter[core_id]++;
+
+	/* Check if queue is getting full, if so push and drain completions */
+	if (!empty && push_counter[core_id] == 1)
+		return 0;
+
+	while (to_pull > 0) {
+		pulled = rte_flow_pull(port_id, core_id, results[core_id], to_pull, error);
+		if (pulled < 0) {
+			return -1;
+		} else if (pulled == 0) {
+			if (++retries > MAX_PULL_RETRIES) {
+				rte_flow_error_set(error, ETIMEDOUT,
+						   RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
+						   "Timeout waiting for async completions");
+				return -1;
+			}
+			rte_pause();
+			continue;
+		}
+		retries = 0;
+
+		to_pull -= pulled;
+		pulled_complete += pulled;
+		if (!check_op_status)
+			continue;
+
+		for (i = 0; i < pulled; i++) {
+			if (results[core_id][i].status != RTE_FLOW_OP_SUCCESS) {
+				rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+						   NULL, "Some flow rule insertion failed");
+				return -1;
+			}
+		}
+	}
+
+	return pulled_complete;
+}
+
+static void
+insert_flows_async(int port_id, uint8_t core_id, uint16_t dst_port_id, struct rte_flow **flows_list)
+{
+	struct rte_flow *flow;
+	struct rte_flow_error error;
+	clock_t start_batch, end_batch;
+	double first_flow_latency;
+	double cpu_time_used;
+	double insertion_rate;
+	double cpu_time_per_batch[MAX_BATCHES_COUNT] = {0};
+	double delta;
+	uint32_t flow_index;
+	uint32_t counter, batch_counter, start_counter = 0, end_counter;
+	int rules_batch_idx;
+	int rules_count_per_core;
+	uint32_t enqueued = 0;
+	bool first_batch = true;
+	int pulled;
+
+	rules_count_per_core = rules_count / mc_pool.cores_count;
+
+	if (async_push_batch > async_queue_size >> 1)
+		async_push_batch = async_queue_size >> 1;
+
+	/* Set boundaries of rules for each core. */
+	if (core_id)
+		start_counter = core_id * rules_count_per_core;
+	end_counter = (core_id + 1) * rules_count_per_core;
+
+	cpu_time_used = 0;
+	flow_index = 0;
+
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
+	for (counter = start_counter; counter < end_counter;) {
+		/* batch adding flow rules, this avoids unnecessary checks for push/pull */
+		for (batch_counter = 0; batch_counter < async_push_batch && counter < end_counter;
+		     batch_counter++, counter++) {
+			/* Create flow with postpone=true to batch operations */
+			flow = async_generate_flow(port_id, core_id, counter, hairpin_queues_num,
+						   encap_data, decap_data, dst_port_id, core_id,
+						   rx_queues_count, unique_data, true, &error);
+
+			if (!flow) {
+				print_flow_error(error);
+				rte_exit(EXIT_FAILURE, "Error in creating async flow\n");
+			}
+
+			if (force_quit)
+				break;
+
+			flows_list[flow_index++] = flow;
+			enqueued++;
+
+			/*
+			 * Save the insertion rate for rules batch.
+			 * Check if the insertion reached the rules
+			 * patch counter, then save the insertion rate
+			 * for this batch.
+			 */
+			if (!((counter + 1) % rules_batch)) {
+				end_batch = rte_get_timer_cycles();
+				delta = (double)(end_batch - start_batch);
+				rules_batch_idx = ((counter + 1) / rules_batch) - 1;
+				cpu_time_per_batch[rules_batch_idx] = delta / rte_get_timer_hz();
+				cpu_time_used += cpu_time_per_batch[rules_batch_idx];
+				start_batch = rte_get_timer_cycles();
+			}
+		}
+
+		pulled = push_pull_flows_async(port_id, core_id, enqueued, false, true, &error);
+		if (pulled < 0) {
+			print_flow_error(error);
+			rte_exit(EXIT_FAILURE, "Error push/pull async operations\n");
+		}
+
+		enqueued -= pulled;
+
+		if (first_batch) {
+			first_flow_latency = (double)(rte_get_timer_cycles() - start_batch);
+			first_flow_latency /= rte_get_timer_hz();
+			/* In millisecond */
+			first_flow_latency *= 1000;
+			printf(":: First Flow Batch Latency (Async) :: Port %d :: First batch (%u) "
+			       "installed in %f milliseconds\n",
+			       port_id, async_push_batch, first_flow_latency);
+			first_batch = false;
+		}
+	}
+
+	if (push_pull_flows_async(port_id, core_id, enqueued, true, true, &error) < 0) {
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
+	if (cpu_time_used > 0) {
+		insertion_rate = ((double)rules_count_per_core / cpu_time_used) / 1000;
+		printf(":: Port %d :: Core %d :: Async rules insertion rate -> %f K Rule/Sec\n",
+		       port_id, core_id, insertion_rate);
+	}
+	printf(":: Port %d :: Core %d :: The time for creating %d async rules is %f seconds\n",
+	       port_id, core_id, rules_count_per_core, cpu_time_used);
+
+	mc_pool.flows_record.insertion[port_id][core_id] = cpu_time_used;
 }
 
 static void
@@ -1585,12 +1812,18 @@ flows_handler(uint8_t core_id)
 	uint16_t port_idx = 0;
 	uint16_t nr_ports;
 	int port_id;
+	int rules_count_per_core;
 
 	nr_ports = rte_eth_dev_count_avail();
 
 	if (rules_batch > rules_count)
 		rules_batch = rules_count;
 
+	rules_count_per_core = rules_count / mc_pool.cores_count;
+	flows_list = malloc(sizeof(struct rte_flow *) * (rules_count_per_core + 1));
+	if (flows_list == NULL)
+		rte_exit(EXIT_FAILURE, "No Memory available!\n");
+
 	printf(":: Rules Count per port: %d\n\n", rules_count);
 
 	for (port_id = 0; port_id < nr_ports; port_id++) {
@@ -1602,10 +1835,10 @@ flows_handler(uint8_t core_id)
 		mc_pool.last_alloc[core_id] = (int64_t)dump_socket_mem(stdout);
 		if (has_meter())
 			meters_handler(port_id, core_id, METER_CREATE);
-		flows_list = insert_flows(port_id, core_id,
-						dst_ports[port_idx++]);
-		if (flows_list == NULL)
-			rte_exit(EXIT_FAILURE, "Error: Insertion Failed!\n");
+		if (async_mode)
+			insert_flows_async(port_id, core_id, dst_ports[port_idx++], flows_list);
+		else
+			insert_flows(port_id, core_id, dst_ports[port_idx++], flows_list);
 		mc_pool.current_alloc[core_id] = (int64_t)dump_socket_mem(stdout);
 
 		if (query_flag)
@@ -2212,6 +2445,16 @@ init_port(void)
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
@@ -2291,6 +2534,8 @@ main(int argc, char **argv)
 
 	RTE_ETH_FOREACH_DEV(port) {
 		rte_flow_flush(port, &error);
+		if (async_mode)
+			async_flow_cleanup_port(port);
 		if (rte_eth_dev_stop(port) != 0)
 			printf("Failed to stop device on port %u\n", port);
 		rte_eth_dev_close(port);
diff --git a/app/test-flow-perf/meson.build b/app/test-flow-perf/meson.build
index e101449e32..70d8671a54 100644
--- a/app/test-flow-perf/meson.build
+++ b/app/test-flow-perf/meson.build
@@ -1,8 +1,15 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2020 Mellanox Technologies, Ltd
 
+if is_windows
+    build = false
+    reason = 'not supported on Windows'
+    subdir_done()
+endif
+
 sources = files(
         'actions_gen.c',
+        'async_flow.c',
         'flow_gen.c',
         'items_gen.c',
         'main.c',
-- 
2.43.0

