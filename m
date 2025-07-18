Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0071C83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 16:33:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6545440E3B;
	Fri, 18 Jul 2025 18:33:08 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 619BE40E28
 for <dev@dpdk.org>; Fri, 18 Jul 2025 18:33:07 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7e169ac6009so228457985a.0
 for <dev@dpdk.org>; Fri, 18 Jul 2025 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752856387;
 x=1753461187; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zIbdjbIsBTJGrUPuCW20jRSg85NEdhyJwxltX+PYxI=;
 b=gNVV0tNwLKUCG7itv1UOvVNONZyD1bBp86h1ZR6VRdA0kwRBPf3+InkamVYTGICBSo
 igfnZdFaLNjASkJ1rPaHazZoCQLGgD8/x2Kwq36wwZlaPbqn4wlx0mtx0Po2RWdYPfdl
 f/jgzFByXq2xgM2+sOM2KS8r4hd4hSARL9wJRLWtHdytsgnDHMV69RnRd6TgR3CBiQqn
 PtYhz2/UNZuoedsQ4VPOs6VIY0ZB/shd1WiHQatACSTBP82ZHEeqM8NPCCw1p7bthtOy
 eusUH3QV1ZWkYUaak37MZnU7BdOZ+rCE/qxW7cFHEE4rzqb5GvMbdcBMK83x2SsZVh3Y
 RXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752856387; x=1753461187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0zIbdjbIsBTJGrUPuCW20jRSg85NEdhyJwxltX+PYxI=;
 b=ArGugA6hIhXg9rt7aXIsI4o0PqzR8l9FNmwyuifZJkWjaqHnUwcKamanDRLFo43fm+
 ZaFaicNo+wVZXEgx2lHkyyK474G0NsC2hi095RP2G9h0o24p9WVQI2wQLMB3f+nWelWn
 EosK9gtuoziuB/pgrbOEhT+egZvPG9291H8ok2iZAYfWD5/oot47fdC4SXYpqH87Sl0I
 W3yS6IUWyYOLTjUNHM6dkA2FI1WE1su87abkkHy06T6eo0TDGp/N1oV7eUBbRD0Vv4dF
 B5Vu/DLPbKxANR+J9re4PZMSePT5huB0i+SVenc1oJBtyIKit5wuaBpcBXidyMfUW+hG
 UzOA==
X-Gm-Message-State: AOJu0YwHxOrO2ogosAE+CZPet7byLjtOvcq1RVpdeWZOAa93B+igLbJr
 7zH8cnoyUvwCSAobgj/trPGnNl1V4JQT/d854P048/uFKsUcIVh3Z/MXXgrFWn6Zcadhh9L7Oyf
 VRZOQ
X-Gm-Gg: ASbGncug7D6k6b4WRPblIm9wuLeNVUri6Q9Ivfr5zEbTfGRdrp8SmTOuGl4+DYL+kKV
 xEDNkcSJC9hMCJkM4NWTzMIT4HvkzDfhSDfYkpHVq6ZcVVI48jJ+ac1Hhc/jrEAsjvvG9U3gj0z
 e8yAaxDakUv0ZVrv0k5zS6qzbGqVCjbjK8zoU2tBuLGHdInT7SU3iVQOjKcwV8yQQtsxZwP7kSd
 ucboMKURiJWKTELNPQEJrwFmyXguuW3p5eSrSV8NFvdgC1k8L2vPqK4v8ynHudc+elmSMJS6cyq
 34mJ2Q3DVWRHKTmduHt159BGB9I9UtP0uw0x95EmcZv7YxRoafjofv0tvN48Uy+3sASACoBhBaG
 KnUj03m9mnMfl0yOgmn3RSmCmrc9ERk0j+Fke+iRBo2oTMMPrXXN8vr/kMb5AwwDGBNz3c+4r
X-Google-Smtp-Source: AGHT+IFMMh9rUdXPat5X7Ouh/yl+aGz9spGQ4RwtKyIU7mNTExvmRI8dI60hQgJ2VidQb/0vajAUmg==
X-Received: by 2002:a05:620a:8390:b0:7e0:b2d3:f397 with SMTP id
 af79cd13be357-7e343613f77mr1278159485a.38.1752856386431; 
 Fri, 18 Jul 2025 09:33:06 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356cc1aa8sm103392685a.111.2025.07.18.09.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 09:33:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v5 11/13] app/testpmd: support for port mirroring
Date: Fri, 18 Jul 2025 09:28:28 -0700
Message-ID: <20250718163236.9870-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718163236.9870-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250718163236.9870-1-stephen@networkplumber.org>
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
 app/test-pmd/cmdline.c                      |   1 +
 app/test-pmd/cmdline_mirror.c               | 129 ++++++++++++++++++++
 app/test-pmd/cmdline_mirror.h               |  12 ++
 app/test-pmd/meson.build                    |   1 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  15 +++
 5 files changed, 158 insertions(+)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 7b4e27eddf..bc4b8b3b72 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -66,6 +66,7 @@
 #include "testpmd.h"
 #include "cmdline_cman.h"
 #include "cmdline_mtr.h"
+#include "cmdline_mirror.h"
 #include "cmdline_tm.h"
 #include "bpf_cmd.h"
 
diff --git a/app/test-pmd/cmdline_mirror.c b/app/test-pmd/cmdline_mirror.c
new file mode 100644
index 0000000000..2c645ffafe
--- /dev/null
+++ b/app/test-pmd/cmdline_mirror.c
@@ -0,0 +1,129 @@
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
+	cmdline_fixed_string_t destination;
+	uint16_t target_id;
+};
+
+static cmdline_parse_token_string_t cmd_create_port_mirror_create =
+	TOKEN_STRING_INITIALIZER(struct cmd_create_port_mirror_result, create, "create");
+static cmdline_parse_token_string_t cmd_create_port_mirror_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_create_port_mirror_result, port, "port");
+static cmdline_parse_token_string_t cmd_create_port_mirror_mirror =
+	TOKEN_STRING_INITIALIZER(struct cmd_create_port_mirror_result, mirror, "mirror");
+static cmdline_parse_token_string_t cmd_create_port_mirror_destination =
+	TOKEN_STRING_INITIALIZER(struct cmd_create_port_mirror_result, destination, "destination");
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
+	.help_str = "create port mirror <port_id> destination <port_id>",
+	.tokens = {
+		(void *)&cmd_create_port_mirror_create,
+		(void *)&cmd_create_port_mirror_port,
+		(void *)&cmd_create_port_mirror_mirror,
+		(void *)&cmd_create_port_mirror_port_id,
+		(void *)&cmd_create_port_mirror_destination,
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
+	cmdline_fixed_string_t destination;
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
+static cmdline_parse_token_string_t cmd_delete_port_mirror_destination =
+	TOKEN_STRING_INITIALIZER(struct cmd_create_port_mirror_result, destination, "destination");
+static cmdline_parse_token_num_t cmd_delete_port_mirror_target_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_delete_port_mirror_result, target_id, RTE_UINT16);
+
+cmdline_parse_inst_t cmd_delete_port_mirror = {
+	.f = cmd_delete_port_mirror_parsed,
+	.data = NULL,
+	.help_str = "delete port mirror <port_id> destination <port_id>",
+	.tokens = {
+		(void *)&cmd_delete_port_mirror_delete,
+		(void *)&cmd_delete_port_mirror_port,
+		(void *)&cmd_delete_port_mirror_mirror,
+		(void *)&cmd_delete_port_mirror_port_id,
+		(void *)&cmd_delete_port_mirror_destination,
+		(void *)&cmd_delete_port_mirror_target_id,
+		NULL
+	},
+};
diff --git a/app/test-pmd/cmdline_mirror.h b/app/test-pmd/cmdline_mirror.h
new file mode 100644
index 0000000000..23ebe1ed75
--- /dev/null
+++ b/app/test-pmd/cmdline_mirror.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Stephen Hemminger <stephen@networkplumber.org>
+ */
+
+#ifndef _CMDLINE_MIRROR_H_
+#define _CMDLINE_MIRROR_H_
+
+/* Port MIRROR commands */
+extern cmdline_parse_inst_t cmd_create_port_mirror;
+extern cmdline_parse_inst_t cmd_disable_port_mirror;
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

