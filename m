Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B78FD9E3A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 19:53:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95F9040B95;
	Fri, 27 Feb 2026 20:53:01 +0100 (CET)
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com
 [209.85.216.73]) by mails.dpdk.org (Postfix) with ESMTP id 0FD4F40A87
 for <dev@dpdk.org>; Fri, 27 Feb 2026 20:53:00 +0100 (CET)
Received: by mail-pj1-f73.google.com with SMTP id
 98e67ed59e1d1-358e5e33ddcso2511437a91.1
 for <dev@dpdk.org>; Fri, 27 Feb 2026 11:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1772221979; x=1772826779; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=x0SE0csXn+4bSFj6yMknFzgi1LTYtOKFHaFCV0t4bqM=;
 b=Qw6323SF57U+mppr0F3fK+8cEkYfQGO9yjU7QnZWiDShwFJvKnhVCwGdw7k30sttas
 C78P6BtygpUgHBNIAtHvplu1netE/+XJ76wP2PJ2PaxklSwYLnL875wcQ1GI2dU5PLT/
 vs60T2ph9Cvks030NEUZbcUB+evghuVDlmnh86poVpOs97P/r8Y3+eVNTOo1NRc+uMRV
 zUWUZeH4akbF7gGxvrNjVX1pbYy2TnI/gJ+jjjoUJbxYjXxN0kJciqvhLxFKn0y8qWxZ
 Iw7j3DjJkEGsp3A8rUnwZTIAvn7fFp9gCm9CKX2d2tu/raBYMv99yP0J4aLDCVFv/w9x
 INBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772221979; x=1772826779;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x0SE0csXn+4bSFj6yMknFzgi1LTYtOKFHaFCV0t4bqM=;
 b=aX7FvBeiWfRvdbPbDvkFM0lU1B0i8Ia7hI3V2FIoXfbB6ITiHS+wkjnbBcchfO2Pf4
 MjrqxBu5FqEJFruuUtfVs1ydDRwirrwhGmEJHMWhQxj9gaqbfnQmgCShWee6+pbGC0px
 j4T7AbxTPSF45oXmTP+ExtbibtvaIycNmlPR7L3IGh4cQr/L3W/Cl+BZcHeQQnmdm4T2
 sLupG8eITQ6i6JwD7oAJpxWHbve2wePO5cz5ZoGMQbZ48kPLeZEVpEfz9JTnRc1aCgVH
 gK6lLPD4ZBWhPsKMpguMU33p/YCdVI98CXUiGQxakR+qIl01cong68IuGBZPNuW2sjun
 zNWA==
X-Gm-Message-State: AOJu0YwMklhxAt+HeTrXTcU1B55JNSfFMKa76t5nqeFwRvOxmRpsanKV
 nlYogIA9qw2cWJ2yBResQwPSiu8k95JIuXRibEO3yCFIB4gHKrK0m6C/T3LT4qYZJt7oJuJ1YWG
 T7GbrTtxczkQtPLMjkERW4d2K1A==
X-Received: from pjbfs20.prod.google.com ([2002:a17:90a:f294:b0:358:e3db:b6c7])
 (user=jtranoleary job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:180e:b0:34c:fe7e:850c with SMTP id
 98e67ed59e1d1-35965c16f20mr2908387a91.1.1772221978992; 
 Fri, 27 Feb 2026 11:52:58 -0800 (PST)
Date: Fri, 27 Feb 2026 19:51:25 +0000
In-Reply-To: <20260227195126.3545607-1-jtranoleary@google.com>
Mime-Version: 1.0
References: <20260227195126.3545607-1-jtranoleary@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227195126.3545607-4-jtranoleary@google.com>
Subject: [PATCH 3/4] net/gve: add adminq commands for flow steering
From: "Jasper Tran O'Leary" <jtranoleary@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, "Jasper Tran O'Leary" <jtranoleary@google.com>, 
 Vee Agarwal <veethebee@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Add new adminq commands for the driver to configure flow rules that are
stored in the device. For configuring flow rules, 3 sub commands are
supported.
- create: creates a new flow rule with a specific rule_id.
- destroy: deletes an existing flow rule with the specified rule_id.
- flush: clears and deletes all currently active flow rules.

Co-developed-by: Vee Agarwal <veethebee@google.com>
Signed-off-by: Vee Agarwal <veethebee@google.com>
Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/base/gve_adminq.c | 52 +++++++++++++++++++++++++++
 drivers/net/gve/base/gve_adminq.h | 30 ++++++++++++++++
 drivers/net/gve/gve_ethdev.h      |  1 +
 drivers/net/gve/gve_flow_rule.h   | 59 +++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+)
 create mode 100644 dpdk/drivers/net/gve/gve_flow_rule.h

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 0cc6d44..9a94591 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -239,6 +239,7 @@ int gve_adminq_alloc(struct gve_priv *priv)
 	priv->adminq_report_stats_cnt = 0;
 	priv->adminq_report_link_speed_cnt = 0;
 	priv->adminq_get_ptype_map_cnt = 0;
+	priv->adminq_cfg_flow_rule_cnt = 0;
 
 	/* Setup Admin queue with the device */
 	rte_pci_read_config(priv->pci_dev, &pci_rev_id, sizeof(pci_rev_id),
@@ -487,6 +488,9 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	case GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY:
 		priv->adminq_verify_driver_compatibility_cnt++;
 		break;
+	case GVE_ADMINQ_CONFIGURE_FLOW_RULE:
+		priv->adminq_cfg_flow_rule_cnt++;
+		break;
 	default:
 		PMD_DRV_LOG(ERR, "unknown AQ command opcode %d", opcode);
 	}
@@ -546,6 +550,54 @@ static int gve_adminq_execute_extended_cmd(struct gve_priv *priv, u32 opcode,
 	return err;
 }
 
+static int
+gve_adminq_configure_flow_rule(struct gve_priv *priv,
+			       struct gve_adminq_configure_flow_rule *flow_rule_cmd)
+{
+	int err = gve_adminq_execute_extended_cmd(priv,
+			GVE_ADMINQ_CONFIGURE_FLOW_RULE,
+			sizeof(struct gve_adminq_configure_flow_rule),
+			flow_rule_cmd);
+
+	return err;
+}
+
+int gve_adminq_add_flow_rule(struct gve_priv *priv,
+			     struct gve_flow_rule_params *rule, u32 loc)
+{
+	struct gve_adminq_configure_flow_rule flow_rule_cmd = {
+		.opcode = cpu_to_be16(GVE_FLOW_RULE_CFG_ADD),
+		.location = cpu_to_be32(loc),
+		.rule = {
+			.flow_type = cpu_to_be16(rule->flow_type),
+			.action = cpu_to_be16(rule->action),
+			.key = rule->key,
+			.mask = rule->mask,
+		},
+	};
+
+	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
+}
+
+int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc)
+{
+	struct gve_adminq_configure_flow_rule flow_rule_cmd = {
+		.opcode = cpu_to_be16(GVE_FLOW_RULE_CFG_DEL),
+		.location = cpu_to_be32(loc),
+	};
+
+	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
+}
+
+int gve_adminq_reset_flow_rules(struct gve_priv *priv)
+{
+	struct gve_adminq_configure_flow_rule flow_rule_cmd = {
+		.opcode = cpu_to_be16(GVE_FLOW_RULE_CFG_RESET),
+	};
+
+	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
+}
+
 /* The device specifies that the management vector can either be the first irq
  * or the last irq. ntfy_blk_msix_base_idx indicates the first irq assigned to
  * the ntfy blks. It if is 0 then the management vector is last, if it is 1 then
diff --git a/drivers/net/gve/base/gve_adminq.h b/drivers/net/gve/base/gve_adminq.h
index f52658e..d8e5e6a 100644
--- a/drivers/net/gve/base/gve_adminq.h
+++ b/drivers/net/gve/base/gve_adminq.h
@@ -7,6 +7,7 @@
 #define _GVE_ADMINQ_H
 
 #include "gve_osdep.h"
+#include "../gve_flow_rule.h"
 
 /* Admin queue opcodes */
 enum gve_adminq_opcodes {
@@ -34,6 +35,10 @@ enum gve_adminq_opcodes {
  * inner opcode of gve_adminq_extended_cmd_opcodes specified. The inner command
  * is written in the dma memory allocated by GVE_ADMINQ_EXTENDED_COMMAND.
  */
+enum gve_adminq_extended_cmd_opcodes {
+	GVE_ADMINQ_CONFIGURE_FLOW_RULE	= 0x101,
+};
+
 /* Admin queue status codes */
 enum gve_adminq_statuses {
 	GVE_ADMINQ_COMMAND_UNSET			= 0x0,
@@ -434,6 +439,26 @@ struct gve_adminq_configure_rss {
 	__be64 indir_addr;
 };
 
+/* Flow rule definition for the admin queue using network byte order (big
+ * endian). This struct represents the hardware wire format and should not be
+ * used outside of admin queue contexts.
+ */
+struct gve_adminq_flow_rule {
+	__be16 flow_type;
+	__be16 action; /* RX queue id */
+	struct gve_flow_spec key;
+	struct gve_flow_spec mask;
+};
+
+struct gve_adminq_configure_flow_rule {
+	__be16 opcode;
+	u8 padding[2];
+	struct gve_adminq_flow_rule rule;
+	__be32 location;
+};
+
+GVE_CHECK_STRUCT_LEN(92, gve_adminq_configure_flow_rule);
+
 union gve_adminq_command {
 	struct {
 		__be32 opcode;
@@ -499,4 +524,9 @@ int gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
 int gve_adminq_configure_rss(struct gve_priv *priv,
 			     struct gve_rss_config *rss_config);
 
+int gve_adminq_add_flow_rule(struct gve_priv *priv,
+			     struct gve_flow_rule_params *rule, u32 loc);
+int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
+int gve_adminq_reset_flow_rules(struct gve_priv *priv);
+
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 3a810b6..4e07ca8 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -314,6 +314,7 @@ struct gve_priv {
 	uint32_t adminq_report_link_speed_cnt;
 	uint32_t adminq_get_ptype_map_cnt;
 	uint32_t adminq_verify_driver_compatibility_cnt;
+	uint32_t adminq_cfg_flow_rule_cnt;
 	volatile uint32_t state_flags;
 
 	/* Gvnic device link speed from hypervisor. */
diff --git a/drivers/net/gve/gve_flow_rule.h b/drivers/net/gve/gve_flow_rule.h
new file mode 100644
index 0000000..d1a2622
--- /dev/null
+++ b/drivers/net/gve/gve_flow_rule.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2022 Intel Corporation
+ */
+
+#ifndef _GVE_FLOW_RULE_H_
+#define _GVE_FLOW_RULE_H_
+
+#include "base/gve_osdep.h"
+
+enum gve_adminq_flow_rule_cfg_opcode {
+	GVE_FLOW_RULE_CFG_ADD	= 0,
+	GVE_FLOW_RULE_CFG_DEL	= 1,
+	GVE_FLOW_RULE_CFG_RESET	= 2,
+};
+
+enum gve_adminq_flow_type {
+	GVE_FLOW_TYPE_TCPV4,
+	GVE_FLOW_TYPE_UDPV4,
+	GVE_FLOW_TYPE_SCTPV4,
+	GVE_FLOW_TYPE_AHV4,
+	GVE_FLOW_TYPE_ESPV4,
+	GVE_FLOW_TYPE_TCPV6,
+	GVE_FLOW_TYPE_UDPV6,
+	GVE_FLOW_TYPE_SCTPV6,
+	GVE_FLOW_TYPE_AHV6,
+	GVE_FLOW_TYPE_ESPV6,
+};
+
+struct gve_flow_spec {
+	__be32 src_ip[4];
+	__be32 dst_ip[4];
+	union {
+		struct {
+			__be16 src_port;
+			__be16 dst_port;
+		};
+		__be32 spi;
+	};
+	union {
+		u8 tos;
+		u8 tclass;
+	};
+};
+
+/* Flow rule parameters using mixed endianness.
+ * - flow_type and action are guest endian.
+ * - key and mask are in network byte order (big endian), matching rte_flow.
+ * This struct is used by the driver when validating and creating flow rules;
+ * guest endian fields are only converted to network byte order within admin
+ * queue functions.
+ */
+struct gve_flow_rule_params {
+	u16 flow_type;
+	u16 action; /* RX queue id */
+	struct gve_flow_spec key;
+	struct gve_flow_spec mask;
+};
+
+#endif /* _GVE_FLOW_RULE_H_ */
-- 
2.53.0.473.g4a7958ca14-goog

