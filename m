Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262A3C83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Jul 2025 16:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA34540E2F;
	Thu, 10 Jul 2025 18:42:58 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4100040E21
 for <dev@dpdk.org>; Thu, 10 Jul 2025 18:42:57 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7d38ddc198eso137151785a.1
 for <dev@dpdk.org>; Thu, 10 Jul 2025 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752165776;
 x=1752770576; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zIbdjbIsBTJGrUPuCW20jRSg85NEdhyJwxltX+PYxI=;
 b=zysFw4psw+HxqsbGsOt/C0n/MePZ282BRzeiB5m1TTCuUezen+t9u1WbU/hC3wLQFu
 mOwgMBXsW2K1hSgPMaoRxqJLouu2Qsp7mLBIz0QIFs7iKV0FlBqQCRekJ3DQP61XGIpt
 ScHq0kpEiOIHgpS/1ttqzScov0swCYD2U5Rd/wxqfevKguMEjPT1alV7SmLC08fFhjIN
 73S62ZV7IA7XefrNI9KMu3b7T6rKh3hTd1TPxFu9sKZSGONtlKcICnyN5lABUzcS0woB
 yjApADRpBug6VFrdqPEm+h+/VMEKu5lzYgfMIIT7efJtUVXtnBSYoH4C6QhC36vDoS6c
 6DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165776; x=1752770576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0zIbdjbIsBTJGrUPuCW20jRSg85NEdhyJwxltX+PYxI=;
 b=HMFEbvaPrec/Ug4OVAtCX+P8mHwix3XOrp4XoQQ55LYbQWDSCRp4Skv3DWzU8QJFtw
 Z0uC+TQHrsPejKL/D6Si4SVMaTlm7VEalfJVCrM56eXI9AAmTHBLqjoRiGzjI6C/PQUt
 HkAJfhNu/o/D+qDE09qJtJJF0TuW7Ug2FG3Tb2Ku9Pj46GvJEv0fBNkowtWD0f1vG9Uj
 VJHTdRBl6ksx2gD/6lmoleESdSSKKVVzxZaFLYRuIQDeT4ZgY8IbEfqPVlm+xY4nrKyJ
 PR8kz0DJJ3gymPI7LsvDcFRVo8yXdQXxae0HK7Cc1+Er+jsYtmHjv8C+Mi7SyLTLz5uz
 Fjdw==
X-Gm-Message-State: AOJu0Yz8dJeMPOFoqoJzh60xFz2LxleyEgUUGgTl24rhfxSndJgYAn4Y
 ZJ/ZlUDQ+54dQT4fwmNB32qezIxhkYx3lRwM1sB5Ri9Fwdxb77iL9ojk+cCFmpOKDqo7gNmHj+k
 mLCu1
X-Gm-Gg: ASbGncs/gWojlKxdIX69BHYFgtVw6OeY01uzV9NHa9nrBGg4z5OO3di3Ey8xusatL4C
 seZh5Vifv8AbJb5j0q0MtN4nPc8HsD8n8Zp0RUFF3zT7/u62/ThNYwUGpP8KVf4tHVxOyPhEvFJ
 s8pS87F1eDADGiiToGDQiJcp/uA6t9p4l5BkPiedZzGtNYUh0w6REzNOHMe5shC19XSV67nG6QQ
 rUJxCALoPtRhYDCaliEnEKyy2ml/MmccXKUsN6TZOQkEGbTlXYznmWqq/vcocWqqrjCloN0sONZ
 I6SHmDvTiLmsZjLvcxFQ1YKXE8vbl/QNBv7DChhry+wWR6ZUWZWm172P48xfRpttRnv+efRsDB4
 emZMdv8TsTn/h4G2j6YxMPy7dFVDxDsiMisjX
X-Google-Smtp-Source: AGHT+IGY5FXS+YIXQ6CbcimoXHSS7NABGI1mi4WsX4yprYHHbNjTMO43YlXPc2t7fuT35VK0NQKsCQ==
X-Received: by 2002:a05:6214:246d:b0:704:76d9:e57e with SMTP id
 6a1803df08f44-704a35db712mr656096d6.22.1752165776555; 
 Thu, 10 Jul 2025 09:42:56 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-704979b49b3sm10167966d6.30.2025.07.10.09.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:42:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v3 11/13] app/testpmd: support for port mirroring
Date: Thu, 10 Jul 2025 09:16:52 -0700
Message-ID: <20250710164237.8630-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710164237.8630-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
 <20250710164237.8630-1-stephen@networkplumber.org>
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

