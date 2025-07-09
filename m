Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5A6C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 17:37:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE7AF40E2E;
	Wed,  9 Jul 2025 19:36:29 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 3C32640E19
 for <dev@dpdk.org>; Wed,  9 Jul 2025 19:36:25 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-235f9ea8d08so1811605ad.1
 for <dev@dpdk.org>; Wed, 09 Jul 2025 10:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752082584;
 x=1752687384; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zIbdjbIsBTJGrUPuCW20jRSg85NEdhyJwxltX+PYxI=;
 b=lpxzq6w2UaIIVqLVrpAeuMiGGMKvL7FG5pkYoAMuw6Ekijmwrb914vdMhDyEvZ7qoX
 jEdl/Th+GZHNHCeXqgSbAgBBzt9m2iPkGGXqVhjQj0Ulgxs7kGCBd094kb5UKhC1VJyQ
 uDltrPHTeQG7OLPcaJUNS5VM93lduot12PNhWwa4JaDIS4AuKY194sdM+MOX4CkeHmYX
 1Ph4tNxZooZOAg9tXkwbhS0XQ0Z5vxoSVb/VGRudIjGM24QJEseIaYKnN4tu5fl7LlfC
 VY+XYagrezMDasW23RGItfaiDUv47eCvRta0fyGfl+4Ww1jEg2GRRhUKSv7cuaOqJxkQ
 tY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752082584; x=1752687384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0zIbdjbIsBTJGrUPuCW20jRSg85NEdhyJwxltX+PYxI=;
 b=AAWY9xQFSGzAi6NCFljI3KfQi52QCKkcMvA/TQRUVieU2iN6MZqfgsWOhfcHDx1v52
 k+QvA/3x/+2AOS+RAgORA+mkdhgl0UrZs+qsWcUxfcLAyLSmGlgTihq8E8+Sg7qancY7
 OFiW7rbQFAiWxbglxWsaDMRL8nCw9rM4LEoiWNnfmRhwU3SXlVj8ngdPyd+7U8eOXHtw
 lpgp7IrgAs46wuiUqR3ZAxWcTvfSHn25T6FG/ffG1+3QNOX4f3cpQgPZ1Toa8daKTxJm
 tLxqSRAkarFsBG2/WaOKLlGDKM2Z25gQ/4TbvHw25nLmeaN2e9DGxcgBwpni//zvg9uC
 mnrw==
X-Gm-Message-State: AOJu0YxdR6Sjys0WpRyrHybte23o1jeZMMo2/lmEnrm1PlEkH+uxWhHO
 xCbpRlHIfwlFiudKLDaad1EzZI1QFYYLHcL3++iO0iz4UBC0DqfhGGIjpGdppOHSCOFZpX0km2y
 /J1IM
X-Gm-Gg: ASbGncv1Naeg5EtKUxRIUhEQx++qhbFxSmgj4poSODriGelS86yAPw/j/Uflw1WO3fH
 4Z2jzioNK80LoIRyftFo888qJdSbhUeF5RugoQ6SpplMt143h0a91mu3zgViGaLxD9sJ0OTt50Y
 4dahUc3BX6IasMmsqUK3YcNGe3oc6eOe7feJTZ9RknIJi05wAB7fBjd31KntB3jKnWQp9FoycJN
 rOKzl0vnHIT10wL9xjpI00X+Lu2Ml8wThDm9qJbepZl6QJQKU68dObIQpyHd2SDCiWjyXRecMmh
 +TDPio2fKjoylCWehgmGkPWgvOVqHmYFfu9bnS3amCdczyt/QrdRR+xyrr4buqoO+Kl17DL8weA
 P9AiddobEzX7SgOR3iu3gHPeY/oRsCRjx1lyu
X-Google-Smtp-Source: AGHT+IFb8YhUJyPK1iSETz2TGwkRznknHBsZiUTAGsDSAomyT4ENrJBoDUl8wGxyGVuLzP7qoq2kFg==
X-Received: by 2002:a17:903:faf:b0:236:8df7:b30a with SMTP id
 d9443c01a7336-23ddb1a0717mr53596335ad.1.1752082584270; 
 Wed, 09 Jul 2025 10:36:24 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c845b7467sm138525475ad.230.2025.07.09.10.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 10:36:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [RFC v2 10/12] app/testpmd: support for port mirroring
Date: Wed,  9 Jul 2025 10:33:36 -0700
Message-ID: <20250709173611.6390-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250709173611.6390-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250709173611.6390-1-stephen@networkplumber.org>
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

