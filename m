Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451B2E7E0DF
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 20:07:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E58D140668;
	Mon,  9 Feb 2026 21:06:57 +0100 (CET)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53]) by mails.dpdk.org (Postfix) with ESMTP id E68E9402C3
 for <dev@dpdk.org>; Mon,  9 Feb 2026 21:06:54 +0100 (CET)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-436317c80f7so1485772f8f.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 12:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770667614;
 x=1771272414; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAvX7pmS556ekiWZ7fxI/KSmtgI/vjkasYHY5dy6a3w=;
 b=cIe4yC+vs9h7egnj6eRCkBBqBRet2CyBpmh2lLB76OIVPc2HZKC+HSJq+VxXYSaOLD
 07PNZTm6za78h8Tcu/bOD0ivz/DDnfM7jFwpBlQ7Q4W0TMvAVl0GLSq4HXQDrah4YRNn
 RrHZ5Na8IyLC8LZXvMJ633/Af2IBwxDLMSmybjkNXPJPmuYri4EIj2p6KlAFlJJDmsS5
 0TmctvKMQt4WHnphiIrA/fshL7p0LbNeecqRvcHPMMXxwjxbK0sk/BENKu+KCyVk1I5F
 +11bX0UX2AC8Y1pmxFqXax+pMCZUdVIQp5t7LZzHBlBdAO89KLwIoXSM3sPkBeegBdQM
 lUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770667614; x=1771272414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JAvX7pmS556ekiWZ7fxI/KSmtgI/vjkasYHY5dy6a3w=;
 b=smZYRvkdPPPxFhEZk72ZnwYl42n/owMkzAM/DNOeNeoFp4dpwiJkpy50R/2pd2BohM
 LCPs5gUrFri9f4pq2IBIs12Joux7icy+1AuEHcMiBF+30CQY1L/lKCq/JAQ5UVWDw5Gg
 QlTUJcSjNuw35qsBtAGHYbmDfc/5LpZBmcAMNAHqNKUy/fFnPvJaL3eoDTsdHL6wT8az
 Yb8oOYYZomIp0fu8DM9k98+XgBhwwt6Jk3SlBRLUL+JhMsOwNzqz29QASA0/oUpntEkm
 9fs9OGGsx3rtRKH1o2S8PUVW+NhxRtM4ei+UZr6kgxUVIIW9pjACzJ/VQ3V9/HOudl2R
 o+uQ==
X-Gm-Message-State: AOJu0YyyW/HSqyd3QHxXUFa+uCaBVLISHXLE5ASMydREjbOmQ1l4a3R8
 zx13l62P9aUoR1TDepWjLaYLtXpl1GQVSuiCLe5aFGhmNhr/5FrPcSY7GKi6FgVZu//K6efe/yv
 vWL+V
X-Gm-Gg: AZuq6aJ2ArSBzKduIQ5QEP5obPrp/flXIcSmTzBja7oeilBQL3h+MX83a17ge/+Zegl
 m/TeSFBlpSmq3pbI5sNJ/OIdpZO2HHUNisgGiSgIuIGTSbEE4E3Eekax1eH5Yl1mPGqjgM0L+4N
 cMZe8d/yXhvplA7vcI4EoE4AzzHbpYbtQPZPqSZAh4uYLHiaFwy41x+qlvqjscvx+mo7SiW6hWE
 ZoyMN1um9Fa6m/BrQ3VKM+rM2SbmKP6Wro4HT9TOPWYZDInyYB+2FcTXHlvcT4RuA3tPwZXTjxR
 SnijnriaDV9kTVjnpIa048NdPhAkx5AyxYk9N/4jQ65+5radQoPM6mn7R4cMZr8dREEDLQJIbok
 WBuSzTaZEXh0RQs943B7VZKUkuUwD42xLmuW/ZHXLrsvQuDq+1mI9iPm00DEwDvAx8NnzQ1ONHv
 TULDTsi9Ez1bM2dEWtsOIjCkMo4T9PVOnWcRfAUM4n7kFgJhrzkQ==
X-Received: by 2002:a05:6000:178f:b0:435:9a18:5a29 with SMTP id
 ffacd0b85a97d-43779e43460mr66648f8f.11.1770667614316; 
 Mon, 09 Feb 2026 12:06:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4376bd5a074sm11905721f8f.11.2026.02.09.12.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 12:06:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [RFC 1/2] net/null: add stub flow ops for rte_flow API testing
Date: Mon,  9 Feb 2026 12:05:42 -0800
Message-ID: <20260209200648.182725-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209200648.182725-1-stephen@networkplumber.org>
References: <20260209200648.182725-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add flow_ops to the null PMD that validate input structure and reject
all rules with properly typed rte_flow_error responses. Pattern items
and actions are walked individually, with cause pointers set to the
offending element. flush() succeeds as a no-op; all other operations
return appropriate error codes.

This enables testing the full rte_flow code path without hardware.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/null/meson.build    |   6 +-
 drivers/net/null/null_flow.c    | 237 ++++++++++++++++++++++++++++++++
 drivers/net/null/null_flow.h    |  12 ++
 drivers/net/null/rte_eth_null.c |  12 ++
 4 files changed, 266 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/null/null_flow.c
 create mode 100644 drivers/net/null/null_flow.h

diff --git a/drivers/net/null/meson.build b/drivers/net/null/meson.build
index bad7dc1af7..810715de52 100644
--- a/drivers/net/null/meson.build
+++ b/drivers/net/null/meson.build
@@ -1,5 +1,9 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-sources = files('rte_eth_null.c')
+sources = files(
+        'rte_eth_null.c',
+        'null_flow.c',
+)
+
 require_iova_in_mbuf = false
diff --git a/drivers/net/null/null_flow.c b/drivers/net/null/null_flow.c
new file mode 100644
index 0000000000..57de18f455
--- /dev/null
+++ b/drivers/net/null/null_flow.c
@@ -0,0 +1,237 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) Stephen Hemminger
+ */
+
+/*
+ * Stub flow operations for the net_null PMD.
+ *
+ * These ops provide a realistic-but-minimal implementation of
+ * rte_flow_ops that can be used for API-layer testing.  Every
+ * operation walks its input, performs basic structural validation,
+ * and then rejects the request with the most specific error type
+ * and message it can produce.  This exercises the full flow-API
+ * code path (port lookup → ops dispatch → PMD callback → error
+ * propagation) without requiring any hardware.
+ *
+ * Summary of behaviour:
+ *
+ *   validate  – walks pattern + actions; rejects each unsupported
+ *               item/action with RTE_FLOW_ERROR_TYPE_ITEM or
+ *               _ACTION, pointing `cause` at the offending element.
+ *               A structurally valid rule whose items are all VOID/END
+ *               and whose actions are all VOID/END gets rejected at
+ *               the attribute level (no ingress+egress+transfer) or
+ *               with a generic "no resources" if nothing else applies.
+ *
+ *   create    – calls validate, then returns NULL (never creates).
+ *
+ *   destroy   – returns -ENOENT (no flows exist).
+ *
+ *   flush     – succeeds (there are no flows to flush).
+ *
+ *   query     – returns -ENOTSUP (no queryable actions).
+ *
+ *   isolate   – returns -ENOTSUP (isolation not supported).
+ */
+
+#include <errno.h>
+#include <string.h>
+
+#include <rte_ethdev.h>
+#include <rte_flow.h>
+#include <rte_flow_driver.h>
+
+/* --------------------------------------------------------------------------
+ * Helpers
+ * -------------------------------------------------------------------------- */
+
+/*
+ * Walk the pattern array and reject the first item that is not
+ * VOID or END.  Return 0 if nothing objectionable was found
+ * (all items are VOID/END), or -rte_errno on failure.
+ */
+static int
+null_flow_validate_pattern(const struct rte_flow_item pattern[],
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_item *item;
+
+	if (pattern == NULL)
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ITEM_NUM,
+			NULL, "NULL pattern");
+
+	for (item = pattern;
+	     item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+		if (item->type == RTE_FLOW_ITEM_TYPE_VOID)
+			continue;
+
+		/* Any real match item is unsupported. */
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ITEM,
+			item,
+			"null PMD does not support pattern items");
+	}
+
+	return 0; /* only VOID + END */
+}
+
+/*
+ * Walk the action array and reject the first action that is not
+ * VOID or END.  Same semantics as above.
+ */
+static int
+null_flow_validate_actions(const struct rte_flow_action actions[],
+			   struct rte_flow_error *error)
+{
+	const struct rte_flow_action *action;
+
+	if (actions == NULL)
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ACTION_NUM,
+			NULL, "NULL action list");
+
+	for (action = actions;
+	     action->type != RTE_FLOW_ACTION_TYPE_END; action++) {
+		if (action->type == RTE_FLOW_ACTION_TYPE_VOID)
+			continue;
+
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ACTION,
+			action,
+			"null PMD does not support flow actions");
+	}
+
+	return 0; /* only VOID + END */
+}
+
+/* --------------------------------------------------------------------------
+ * Flow ops callbacks
+ * -------------------------------------------------------------------------- */
+
+static int
+null_flow_validate(struct rte_eth_dev *dev __rte_unused,
+		   const struct rte_flow_attr *attr,
+		   const struct rte_flow_item pattern[],
+		   const struct rte_flow_action actions[],
+		   struct rte_flow_error *error)
+{
+	int ret;
+
+	/* ---- attribute checks ---- */
+	if (attr == NULL)
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ATTR,
+			NULL, "NULL attributes");
+
+	if (!attr->ingress && !attr->egress && !attr->transfer)
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ATTR,
+			attr,
+			"at least one of ingress/egress/transfer "
+			"must be set");
+
+	if (attr->transfer)
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER,
+			attr,
+			"transfer attribute not supported");
+
+	if (attr->group > 0)
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ATTR_GROUP,
+			attr,
+			"only group 0 is supported");
+
+	if (attr->priority > 0)
+		return rte_flow_error_set(error, ENOTSUP,
+			RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
+			attr,
+			"only priority 0 is supported");
+
+	/* ---- pattern checks ---- */
+	ret = null_flow_validate_pattern(pattern, error);
+	if (ret)
+		return ret;
+
+	/* ---- action checks ---- */
+	ret = null_flow_validate_actions(actions, error);
+	if (ret)
+		return ret;
+
+	/*
+	 * If we get here, the rule is structurally valid but contains
+	 * nothing but VOID items and VOID actions — reject generically.
+	 */
+	return rte_flow_error_set(error, ENOTSUP,
+		RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+		NULL,
+		"null PMD cannot offload any flow rules");
+}
+
+static struct rte_flow *
+null_flow_create(struct rte_eth_dev *dev,
+		 const struct rte_flow_attr *attr,
+		 const struct rte_flow_item pattern[],
+		 const struct rte_flow_action actions[],
+		 struct rte_flow_error *error)
+{
+	null_flow_validate(dev, attr, pattern, actions, error);
+	return NULL;
+}
+
+static int
+null_flow_destroy(struct rte_eth_dev *dev __rte_unused,
+		  struct rte_flow *flow __rte_unused,
+		  struct rte_flow_error *error)
+{
+	return rte_flow_error_set(error, ENOENT,
+		RTE_FLOW_ERROR_TYPE_HANDLE,
+		flow,
+		"no flow rules exist on null PMD");
+}
+
+static int
+null_flow_flush(struct rte_eth_dev *dev __rte_unused,
+		struct rte_flow_error *error __rte_unused)
+{
+	/* Nothing to flush — success. */
+	return 0;
+}
+
+static int
+null_flow_query(struct rte_eth_dev *dev __rte_unused,
+		struct rte_flow *flow __rte_unused,
+		const struct rte_flow_action *action __rte_unused,
+		void *data __rte_unused,
+		struct rte_flow_error *error)
+{
+	return rte_flow_error_set(error, ENOTSUP,
+		RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+		NULL,
+		"null PMD does not support flow queries");
+}
+
+static int
+null_flow_isolate(struct rte_eth_dev *dev __rte_unused,
+		  int set __rte_unused,
+		  struct rte_flow_error *error)
+{
+	return rte_flow_error_set(error, ENOTSUP,
+		RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+		NULL,
+		"null PMD does not support flow isolation");
+}
+
+/* --------------------------------------------------------------------------
+ * Public ops structure — referenced by rte_eth_null.c
+ * -------------------------------------------------------------------------- */
+
+const struct rte_flow_ops null_flow_ops = {
+	.validate = null_flow_validate,
+	.create   = null_flow_create,
+	.destroy  = null_flow_destroy,
+	.flush    = null_flow_flush,
+	.query    = null_flow_query,
+	.isolate  = null_flow_isolate,
+};
diff --git a/drivers/net/null/null_flow.h b/drivers/net/null/null_flow.h
new file mode 100644
index 0000000000..f589533079
--- /dev/null
+++ b/drivers/net/null/null_flow.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Stephen Hemminger
+ */
+
+#ifndef NULL_FLOW_H
+#define NULL_FLOW_H
+
+#include <rte_flow_driver.h>
+
+extern const struct rte_flow_ops null_flow_ops;
+
+#endif /* NULL_FLOW_H */
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 46e7e7bd8c..b8dbef35e1 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -8,12 +8,15 @@
 #include <rte_mbuf.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
+#include <rte_flow.h>
 #include <rte_malloc.h>
 #include <rte_memcpy.h>
 #include <bus_vdev_driver.h>
 #include <rte_kvargs.h>
 #include <rte_spinlock.h>
 
+#include "null_flow.h"
+
 #define ETH_NULL_PACKET_SIZE_ARG	"size"
 #define ETH_NULL_PACKET_COPY_ARG	"copy"
 #define ETH_NULL_PACKET_NO_RX_ARG	"no-rx"
@@ -511,12 +514,21 @@ eth_dev_close(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+null_dev_flow_ops_get(struct rte_eth_dev *dev __rte_unused,
+		      const struct rte_flow_ops **ops)
+{
+	*ops = &null_flow_ops;
+	return 0;
+}
+
 static const struct eth_dev_ops ops = {
 	.dev_close = eth_dev_close,
 	.dev_start = eth_dev_start,
 	.dev_stop = eth_dev_stop,
 	.dev_configure = eth_dev_configure,
 	.dev_infos_get = eth_dev_info,
+	.flow_ops_get = null_dev_flow_ops_get,
 	.rx_queue_setup = eth_rx_queue_setup,
 	.tx_queue_setup = eth_tx_queue_setup,
 	.rx_queue_release = eth_rx_queue_release,
-- 
2.51.0

