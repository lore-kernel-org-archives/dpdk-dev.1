Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AD9CD4855
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 07:57:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5412240A4B;
	Tue, 12 May 2026 09:56:04 +0200 (CEST)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74]) by mails.dpdk.org (Postfix) with ESMTP id 82DA540278
 for <dev@dpdk.org>; Tue, 12 May 2026 00:44:04 +0200 (CEST)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8acafc224a8so118913136d6.1
 for <dev@dpdk.org>; Mon, 11 May 2026 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778539444; x=1779144244; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=OXYFUpX6xmuMl5KHfAAaZexjTy8DALCzrkd8uZ5mhIQ=;
 b=p9nN989Ic08X/HephFDZOPaCDXgIkq2w3C63NwSsXWkMnS2874fwAqiIfC9btt224X
 ac5jicTD1zxqdt7NkHbXkUJLGYmkNasSnB5j3taTl2uUC59Hu+YNHeJU6hSgMe31Z8jd
 vuZCHK3RtBLLQ1P/iCVmxqOd+gla2QznDfyUZ5Yqz9Z8xgyb9wH5mPv96h7TEaC/FXf7
 PJmoyHD1omtJ+TUYG0HN6VAQZLdFAiSeJoeU3WVu/e44rWO7pf8dZiFacqjDI/D7ACTP
 6gvvXiO7j6XvNDhY06v/Iw7RY96Rf3LajBVeZG3nsyC1ZvPO21zk37fT4dTY2QaMLLIn
 CqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778539444; x=1779144244;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OXYFUpX6xmuMl5KHfAAaZexjTy8DALCzrkd8uZ5mhIQ=;
 b=UEDhn+rh3B7yPEos8qCCp5Qsxh0G8mKOdW4umvU4clyXUUqWdwcPAze+hjEdTXg8wi
 Cln9gHYycCl0gtfC+Dr2FRZbCnvwa2yR7wqn3DT/xCqI1lZUG1SthdJVgIQBFjYS5wZ2
 rkbaP1Wh6Lw4+5BUM8cf2yLLxzKsv6IvZL9w4+xSVSualzOLMDeoKj8cjqCdnUrg5ksk
 0Y3dl3TpESoxLB4oKw72aS0TL31HOHA2+irsv3quSk98bChruAPVKkN7HfCRLG9PBrow
 MQB79yAmurZgYyKKQwl9hV8W3wxjkA+alsdxqorxtPwQuQHfHCYkYCAVtEcTFjzXWZm6
 pwaw==
X-Gm-Message-State: AOJu0YyH/9cEE5YSTCMJdd5N5dpQ0w77bbv85Mdd4oXUB0tpsABXkv89
 Be4cCGdyDgaoNcRsUdVIMM9RLZ0TLUFilf4u68U5/cuX9xvdxztjK6iqWh76gPZP+RHALtveYor
 HaFAxkQ==
X-Received: from qvtt4.prod.google.com ([2002:ad4:5bc4:0:b0:89c:56ed:47d1])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4f15:b0:8be:1620:a98e
 with SMTP id 6a1803df08f44-8bf41ea12a2mr232258176d6.20.1778539443664; Mon, 11
 May 2026 15:44:03 -0700 (PDT)
Date: Mon, 11 May 2026 22:43:51 +0000
In-Reply-To: <20260511224354.872997-1-blasko@google.com>
Mime-Version: 1.0
References: <20260511224354.872997-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511224354.872997-4-blasko@google.com>
Subject: [PATCH 3/6] net/gve: add AdminQ command for NIC timestamps
From: mark-blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, Mark Blasko <blasko@google.com>, 
 Joshua Washington <joshwash@google.com>,
 "Jasper Tran O'Leary" <jtranoleary@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 12 May 2026 09:55:49 +0200
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

