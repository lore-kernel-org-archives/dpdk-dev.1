Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AE8C87FCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 16:31:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 126B040B9E;
	Mon,  4 Aug 2025 18:31:09 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id F0D144069F
 for <dev@dpdk.org>; Mon,  4 Aug 2025 18:31:06 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b792b0b829so3425852f8f.3
 for <dev@dpdk.org>; Mon, 04 Aug 2025 09:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754325066;
 x=1754929866; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZnfE3o0WVfvLfQCwYsuMofxzyHDIWBoPNfdhsdRpE0=;
 b=uFhsDeb19s/uWANRTpH4Y4aJYoLxIIBwNmr54HRMG1AWcRpJqDAT0RC5qbeQcOEsmz
 Ft8h1+9xspjn9J2Zry24Z779tJXx1MvvIuWcAj/af5TiovaxNptb2PILlhpf7aIa8USn
 3va4zbTUj4NfGEtFjlolnZstTNlz8LpbbT2+J6iw7fFuACu6c1UggW36wb2jBxb5NKbp
 eG03wn+NyWgQILNg4v/wOhDdTd7habQg4NbuvkvVZ29nbbnkF5B0hpwWCE0sGAUAicnV
 tW/TPZWjpEsNaY/L6ntDamBcwVXo0mbNd49JkTSa9nItGTDlQI0/R7wDB9hrgw7vVnle
 Uf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325066; x=1754929866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZnfE3o0WVfvLfQCwYsuMofxzyHDIWBoPNfdhsdRpE0=;
 b=JKIRYptw4ARKMWqn1Qez66xacZnbwhZp+YyCcPhksoR6+FAvh7UxuUJBB4r9+XHK8F
 7bqwN276whiLmLct90vSgjpCMPhb9gNmuhhM9BaRNU8kyQB5gDHmFNuoza9SuCsCS5Bh
 UPTnXO9DJCTQJNCWwj4G3gGd/rRU6HgYummO+VUfJ7rxYS3ncXFxTYrXx8HQu05sQOff
 qT592TqKIONPdk/GWHMKp+gTHzquGALzbDupUmcodWislukMiuLsO+UxEuPbfjyhKvwc
 DObbV89Hj2lcJd6T5ngXkI3faRZerQLdxIed+d+dAKcFtOhFUp2R1PGteteKZLNEQepP
 lcIg==
X-Gm-Message-State: AOJu0YzPz4oxIaUOyUfJ8gKwdKzWoJJl+lPYmJsDk6FPTYkrkudmZ+NQ
 +CS5n+hKW3XOa8cpqKTdQjJpNl1HBQ9VlxXUSP/OVKvYV6BFSdeFBcxPt0Tb/cKiivRP5Zc7Eo0
 unrN9
X-Gm-Gg: ASbGncsIteI4nvmqePVO3MlDVCVQRN9dQQ48wgS3BUahWCK9zewn8ygknpHMUm/P+wD
 aWztDyTzgF7TvwHeG0uXz/+j2fZDPGf4W4xZoWQx4TdyPklCHbojNRXad9LwLPS5oehh6KUYuiU
 3M/M32aTN43+f5Vfy627tr1tNYVgpBCXagC4QskxJ8St6zYac+thd4RbSUhDuRjSEvjXb0o3I54
 OxoV2/ztGSMJgH0rRh7OXwSb9uDQ1AYKVVMz8R9ibFke64faDoW3CVh9xHNZhcDKzwSuuR7lkmD
 +HAXVzeCnriz2rJ394881OK7q128GuGFy6NeNShAcsAU2zJ/p2I9mGLkvASJrMgqCYjkqn9yB6l
 tfQHX/F+GX2IYzXmDXpisZjvjKYi4zNbHR68fe3TUTUgyFj3qYCkYXDnQ1giNImU9VNZ3gAX2
X-Google-Smtp-Source: AGHT+IHd0QW+9RQznPYIi3ye/IYMtOcOZ1VFD1kIXnXn6R+BDarKvpnD48jFQguRtDLhbMs8hu+5/Q==
X-Received: by 2002:a05:6000:22c2:b0:3b7:9141:f044 with SMTP id
 ffacd0b85a97d-3b8d947507bmr7829726f8f.21.1754325066511; 
 Mon, 04 Aug 2025 09:31:06 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b5fc556bsm105891405e9.31.2025.08.04.09.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:31:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v8 10/13] app/testpmd: support for port mirroring
Date: Mon,  4 Aug 2025 09:27:41 -0700
Message-ID: <20250804163039.138959-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804163039.138959-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250804163039.138959-1-stephen@networkplumber.org>
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
index 0000000000..6357791842
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
+		.flags = RTE_ETH_MIRROR_DIRECTION_INGRESS | RTE_ETH_MIRROR_DIRECTION_EGRESS
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

