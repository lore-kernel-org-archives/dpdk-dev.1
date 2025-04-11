Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F1AC369AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 23:51:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D302B40E4B;
	Sat, 12 Apr 2025 01:49:56 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 4FF1E40E1E
 for <dev@dpdk.org>; Sat, 12 Apr 2025 01:49:50 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-7fd581c2bf4so2309502a12.3
 for <dev@dpdk.org>; Fri, 11 Apr 2025 16:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744415389;
 x=1745020189; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7hw9uLttLA2GYfmrnQpmGdiTIFpq3OUSqsW/9Oojzg=;
 b=cWpcpgQ25JcHvmZ3FCRIBwoG4k9o+nmhO7iEwDY/U9i20QYTdgFmP8PpFgLWTpNQlF
 uP6pOhltxuLQ5vh4H+bhftqpjQqR15EMKhnU5bAGXcvSh5Q2+l8n78tgDD+bJKKdLuwW
 5e0att1X+laMgQX/LstImUBlGdZnQcmHxYon055hKx9RcBtsxwIpZuYeeP226F9c2vPK
 7oS7u9MWezQqUa+xKko6T0ehJjykg/qPpuCEC9NgIz5DiRk3TFcwa1pm76p8obrwnzXk
 xubTQo+RrvauRvoeRg9EpCat5eHvlVOaIF9fI1vx2Thtd8LI7lh8ek94KJrwyToXaSi+
 rccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744415389; x=1745020189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7hw9uLttLA2GYfmrnQpmGdiTIFpq3OUSqsW/9Oojzg=;
 b=lrjg3KAkP1IObCfgJ5uJ2kJXjPecrkLIB5w7+n8uVAElM1knPtLnKBGNZ9G1eta23g
 i2OGjPxMCuEvrRoAEuBbCpTuAS3Id4ZDuxZ5ODzRys4cTJxa3I0M8TG+QhhAQqd4Z0h+
 ZnF5PU8uaGcormMwnejKEW4miKZEdkF3CpUHa52Jq3Y2RHOH59Wdle5jKoMrH7u9vmi5
 a+wFYtQIhyHi0zgrNIx0DcRLbxvCDlHhg7vItrMsCxgVuSDOEWJXWfFOHODIMx+vqo8L
 /eERv/T90M9EXZEww2cQ1AY3ZmKvf2j8yXuD+23El/wFFLqXtayFDVWUJIdmZ9SaOkPu
 yp5g==
X-Gm-Message-State: AOJu0Yx3ingD0hdLg15fWk+ka5nLWjg7YTzV54bheOl6jLzr7UTPE/N4
 vtENt9COJoaPpbyauGHnkABaZI8fWcQY1mxhv+a5M07Itf5Veo74UY9z3lUAKQnTZgwvRMXY+kQ
 D
X-Gm-Gg: ASbGncsLNY7UEJdQGTeshZ37FU616w0quwqCsqVeMZByo+I6svXhwgiy4bJyb9s6y2N
 hvzdRV3YTQkdjgvocvoYUwyje6vKA5szdqK6ncS1zt/icKyQg1Zrb71twD16GsoZ4cNCHK9TBYt
 WopAWooYM5QL53Ye4Ix3OcV7OpfQYz5ko0wS+r7E8/fF2bfjbfTeHrp5EkjpNiu2KhdMVNpSxvU
 Dmno7rKebCyUQaBIgcqTgfG/NWM9nYi9ks25r6HunC2WoWq+MZabluxyv15VWGSa85y28X85rhe
 rvpjNRTgVbfjG2hhv9QpjVBdg+m82zXLvfLcs46FBmitgXh/BXMcQuEnTADqUMt/hePPw7BL+cr
 Q+/i1ndcBbyr2BpGN
X-Google-Smtp-Source: AGHT+IFVy5Mx/Ap/p+rDzHuW8PuTpFPHvjv0Gv5sbPL3TAWKK0kpW9IG8qi3f/xNnEi3egl03/IOsA==
X-Received: by 2002:a17:90b:6ce:b0:2ee:7c65:ae8e with SMTP id
 98e67ed59e1d1-30823670b82mr7587782a91.11.1744415389413; 
 Fri, 11 Apr 2025 16:49:49 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm6538661a91.12.2025.04.11.16.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 16:49:49 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [RFC 12/13] app/testpmd: support for port mirroring
Date: Fri, 11 Apr 2025 16:44:49 -0700
Message-ID: <20250411234927.114568-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
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
 app/test-pmd/cmdline_mirror.c               | 120 ++++++++++++++++++++
 app/test-pmd/cmdline_mirror.h               |  12 ++
 app/test-pmd/meson.build                    |   1 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  15 +++
 5 files changed, 149 insertions(+)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index b4089d281b..64ba094e04 100644
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
index 0000000000..cea41302e1
--- /dev/null
+++ b/app/test-pmd/cmdline_mirror.c
@@ -0,0 +1,120 @@
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
+/* *** Create Port Mirror Object *** */
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
+	struct rte_eth_mirror_conf mirror_conf = {
+		.snaplen = RTE_MBUF_DEFAULT_BUF_SIZE,
+		.direction = RTE_MIRROR_DIRECTION_INGRESS | RTE_MIRROR_DIRECTION_EGRESS
+	};
+	int ret;
+
+	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
+		return;
+
+	if (port_id_is_invalid(res->target_id, ENABLED_WARN))
+		return;
+
+	ret = rte_eth_add_mirror(res->port_id, res->target_id, &mirror_conf);
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
+/* *** Disable Port Mirror Object *** */
+struct cmd_disable_port_mirror_result {
+	cmdline_fixed_string_t disable;
+	cmdline_fixed_string_t port;
+	cmdline_fixed_string_t mirror;
+	uint16_t port_id;
+};
+
+static void cmd_disable_port_mirror_parsed(void *parsed_result,
+	__rte_unused struct cmdline *cl,
+	__rte_unused void *data)
+{
+	const struct cmd_disable_port_mirror_result *res = parsed_result;
+	int ret;
+
+	if (port_id_is_invalid(res->port_id, ENABLED_WARN))
+		return;
+
+	/* Disable Mirror */
+	ret = rte_eth_remove_mirror(res->port_id);
+	if (ret != 0)
+		fprintf(stderr, "%s\n", rte_strerror(-ret));
+}
+
+static cmdline_parse_token_string_t cmd_disable_port_mirror_disable =
+	TOKEN_STRING_INITIALIZER(struct cmd_disable_port_mirror_result, disable, "disable");
+static cmdline_parse_token_string_t cmd_disable_port_mirror_port =
+	TOKEN_STRING_INITIALIZER(struct cmd_disable_port_mirror_result, port, "port");
+static cmdline_parse_token_string_t cmd_disable_port_mirror_mirror =
+	TOKEN_STRING_INITIALIZER(struct cmd_disable_port_mirror_result, mirror, "mirror");
+static cmdline_parse_token_num_t cmd_disable_port_mirror_port_id =
+	TOKEN_NUM_INITIALIZER(struct cmd_disable_port_mirror_result, port_id, RTE_UINT16);
+
+cmdline_parse_inst_t cmd_disable_port_mirror = {
+	.f = cmd_disable_port_mirror_parsed,
+	.data = NULL,
+	.help_str = "disable port mirror <port_id>",
+	.tokens = {
+		(void *)&cmd_disable_port_mirror_disable,
+		(void *)&cmd_disable_port_mirror_port,
+		(void *)&cmd_disable_port_mirror_mirror,
+		(void *)&cmd_disable_port_mirror_port_id,
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
index 000548c261..f34d80bb5d 100644
--- a/app/test-pmd/meson.build
+++ b/app/test-pmd/meson.build
@@ -9,6 +9,7 @@ sources = files(
         'cmdline_cman.c',
         'cmdline_flow.c',
         'cmdline_mtr.c',
+        'cmdline_mirror.c',
         'cmdline_tm.c',
         'cmd_flex_item.c',
         'config.c',
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index eeef49500f..ea94f993fe 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -2568,6 +2568,21 @@ where:
 * ``clear``: Flag that indicates whether the statistics counters should
   be cleared (i.e. set to zero) immediately after they have been read or not.
 
+create mirror
+-----------
+
+Create a new MIRROR port for an ethernet device::
+
+   testpmd> create port mirror (port_id) destination (port_id)
+
+delete mirror
+-----------
+
+Disable MIRROR port for an ethernet device::
+
+   testpmd> disable port mirror (port_id)
+
+
 Traffic Management
 ------------------
 
-- 
2.47.2

