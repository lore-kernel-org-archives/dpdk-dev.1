Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB3ECD37BE
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 00:51:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ED084065E;
	Tue, 12 May 2026 02:51:09 +0200 (CEST)
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com
 [209.85.222.201])
 by mails.dpdk.org (Postfix) with ESMTP id 0233A4064F
 for <dev@dpdk.org>; Tue, 12 May 2026 02:51:07 +0200 (CEST)
Received: by mail-qk1-f201.google.com with SMTP id
 af79cd13be357-909120afff9so252520785a.1
 for <dev@dpdk.org>; Mon, 11 May 2026 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778547066; x=1779151866; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=OXYFUpX6xmuMl5KHfAAaZexjTy8DALCzrkd8uZ5mhIQ=;
 b=finhKn0dHG7zbAoCph2mG/Lc+WxqTRXD9nI4WCy0qxTTlK45jp6RuiJpt20wJOHhhn
 IOz6CMdmeIGRW+OmXIFcocaQC3VQHTaHxMwSAtFqU64h9LgvBRRNvjss2nFMicIyZqRY
 L4ieur05PmoglLThszSJGEcP8XusT+NJd6hskN9YAHKIbdKfkMLxgEXYzgPhoA8V8QPY
 riXgNTsQ90w8ivFEavI/SvM5n//yaA/rwIZ8HZ0nD/ahdaxu2mL1e0ly9z1gVxURxqxG
 EOqy6eLI5Xy/oc7ijIA0wfCeWfs/ISheBn0R6G9+RnVsgqBB7eRWikl8chK2XRyqgRFX
 II7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778547066; x=1779151866;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OXYFUpX6xmuMl5KHfAAaZexjTy8DALCzrkd8uZ5mhIQ=;
 b=Z9Ot6ABoF4KEmE/iCyk7Zp3jSkS+Fe9NOEk7y1m96YOp4Z90vDaL8LupD5KOcMDJc5
 +JQezdeUH00UWu7xHzeRKNoMZHa9r1neevzp4SuV4OpFE9NgXgTiONQvTui6Pl001O93
 yz4nQ146DvoPj9ufmTNUJNjl8x6DRF3gJ6OCzZF3G55bRMOCuoh24RyaDKpD6G110Hkq
 ZjonpCHz7dCyUs0Tm7RsyN8sZiCGyLXptLIc+8+0siJh56c5CQJMukGvjFNd4Mca4ii+
 5e2umxELoQ1rO4JpQrYj35qSiq3iz2s80Vsa4oY0iEtzqaZOkuLKznW5Yuks5T6VEC5y
 xwsQ==
X-Gm-Message-State: AOJu0Yx27DetMj4cWYapDsCNcIqVy2Te/8lwgubMTeWCQ/VfE701aIBP
 wlMUmHw14w1qK8C/KAsgwN9Qnr+q+PusVtcmLqnAOfTuxT7+4J2hKKv6WcoxjrBnmpIqReokDBm
 Udh+Iqw==
X-Received: from qkgf19.prod.google.com ([2002:ae9:ea13:0:b0:8f8:6a2a:7d4e])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:958:b0:90c:f4fb:299b
 with SMTP id af79cd13be357-90cf50a77c0mr111589885a.25.1778547066145; Mon, 11
 May 2026 17:51:06 -0700 (PDT)
Date: Tue, 12 May 2026 00:50:52 +0000
In-Reply-To: <20260512005057.944672-1-blasko@google.com>
Mime-Version: 1.0
References: <20260512005057.944672-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512005057.944672-4-blasko@google.com>
Subject: [PATCH 3/6] net/gve: add AdminQ command for NIC timestamps
From: mark-blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>, 
 Joshua Washington <joshwash@google.com>,
 "Jasper Tran O'Leary" <jtranoleary@google.com>
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

From: Mark Blasko <blasko@google.com>

Introduce the necessary definitions and functions for the
GVE_ADMINQ_REPORT_NIC_TIMESTAMP AdminQ command.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Jasper Tran O'Leary <jtranoleary@google.com>
---
 drivers/net/gve/base/gve_adminq.c | 18 ++++++++++++++++++
 drivers/net/gve/base/gve_adminq.h | 20 ++++++++++++++++++++
 drivers/net/gve/gve_ethdev.h      |  1 +
 3 files changed, 39 insertions(+)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index c9095fd165..e700262d7f 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -523,6 +523,10 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	case GVE_ADMINQ_CONFIGURE_FLOW_RULE:
 		priv->adminq_cfg_flow_rule_cnt++;
 		break;
+	case GVE_ADMINQ_REPORT_NIC_TIMESTAMP:
+		priv->adminq_report_nic_timestamp_cnt++;
+		break;
+
 	default:
 		PMD_DRV_LOG(ERR, "unknown AQ command opcode %d", opcode);
 	}
@@ -637,6 +641,20 @@ int gve_adminq_reset_flow_rules(struct gve_priv *priv)
 	return gve_adminq_configure_flow_rule(priv, &flow_rule_cmd);
 }
 
+int gve_adminq_report_nic_timestamp(struct gve_priv *priv, dma_addr_t nic_ts_report_addr)
+{
+	union gve_adminq_command cmd;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.opcode = cpu_to_be32(GVE_ADMINQ_REPORT_NIC_TIMESTAMP);
+	cmd.report_nic_timestamp = (struct gve_adminq_report_nic_timestamp) {
+		.nic_ts_report_len = cpu_to_be64(sizeof(struct gve_nic_ts_report)),
+		.nic_timestamp_addr = cpu_to_be64(nic_ts_report_addr),
+	};
+
+	return gve_adminq_execute_cmd(priv, &cmd);
+}
+
 /* The device specifies that the management vector can either be the first irq
  * or the last irq. ntfy_blk_msix_base_idx indicates the first irq assigned to
  * the ntfy blks. It if is 0 then the management vector is last, if it is 1 then
diff --git a/drivers/net/gve/base/gve_adminq.h b/drivers/net/gve/base/gve_adminq.h
index eaee5649f2..954be39fbf 100644
--- a/drivers/net/gve/base/gve_adminq.h
+++ b/drivers/net/gve/base/gve_adminq.h
@@ -26,6 +26,7 @@ enum gve_adminq_opcodes {
 	GVE_ADMINQ_REPORT_LINK_SPEED		= 0xD,
 	GVE_ADMINQ_GET_PTYPE_MAP		= 0xE,
 	GVE_ADMINQ_VERIFY_DRIVER_COMPATIBILITY	= 0xF,
+	GVE_ADMINQ_REPORT_NIC_TIMESTAMP		= 0x11,
 	/* For commands that are larger than 56 bytes */
 	GVE_ADMINQ_EXTENDED_COMMAND		= 0xFF,
 };
@@ -373,6 +374,23 @@ struct gve_stats_report {
 
 GVE_CHECK_STRUCT_LEN(8, gve_stats_report);
 
+struct gve_adminq_report_nic_timestamp {
+	__be64 nic_ts_report_len;
+	__be64 nic_timestamp_addr;
+};
+
+GVE_CHECK_STRUCT_LEN(16, gve_adminq_report_nic_timestamp);
+
+struct gve_nic_ts_report {
+	__be64 nic_timestamp; /* NIC clock in nanoseconds */
+	__be64 pre_cycles; /* System cycle counter before NIC clock read */
+	__be64 post_cycles; /* System cycle counter after NIC clock read */
+	__be64 reserved3;
+	__be64 reserved4;
+};
+
+GVE_CHECK_STRUCT_LEN(40, gve_nic_ts_report);
+
 /* Numbers of gve tx/rx stats in stats report. */
 #define GVE_TX_STATS_REPORT_NUM        6
 #define GVE_RX_STATS_REPORT_NUM        2
@@ -490,6 +508,7 @@ union gve_adminq_command {
 			struct gve_adminq_verify_driver_compatibility
 				verify_driver_compatibility;
 			struct gve_adminq_extended_command extended_command;
+			struct gve_adminq_report_nic_timestamp report_nic_timestamp;
 		};
 	};
 	u8 reserved[64];
@@ -537,5 +556,6 @@ int gve_adminq_add_flow_rule(struct gve_priv *priv,
 			     struct gve_flow_rule_params *rule, u32 loc);
 int gve_adminq_del_flow_rule(struct gve_priv *priv, u32 loc);
 int gve_adminq_reset_flow_rules(struct gve_priv *priv);
+int gve_adminq_report_nic_timestamp(struct gve_priv *priv, dma_addr_t nic_ts_report_addr);
 
 #endif /* _GVE_ADMINQ_H */
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index b9b4688367..b67f82c263 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -328,6 +328,7 @@ struct gve_priv {
 	uint32_t adminq_get_ptype_map_cnt;
 	uint32_t adminq_verify_driver_compatibility_cnt;
 	uint32_t adminq_cfg_flow_rule_cnt;
+	uint32_t adminq_report_nic_timestamp_cnt;
 	volatile uint32_t state_flags;
 
 	/* Gvnic device link speed from hypervisor. */
-- 
2.54.0.563.g4f69b47b94-goog

