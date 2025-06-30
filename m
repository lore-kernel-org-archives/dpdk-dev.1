Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B50FC7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 11:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D54AB4066C;
	Mon, 30 Jun 2025 13:14:45 +0200 (CEST)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com
 [52.119.213.156])
 by mails.dpdk.org (Postfix) with ESMTP id 4657D40665
 for <dev@dpdk.org>; Mon, 30 Jun 2025 13:14:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1751282084; x=1782818084;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=eI5MJ5/euqO/FBNjSABvSZU7UOhWHEYmllCOTlcZQMY=;
 b=Zhj7n48lun5SVWqe5OnUkPqdaGDX6s5CjxEKkolq+A5ShhKojZR6WUrd
 OlONkarxiwqYceZ6lGNRcNqrztvBA5SB8zXxOl6ZoAYZ1qb4HbL+/9dHP
 GYGCYAoeCVCxRjE9RuThnQX7MgdzHzYPiO8IDkA/ist7Zz1MEoqowvLoD
 kgbvxAj0zfzsNG+Y5i2XhJ2kvyCm/DhdTqFnqZqp0yKIzCn8okTfxmAa9
 6bK0VmB+jqtotE42CdUPYoerlQ5PNXY3behcbOL2YDg+/SnvZR7qRIhtJ
 OnyIE+5dB0czErjUMHkejLWOnlypB0Ml4UVXtS+Ml8mcjYL4D4XryvOlg g==;
X-IronPort-AV: E=Sophos;i="6.16,277,1744070400"; d="scan'208";a="759899650"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52005.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 11:14:41 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:42464]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.40.132:2525]
 with esmtp (Farcaster)
 id 0dfa611b-bfde-4ccc-b02c-6317db860523; Mon, 30 Jun 2025 11:14:39 +0000 (UTC)
X-Farcaster-Flow-ID: 0dfa611b-bfde-4ccc-b02c-6317db860523
Received: from EX19D007EUA002.ant.amazon.com (10.252.50.68) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:14:39 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.9) by
 EX19D007EUA002.ant.amazon.com (10.252.50.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 30 Jun 2025 11:14:36 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>, Yosef Raisman
 <yraisman@amazon.com>
Subject: [PATCH 4/7] net/ena: support fragment bypass mode
Date: Mon, 30 Jun 2025 14:13:55 +0300
Message-ID: <20250630111358.3476-5-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250630111358.3476-1-shaibran@amazon.com>
References: <20250630111358.3476-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.9]
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D007EUA002.ant.amazon.com (10.252.50.68)
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

Introduce devarg `enable_frag_bypass` to toggle the fragment bypass
mode for egress packets.

When enabled, this feature bypasses the PPS limit enforced by EC2 for
fragmented egress packets on every ENI. Note that enabling this might
negatively impact network performance.

By default, this feature is disabled. To enable it set
`enable_frag_bypass=1`. If it cannot be enabled, a warning will be
printed, but driver initialization will proceed as normal.

Signed-off-by: Yosef Raisman <yraisman@amazon.com>
Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
---
 doc/guides/nics/ena.rst                       |  9 ++++
 doc/guides/rel_notes/release_25_07.rst        |  5 ++
 drivers/net/ena/base/ena_com.c                | 34 +++++++++++++
 drivers/net/ena/base/ena_com.h                |  7 +++
 .../net/ena/base/ena_defs/ena_admin_defs.h    | 14 ++++++
 drivers/net/ena/ena_ethdev.c                  | 48 ++++++++++++++++++-
 drivers/net/ena/ena_ethdev.h                  |  1 +
 7 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/ena.rst b/doc/guides/nics/ena.rst
index a34575dc9b..a42deccd81 100644
--- a/doc/guides/nics/ena.rst
+++ b/doc/guides/nics/ena.rst
@@ -141,6 +141,15 @@ Runtime Configuration
      **A non-zero value for this devarg is mandatory for control path functionality
      when binding ports to uio_pci_generic kernel module which lacks interrupt support.**
 
+   * **enable_frag_bypass** (default 0)
+
+     Enable fragment bypass mode for egress packets. This mode bypasses the PPS
+     limit enforced by EC2 for fragmented egress packets on every ENI. Note that
+     enabling it might negatively impact network performance.
+
+     0 - Disabled (Default).
+
+     1 - Enabled.
 
 ENA Configuration Parameters
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 19be7740c4..822b3d4595 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -72,6 +72,11 @@ New Features
   Added a Performance Monitoring Unit (PMU) library which allows Linux applications
   to perform self monitoring activities without depending on external utilities like perf.
 
+* **Updated Amazon ENA (Elastic Network Adapter) net driver.**
+
+  * Added support for enabling fragment bypass mode for egress packets.
+    This mode bypasses the PPS limit enforced by EC2 for fragmented egress packets on every ENI.
+
 * **Added Mucse rnp net driver.**
 
   Added a new network PMD which supports Mucse 10 Gigabit Ethernet NICs.
diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 588dc61387..1a93d22b71 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -3459,3 +3459,37 @@ int ena_com_config_dev_mode(struct ena_com_dev *ena_dev,
 
 	return 0;
 }
+
+int ena_com_set_frag_bypass(struct ena_com_dev *ena_dev, bool enable)
+{
+	struct ena_admin_set_feat_resp set_feat_resp;
+	struct ena_com_admin_queue *admin_queue;
+	struct ena_admin_set_feat_cmd cmd;
+	int ret;
+
+	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_FRAG_BYPASS)) {
+		ena_trc_dbg(ena_dev, "Feature %d isn't supported\n",
+			    ENA_ADMIN_FRAG_BYPASS);
+		return ENA_COM_UNSUPPORTED;
+	}
+
+	memset(&cmd, 0x0, sizeof(cmd));
+	admin_queue = &ena_dev->admin_queue;
+
+	cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
+	cmd.aq_common_descriptor.flags = 0;
+	cmd.feat_common.feature_id = ENA_ADMIN_FRAG_BYPASS;
+	cmd.feat_common.feature_version = ENA_ADMIN_FRAG_BYPASS_FEATURE_VERSION_0;
+	cmd.u.frag_bypass.enable = (u8)enable;
+
+	ret = ena_com_execute_admin_command(admin_queue,
+					    (struct ena_admin_aq_entry *)&cmd,
+					    sizeof(cmd),
+					    (struct ena_admin_acq_entry *)&set_feat_resp,
+					    sizeof(set_feat_resp));
+
+	if (unlikely(ret))
+		ena_trc_err(ena_dev, "Failed to enable frag bypass. error: %d\n", ret);
+
+	return ret;
+}
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index b2aede1be1..1c752327dc 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -1109,6 +1109,13 @@ static inline bool ena_com_get_missing_admin_interrupt(struct ena_com_dev *ena_d
 	return ena_dev->admin_queue.is_missing_admin_interrupt;
 }
 
+/* ena_com_set_frag_bypass - set fragment bypass
+ * @ena_dev: ENA communication layer struct
+ * @enable: true if fragment bypass is enabled, false otherwise.
+ *
+ * @return - 0 on success, negative value on failure.
+ */
+int ena_com_set_frag_bypass(struct ena_com_dev *ena_dev, bool enable);
 /* ena_com_io_sq_to_ena_dev - Extract ena_com_dev using contained field io_sq.
  * @io_sq: IO submit queue struct
  *
diff --git a/drivers/net/ena/base/ena_defs/ena_admin_defs.h b/drivers/net/ena/base/ena_defs/ena_admin_defs.h
index bdc6efadcf..707aa32f06 100644
--- a/drivers/net/ena/base/ena_defs/ena_admin_defs.h
+++ b/drivers/net/ena/base/ena_defs/ena_admin_defs.h
@@ -57,6 +57,7 @@ enum ena_admin_aq_feature_id {
 	ENA_ADMIN_EXTRA_PROPERTIES_STRINGS          = 5,
 	ENA_ADMIN_EXTRA_PROPERTIES_FLAGS            = 6,
 	ENA_ADMIN_MAX_QUEUES_EXT                    = 7,
+	ENA_ADMIN_FRAG_BYPASS                       = 8,
 	ENA_ADMIN_RSS_HASH_FUNCTION                 = 10,
 	ENA_ADMIN_STATELESS_OFFLOAD_CONFIG          = 11,
 	ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG      = 12,
@@ -165,6 +166,10 @@ enum ena_admin_ena_srd_flags {
 	ENA_ADMIN_ENA_SRD_UDP_ORDERING_BYPASS_ENABLED = BIT(2),
 };
 
+enum ena_admin_frag_bypass_feature_version {
+	/* Enable only */
+	ENA_ADMIN_FRAG_BYPASS_FEATURE_VERSION_0     = 0,
+};
 struct ena_admin_aq_common_desc {
 	/* 11:0 : command_id
 	 * 15:12 : reserved12
@@ -706,6 +711,12 @@ struct ena_admin_feature_llq_desc {
 	struct ena_admin_accel_mode_req accel_mode;
 };
 
+struct ena_admin_feature_frag_bypass_desc {
+	/* Enable frag_bypass */
+	uint8_t enable;
+
+	uint8_t reserved[3];
+};
 struct ena_admin_queue_ext_feature_fields {
 	uint32_t max_tx_sq_num;
 
@@ -1180,6 +1191,9 @@ struct ena_admin_set_feat_cmd {
 
 		/* PHC configuration */
 		struct ena_admin_feature_phc_desc phc;
+
+		/* Fragment bypass configuration */
+		struct ena_admin_feature_frag_bypass_desc frag_bypass;
 	} u;
 };
 
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index d8ff6851d2..8ef6e55248 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -107,6 +107,13 @@ struct ena_stats {
  */
 #define ENA_DEVARG_CONTROL_PATH_POLL_INTERVAL "control_path_poll_interval"
 
+/*
+ * Toggles fragment bypass mode. Fragmented egress packets are rate limited by
+ * EC2 per ENI; this devarg bypasses the PPS limit but may impact performance.
+ * Disabled by default.
+ */
+#define ENA_DEVARG_ENABLE_FRAG_BYPASS "enable_frag_bypass"
+
 /*
  * Each rte_memzone should have unique name.
  * To satisfy it, count number of allocation and add it to name.
@@ -306,6 +313,9 @@ static int ena_xstats_get_by_id(struct rte_eth_dev *dev,
 static int ena_process_llq_policy_devarg(const char *key,
 			const char *value,
 			void *opaque);
+static int ena_process_bool_devarg(const char *key,
+				   const char *value,
+				   void *opaque);
 static int ena_parse_devargs(struct ena_adapter *adapter,
 			     struct rte_devargs *devargs);
 static void ena_copy_customer_metrics(struct ena_adapter *adapter,
@@ -1336,6 +1346,11 @@ static int ena_start(struct rte_eth_dev *dev)
 	if (rc)
 		goto err_start_tx;
 
+	if (adapter->enable_frag_bypass) {
+		rc = ena_com_set_frag_bypass(&adapter->ena_dev, true);
+		if (rc)
+			PMD_DRV_LOG_LINE(WARNING, "Failed to enable frag bypass, rc: %d", rc);
+	}
 	if (adapter->edev_data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG) {
 		rc = ena_rss_configure(adapter);
 		if (rc)
@@ -3764,6 +3779,31 @@ static int ena_process_llq_policy_devarg(const char *key, const char *value, voi
 	PMD_INIT_LOG_LINE(INFO,
 		"LLQ policy is %u [0 - disabled, 1 - device recommended, 2 - normal, 3 - large]",
 		adapter->llq_header_policy);
+
+	return 0;
+}
+
+static int ena_process_bool_devarg(const char *key, const char *value, void *opaque)
+{
+	struct ena_adapter *adapter = opaque;
+	bool bool_value;
+
+	/* Parse the value. */
+	if (strcmp(value, "1") == 0) {
+		bool_value = true;
+	} else if (strcmp(value, "0") == 0) {
+		bool_value = false;
+	} else {
+		PMD_INIT_LOG_LINE(ERR,
+			"Invalid value: '%s' for key '%s'. Accepted: '0' or '1'",
+			value, key);
+		return -EINVAL;
+	}
+
+	/* Now, assign it to the proper adapter field. */
+	if (strcmp(key, ENA_DEVARG_ENABLE_FRAG_BYPASS) == 0)
+		adapter->enable_frag_bypass = bool_value;
+
 	return 0;
 }
 
@@ -3773,6 +3813,7 @@ static int ena_parse_devargs(struct ena_adapter *adapter, struct rte_devargs *de
 		ENA_DEVARG_LLQ_POLICY,
 		ENA_DEVARG_MISS_TXC_TO,
 		ENA_DEVARG_CONTROL_PATH_POLL_INTERVAL,
+		ENA_DEVARG_ENABLE_FRAG_BYPASS,
 		NULL,
 	};
 	struct rte_kvargs *kvlist;
@@ -3799,6 +3840,10 @@ static int ena_parse_devargs(struct ena_adapter *adapter, struct rte_devargs *de
 		ena_process_uint_devarg, adapter);
 	if (rc != 0)
 		goto exit;
+	rc = rte_kvargs_process(kvlist, ENA_DEVARG_ENABLE_FRAG_BYPASS,
+		ena_process_bool_devarg, adapter);
+	if (rc != 0)
+		goto exit;
 
 exit:
 	rte_kvargs_free(kvlist);
@@ -4020,7 +4065,8 @@ RTE_PMD_REGISTER_KMOD_DEP(net_ena, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_ena,
 	ENA_DEVARG_LLQ_POLICY "=<0|1|2|3> "
 	ENA_DEVARG_MISS_TXC_TO "=<uint>"
-	ENA_DEVARG_CONTROL_PATH_POLL_INTERVAL "=<0-1000>");
+	ENA_DEVARG_CONTROL_PATH_POLL_INTERVAL "=<0-1000>")
+	ENA_DEVARG_ENABLE_FRAG_BYPASS "=<0|1> ");
 RTE_LOG_REGISTER_SUFFIX(ena_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(ena_logtype_driver, driver, NOTICE);
 #ifdef RTE_ETHDEV_DEBUG_RX
diff --git a/drivers/net/ena/ena_ethdev.h b/drivers/net/ena/ena_ethdev.h
index 335028ad19..e3cb4919c5 100644
--- a/drivers/net/ena/ena_ethdev.h
+++ b/drivers/net/ena/ena_ethdev.h
@@ -348,6 +348,7 @@ struct ena_adapter {
 	/* Time (in microseconds) of the control path queues monitoring interval */
 	uint64_t control_path_poll_interval;
 
+	bool enable_frag_bypass;
 	/*
 	 * Helper variables for holding the information about the supported
 	 * metrics.
-- 
2.17.1

