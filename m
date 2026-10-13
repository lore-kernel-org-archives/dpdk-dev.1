Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E0ACC6B16
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:11:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1AFE406B8;
	Tue, 13 Oct 2026 17:11:50 +0200 (CEST)
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [52.13.214.179]) by mails.dpdk.org (Postfix) with ESMTP id DAC3E40272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:11:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1791904309; x=1823440309;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=B7utInWQMBeJh9ks2ZiPnkieFlZVWXpu5ZFiVkLR3N0=;
 b=f+fxJJnJxQ+Qr8AiKunMpLKV71Aibn35xPfD42eyQDR5klj5sCQ+teVb
 1T8sj88/xq+l9TyBWbR/c80V+yoWbDMWcYIOKOEWsv1XKBiDSo3kzNOc3
 g7iqe8nLnahJ/xdMWtueKp1ZI1hM1MUMJx9a+sGLDoc+wFUjOW2nao6ic
 KCPfvc3A/zyVspu4HyCz5Ji1dosBuzB39HhqMhv8q+/VeaO0GT+M6/nkX
 KLvIj/0xT8zBin7FRfRJpa04t0hLRyXFP2ozdm9/PB5lK6y5X794UAyY5
 DXqiq+cQbpAV70hJpEpIOvDcvs7bYbYpKAmC+Zp5ZZ5mqbHNs/s/sf2eO g==;
X-CSE-ConnectionGUID: aLwFSh9tRi+z5W0fDKTDFQ==
X-CSE-MsgGUID: 5IbMb4ckRBCLmrzzkrejNw==
X-IronPort-AV: E=Sophos;i="6.27,155,1787011200"; d="scan'208";a="31117307"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 15:11:48 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:4956]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.123:2525]
 with esmtp (Farcaster)
 id 7bc7f0f0-ee29-4cf0-8cb7-968ca4a0c728; Tue, 13 Oct 2026 15:11:47 +0000 (UTC)
X-Farcaster-Flow-ID: 7bc7f0f0-ee29-4cf0-8cb7-968ca4a0c728
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 15:11:47 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.11) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 13 Oct 2026 15:11:45 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 11/13] net/ena: support flow API for n-tuple Rx steering
Date: Tue, 13 Oct 2026 18:11:27 +0300
Message-ID: <20261013151127.9776-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.11]
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

Implement the flow_ops_get ethdev callback to expose hardware
n-tuple Rx steering through the rte_flow API, allowing applications
to direct selected traffic to dedicated Rx queues for workload
isolation.

Supported patterns are IPv4, IPv6, TCP and UDP, matching source and
destination addresses, source and destination ports and IP TOS/DSCP.
The protocol is derived from the TCP or UDP item type. The only
supported action is queue steering to a single Rx queue. Rules are
accepted for ingress traffic in group 0 with priority 0. Item spec
and mask are honoured, including default masks; ranges specified
through the item last field are rejected, as are unsupported
header fields.

Flow steering is reported as unsupported when the device exposes no
rule entries.

Documented limitations: rules can only be created once the device
is started, they are not retained across device stop, and a rule
referencing an Rx queue that is removed by a later reconfiguration
will cause matching packets to be dropped.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 doc/guides/nics/ena.rst                       |  26 +
 doc/guides/nics/features/ena.ini              |  10 +
 doc/guides/rel_notes/release_26_11.rst        |   4 +
 drivers/net/ena/base/ena_com.c                | 300 ++++++++++
 drivers/net/ena/base/ena_com.h                |  86 +++
 .../net/ena/base/ena_defs/ena_admin_defs.h    |  83 ++-
 drivers/net/ena/ena_ethdev.c                  |  71 ++-
 drivers/net/ena/ena_ethdev.h                  |   3 +-
 drivers/net/ena/ena_flow.c                    | 542 ++++++++++++++++++
 drivers/net/ena/ena_flow.h                    |  12 +
 drivers/net/ena/meson.build                   |   1 +
 11 files changed, 1135 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ena/ena_flow.c
 create mode 100644 drivers/net/ena/ena_flow.h

diff --git a/doc/guides/nics/ena.rst b/doc/guides/nics/ena.rst
index d829e8854f..4c2f0e098a 100644
--- a/doc/guides/nics/ena.rst
+++ b/doc/guides/nics/ena.rst
@@ -33,6 +33,7 @@ Supported features
 * Device reset upon failure
 * Rx interrupts
 * Rx HW packet timestamping
+* Rx flow steering
 
 Overview
 --------
@@ -59,6 +60,9 @@ Queue (LLQ), which saves several more microseconds.
 Rx hardware timestamping is available in the ENA driver
 on platforms that support this feature.
 
+Rx flow steering is available in the ENA driver
+on platforms that support this feature.
+
 Management Interface
 --------------------
 
@@ -248,6 +252,28 @@ There is possibility that there won't be enough event file descriptors to
 handle both admin and Rx interrupts. In that situation the Rx interrupt request
 will fail.
 
+**Rx flow steering support**
+
+ENA PMD supports steering ingress packets to a specific Rx queue
+using the generic flow API (``rte_flow``).
+A rule matches IPv4 or IPv6 packets, optionally followed by TCP or UDP,
+on any combination of source and destination addresses,
+TOS (IPv4) or traffic class (IPv6), and source and destination ports.
+Each rule has a single ``QUEUE`` action.
+
+The following limitations apply:
+
+* Only ingress rules in group 0 with priority 0 are supported.
+* The ``ETH`` item is accepted only as a wildcard, without matching fields.
+* Rules can be created only after the device is started.
+* ``RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP`` is not advertised,
+  so the application must not rely on rules being kept across device stop,
+  and should flush them with ``rte_flow_flush()`` before stopping the device.
+* The queue index is checked only when the rule is created.
+  If the port is later reconfigured with fewer Rx queues,
+  the device silently drops the packets matching the rule.
+* The maximum number of rules is defined by the device.
+
 **Note about usage on \*.metal instances**
 
 On AWS, the metal instances are supporting IOMMU for both arm64 and x86_64 hosts.
diff --git a/doc/guides/nics/features/ena.ini b/doc/guides/nics/features/ena.ini
index 037e0bad60..a8cbb6df1c 100644
--- a/doc/guides/nics/features/ena.ini
+++ b/doc/guides/nics/features/ena.ini
@@ -22,3 +22,13 @@ Linux                = Y
 ARMv8                = Y
 x86-32               = Y
 x86-64               = Y
+
+[rte_flow items]
+eth                  = P
+ipv4                 = Y
+ipv6                 = Y
+tcp                  = Y
+udp                  = Y
+
+[rte_flow actions]
+queue                = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 699f63d341..05281c3d11 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -92,6 +92,10 @@ New Features
     ``xdp_meta_rx_ts_valid_mask``.
   * Added ``read_clock`` operation to query the PTP hardware clock.
 
+* **Updated Amazon ENA (Elastic Network Adapter) ethernet driver.**
+
+  * Added Rx flow steering support using the generic flow API.
+
 * **Updated Intel iavf driver.**
 
   * Runtime Rx/Tx queue setup is now automatically disabled
diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 9030b0f2c1..95702ed5f3 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -3345,6 +3345,62 @@ void ena_com_rss_destroy(struct ena_com_dev *ena_dev)
 	memset(&ena_dev->rss, 0x0, sizeof(ena_dev->rss));
 }
 
+int ena_com_flow_steering_init(struct ena_com_dev *ena_dev, u16 flow_steering_entries)
+{
+	u32 tbl_size_in_bytes =
+		flow_steering_entries * sizeof(struct ena_com_flow_steering_table_entry);
+	struct ena_com_flow_steering *flow_steering = &ena_dev->flow_steering;
+
+	memset(flow_steering, 0x0, sizeof(*flow_steering));
+
+	if (!(ena_dev->supported_features & BIT(ENA_ADMIN_FLOW_STEERING_CONFIG)))
+		return ENA_COM_UNSUPPORTED;
+
+	flow_steering->tbl_size = flow_steering_entries;
+
+	flow_steering->flow_steering_tbl = ENA_MEM_ALLOC(ena_dev->dmadev, tbl_size_in_bytes);
+	if (unlikely(!flow_steering->flow_steering_tbl)) {
+		ena_trc_err(ena_dev, "Flow steering table memory allocation failed\n");
+		return ENA_COM_NO_MEM;
+	}
+
+	ENA_MEM_ALLOC_COHERENT(ena_dev->dmadev,
+			       sizeof(struct ena_admin_flow_steering_rule_params),
+			       flow_steering->requested_rule,
+			       flow_steering->requested_rule_dma_addr,
+			       flow_steering->requested_rule_mem_handle);
+	if (unlikely(!flow_steering->requested_rule)) {
+		ena_trc_err(ena_dev, "Flow steering dma-able params memory allocation failed\n");
+		goto err;
+	}
+
+	return 0;
+err:
+	ena_com_flow_steering_destroy(ena_dev);
+
+	return ENA_COM_NO_MEM;
+}
+
+void ena_com_flow_steering_destroy(struct ena_com_dev *ena_dev)
+{
+	struct ena_com_flow_steering *flow_steering = &ena_dev->flow_steering;
+
+	if (flow_steering->requested_rule) {
+		ENA_MEM_FREE_COHERENT(ena_dev->dmadev,
+				      sizeof(struct ena_admin_flow_steering_rule_params),
+				      flow_steering->requested_rule,
+				      flow_steering->requested_rule_dma_addr,
+				      flow_steering->requested_rule_mem_handle);
+	}
+
+	if (flow_steering->flow_steering_tbl) {
+		ENA_MEM_FREE(ena_dev->dmadev,
+			     flow_steering->flow_steering_tbl,
+			     flow_steering->tbl_size *
+			     sizeof(struct ena_com_flow_steering_table_entry));
+	}
+}
+
 int ena_com_allocate_host_info(struct ena_com_dev *ena_dev)
 {
 	struct ena_host_attribute *host_attr = &ena_dev->host_attr;
@@ -3607,6 +3663,250 @@ int ena_com_config_dev_mode(struct ena_com_dev *ena_dev,
 	return 0;
 }
 
+int ena_com_flow_steering_add_rule(struct ena_com_dev *ena_dev,
+				   struct ena_com_flow_steering_rule_params *configure_params,
+				   u16 *rule_idx)
+{
+	struct ena_com_flow_steering *flow_steering = &ena_dev->flow_steering;
+	struct ena_com_admin_queue *admin_queue;
+	struct ena_admin_set_feat_resp resp;
+	struct ena_admin_set_feat_cmd cmd;
+	int ret;
+
+	if (!(ena_dev->supported_features & BIT(ENA_ADMIN_FLOW_STEERING_CONFIG))) {
+		ena_trc_err(ena_dev, "Flow steering rules are not supported by this device\n");
+		return ENA_COM_UNSUPPORTED;
+	}
+
+	if ((*rule_idx >= flow_steering->tbl_size) &&
+	    (*rule_idx != ENA_ADMIN_FLOW_STEERING_DEVICE_CHOOSE_LOCATION)) {
+		ena_trc_err(ena_dev, "Failed to add a flow steering rule, index %u out of bounds\n",
+			    *rule_idx);
+		return ENA_COM_INVAL;
+	}
+
+	if ((*rule_idx != ENA_ADMIN_FLOW_STEERING_DEVICE_CHOOSE_LOCATION) &&
+	    flow_steering->flow_steering_tbl[*rule_idx].in_use) {
+		ena_trc_err(ena_dev,
+			    "Failed to configure Flow steering rule to index %u with currently active rule in it\n",
+			    *rule_idx);
+		return ENA_COM_INVAL;
+	}
+
+	memset(&cmd, 0x0, sizeof(cmd));
+	admin_queue = &ena_dev->admin_queue;
+
+	cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
+	cmd.aq_common_descriptor.flags =
+			ENA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT_MASK;
+	cmd.feat_common.feature_id = ENA_ADMIN_FLOW_STEERING_CONFIG;
+	cmd.u.flow_steering.action = ENA_ADMIN_FLOW_STEERING_ADD_RULE;
+	cmd.u.flow_steering.flow_type = configure_params->flow_type;
+	cmd.u.flow_steering.rx_q_idx = configure_params->qid;
+	cmd.u.flow_steering.rule_location = *rule_idx;
+	cmd.u.flow_steering.flags = 0;
+
+	memcpy(flow_steering->requested_rule,
+	       &configure_params->flow_params,
+	       sizeof(struct ena_admin_flow_steering_rule_params));
+
+	ret = ena_com_mem_addr_set(ena_dev,
+				   &cmd.control_buffer.address,
+				   flow_steering->requested_rule_dma_addr);
+	if (unlikely(ret)) {
+		ena_trc_err(ena_dev, "Memory address set failed\n");
+		return ret;
+	}
+
+	cmd.control_buffer.length = sizeof(struct ena_admin_flow_steering_rule_params);
+
+	ret = ena_com_execute_admin_command(admin_queue,
+					    (struct ena_admin_aq_entry *)&cmd,
+					    sizeof(cmd),
+					    (struct ena_admin_acq_entry *)&resp,
+					    sizeof(resp));
+	if (unlikely(ret)) {
+		ena_trc_err(ena_dev, "Failed to add a new flow steering rule: %d\n", ret);
+		return ret;
+	}
+
+	/* If the rule index needs to be chosen by the device,
+	 * set it to the rule_idx from the response
+	 */
+	if (*rule_idx == ENA_ADMIN_FLOW_STEERING_DEVICE_CHOOSE_LOCATION) {
+		*rule_idx = resp.u.flow_steering.rule_location;
+		if (*rule_idx >= flow_steering->tbl_size) {
+			ena_trc_err(ena_dev, "Flow steering rule configured to invalid index: %d\n",
+				    *rule_idx);
+			return ENA_COM_FAULT;
+		}
+	}
+
+	flow_steering->flow_steering_tbl[*rule_idx].rule_params = *configure_params;
+	flow_steering->flow_steering_tbl[*rule_idx].in_use = true;
+
+	flow_steering->active_rules_cnt++;
+
+	return 0;
+}
+
+int ena_com_flow_steering_remove_rule(struct ena_com_dev *ena_dev, u16 rule_idx)
+{
+	struct ena_com_flow_steering *flow_steering = &ena_dev->flow_steering;
+	struct ena_admin_set_feat_resp resp;
+	struct ena_admin_set_feat_cmd cmd;
+	int ret;
+
+	if (!(ena_dev->supported_features & BIT(ENA_ADMIN_FLOW_STEERING_CONFIG))) {
+		ena_trc_err(ena_dev, "Flow steering rules are not supported by this device\n");
+		return ENA_COM_UNSUPPORTED;
+	}
+
+	if (rule_idx >= flow_steering->tbl_size) {
+		ena_trc_err(ena_dev, "Failed to remove a flow steering rule, index %u out of bounds\n",
+			    rule_idx);
+		return ENA_COM_INVAL;
+	}
+
+	if (!flow_steering->flow_steering_tbl[rule_idx].in_use) {
+		ena_trc_err(ena_dev,
+			    "Failed to remove a flow steering rule, no rule configured in index %u\n",
+			    rule_idx);
+		return ENA_COM_INVAL;
+	}
+
+	memset(&cmd, 0x0, sizeof(cmd));
+
+	cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
+	cmd.feat_common.feature_id = ENA_ADMIN_FLOW_STEERING_CONFIG;
+	cmd.u.flow_steering.action = ENA_ADMIN_FLOW_STEERING_REMOVE_RULE;
+	cmd.u.flow_steering.rule_location = rule_idx;
+
+	ret = ena_com_execute_admin_command(&ena_dev->admin_queue,
+					    (struct ena_admin_aq_entry *)&cmd,
+					    sizeof(cmd),
+					    (struct ena_admin_acq_entry *)&resp,
+					    sizeof(resp));
+	if (unlikely(ret)) {
+		ena_trc_err(ena_dev, "Failed to remove a flow steering rule: %d\n", ret);
+		return ret;
+	}
+
+	memset(&flow_steering->flow_steering_tbl[rule_idx].rule_params, 0,
+	       sizeof(struct ena_admin_flow_steering_rule_params));
+	flow_steering->flow_steering_tbl[rule_idx].in_use = false;
+
+	flow_steering->active_rules_cnt--;
+
+	return 0;
+}
+
+int ena_com_flow_steering_remove_all_rules(struct ena_com_dev *ena_dev)
+{
+	struct ena_com_flow_steering *flow_steering = &ena_dev->flow_steering;
+	struct ena_admin_set_feat_resp resp;
+	struct ena_admin_set_feat_cmd cmd;
+	int ret;
+
+	if (!(ena_dev->supported_features & BIT(ENA_ADMIN_FLOW_STEERING_CONFIG))) {
+		ena_trc_err(ena_dev, "Flow steering rules are not supported by this device\n");
+		return ENA_COM_UNSUPPORTED;
+	}
+
+	memset(&cmd, 0x0, sizeof(cmd));
+
+	cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
+	cmd.feat_common.feature_id = ENA_ADMIN_FLOW_STEERING_CONFIG;
+	cmd.u.flow_steering.action = ENA_ADMIN_FLOW_STEERING_REMOVE_ALL_RULES;
+
+	ret = ena_com_execute_admin_command(&ena_dev->admin_queue,
+					    (struct ena_admin_aq_entry *)&cmd,
+					    sizeof(cmd),
+					    (struct ena_admin_acq_entry *)&resp,
+					    sizeof(resp));
+	if (unlikely(ret)) {
+		ena_trc_err(ena_dev, "Failed to remove all flow steering rules: %d\n", ret);
+		return ret;
+	}
+
+	memset(flow_steering->flow_steering_tbl, 0,
+	       flow_steering->tbl_size * sizeof(struct ena_com_flow_steering_table_entry));
+	flow_steering->active_rules_cnt = 0;
+
+	return 0;
+}
+
+int ena_com_flow_steering_get_rule(struct ena_com_dev *ena_dev,
+				   struct ena_com_flow_steering_rule_params *configure_params,
+				   u16 rule_idx)
+{
+	struct ena_com_flow_steering *flow_steering = &ena_dev->flow_steering;
+	struct ena_com_flow_steering_table_entry *entry;
+
+	if (!(ena_dev->supported_features & BIT(ENA_ADMIN_FLOW_STEERING_CONFIG))) {
+		ena_trc_err(ena_dev, "Flow steering rules are not supported by this device\n");
+		return ENA_COM_UNSUPPORTED;
+	}
+
+	if (rule_idx >= flow_steering->tbl_size) {
+		ena_trc_err(ena_dev, "Failed to get a flow steering rule, index %u out bounds\n",
+			    rule_idx);
+		return ENA_COM_INVAL;
+	}
+
+	entry = &flow_steering->flow_steering_tbl[rule_idx];
+
+	if (!entry->in_use) {
+		ena_trc_err(ena_dev, "Failed to get a flow steering rule in index %u, entry not in use\n",
+			    rule_idx);
+		return ENA_COM_INVAL;
+	}
+
+	*configure_params = entry->rule_params;
+
+	return 0;
+}
+
+int ena_com_flow_steering_restore_device_rules(struct ena_com_dev *ena_dev)
+{
+	struct ena_com_flow_steering *flow_steering = &ena_dev->flow_steering;
+	struct ena_com_flow_steering_table_entry *rule_entry;
+	u16 rule_idx;
+	int ret;
+
+	if (!(ena_dev->supported_features & BIT(ENA_ADMIN_FLOW_STEERING_CONFIG)))
+		return ENA_COM_UNSUPPORTED;
+
+	/* no rules to restore */
+	if (flow_steering->active_rules_cnt == 0)
+		return 0;
+
+	/* set the amount of active rules to zero, will count them again while restoring */
+	flow_steering->active_rules_cnt = 0;
+
+	for (rule_idx = 0; rule_idx < flow_steering->tbl_size; rule_idx++) {
+		rule_entry = &flow_steering->flow_steering_tbl[rule_idx];
+
+		if (rule_entry->in_use) {
+			/* mark the entry as not in use before attempt to reconfigure it
+			 * so it will be counted as new rule
+			 */
+			rule_entry->in_use = false;
+
+			ret = ena_com_flow_steering_add_rule(ena_dev, &rule_entry->rule_params,
+							     &rule_idx);
+			if (unlikely(ret)) {
+				ena_trc_err(ena_dev,
+					    "Failed to restore flow steering rule in index %d\n",
+					    rule_idx);
+				return ENA_COM_FAULT;
+			}
+		}
+	}
+
+	return 0;
+}
+
 int ena_com_set_frag_bypass(struct ena_com_dev *ena_dev, bool enable)
 {
 	struct ena_com_admin_queue *admin_queue;
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index df7e0786bf..c8f6161e63 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -368,6 +368,28 @@ struct ena_host_attribute {
 	ena_mem_handle_t host_info_dma_handle;
 };
 
+struct ena_com_flow_steering_rule_params {
+	struct ena_admin_flow_steering_rule_params flow_params;
+	u16 qid;
+	/* Specific flow type as defined in enum ena_admin_flow_steering_type */
+	u8 flow_type;
+};
+
+struct ena_com_flow_steering_table_entry {
+	struct ena_com_flow_steering_rule_params rule_params;
+	bool in_use;
+};
+
+struct ena_com_flow_steering {
+	struct ena_com_flow_steering_table_entry *flow_steering_tbl;
+	u16 tbl_size;
+	u16 active_rules_cnt;
+
+	ena_mem_handle_t requested_rule_mem_handle;
+	struct ena_admin_flow_steering_rule_params *requested_rule;
+	dma_addr_t requested_rule_dma_addr;
+};
+
 /* Each ena_dev is a PCI function. */
 struct ena_com_dev {
 	struct ena_com_admin_queue admin_queue;
@@ -410,6 +432,9 @@ struct ena_com_dev {
 	struct ena_com_llq_info llq_info;
 
 	struct ena_customer_metrics customer_metrics;
+
+	struct ena_com_flow_steering flow_steering;
+
 	bool use_extended_tx_cdesc;
 	bool use_extended_rx_cdesc;
 };
@@ -799,6 +824,23 @@ int ena_com_rss_init(struct ena_com_dev *ena_dev);
  */
 void ena_com_rss_destroy(struct ena_com_dev *ena_dev);
 
+/* ena_com_flow_steering_init - Init Flow steering
+ * @ena_dev: ENA communication layer struct
+ * @flow_steering_entries: Number of Flow steering entries to use.
+ *
+ * Allocate the table to hold the steering rules context.
+ *
+ * @return: 0 on success and negative value otherwise.
+ */
+int ena_com_flow_steering_init(struct ena_com_dev *ena_dev, u16 flow_steering_entries);
+
+/* ena_com_flow_steering_destroy - Destroy flow steering
+ * @ena_dev: ENA communication layer struct
+ *
+ * Free the flow steering allocated resources.
+ */
+void ena_com_flow_steering_destroy(struct ena_com_dev *ena_dev);
+
 /* ena_com_get_current_hash_function - Get RSS hash function
  * @ena_dev: ENA communication layer struct
  *
@@ -1101,6 +1143,50 @@ static inline bool ena_com_get_missing_admin_interrupt(struct ena_com_dev *ena_d
 	return ena_dev->admin_queue.is_missing_admin_interrupt;
 }
 
+/* ena_com_flow_steering_add_rule - configure new Rx flow steering rule
+ * @ena_dev: ENA communication layer struct
+ * @configure_params: Steering rule params, including queue and flow type.
+ * @rule_idx: Index in rules table to configure the rule into, on return
+ * it will hold the actual index of the configured rule.
+ *
+ * @return - 0 on success, negative value on failure.
+ */
+int ena_com_flow_steering_add_rule(struct ena_com_dev *ena_dev,
+				   struct ena_com_flow_steering_rule_params *configure_params,
+				   u16 *rule_idx);
+
+/* ena_com_flow_steering_remove_rule - Remove an existing RX flow steering rule
+ * @ena_dev: ENA communication layer struct
+ * @rule_idx: Rule table index to delete
+ *
+ * @return - 0 on success, negative value on failure.
+ */
+int ena_com_flow_steering_remove_rule(struct ena_com_dev *ena_dev, u16 rule_idx);
+
+/* ena_com_flow_steering_remove_all_rules - Remove all flow steering rules
+ * @ena_dev: ENA communication layer struct
+ *
+ * @return - 0 on success, negative value on failure.
+ */
+int ena_com_flow_steering_remove_all_rules(struct ena_com_dev *ena_dev);
+
+/* ena_com_flow_steering_get_rule - retrieve info about specific steering rule
+ * @ena_dev: ENA communication layer struct
+ * @configure_params: pointer to be filled with the steering rule parmeters.
+ * @rule_idx: Rule index to get info about.
+ *
+ * @return - 0 on success, negative value on failure.
+ */
+int ena_com_flow_steering_get_rule(struct ena_com_dev *ena_dev,
+				   struct ena_com_flow_steering_rule_params *configure_params,
+				   u16 rule_idx);
+
+/* ena_com_flow_steering_restore_device_rules - reconfigure the existing rules to the device
+ * after resets caused by errors
+ * @ena_dev: ENA communication layer struct
+ */
+int ena_com_flow_steering_restore_device_rules(struct ena_com_dev *ena_dev);
+
 /* ena_com_set_frag_bypass - set fragment bypass
  * @ena_dev: ENA communication layer struct
  * @enable: true if fragment bypass is enabled, false otherwise.
diff --git a/drivers/net/ena/base/ena_defs/ena_admin_defs.h b/drivers/net/ena/base/ena_defs/ena_admin_defs.h
index 717d21f9b9..64b4f8cb5f 100644
--- a/drivers/net/ena/base/ena_defs/ena_admin_defs.h
+++ b/drivers/net/ena/base/ena_defs/ena_admin_defs.h
@@ -9,6 +9,8 @@
 #define ENA_ADMIN_EXTRA_PROPERTIES_STRING_LEN 32
 #define ENA_ADMIN_EXTRA_PROPERTIES_COUNT     32
 
+#define ENA_ADMIN_FLOW_STEERING_DEVICE_CHOOSE_LOCATION 0xFFFF
+
 #define ENA_ADMIN_RSS_KEY_PARTS              10
 
 #define ENA_ADMIN_CUSTOMER_METRICS_SUPPORT_MASK 0x3F
@@ -68,6 +70,7 @@ enum ena_admin_aq_feature_id {
 	ENA_ADMIN_LINK_CONFIG                       = 27,
 	ENA_ADMIN_HOST_ATTR_CONFIG                  = 28,
 	ENA_ADMIN_PHC_CONFIG                        = 29,
+	ENA_ADMIN_FLOW_STEERING_CONFIG              = 30,
 	ENA_ADMIN_HW_TIMESTAMP                      = 31,
 	ENA_ADMIN_FEATURES_OPCODE_NUM               = 32,
 };
@@ -600,7 +603,7 @@ struct ena_admin_device_attr_feature_desc {
 	/* unicast MAC address (in Network byte order) */
 	uint8_t mac_addr[6];
 
-	uint8_t reserved7[2];
+	uint16_t flow_steering_max_entries;
 
 	uint32_t max_mtu;
 };
@@ -751,6 +754,78 @@ struct ena_admin_feature_hw_ts_desc {
 	uint8_t rx;
 };
 
+struct ena_admin_flow_steering_rule_params {
+	uint8_t dst_ip[16];
+
+	uint8_t dst_ip_mask[16];
+
+	uint8_t src_ip[16];
+
+	uint8_t src_ip_mask[16];
+
+	uint16_t dst_port;
+
+	uint16_t dst_port_mask;
+
+	uint16_t src_port;
+
+	uint16_t src_port_mask;
+
+	uint8_t tos;
+
+	uint8_t tos_mask;
+
+	/* Reserved */
+	uint8_t reserved1[54];
+};
+
+/* add new rule or remove existing one */
+enum ena_admin_flow_steering_action {
+	ENA_ADMIN_FLOW_STEERING_ADD_RULE            = 1,
+	ENA_ADMIN_FLOW_STEERING_REMOVE_RULE         = 2,
+	ENA_ADMIN_FLOW_STEERING_REMOVE_ALL_RULES    = 3,
+};
+
+/* type of traffic the rule applied on */
+enum ena_admin_flow_steering_type {
+	ENA_ADMIN_FLOW_INVALID                      = 0,
+	ENA_ADMIN_FLOW_IPV4                         = 1,
+	ENA_ADMIN_FLOW_IPV6                         = 2,
+	ENA_ADMIN_FLOW_IPV4_TCP                     = 3,
+	ENA_ADMIN_FLOW_IPV6_TCP                     = 4,
+	ENA_ADMIN_FLOW_IPV4_UDP                     = 5,
+	ENA_ADMIN_FLOW_IPV6_UDP                     = 6,
+	ENA_ADMIN_FLOW_LAST                         = 7,
+};
+
+struct ena_admin_set_feature_flow_steering_desc_req {
+	/* specific command action as defined in enum
+	 * ena_admin_flow_steering_action
+	 */
+	uint8_t action;
+
+	/* specific flow type as defined in enum ena_admin_flow_steering_type */
+	uint8_t flow_type;
+
+	uint16_t rx_q_idx;
+
+	/* if value is ENA_ADMIN_FLOW_STEERING_DEVICE_CHOOSE_LOCATION it means
+	 * the device should find unused location for this rule
+	 */
+	uint16_t rule_location;
+
+	uint16_t reserved;
+
+	/* 31:0 : reserved */
+	uint32_t flags;
+};
+
+struct ena_admin_set_feature_flow_steering_desc_resp {
+	uint16_t rule_location;
+
+	uint16_t reserved;
+};
+
 struct ena_admin_feature_frag_bypass_desc {
 	/* Enable frag_bypass */
 	uint8_t enable;
@@ -1234,6 +1309,9 @@ struct ena_admin_set_feat_cmd {
 		/* PHC configuration */
 		struct ena_admin_feature_phc_desc phc;
 
+		/* Flow steering configuration */
+		struct ena_admin_set_feature_flow_steering_desc_req flow_steering;
+
 		/* Fragment bypass configuration */
 		struct ena_admin_feature_frag_bypass_desc frag_bypass;
 
@@ -1246,6 +1324,9 @@ struct ena_admin_set_feat_resp {
 
 	union {
 		uint32_t raw[14];
+
+		/* Flow steering configuration */
+		struct ena_admin_set_feature_flow_steering_desc_resp flow_steering;
 	} u;
 };
 
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index c2d0194e51..3eee5e2545 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -240,6 +240,7 @@ static void ena_tx_map_mbuf(struct ena_ring *tx_ring,
 	uint16_t *header_len);
 static int ena_xmit_mbuf(struct ena_ring *tx_ring, struct rte_mbuf *mbuf);
 static int ena_tx_cleanup(void *txp, uint32_t free_pkt_cnt);
+static int ena_flow_ops_get(struct rte_eth_dev *dev, const struct rte_flow_ops **ops);
 static uint16_t eth_ena_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 				  uint16_t nb_pkts);
 static uint16_t eth_ena_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
@@ -360,6 +361,7 @@ static const struct eth_dev_ops ena_dev_ops = {
 	.rss_hash_update        = ena_rss_hash_update,
 	.rss_hash_conf_get      = ena_rss_hash_conf_get,
 	.tx_done_cleanup        = ena_tx_cleanup,
+	.flow_ops_get           = ena_flow_ops_get,
 };
 
 /*********************************************************************
@@ -944,6 +946,12 @@ static int ena_close(struct rte_eth_dev *dev)
 		rte_eal_alarm_cancel(ena_control_path_poll_handler, dev);
 	}
 
+	if (adapter->flow_rule_count) {
+		PMD_INIT_LOG_LINE(WARNING,
+				  "Closing device with %u active flow rules",
+				  adapter->flow_rule_count);
+		adapter->flow_rule_count = 0;
+	}
 	ena_rx_queue_release_all(dev);
 	ena_tx_queue_release_all(dev);
 
@@ -952,6 +960,7 @@ static int ena_close(struct rte_eth_dev *dev)
 	adapter->drv_stats = NULL;
 	ena_com_set_admin_running_state(ena_dev, false);
 	ena_com_rss_destroy(ena_dev);
+	ena_com_flow_steering_destroy(ena_dev);
 	ena_com_delete_debug_area(ena_dev);
 	ena_com_delete_host_info(ena_dev);
 	ena_com_abort_admin_commands(ena_dev);
@@ -1460,6 +1469,17 @@ static int ena_stop(struct rte_eth_dev *dev)
 			PMD_DRV_LOG_LINE(ERR, "Device reset failed, rc: %d", rc);
 	}
 
+	/*
+	 * Warn if application didn't flush rules before stopping.
+	 * RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP is not advertised, so applications must
+	 * not rely on rules being kept across device stop. The PMD doesn't flush
+	 * them either, so the remaining rules stay active until destroyed.
+	 */
+	if (adapter->flow_rule_count)
+		PMD_DRV_LOG_LINE(WARNING,
+				 "Stopping device with %u active flow rules. "
+				 "Application should call rte_flow_flush() before stop.",
+				 adapter->flow_rule_count);
 	rte_intr_disable(intr_handle);
 
 	rte_intr_efd_disable(intr_handle);
@@ -2546,6 +2566,19 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 			goto err_rss_destroy;
 		}
 	}
+
+	/* A device that reports no rule entries can't hold any rule */
+	if (!get_feat_ctx.dev_attr.flow_steering_max_entries)
+		ena_dev->supported_features &= ~BIT(ENA_ADMIN_FLOW_STEERING_CONFIG);
+
+	rc = ena_com_flow_steering_init(ena_dev,
+					get_feat_ctx.dev_attr.flow_steering_max_entries);
+	if (rc && rc != ENA_COM_UNSUPPORTED) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to init flow steering rules: %d", rc);
+		goto err_indirect_table_destroy;
+	}
+	adapter->flow_rule_count = 0;
+
 	adapter->drv_stats = rte_zmalloc("adapter stats",
 					 sizeof(*adapter->drv_stats),
 					 RTE_CACHE_LINE_SIZE);
@@ -2553,7 +2586,7 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 		PMD_DRV_LOG_LINE(ERR,
 			"Failed to allocate memory for adapter statistics");
 		rc = -ENOMEM;
-		goto err_indirect_table_destroy;
+		goto err_rx_flow_steering_destroy;
 	}
 
 	rte_spinlock_init(&adapter->admin_lock);
@@ -2597,6 +2630,8 @@ static int eth_ena_dev_init(struct rte_eth_dev *eth_dev)
 	}
 err_stats_destroy:
 	rte_free(adapter->drv_stats);
+err_rx_flow_steering_destroy:
+	ena_com_flow_steering_destroy(ena_dev);
 err_indirect_table_destroy:
 	ena_indirect_table_release(adapter);
 err_rss_destroy:
@@ -2818,6 +2853,24 @@ static int ena_infos_get(struct rte_eth_dev *dev,
 
 	dev_info->err_handle_mode = RTE_ETH_ERROR_HANDLE_MODE_PASSIVE;
 
+	/*
+	 * Flow rule lifecycle compliance:
+	 * rte_flow specification states that if this flag is not advertised,
+	 * rules cannot be created until the device is started for the
+	 * first time and cannot be kept when the device is stopped.
+	 * Explicitly clear RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP to inform applications
+	 * that they must not rely on rules being kept across device stop, and
+	 * should call rte_flow_flush() before stopping the device.
+	 */
+	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
+	/*
+	 * ENA PMD does not implement internal locking for flow operations.
+	 * We clear RTE_ETH_DEV_FLOW_OPS_THREAD_SAFE to tell DPDK that the
+	 * rte_flow API layer must provide thread-safety protection (via mutex)
+	 * when multiple threads call flow operations concurrently.
+	 */
+	dev->data->dev_flags &= ~RTE_ETH_DEV_FLOW_OPS_THREAD_SAFE;
+
 	return 0;
 }
 
@@ -4354,3 +4407,19 @@ static bool ena_use_large_llq_hdr(struct ena_adapter *adapter, uint8_t recommend
 	}
 	return false;
 }
+
+static int
+ena_flow_ops_get(struct rte_eth_dev *dev, const struct rte_flow_ops **ops)
+{
+	struct ena_adapter *adapter = dev->data->dev_private;
+	struct ena_com_dev *ena_dev = &adapter->ena_dev;
+
+	if (!(ena_dev->supported_features & BIT(ENA_ADMIN_FLOW_STEERING_CONFIG))) {
+		PMD_DRV_LOG_LINE(WARNING, "Flow steering not supported");
+		*ops = NULL;
+		rte_errno = ENOTSUP;
+		return -rte_errno;
+	}
+	*ops = &ena_flow_ops;
+	return 0;
+}
diff --git a/drivers/net/ena/ena_ethdev.h b/drivers/net/ena/ena_ethdev.h
index b204b07767..7a7d4a4036 100644
--- a/drivers/net/ena/ena_ethdev.h
+++ b/drivers/net/ena/ena_ethdev.h
@@ -15,7 +15,7 @@
 #include <rte_timer.h>
 #include <rte_dev.h>
 #include <rte_net.h>
-
+#include "ena_flow.h"
 #include "ena_com.h"
 
 #define ENA_REGS_BAR	0
@@ -343,6 +343,7 @@ struct ena_adapter {
 	struct ena_stats_dev dev_stats;
 	struct ena_admin_basic_stats basic_stats;
 
+	uint16_t flow_rule_count;
 	u32 *indirect_table;
 	size_t indirect_table_size;
 
diff --git a/drivers/net/ena/ena_flow.c b/drivers/net/ena/ena_flow.c
new file mode 100644
index 0000000000..1594c02f87
--- /dev/null
+++ b/drivers/net/ena/ena_flow.c
@@ -0,0 +1,542 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2024 Amazon.com, Inc. or its affiliates.
+ */
+
+#include <rte_flow.h>
+#include <rte_flow_driver.h>
+#include <rte_malloc.h>
+
+#include "ena_ethdev.h"
+#include "ena_logs.h"
+#include "base/ena_com.h"
+#include "ena_flow.h"
+
+/* Flow handle encoding - no heap allocation needed */
+static inline struct rte_flow *
+ena_flow_handle_encode(uint16_t rule_idx)
+{
+	return (struct rte_flow *)(uintptr_t)(rule_idx + 1);
+}
+
+static inline int
+ena_flow_handle_decode(const struct rte_flow *flow, uint16_t *rule_idx)
+{
+	uintptr_t v = (uintptr_t)flow;
+	if (v == 0 || v > (uintptr_t)UINT16_MAX + 1)
+		return -EINVAL;
+	*rule_idx = (uint16_t)(v - 1);
+	return 0;
+}
+
+/* Convert to ENA flow type - note: returns uint8_t for flow_type field */
+static uint8_t
+ena_flow_type_convert(bool ipv4, bool ipv6, bool tcp, bool udp)
+{
+	if (ipv4 && tcp)
+		return ENA_ADMIN_FLOW_IPV4_TCP;
+	if (ipv4 && udp)
+		return ENA_ADMIN_FLOW_IPV4_UDP;
+	if (ipv4)
+		return ENA_ADMIN_FLOW_IPV4;
+	if (ipv6 && tcp)
+		return ENA_ADMIN_FLOW_IPV6_TCP;
+	if (ipv6 && udp)
+		return ENA_ADMIN_FLOW_IPV6_UDP;
+	if (ipv6)
+		return ENA_ADMIN_FLOW_IPV6;
+
+	return ENA_ADMIN_FLOW_INVALID;
+}
+
+/* Parse rte_flow pattern and actions into ENA format */
+static int
+ena_flow_parse(struct rte_eth_dev *dev,
+	       const struct rte_flow_item pattern[],
+	       const struct rte_flow_action actions[],
+	       struct ena_com_flow_steering_rule_params *cfg,
+	       struct rte_flow_error *error)
+{
+	const struct rte_flow_item *item;
+	const struct rte_flow_action *action;
+	bool has_ipv4 = false, has_ipv6 = false;
+	bool has_tcp = false, has_udp = false;
+	bool has_queue = false;
+	uint8_t flow_type;
+
+	if (!pattern || !actions || !cfg)
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					  NULL, "Null flow input");
+
+	memset(cfg, 0, sizeof(*cfg));
+
+	/* Parse pattern items - spec/mask semantics, ranges (last) are rejected */
+	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
+		if (item->type == RTE_FLOW_ITEM_TYPE_VOID)
+			continue;
+
+		switch (item->type) {
+		case RTE_FLOW_ITEM_TYPE_ETH: {
+			const struct rte_flow_item_eth *spec = item->spec;
+			const struct rte_flow_item_eth *mask = item->mask;
+
+			/* Reject mask/last without spec */
+			if (!spec && (mask || item->last))
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "mask/last without spec");
+
+			if (!spec)
+				break; /* wildcard ETH */
+
+			/* Use default mask if not provided */
+			if (!mask)
+				mask = &rte_flow_item_eth_mask;
+
+			/* Reject any ETH field matching (not supported) */
+			if (mask->hdr.ether_type != 0)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "EtherType matching not supported");
+
+			for (int i = 0; i < 6; i++) {
+				if (mask->hdr.dst_addr.addr_bytes[i] ||
+				    mask->hdr.src_addr.addr_bytes[i])
+					return rte_flow_error_set(error, ENOTSUP,
+								  RTE_FLOW_ERROR_TYPE_ITEM, item,
+								  "MAC address matching not supported");
+			}
+			break;
+		}
+
+		case RTE_FLOW_ITEM_TYPE_IPV4: {
+			const struct rte_flow_item_ipv4 *spec = item->spec;
+			const struct rte_flow_item_ipv4 *mask = item->mask;
+
+			/* Reject mask/last without spec */
+			if (!spec && (mask || item->last))
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "mask/last without spec");
+
+			if (!spec)
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "IPv4 item requires spec");
+
+			if (item->last)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Range (last) not supported");
+
+			has_ipv4 = true;
+			if (has_ipv6)
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Mixed IPv4/IPv6 not supported");
+
+			/* Use default mask if not provided */
+			if (!mask)
+				mask = &rte_flow_item_ipv4_mask;
+
+			/* Reject unsupported mask fields */
+			if (mask->hdr.version_ihl || mask->hdr.total_length ||
+			    mask->hdr.packet_id || mask->hdr.fragment_offset ||
+			    mask->hdr.time_to_live || mask->hdr.next_proto_id ||
+			    mask->hdr.hdr_checksum)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Unsupported IPv4 header mask fields");
+
+			/* Copy supported fields: src/dst + tos */
+			memcpy(cfg->flow_params.src_ip, &spec->hdr.src_addr, 4);
+			memcpy(cfg->flow_params.src_ip_mask, &mask->hdr.src_addr, 4);
+			memcpy(cfg->flow_params.dst_ip, &spec->hdr.dst_addr, 4);
+			memcpy(cfg->flow_params.dst_ip_mask, &mask->hdr.dst_addr, 4);
+			cfg->flow_params.tos = spec->hdr.type_of_service;
+			cfg->flow_params.tos_mask = mask->hdr.type_of_service;
+			break;
+		}
+
+		case RTE_FLOW_ITEM_TYPE_IPV6: {
+			const struct rte_flow_item_ipv6 *spec = item->spec;
+			const struct rte_flow_item_ipv6 *mask = item->mask;
+
+			/* Reject mask/last without spec */
+			if (!spec && (mask || item->last))
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "mask/last without spec");
+
+			if (!spec)
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "IPv6 item requires spec");
+
+			if (item->last)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Range (last) not supported");
+
+			has_ipv6 = true;
+			if (has_ipv4)
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Mixed IPv4/IPv6 not supported");
+
+			/* Use default mask if not provided */
+			if (!mask)
+				mask = &rte_flow_item_ipv6_mask;
+
+			/* Reject unsupported IPv6 mask fields */
+			if (mask->hdr.payload_len || mask->hdr.proto || mask->hdr.hop_limits)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Unsupported IPv6 header mask fields");
+
+			/* Only allow traffic class bits in vtc_flow mask */
+			uint32_t vtc_m = rte_be_to_cpu_32(mask->hdr.vtc_flow);
+			if (vtc_m & 0xF0000000u) /* version bits */
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "IPv6 version matching not supported");
+			if (vtc_m & 0x000FFFFFu) /* flowlabel bits */
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "IPv6 flowlabel matching not supported");
+
+			memcpy(cfg->flow_params.src_ip, spec->hdr.src_addr.a, 16);
+			memcpy(cfg->flow_params.src_ip_mask, mask->hdr.src_addr.a, 16);
+			memcpy(cfg->flow_params.dst_ip, spec->hdr.dst_addr.a, 16);
+			memcpy(cfg->flow_params.dst_ip_mask, mask->hdr.dst_addr.a, 16);
+
+			uint32_t vtc = rte_be_to_cpu_32(spec->hdr.vtc_flow);
+			cfg->flow_params.tos = (uint8_t)((vtc >> 20) & 0xFF);
+			cfg->flow_params.tos_mask = (uint8_t)((vtc_m >> 20) & 0xFF);
+			break;
+		}
+
+		case RTE_FLOW_ITEM_TYPE_TCP: {
+			const struct rte_flow_item_tcp *spec = item->spec;
+			const struct rte_flow_item_tcp *mask = item->mask;
+
+			/* Reject mask/last without spec */
+			if (!spec && (mask || item->last))
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "mask/last without spec");
+
+			if (!spec)
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "TCP item requires spec");
+
+			if (item->last)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Range (last) not supported");
+
+			has_tcp = true;
+			if (has_udp)
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Mixed TCP/UDP not supported");
+
+			/* Use default mask if not provided */
+			if (!mask)
+				mask = &rte_flow_item_tcp_mask;
+
+			/* Reject unsupported TCP mask fields */
+			if (mask->hdr.sent_seq || mask->hdr.recv_ack ||
+			    mask->hdr.data_off || mask->hdr.tcp_flags ||
+			    mask->hdr.rx_win || mask->hdr.cksum || mask->hdr.tcp_urp)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Unsupported TCP header mask fields");
+
+			cfg->flow_params.src_port = rte_be_to_cpu_16(spec->hdr.src_port);
+			cfg->flow_params.src_port_mask = rte_be_to_cpu_16(mask->hdr.src_port);
+			cfg->flow_params.dst_port = rte_be_to_cpu_16(spec->hdr.dst_port);
+			cfg->flow_params.dst_port_mask = rte_be_to_cpu_16(mask->hdr.dst_port);
+			break;
+		}
+
+		case RTE_FLOW_ITEM_TYPE_UDP: {
+			const struct rte_flow_item_udp *spec = item->spec;
+			const struct rte_flow_item_udp *mask = item->mask;
+
+			/* Reject mask/last without spec */
+			if (!spec && (mask || item->last))
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "mask/last without spec");
+
+			if (!spec)
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "UDP item requires spec");
+
+			if (item->last)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Range (last) not supported");
+
+			has_udp = true;
+			if (has_tcp)
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Mixed TCP/UDP not supported");
+
+			/* Use default mask if not provided */
+			if (!mask)
+				mask = &rte_flow_item_udp_mask;
+
+			/* Reject unsupported UDP mask fields */
+			if (mask->hdr.dgram_len || mask->hdr.dgram_cksum)
+				return rte_flow_error_set(error, ENOTSUP,
+							  RTE_FLOW_ERROR_TYPE_ITEM, item,
+							  "Unsupported UDP header mask fields");
+
+			cfg->flow_params.src_port = rte_be_to_cpu_16(spec->hdr.src_port);
+			cfg->flow_params.src_port_mask = rte_be_to_cpu_16(mask->hdr.src_port);
+			cfg->flow_params.dst_port = rte_be_to_cpu_16(spec->hdr.dst_port);
+			cfg->flow_params.dst_port_mask = rte_be_to_cpu_16(mask->hdr.dst_port);
+			break;
+		}
+
+		default:
+			return rte_flow_error_set(error, ENOTSUP,
+						  RTE_FLOW_ERROR_TYPE_ITEM,
+						  item, "Unsupported pattern item");
+		}
+	}
+
+	/* Determine flow type */
+	flow_type = ena_flow_type_convert(has_ipv4, has_ipv6, has_tcp, has_udp);
+	if (flow_type == ENA_ADMIN_FLOW_INVALID)
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ITEM,
+					  NULL, "Invalid pattern: requires IPv4 or IPv6");
+
+	cfg->flow_type = flow_type;
+
+	/* Parse actions: exactly one QUEUE, no other non-VOID actions */
+	for (action = actions; action->type != RTE_FLOW_ACTION_TYPE_END; action++) {
+		switch (action->type) {
+		case RTE_FLOW_ACTION_TYPE_VOID:
+			break;
+
+		case RTE_FLOW_ACTION_TYPE_QUEUE: {
+			const struct rte_flow_action_queue *queue = action->conf;
+
+			if (!queue)
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ACTION,
+							  action, "Missing queue configuration");
+
+			if (has_queue)
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ACTION,
+							  action, "Multiple QUEUE actions not supported");
+
+			/*
+			 * Validate queue index. It is checked only here: if the port is
+			 * later reconfigured with fewer Rx queues, the device silently
+			 * drops the packets matching this rule.
+			 */
+			if (queue->index >= dev->data->nb_rx_queues)
+				return rte_flow_error_set(error, EINVAL,
+							  RTE_FLOW_ERROR_TYPE_ACTION,
+							  action, "Queue index out of range");
+
+			cfg->qid = queue->index;
+			has_queue = true;
+			break;
+		}
+
+		default:
+			return rte_flow_error_set(error, ENOTSUP,
+						  RTE_FLOW_ERROR_TYPE_ACTION,
+						  action, "Unsupported action type");
+		}
+	}
+
+	/* QUEUE action is mandatory */
+	if (!has_queue)
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ACTION,
+					  NULL, "QUEUE action required");
+
+	return 0;
+}
+
+/* Validate flow rule */
+static int
+ena_flow_validate(struct rte_eth_dev *dev,
+		  const struct rte_flow_attr *attr,
+		  const struct rte_flow_item pattern[],
+		  const struct rte_flow_action actions[],
+		  struct rte_flow_error *error)
+{
+	struct ena_com_flow_steering_rule_params cfg;
+
+	/* Check device is started - use STATE error type, not EAGAIN */
+	if (!dev->data->dev_started)
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_STATE, dev,
+					  "Device not started; flow rules cannot be created in this state");
+
+	/* Validate attributes */
+	if (attr->group != 0)
+		return rte_flow_error_set(error, ENOTSUP,
+					  RTE_FLOW_ERROR_TYPE_ATTR_GROUP,
+					  attr, "Only group 0 supported");
+
+	if (attr->priority != 0)
+		return rte_flow_error_set(error, ENOTSUP,
+					  RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY,
+					  attr, "Priority not supported");
+
+	if (!attr->ingress || attr->egress || attr->transfer)
+		return rte_flow_error_set(error, ENOTSUP,
+					  RTE_FLOW_ERROR_TYPE_ATTR,
+					  attr, "Only ingress supported");
+
+	/* Validate pattern and actions */
+	return ena_flow_parse(dev, pattern, actions, &cfg, error);
+}
+
+/* Create flow rule */
+static struct rte_flow *
+ena_flow_create(struct rte_eth_dev *dev,
+		const struct rte_flow_attr *attr,
+		const struct rte_flow_item pattern[],
+		const struct rte_flow_action actions[],
+		struct rte_flow_error *error)
+{
+	struct ena_adapter *adapter = dev->data->dev_private;
+	struct ena_com_dev *ena_dev = &adapter->ena_dev;
+	struct ena_com_flow_steering_rule_params cfg;
+	uint16_t rule_idx = ENA_ADMIN_FLOW_STEERING_DEVICE_CHOOSE_LOCATION;
+	int ret;
+
+	/* Validate attributes, parse pattern and actions into cfg */
+	ret = ena_flow_validate(dev, attr, pattern, actions, error);
+	if (ret)
+		return NULL;
+
+	/* Parse pattern and actions */
+	ret = ena_flow_parse(dev, pattern, actions, &cfg, error);
+	if (ret)
+		return NULL;
+
+	/* Add rule to hardware via base layer */
+	ret = ena_com_flow_steering_add_rule(ena_dev, &cfg, &rule_idx);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to add flow steering rule: %d", ret);
+		rte_flow_error_set(error, (ret == -EAGAIN) ? EBUSY : -ret,
+				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+				   "Failed to add flow steering rule");
+		return NULL;
+	}
+
+	/* Increment flow counter for lifecycle tracking */
+	adapter->flow_rule_count++;
+
+	PMD_DRV_LOG_LINE(DEBUG, "Flow rule created at HW location %u (total: %u)",
+		    rule_idx, adapter->flow_rule_count);
+
+	/* Return encoded handle (no heap allocation) */
+	return ena_flow_handle_encode(rule_idx);
+}
+
+/* Destroy flow rule */
+static int
+ena_flow_destroy(struct rte_eth_dev *dev,
+		 struct rte_flow *rte_flow,
+		 struct rte_flow_error *error)
+{
+	struct ena_adapter *adapter = dev->data->dev_private;
+	struct ena_com_dev *ena_dev = &adapter->ena_dev;
+	uint16_t rule_idx;
+	int ret;
+
+	/* Decode handle */
+	ret = ena_flow_handle_decode(rte_flow, &rule_idx);
+	if (ret)
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					  "Invalid flow handle");
+
+	/* Remove rule from hardware */
+	ret = ena_com_flow_steering_remove_rule(ena_dev, rule_idx);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to remove flow rule %u: %d",
+			    rule_idx, ret);
+		return rte_flow_error_set(error, -ret,
+					  RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+					  "Failed to remove rule from hardware");
+	}
+
+	/* Decrement flow counter */
+	if (adapter->flow_rule_count > 0)
+		adapter->flow_rule_count--;
+
+	PMD_DRV_LOG_LINE(DEBUG, "Flow rule %u destroyed (remaining: %u)",
+		    rule_idx, adapter->flow_rule_count);
+
+	/* No free needed - handle is encoded, not allocated */
+	return 0;
+}
+
+/* Flush all flow rules */
+static int
+ena_flow_flush(struct rte_eth_dev *dev, struct rte_flow_error *error)
+{
+	struct ena_adapter *adapter = dev->data->dev_private;
+	struct ena_com_dev *ena_dev = &adapter->ena_dev;
+	int ret;
+
+	/* Remove all rules from hardware */
+	ret = ena_com_flow_steering_remove_all_rules(ena_dev);
+	if (ret) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to flush all flow rules: %d", ret);
+		return rte_flow_error_set(error, -ret,
+					  RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+					  NULL, "Failed to flush rules from hardware");
+	}
+
+	PMD_DRV_LOG_LINE(DEBUG, "Flushed %u flow rules", adapter->flow_rule_count);
+
+	/* Reset flow counter */
+	adapter->flow_rule_count = 0;
+
+	/* No handles to free - all were encoded, not allocated */
+	return 0;
+}
+
+/* Query flow rule - not supported */
+static int
+ena_flow_query(struct rte_eth_dev *dev,
+	       struct rte_flow *flow,
+	       const struct rte_flow_action *action,
+	       void *data,
+	       struct rte_flow_error *error)
+{
+	(void)dev;
+	(void)flow;
+	(void)data;
+
+	return rte_flow_error_set(error, ENOTSUP,
+				  RTE_FLOW_ERROR_TYPE_ACTION,
+				  action, "Query not supported");
+}
+
+/* Flow operations structure */
+const struct rte_flow_ops ena_flow_ops = {
+	.validate = ena_flow_validate,
+	.create = ena_flow_create,
+	.destroy = ena_flow_destroy,
+	.flush = ena_flow_flush,
+	.query = ena_flow_query,
+};
diff --git a/drivers/net/ena/ena_flow.h b/drivers/net/ena/ena_flow.h
new file mode 100644
index 0000000000..e83aa56e87
--- /dev/null
+++ b/drivers/net/ena/ena_flow.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2024 Amazon.com, Inc. or its affiliates.
+ */
+#ifndef _ENA_FLOW_H_
+#define _ENA_FLOW_H_
+
+#include <rte_flow.h>
+
+/* Flow operations */
+extern const struct rte_flow_ops ena_flow_ops;
+
+#endif /* _ENA_FLOW_H_ */
diff --git a/drivers/net/ena/meson.build b/drivers/net/ena/meson.build
index 2b18d7add7..244775bf16 100644
--- a/drivers/net/ena/meson.build
+++ b/drivers/net/ena/meson.build
@@ -10,6 +10,7 @@ endif
 sources = files(
         'ena_ethdev.c',
         'ena_rss.c',
+        'ena_flow.c',
         'base/ena_com.c',
         'base/ena_eth_com.c',
 )
-- 
2.17.1

