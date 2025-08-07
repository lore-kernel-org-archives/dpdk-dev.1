Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24839C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 17:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5883F40A67;
	Thu,  7 Aug 2025 19:35:09 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id A700D4069F
 for <dev@dpdk.org>; Thu,  7 Aug 2025 19:35:07 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-459ddf8acf1so11774955e9.0
 for <dev@dpdk.org>; Thu, 07 Aug 2025 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754588107;
 x=1755192907; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZnfE3o0WVfvLfQCwYsuMofxzyHDIWBoPNfdhsdRpE0=;
 b=2pMa1Zu46T7iQvOtdfKiApswpBBYpUExxai2eNXncKaDn3rhpXyngrlAb59Sf+tscX
 EbTEw6EExIXFuGGPzUzgCPT2iRpO8XI4YVc/tGlX2WfFnKwDzyVrwlWfX19VjJ4y9RYR
 viuGatK6tQhidK4cd4nfhS04zaRhqZ+9L1PWK8lARXKiAB+8e9MsgKaVfKFhuC4q8e9u
 0w8s+AWSVoufeLNz2cqF0wjPjIAJh1N3lRsjqIkvBpLFvOMV3HPsRhGqB5SXZkdvR3Ms
 v3MbkDKmtu/cK7YqmXCHSuXeIp7Zj2BLDBB1V/UtS8pr1gFL0a4H/jbYX+mlbYzsdTDz
 pRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754588107; x=1755192907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZnfE3o0WVfvLfQCwYsuMofxzyHDIWBoPNfdhsdRpE0=;
 b=IN81UX0dN08o14d2W+NdLL3LsgTYuLhurTMGlxS3bt5Oe2rjNVP1hWOtU/rkmhpw4p
 bTZk3SL7Cq57onjhLb7Es5TdCDkCW7vOPZXwxI9uw9vzcSVrzqinLNLoAj+EA6XkTO6P
 fVsavJVgELCA9iYPDb4dIsIo8i+sCzJ0ueka37+0n9D3lTzE2Vo/8K3pMIEh/fa7fN9l
 HOi/Ymohjg/KQZQdbuUWtTodhKEdUgMfMyKzP6nDGws640HpS20XczWxjQvDiVJRkmr5
 GsL78uaFXu4yEq6qpmCtl6PJ5FB6OP0MSNECjxs1Su9wnHL/Dt1tBqQBsPK7ai3nAw7N
 d2OA==
X-Gm-Message-State: AOJu0YyEb1eV24KxyeqCzY2v0kHr9Zz4shvMWXL9fC9ypcyi9i9kg2mZ
 kF/sF5Evo2rktQwslWZfA5OeSq/3wsCyEJX0PL6CHPV/CLatOBVqZgqSrj39ihBjlP70EjMmlOY
 E9dtG
X-Gm-Gg: ASbGncuW6xxEa7uYQXbmXeEsdFDUGE6+aUrBTrOlv6jA294miydjn3ylVIBK4XMInoU
 9Ux/eMUp5UBdo9tXzDIc4te9A36+caHO+xYgAoWtaHEm+FfSpi+eALOqi/0IV3sX0uZJBmo6uHh
 +1xN+Ahvx4qgPhibSxw8yFoAriQDyQ67RN4Z2FS7w5tds5w7dCQ5AjaVLxU+HwvVoT3es8D1eer
 hTOEQzyzdnmL86cl8ZenJRoupZLHy6pFZTe6FdJwRoHNBNCn2EVP98jGS9LtiB+PIixZtRz2xA5
 ZUe0QVex64Evk9Vh+rTmKwXZcYy8sqRAOGLp4Od4lmDC/JVgyCk5gv65TVx3xYlN608ZoN0GDEs
 dMRz+4mGRHuPJ1eQJNWpUCZDsj+qth6uYb44Qm4AM4BFVp1U5HNGdtsNcZEVx0ZYDCRlwmEeE
X-Google-Smtp-Source: AGHT+IG6lKOhYjB2nMztkHdIsEukdfqKGJzO4RPPKb566MD0kyPp4kV5gLIzIh+6YQpMdFym8iCAuQ==
X-Received: by 2002:a05:600c:350c:b0:459:dd34:52fb with SMTP id
 5b1f17b1804b1-459e70891afmr78880565e9.12.1754588107199; 
 Thu, 07 Aug 2025 10:35:07 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm13242838f8f.19.2025.08.07.10.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 10:35:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v10 10/14] app/testpmd: support for port mirroring
Date: Thu,  7 Aug 2025 10:33:24 -0700
Message-ID: <20250807173437.11442-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807173437.11442-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250807173437.11442-1-stephen@networkplumber.org>
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

