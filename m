Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27BFCD98D2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 00:07:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDB7740DD0;
	Wed, 17 Jun 2026 02:07:24 +0200 (CEST)
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com
 [209.85.160.201])
 by mails.dpdk.org (Postfix) with ESMTP id D17F940674
 for <dev@dpdk.org>; Wed, 17 Jun 2026 02:07:20 +0200 (CEST)
Received: by mail-qt1-f201.google.com with SMTP id
 d75a77b69052e-5177b8def69so75070851cf.2
 for <dev@dpdk.org>; Tue, 16 Jun 2026 17:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781654840; x=1782259640; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3aHa23V5OPalSQbCBLHOce5pklCGfWjeuSvArek+W6I=;
 b=kptuPdE30nRWqjKmpHo4AyAX4FdR0pybQENJIW/fa7MkyxTlLaheD2hawOE9nKaMFk
 LU+jKg2wCVXYVn9O+BxncjIFcTwwArdjhaQ2Fj5o6+prOw2tFLYjBdKiK3UkAAhsI4nw
 pwNBi7kMi3uL01W3CdkPtt5rNvp/GikR/tBd3Yc6XXhPEKoNCQKdntXGLkYBbfdQwxTz
 8hUZubYUsifEkmNE2+wMvooWThp3t+H4usKoMXJJqceUCgxwXK8zhurv6c1aa+Vd4iZh
 erUrR9MiAhYmJAf/vD6GEWG96vuWKX2//ANDD2N+Ifo06q0XVY5I4BjSMUmILI8gLegv
 2kiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781654840; x=1782259640;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3aHa23V5OPalSQbCBLHOce5pklCGfWjeuSvArek+W6I=;
 b=jWBvCXYR69x3PfVnMvjd6aVoFurK+mINRMy0HHEMxq9F0Z8C2UlPnC2f3b5El8dg0/
 L2LzOThuMIcCAvwBJEw8/oi/sp4pu9I6V0zMl9JZ5E1RXhlY+QuILvI7QVsx96WU5/Ux
 PQbXtZ6ZZ/fRgsBp0Pa8lsnTsHG0iD3flY3Mvx87E6WVP/A8dN5TX172aOhxagpUN7uJ
 LfDq0M2yMaAYs1s1uvI3bY4Ag20W8TKb7dvfjohMVDBYdrV6C0Ysxcf7UWAuFCrBiNbT
 m+H4s7VMUpNzSVc2remJx2oID4s696m5iJI43Xue0lIS/Dv5/lc4jC0OvUmxxjLnghTf
 flkg==
X-Gm-Message-State: AOJu0YxRi63jTXw3njuABOFZ6rPte84d8WmG4P+LZ8r2D5VUqcnWDJfK
 HWOc2Zl6PIvxOXbsxU++uHBRE+GdRSGTXIGHfdH8BUqoPT2gT7pN18aQ+kxCRBGfqwmbUF2e2Ua
 XlimYCg==
X-Received: from qknxj53.prod.google.com
 ([2002:a05:620a:5bf5:b0:915:8d87:833a])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:25ca:b0:915:351b:3ae5
 with SMTP id af79cd13be357-91d8dcaab4amr344916785a.41.1781654839426; Tue, 16
 Jun 2026 17:07:19 -0700 (PDT)
Date: Wed, 17 Jun 2026 00:07:07 +0000
In-Reply-To: <20260617000712.2195506-1-blasko@google.com>
Mime-Version: 1.0
References: <20260613042300.3760470-1-blasko@google.com>
 <20260617000712.2195506-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260617000712.2195506-4-blasko@google.com>
Subject: [PATCH v5 3/6] net/gve: add AdminQ command for NIC timestamps
From: Mark Blasko <blasko@google.com>
To: stephen@networkplumber.org
Cc: dev@dpdk.org, joshwash@google.com, jtranoleary@google.com, 
 blasko@google.com
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
v2:
    - Added adminq timestamp counter reset to gve_adminq_alloc.
---
 drivers/net/gve/base/gve_adminq.c | 20 ++++++++++++++++++++
 drivers/net/gve/base/gve_adminq.h | 20 ++++++++++++++++++++
 drivers/net/gve/gve_ethdev.h      |  1 +
 3 files changed, 41 insertions(+)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index 1ced1e442e..2b25c7f390 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -263,6 +263,8 @@ int gve_adminq_alloc(struct gve_priv *priv)
 	priv->adminq_get_ptype_map_cnt = 0;
 	priv->adminq_cfg_flow_rule_cnt = 0;
 
+	priv->adminq_report_nic_timestamp_cnt = 0;
+
 	pthread_mutexattr_init(&mutexattr);
 	pthread_mutexattr_setpshared(&mutexattr, PTHREAD_PROCESS_SHARED);
 	pthread_mutex_init(&priv->adminq_lock, &mutexattr);
@@ -522,6 +524,10 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
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
@@ -636,6 +642,20 @@ int gve_adminq_reset_flow_rules(struct gve_priv *priv)
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
2.54.0.1189.g8c84645362-goog

