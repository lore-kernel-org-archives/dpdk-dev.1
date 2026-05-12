Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9595FCD4846
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 00:54:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7417B40666;
	Tue, 12 May 2026 02:54:12 +0200 (CEST)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74]) by mails.dpdk.org (Postfix) with ESMTP id 14AEE40657
 for <dev@dpdk.org>; Tue, 12 May 2026 02:54:10 +0200 (CEST)
Received: by mail-qv1-f74.google.com with SMTP id
 6a1803df08f44-8acb0aa51c6so40334766d6.1
 for <dev@dpdk.org>; Mon, 11 May 2026 17:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778547249; x=1779152049; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=rZhC7kOnfNvrtZxgohj5KSqfW2MKTW07CyFfuvXLpFk=;
 b=JqkgU4wUZUQCbdaEFjCckPn8yqDmbVzbed504bJXRD6y2FeLVnU54lpgVTdrWF1PIk
 fjNm8NKtawHOLSk5K3BAY0/4PHEFRC4yZc0DDjDI+wHD2DQN97TWnHTo3YcD3W+SFtcw
 IbeejFQU6NUKrHR5Aog5YdWB2tJMfSrSl/acsbOgNL+0pA5ywvccWLwGXPioLqjziiGI
 AHA6kQB2Rk5+Ju55v6NxduvMS0DYQ4568QhSa2BeKlOAOIpSNpFTmVd2ichNtqoWTe90
 wtKSUCVGCR9yoxbKXJ0hyxWj0t9ggkLuXGSp5d53eJgsoK/VmSiTMWzaFJ09SFLVa0sB
 vyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778547249; x=1779152049;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rZhC7kOnfNvrtZxgohj5KSqfW2MKTW07CyFfuvXLpFk=;
 b=UlLlKwf9Xy9fhgtbx/kkvfeefxDCwh7z6RrtERb700bXOnD3rGZ2FmUeHplya0XwhN
 1gvZypuS55izEYaCij14WfZwyiab9G1qfQtlsIkoXdFHkgsAVMnW/VmxghoO82jBOUEl
 99BrSHoAMfEWWDbFgFVYIjj9/VvB4JmS7kgrJyLaPhuss/vdBNJcrbjmj8KfaeDgK/EN
 Fon8KPBZiHWiAQudAltHFMu0WOBk7v8rqpGtoDjCXiBqzplG2catyokxJcenx1sOOALj
 pA07PFoas0EAlToTM9B6nobjrry7uXVNnA3DCkL9sDhIxjJhKmNYuj/BPxMGPdMN6Jse
 C66w==
X-Gm-Message-State: AOJu0YzIfxsMYjFy/Nv5ec0id3I6jvyRGO1jvCCQKkIijZpOTH2gyOAx
 qGaK/nyNxEbkwLJZcU8Kl46wXXMFa/qyczjaQW+Tt4naojYGGsC0PF7R7SkPI0lE8O/Iuct8hBU
 pJlVqew==
X-Received: from qvbiw11.prod.google.com ([2002:a05:6214:f2b:b0:89c:5b0a:675d])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:40c:b0:8b3:ff3f:5d61
 with SMTP id 6a1803df08f44-8c634105d9fmr23339236d6.22.1778547249283; Mon, 11
 May 2026 17:54:09 -0700 (PDT)
Date: Tue, 12 May 2026 00:53:50 +0000
In-Reply-To: <20260512005404.946979-1-blasko@google.com>
Mime-Version: 1.0
References: <20260512005404.946979-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512005404.946979-4-blasko@google.com>
Subject: [PATCH 3/6] net/gve: add AdminQ command for NIC timestamps
From: Mark Blasko <blasko@google.com>
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

