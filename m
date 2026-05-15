Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC09CD343F
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 May 2026 23:19:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F374140667;
	Sat, 16 May 2026 01:19:46 +0200 (CEST)
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com
 [209.85.160.202])
 by mails.dpdk.org (Postfix) with ESMTP id D477340650
 for <dev@dpdk.org>; Sat, 16 May 2026 01:19:43 +0200 (CEST)
Received: by mail-qt1-f202.google.com with SMTP id
 d75a77b69052e-514551d5f2aso18143381cf.2
 for <dev@dpdk.org>; Fri, 15 May 2026 16:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778887183; x=1779491983; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hcc90tYY04WTYxQQwi427VVktTgbuXBfBlUTPYDePcQ=;
 b=ei8M/DZIWcN3opGSAZZ3kvs/Wz1yh11kx0x/I5URviWQpVxEV17lRB1UPcm9rlXf2x
 loUoE/nX4e5S6m9RIkKgKLU1O6p/y/Ea4piEfOeyY31dBwH3HLfODx245CaweIL087pJ
 x5vaJFy+Pv0n/fdz8lHL83iKjsaZy5RJD3BgWS+3NzynMj54HEfkwqMt1GtdA6Vlvjg7
 M6lL9/H06+cKL9JFOnlkW4VfiNHM/gmIRHH1I1e9V1t1tCqXzvKzCAEwPfoeBYmrFfj4
 uaRrL0r3Ra+V5P8GDWMKIynJLpNlAUfkpDS4zRyWOubWzhwsz0WyglygtSM7Z4uL0Td9
 fh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778887183; x=1779491983;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hcc90tYY04WTYxQQwi427VVktTgbuXBfBlUTPYDePcQ=;
 b=chZVF2YYHibXu9WlyCzNWhslBUCZr0RWUvJ95BbGZMzU1qgkl8dpi7n3MCY11h9041
 4aqmBJXc7Q5ELZjR4I7FrnSVK+nfvxtsHomeksfv40JJb+lr+EFxik7ihcdPFM8d5zPW
 MP07g7evLHXTzN2EoeZscHpiPNKfj/MtNsekzxHMD0dMIOh3aJtcnMRry38A/aMllp/0
 q+C4RhpbgBf+Yc9Fse/pPOpZGVsvzM/Wc1cVbOTohuOvOPz+6I3AfIHqzFEhkh4VV8cT
 wjowsJvl+dCqj89aEDkOh+hkIT0dXfnszssIdiyyKy7frEkynqZhLbBAtjHskT8lmbJT
 Q4Ig==
X-Gm-Message-State: AOJu0YxZoik8MdpazFYivCA4olqzq1FHe7CS0iqp9uhSd/uHFdP+wtM6
 6B11lz1Y1Sml/kSkS6iF4TG7+hKu0RBkViBZp3OpRZMmDiurXDm+oAdimF6epCSbBEm3B7nH/PI
 s9gLBbg==
X-Received: from qvbiu5.prod.google.com ([2002:ad4:5cc5:0:b0:8a5:c5d:e50])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:57ce:0:b0:50f:bd6d:aa2a
 with SMTP id d75a77b69052e-5165a0061a1mr86338631cf.17.1778887182872; Fri, 15
 May 2026 16:19:42 -0700 (PDT)
Date: Fri, 15 May 2026 23:19:32 +0000
In-Reply-To: <20260515231936.3296603-1-blasko@google.com>
Mime-Version: 1.0
References: <20260511224354.872997-1-blasko@google.com>
 <20260515231936.3296603-1-blasko@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515231936.3296603-4-blasko@google.com>
Subject: [PATCH v2 3/6] net/gve: add AdminQ command for NIC timestamps
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
2.54.0.563.g4f69b47b94-goog

