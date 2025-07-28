Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1F9C83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 22:11:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C783340DCD;
	Tue, 29 Jul 2025 00:10:17 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by mails.dpdk.org (Postfix) with ESMTP id 90B0240A81
 for <dev@dpdk.org>; Tue, 29 Jul 2025 00:10:14 +0200 (CEST)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7e34399cdb2so497335085a.3
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753740614;
 x=1754345414; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyx+XH8SZ1E1r7hjqR6keHS+7ui7h1eER57XodAbxiQ=;
 b=yKvR86BJCY5OHUZA+Wpiqmzd69ya1M06EKfiJzcNXGvzuCTsFs8nHJoBuiQaNWepox
 v/L8jvuEhLWTH6v4V1Bc3y+/kcdDXXAqc2tGkMe97qxKgplbNrgfZUF5PVJxdsmqjCyh
 xZp+LDtUpQpi4MDw7IMZI2Y5DVYW6W9Lmi7SpqZoDYP1SH0cHB6MF6W48wPiR5CJJj3B
 FOLQ14nqkooKJ1rLZMrOg2nx8y3Y1kBRNRGtakDKNp4BYYNWjBWJ95dCS1MaZBCbmyGE
 t7jn/uocBVxkHLTGHxHTbBBqleqtg+a9+hlolfSetnx03SjBJztLF5rnt+Nji+C9Vtc8
 3SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753740614; x=1754345414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyx+XH8SZ1E1r7hjqR6keHS+7ui7h1eER57XodAbxiQ=;
 b=LN+lSAO/OIWQePCPX9vGB0jdqNdnNVY1pLKsCD+W9Xfmqc2UKTU8ORgHrpYDyRoDuf
 SUVfkLYYi5WZPPnXJKpp1pNQVzS4pCo5l+TWjf7FwBgB5C5CvTIqeWa5SMw/UOPi54ON
 EQ5eqInaaiU5PMPThebPCsVUJkAEOoxoTkbAeLLTwWRTkBN5ah9ocNWhUQUEv4nU6iIx
 o5LH7OTi6i5lRvbin1bexDpzHZ6UkupaDdePmz1P3yrC8siEs+CnsOA6qVOOZ9VmQcLv
 Q/QkceY5M7dmP4dQYlC1TI/nBx9auZePRhjg9PVBE/JiPlx1HRI/zdZEB6vl3WsW2vp/
 77wQ==
X-Gm-Message-State: AOJu0YzBqLzcatSZEEsFNY3W4O148/qQfkwfMYIiFLWjf72t+M4mlQMH
 d7G4wXXoXzyC3s8FVy5+bzVK8BUi/RpzPFqXpCIrMuRl5P9NBsBTUoYWKb/Zuc+IlJTebLClK6p
 Q2kK0
X-Gm-Gg: ASbGncsIcEtYpiVZkyx1zMWB3yYA6bAsjkUN2/Hm6Tb0SF8Y6PPQOB+ObWuEjyExbDp
 yl5QbNrOMFK6wC1ISvnU+qH64DaMXrCxanFBPwlESk0rk3tAlzWMB93HXLIiMSqJubZMlzhVGLN
 Zgvd2Vq+zPUPxErMK2eIAcQ7XF1G3rzhAc63LVchoSlQFXcJ4GGxhz8l4aJwrFMT8kzpP7X8VNV
 ou4oLyPaY4UT5lX+qAm5uMeU+YO5gepXDR+vg6sAT3KMoahMUtf/d0Ewm+1A6YtLo/XD7B2PtIX
 hbRBjrBRFpFxxcjxwCt6PgZn7krdMnjrbesBXnf9EPPcgHuCIbo8UMn9OoYFuitEulE5mbOjvEs
 0YOd+cLpnTnJusDzo5t1XdiX/ryUYo2ejg/ubT7rFjnyYynAzhQ1aW2foqWjkCH6QwStQR5PT
X-Google-Smtp-Source: AGHT+IEElaTjNGk9tnFNDX08Jds3XYcjUecfC03SO0/1TT+idtF/+H6skVcleokXYTemCCuAs58BJA==
X-Received: by 2002:a05:620a:2549:b0:7e0:46c3:c0a1 with SMTP id
 af79cd13be357-7e63bf682d5mr1714223785a.26.1753740613869; 
 Mon, 28 Jul 2025 15:10:13 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64327d41esm344024785a.15.2025.07.28.15.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 15:10:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v7 11/12] app/testpmd: support for port mirroring
Date: Mon, 28 Jul 2025 15:08:19 -0700
Message-ID: <20250728220955.332924-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728220955.332924-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250728220955.332924-1-stephen@networkplumber.org>
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

Add new commands to enable testing of port mirror functionality.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/cmdline.c                      |  13 ++
 app/test-pmd/cmdline_mirror.c               | 194 ++++++++++++++++++++
 app/test-pmd/cmdline_mirror.h               |  13 ++
 app/test-pmd/meson.build                    |   1 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  15 ++
 5 files changed, 236 insertions(+)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 7b4e27eddf..1d94e29ea7 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -66,6 +66,7 @@
 #include "testpmd.h"
 #include "cmdline_cman.h"
 #include "cmdline_mtr.h"
+#include "cmdline_mirror.h"
 #include "cmdline_tm.h"
 #include "bpf_cmd.h"
 
@@ -212,6 +213,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"show port meter stats (port_id) (meter_id) (clear)\n"
 			"    Get meter stats on a port\n\n"
 
+			"show port mirror stats (port_id) (target_id)\n"
+			"    Get port mirror stats.\n\n"
+
 			"show fwd stats all\n"
 			"    Display statistics for all fwd engines.\n\n"
 
@@ -661,6 +665,12 @@ static void cmd_help_long_parsed(void *parsed_result,
 			"set port meter stats mask (port_id) (mtr_id) (stats_mask)\n"
 			"    meter update stats\n\n"
 
+			"create port mirror (port_id) (target_id)\n"
+			"    create mirror from port_id to target_id\n\n"
+
+			"delete port mirror (port_id) (target_id)\n"
+			"    delete mirror from port_id to target_id\n\n"
+
 			"set port (port_id) fec_mode auto|off|rs|baser\n"
 			"    set fec mode for a specific port\n\n"
 
@@ -14011,6 +14021,9 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_get_port_meter_in_proto_prio,
 	&cmd_set_port_meter_stats_mask,
 	&cmd_show_port_meter_stats,
+	&cmd_create_port_mirror,
+	&cmd_delete_port_mirror,
+	&cmd_show_port_mirror_stats,
 	&cmd_mcast_addr,
 	&cmd_mcast_addr_flush,
 	&cmd_set_vf_vlan_anti_spoof,
diff --git a/app/test-pmd/cmdline_mirror.c b/app/test-pmd/cmdline_mirror.c
new file mode 100644
index 0000000000..3b20094c7e
--- /dev/null
+++ b/app/test-pmd/cmdline_mirror.c
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#include <stdlib.h>
+
+#include <cmdline_parse.h>
+#include <cmdline_parse_num.h>
+#include <cmdline_parse_string.h>
+
+#include <rte_ethdev.h>
+
+#include "testpmd.h"
+#include "cmdline_mirror.h"
+
+/* *** Create MIRROR port Object *** */
+struct cmd_create_port_mirror_result {
+	cmdline_fixed_string_t create;
+	cmdline_fixed_string_t port;
+	cmdline_fixed_string_t mirror;
+	uint16_t port_id;
+	uint16_t target_id;
+};
+
+static cmdline_parse_token_string_t cmd_create_port_mirror_create =
+	TOKEN_STRING_INITIALIZER(struct cmd_create_port_mirror_result, create, "create");
+static cmdline_parse_token_string_t cmd_create_port_mirror_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_create_port_mirror_result, port, "port");
+static cmdline_parse_token_string_t cmd_create_port_mirror_mirror =
+	TOKEN_STRING_INITIALIZER(struct cmd_create_port_mirror_result, mirror, "mirror");
+static cmdline_parse_token_num_t cmd_create_port_mirror_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_create_port_mirror_result, port_id, RTE_UINT16);
+static cmdline_parse_token_num_t cmd_create_port_mirror_target_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_create_port_mirror_result, target_id, RTE_UINT16);
+
+static void cmd_create_port_mirror_parsed(void *parsed_result,
+	__rte_unused struct cmdline *cl,
+	__rte_unused void *data)
+{
+	const struct cmd_create_port_mirror_result *res = parsed_result;
+	/* TODO these should be set by command */
+	struct rte_eth_mirror_conf mirror_conf = {
+		.direction = RTE_ETH_MIRROR_DIRECTION_INGRESS | RTE_ETH_MIRROR_DIRECTION_EGRESS
+	};
+	int ret;
+
+	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
+		return;
+
+	if (port_id_is_invalid(res->target_id, ENABLED_WARN))
+		return;
+
+	mirror_conf.target = res->target_id;
+
+	ret = rte_eth_add_mirror(res->port_id,  &mirror_conf);
+	if (ret != 0)
+		fprintf(stderr, "%s\n", rte_strerror(-ret));
+}
+
+cmdline_parse_inst_t cmd_create_port_mirror = {
+	.f = cmd_create_port_mirror_parsed,
+	.data = NULL,
+	.help_str = "create port mirror <port_id> <target_id>",
+	.tokens = {
+		(void *)&cmd_create_port_mirror_create,
+		(void *)&cmd_create_port_mirror_port,
+		(void *)&cmd_create_port_mirror_mirror,
+		(void *)&cmd_create_port_mirror_port_id,
+		(void *)&cmd_create_port_mirror_target_id,
+		NULL
+	},
+};
+
+/* *** Delete Port Mirror Object *** */
+struct cmd_delete_port_mirror_result {
+	cmdline_fixed_string_t delete;
+	cmdline_fixed_string_t port;
+	cmdline_fixed_string_t mirror;
+	uint16_t port_id;
+	uint16_t target_id;
+};
+
+static void cmd_delete_port_mirror_parsed(void *parsed_result,
+	__rte_unused struct cmdline *cl,
+	__rte_unused void *data)
+{
+	const struct cmd_delete_port_mirror_result *res = parsed_result;
+	int ret;
+
+	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
+		return;
+
+	ret = rte_eth_remove_mirror(res->port_id, res->target_id);
+	if (ret != 0)
+		fprintf(stderr, "%s\n", rte_strerror(-ret));
+}
+
+static cmdline_parse_token_string_t cmd_delete_port_mirror_delete =
+	TOKEN_STRING_INITIALIZER(struct cmd_delete_port_mirror_result, delete, "delete");
+static cmdline_parse_token_string_t cmd_delete_port_mirror_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_delete_port_mirror_result, port, "port");
+static cmdline_parse_token_string_t cmd_delete_port_mirror_mirror =
+	TOKEN_STRING_INITIALIZER(struct cmd_delete_port_mirror_result, mirror, "mirror");
+static cmdline_parse_token_num_t cmd_delete_port_mirror_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_delete_port_mirror_result, port_id, RTE_UINT16);
+static cmdline_parse_token_num_t cmd_delete_port_mirror_target_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_delete_port_mirror_result, target_id, RTE_UINT16);
+
+cmdline_parse_inst_t cmd_delete_port_mirror = {
+	.f = cmd_delete_port_mirror_parsed,
+	.data = NULL,
+	.help_str = "delete port mirror <port_id> <target_id>",
+	.tokens = {
+		(void *)&cmd_delete_port_mirror_delete,
+		(void *)&cmd_delete_port_mirror_port,
+		(void *)&cmd_delete_port_mirror_mirror,
+		(void *)&cmd_delete_port_mirror_port_id,
+		(void *)&cmd_delete_port_mirror_target_id,
+		NULL
+	},
+};
+
+/* *** Show Port Mirror Stats *** */
+struct cmd_show_port_mirror_stats_result {
+	cmdline_fixed_string_t show;
+	cmdline_fixed_string_t port;
+	cmdline_fixed_string_t mirror;
+	cmdline_fixed_string_t stats;
+	uint16_t port_id;
+	uint32_t target_id;
+};
+
+static cmdline_parse_token_string_t cmd_show_port_mirror_stats_show =
+	TOKEN_STRING_INITIALIZER(
+		struct cmd_show_port_mirror_stats_result, show, "show");
+static cmdline_parse_token_string_t cmd_show_port_mirror_stats_port =
+	TOKEN_STRING_INITIALIZER(
+		struct cmd_show_port_mirror_stats_result, port, "port");
+static cmdline_parse_token_string_t cmd_show_port_mirror_stats_mirror =
+	TOKEN_STRING_INITIALIZER(
+		struct cmd_show_port_mirror_stats_result, mirror, "mirror");
+static cmdline_parse_token_string_t cmd_show_port_mirror_stats_stats =
+	TOKEN_STRING_INITIALIZER(
+		struct cmd_show_port_mirror_stats_result, stats, "stats");
+static cmdline_parse_token_num_t cmd_show_port_mirror_stats_port_id =
+	TOKEN_NUM_INITIALIZER(
+		struct cmd_show_port_mirror_stats_result, port_id, RTE_UINT16);
+static cmdline_parse_token_num_t cmd_show_port_mirror_stats_target_id =
+	TOKEN_NUM_INITIALIZER(
+		struct cmd_show_port_mirror_stats_result, target_id, RTE_UINT32);
+
+static void cmd_show_port_mirror_stats_parsed(void *parsed_result,
+	__rte_unused struct cmdline *cl,
+	__rte_unused void *data)
+{
+	struct cmd_show_port_mirror_stats_result *res = parsed_result;
+	struct rte_eth_mirror_stats stats;
+	uint32_t target_id = res->target_id;
+	uint16_t port_id = res->port_id;
+	int ret;
+
+	if (port_id_is_invalid(port_id, ENABLED_WARN))
+		return;
+
+	if (port_id_is_invalid(target_id, ENABLED_WARN))
+		return;
+
+	ret = rte_eth_mirror_stats_get(port_id, target_id, &stats);
+	if (ret != 0) {
+		fprintf(stderr,
+			"%s: Error failed to get stats for mirror from %u to %u: %d\n",
+			__func__, port_id, target_id, ret);
+		return;
+	}
+
+	printf("Packets: %" PRIu64 "\n", stats.packets);
+	printf("No mbuf: %" PRIu64 "\n", stats.nombuf);
+	printf("Tx Full: %" PRIu64 "\n", stats.full);
+}
+
+cmdline_parse_inst_t cmd_show_port_mirror_stats = {
+	.f = cmd_show_port_mirror_stats_parsed,
+	.data = NULL,
+	.help_str = "show port mirror stats <port_id> <target_id>",
+	.tokens = {
+		(void *)&cmd_show_port_mirror_stats_show,
+		(void *)&cmd_show_port_mirror_stats_port,
+		(void *)&cmd_show_port_mirror_stats_mirror,
+		(void *)&cmd_show_port_mirror_stats_stats,
+		(void *)&cmd_show_port_mirror_stats_port_id,
+		(void *)&cmd_show_port_mirror_stats_target_id,
+		NULL
+	},
+};
diff --git a/app/test-pmd/cmdline_mirror.h b/app/test-pmd/cmdline_mirror.h
new file mode 100644
index 0000000000..b7143a9c3f
--- /dev/null
+++ b/app/test-pmd/cmdline_mirror.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#ifndef _CMDLINE_MIRROR_H_
+#define _CMDLINE_MIRROR_H_
+
+/* Port MIRROR commands */
+extern cmdline_parse_inst_t cmd_create_port_mirror;
+extern cmdline_parse_inst_t cmd_delete_port_mirror;
+extern cmdline_parse_inst_t cmd_show_port_mirror_stats;
+
+#endif /* _CMDLINE_MIRROR_H_ */
diff --git a/app/test-pmd/meson.build b/app/test-pmd/meson.build
index 000548c261..e67665028f 100644
--- a/app/test-pmd/meson.build
+++ b/app/test-pmd/meson.build
@@ -8,6 +8,7 @@ sources = files(
         'cmdline.c',
         'cmdline_cman.c',
         'cmdline_flow.c',
+        'cmdline_mirror.c',
         'cmdline_mtr.c',
         'cmdline_tm.c',
         'cmd_flex_item.c',
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 6ad83ae50d..603468a70d 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2570,6 +2570,21 @@ where:
 * ``clear``: Flag that indicates whether the statistics counters should
   be cleared (i.e. set to zero) immediately after they have been read or not.
 
+create mirror
+-------------
+
+Create a new MIRROR port for an ethernet device::
+
+   testpmd> create port mirror (port_id) destination (port_id)
+
+delete mirror
+-------------
+
+Delete an existing MIRROR port on ethernet device::
+
+   testpmd> delete port mirror (port_id)
+
+
 Traffic Management
 ------------------
 
-- 
2.47.2

