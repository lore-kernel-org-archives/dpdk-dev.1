Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2BDCD6E7C
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 21:31:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 758D44067C;
	Fri,  5 Jun 2026 23:30:56 +0200 (CEST)
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73]) by mails.dpdk.org (Postfix) with ESMTP id 27A1B40666
 for <dev@dpdk.org>; Fri,  5 Jun 2026 23:30:55 +0200 (CEST)
Received: by mail-qv1-f73.google.com with SMTP id
 6a1803df08f44-8ccd83d58d9so39043866d6.0
 for <dev@dpdk.org>; Fri, 05 Jun 2026 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1780695054; x=1781299854; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ezod7LuRbLSqs94ntNNNrennxDtSwqcezajyyA3bmzg=;
 b=rT/Po4rYvWBH1IoFynKlyNLSk+mP0rzaFN12C4kBdHxk18cbwjKUM47e034L6gOaoF
 tOcOUCe7rl8VCHy+Zq3v9ODmOWLt0N9EfgjuSupvxdvTkG8JI8jM30XCDj6jUUpIrlgM
 KNFE1h7G+yUqKS0m1afj9XWrTTgYy+FoN0XWs04+WxaVrfCh92lfm+CRzMSqOmBY2QZ4
 R13WNQpEhvfATrfsIwXx4A5rvUah0epzL+2fiwZlgyELce5/2RXQrC4P97ag+hrTnjDQ
 vs46GUnFV1hEVOUoY5zlGWmUhaeK/p6lTF5iPXy9pCGDTKUHAPEsn/bZKz8zxRurr55S
 Xfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780695054; x=1781299854;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ezod7LuRbLSqs94ntNNNrennxDtSwqcezajyyA3bmzg=;
 b=CQvYSDb3E6YacT7ZNTiTQgrjANfzGJ/kUtRBhqtpYA2UsOBmL587P1cV4WUAUhvbd3
 xLWe9/6niVzltntt6X+66Sy+QxMK+oR8/cDNanu3RkVStXxXs0579+0NggkGEXynOMU/
 LCaKAjvsezonLPKe6v1sVeiOrjO457ulalQrH2EDbmK2Nhac/zFiAY90pv5ezcshloHc
 wIQEQvbFxg3OsoZ90AB+BnKXwAAgBzTayhskVLgo6xOXtu2WIJaxgOpZRQkwQL3GFzMb
 vbByXQubdXmzbNDIVmpH95McFiXuRWwWjdXsPEP8G4W/SZH30fJRmFRRgieGC00A2N9v
 zB6A==
X-Gm-Message-State: AOJu0Yzbt4c9kaJKH1b3BSieKAj+AmAAceRTYcBo9K222y3e40cEua9Q
 JvQb+DFcTesQ703J6V+CkNGacM2m/7y8neEW2iCkk1Obfd851m2ddGNVPiagyhWeVKbnWeiykSm
 VFLnkFQ==
X-Received: from qvc21.prod.google.com ([2002:a05:6214:8115:b0:8ce:b951:b238])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a0c:e6ca:0:b0:8ce:e29a:a0bf
 with SMTP id 6a1803df08f44-8cee626fc48mr73727666d6.43.1780695054138; Fri, 05
 Jun 2026 14:30:54 -0700 (PDT)
Date: Fri,  5 Jun 2026 21:29:41 +0000
In-Reply-To: <20260605213022.2770893-1-blasko@google.com>
Mime-Version: 1.0
References: <20260515231936.3296603-1-blasko@google.com>
 <20260605213022.2770893-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605213022.2770893-4-blasko@google.com>
Subject: [PATCH v3 3/6] net/gve: add AdminQ command for NIC timestamps
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
2.54.0.1032.g2f8565e1d1-goog

