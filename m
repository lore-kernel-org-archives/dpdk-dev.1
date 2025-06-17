Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EB0C71155
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 04:56:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7637D40697;
	Tue, 17 Jun 2025 06:56:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8E00740156
 for <dev@dpdk.org>; Tue, 17 Jun 2025 06:56:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750136174; x=1781672174;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5A3UN4ga+0DJ1+LMVF/SSy67rYNmcBzvNrn/srRrGgc=;
 b=fw+bLZorm1P+tu8EjN4y+lqxBAjSEmGz4yy9XQVmZKpCg1xjwFnnMEdw
 UwbHJ2wKqALA3vXOCx3Rq2UNVtj0TPm1Db+5Kg/0W/+CZcGvKbHcPGJvD
 jh3ICJoQYopwEFMS2W54N6rsYO/tmnMkarRmWGU+CJgGMGV6CZdSyoBc3
 S5BQ9rgtumYJz/u+WJy0UZM52GqkMSqDSMImWaOOycFPalQxcyhutDDg9
 2q45C0oIpGmmGkpUSSvK7Il73xeoVQxYTTN7GllxGpToo2SZwpehtyFpy
 MBLL40toeYlMYDFLelS/eNyXtjyqoT216uT0NWKlLiuWpVeDpgCFbAD88 A==;
X-CSE-ConnectionGUID: AEjx6CJxTcGJWZ2e+2CYhw==
X-CSE-MsgGUID: BkIyA3+7SR2WMk85UFL+xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="69739079"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="69739079"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:56:13 -0700
X-CSE-ConnectionGUID: UF0xXGjHTiGiPqcWZt3zlA==
X-CSE-MsgGUID: p3sQEojUSE+inqtdBm02iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="153627157"
Received: from srf-bkc.iind.intel.com ([10.49.110.107])
 by orviesa004.jf.intel.com with ESMTP; 16 Jun 2025 21:56:10 -0700
From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, pravin.pathak@intel.com,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Subject: [PATCH] event/dlb2: add datapath support in secondary processes
Date: Tue, 17 Jun 2025 00:56:07 -0400
Message-ID: <20250617045607.245070-1-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
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

The producer port and consumer queue addresses are configured during
port setup. These are needed during enqueue and dequeue operations.
For a eventdev that is configured in primary process, these need to be
stored so that secondary processes can retrieve them for doing enueue
and dequeue.

Store producer port and consumer queue addresses during port setup and
retrieve them back in local data during secondary init.

Additionally, add checks to retrieve stored addresses in primary data path
for ports configured in secondary.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/event/dlb2/dlb2.c                  | 23 ++++++++-
 drivers/event/dlb2/dlb2_iface.c            |  2 +-
 drivers/event/dlb2/dlb2_iface.h            |  2 +-
 drivers/event/dlb2/pf/base/dlb2_hw_types.h |  2 +
 drivers/event/dlb2/pf/dlb2_pf.c            | 57 +++++++++++++++++-----
 5 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 286241ea41..08291b10b8 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -3257,6 +3257,9 @@ __dlb2_event_enqueue_burst_reorder(void *event_port,
 
 	port_data = &dlb2_port[qm_port->id][PORT_TYPE(qm_port)];
 
+	if (!port_data->mmaped)
+		dlb2_iface_low_level_io_init(&ev_port->dlb2->qm_instance);
+
 	num_tx = RTE_MIN(num, ev_port->conf.enqueue_depth);
 #if DLB2_BYPASS_FENCE_ON_PP == 1
 	if (!qm_port->is_producer) /* Call memory fense once at the start */
@@ -3390,6 +3393,10 @@ __dlb2_event_enqueue_burst(void *event_port,
 	i = 0;
 
 	port_data = &dlb2_port[qm_port->id][PORT_TYPE(qm_port)];
+
+	if (!port_data->mmaped)
+		dlb2_iface_low_level_io_init(&ev_port->dlb2->qm_instance);
+
 	num_tx = RTE_MIN(num, ev_port->conf.enqueue_depth);
 	while (i < num_tx) {
 		uint8_t sched_types[DLB2_NUM_QES_PER_CACHE_LINE];
@@ -4448,11 +4455,17 @@ dlb2_event_dequeue_burst(void *event_port, struct rte_event *ev, uint16_t num,
 	struct dlb2_port *qm_port = &ev_port->qm_port;
 	struct dlb2_eventdev *dlb2 = ev_port->dlb2;
 	struct dlb2_reorder *order = qm_port->order;
+	struct process_local_port_data *port_data;
 	uint16_t cnt;
 
 	RTE_ASSERT(ev_port->setup_done);
 	RTE_ASSERT(ev != NULL);
 
+	port_data = &dlb2_port[qm_port->id][PORT_TYPE(qm_port)];
+
+	if (!port_data->mmaped)
+		dlb2_iface_low_level_io_init(&dlb2->qm_instance);
+
 	if (ev_port->implicit_release && ev_port->outstanding_releases > 0) {
 		uint16_t out_rels = ev_port->outstanding_releases;
 		if (qm_port->reorder_en) {
@@ -4495,11 +4508,17 @@ dlb2_event_dequeue_burst_sparse(void *event_port, struct rte_event *ev,
 	struct dlb2_port *qm_port = &ev_port->qm_port;
 	struct dlb2_eventdev *dlb2 = ev_port->dlb2;
 	struct dlb2_reorder *order = qm_port->order;
+	struct process_local_port_data *port_data;
 	uint16_t cnt;
 
 	RTE_ASSERT(ev_port->setup_done);
 	RTE_ASSERT(ev != NULL);
 
+	port_data = &dlb2_port[qm_port->id][PORT_TYPE(qm_port)];
+
+	if (!port_data->mmaped)
+		dlb2_iface_low_level_io_init(&dlb2->qm_instance);
+
 	if (ev_port->implicit_release && ev_port->outstanding_releases > 0) {
 		uint16_t out_rels = ev_port->outstanding_releases;
 		if (qm_port->reorder_en) {
@@ -4983,7 +5002,7 @@ dlb2_primary_eventdev_probe(struct rte_eventdev *dev,
 
 	rte_spinlock_init(&dlb2->qm_instance.resource_lock);
 
-	dlb2_iface_low_level_io_init();
+	dlb2_iface_low_level_io_init(NULL);
 
 	dlb2_entry_points_init(dev);
 
@@ -5015,7 +5034,7 @@ dlb2_secondary_eventdev_probe(struct rte_eventdev *dev,
 		return err;
 	}
 
-	dlb2_iface_low_level_io_init();
+	dlb2_iface_low_level_io_init(&dlb2->qm_instance);
 
 	dlb2_entry_points_init(dev);
 
diff --git a/drivers/event/dlb2/dlb2_iface.c b/drivers/event/dlb2/dlb2_iface.c
index 100db434d0..72d5b82bc5 100644
--- a/drivers/event/dlb2/dlb2_iface.c
+++ b/drivers/event/dlb2/dlb2_iface.c
@@ -12,7 +12,7 @@
  * If PCI (PF PMD),  these will be implemented locally in user mode.
  */
 
-void (*dlb2_iface_low_level_io_init)(void);
+void (*dlb2_iface_low_level_io_init)(struct dlb2_hw_dev *handle);
 
 int (*dlb2_iface_open)(struct dlb2_hw_dev *handle, const char *name);
 
diff --git a/drivers/event/dlb2/dlb2_iface.h b/drivers/event/dlb2/dlb2_iface.h
index dc0c446ce8..5106b860b9 100644
--- a/drivers/event/dlb2/dlb2_iface.h
+++ b/drivers/event/dlb2/dlb2_iface.h
@@ -11,7 +11,7 @@
  * If PCI (PF PMD),  these will be implemented locally in user mode.
  */
 
-extern void (*dlb2_iface_low_level_io_init)(void);
+extern void (*dlb2_iface_low_level_io_init)(struct dlb2_hw_dev *handle);
 
 extern int (*dlb2_iface_open)(struct dlb2_hw_dev *handle, const char *name);
 
diff --git a/drivers/event/dlb2/pf/base/dlb2_hw_types.h b/drivers/event/dlb2/pf/base/dlb2_hw_types.h
index be09363893..6a935f0bcd 100644
--- a/drivers/event/dlb2/pf/base/dlb2_hw_types.h
+++ b/drivers/event/dlb2/pf/base/dlb2_hw_types.h
@@ -139,6 +139,7 @@ struct dlb2_dir_pq_pair {
 	struct dlb2_list_entry func_list;
 	struct dlb2_resource_id id;
 	struct dlb2_resource_id domain_id;
+	struct process_local_port_data port_data;
 	u32 ref_cnt;
 	u8 init_tkn_cnt;
 	u8 queue_configured;
@@ -178,6 +179,7 @@ struct dlb2_ldb_port {
 	struct dlb2_resource_id domain_id;
 	/* The qid_map represents the hardware QID mapping state. */
 	struct dlb2_ldb_port_qid_map qid_map[DLB2_MAX_NUM_QIDS_PER_LDB_CQ];
+	struct process_local_port_data port_data;
 	u32 hist_list_entry_base;
 	u32 hist_list_entry_limit;
 	u32 ref_cnt;
diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index ed4e6e424c..ac432b81ad 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -45,20 +45,39 @@ static unsigned int dlb2_qe_sa_pct = 1;
 static unsigned int dlb2_qid_sa_pct;
 
 static void
-dlb2_pf_low_level_io_init(void)
+dlb2_pf_low_level_io_init(struct dlb2_hw_dev *handle)
 {
 	int i;
-	/* Addresses will be initialized at port create */
-	for (i = 0; i < DLB2_MAX_NUM_PORTS(DLB2_HW_V2_5); i++) {
-		/* First directed ports */
-		dlb2_port[i][DLB2_DIR_PORT].pp_addr = NULL;
-		dlb2_port[i][DLB2_DIR_PORT].cq_base = NULL;
-		dlb2_port[i][DLB2_DIR_PORT].mmaped = true;
-
-		/* Now load balanced ports */
-		dlb2_port[i][DLB2_LDB_PORT].pp_addr = NULL;
-		dlb2_port[i][DLB2_LDB_PORT].cq_base = NULL;
-		dlb2_port[i][DLB2_LDB_PORT].mmaped = true;
+
+	if (handle == NULL) {
+		/* Addresses will be initialized at port create in primary process*/
+		for (i = 0; i < DLB2_MAX_NUM_PORTS(DLB2_HW_V2_5); i++) {
+			/* First directed ports */
+			dlb2_port[i][DLB2_DIR_PORT].pp_addr = NULL;
+			dlb2_port[i][DLB2_DIR_PORT].cq_base = NULL;
+			dlb2_port[i][DLB2_DIR_PORT].mmaped = false;
+
+			/* Now load balanced ports */
+			dlb2_port[i][DLB2_LDB_PORT].pp_addr = NULL;
+			dlb2_port[i][DLB2_LDB_PORT].cq_base = NULL;
+			dlb2_port[i][DLB2_LDB_PORT].mmaped = false;
+		}
+	} else {
+		/* Retrieve stored addresses in secondary processes */
+		struct dlb2_dev *dlb2_dev = (struct dlb2_dev *)handle->pf_dev;
+		struct dlb2_ldb_port *ldb_ports = dlb2_dev->hw.rsrcs.ldb_ports;
+		struct dlb2_dir_pq_pair *dir_ports = dlb2_dev->hw.rsrcs.dir_pq_pairs;
+
+		for (i = 0; i < DLB2_MAX_NUM_LDB_PORTS; i++) {
+			dlb2_port[i][DLB2_LDB_PORT].cq_base = ldb_ports[i].port_data.cq_base;
+			dlb2_port[i][DLB2_LDB_PORT].pp_addr = ldb_ports[i].port_data.pp_addr;
+			dlb2_port[i][DLB2_LDB_PORT].mmaped = true;
+		}
+		for (i = 0; i < DLB2_MAX_NUM_DIR_PORTS_V2_5; i++) {
+			dlb2_port[i][DLB2_DIR_PORT].cq_base = dir_ports[i].port_data.cq_base;
+			dlb2_port[i][DLB2_DIR_PORT].pp_addr = dir_ports[i].port_data.pp_addr;
+			dlb2_port[i][DLB2_DIR_PORT].mmaped = true;
+		}
 	}
 }
 
@@ -304,6 +323,7 @@ dlb2_pf_ldb_port_create(struct dlb2_hw_dev *handle,
 			enum dlb2_cq_poll_modes poll_mode)
 {
 	struct dlb2_dev *dlb2_dev = (struct dlb2_dev *)handle->pf_dev;
+	struct process_local_port_data *port_data;
 	struct dlb2_cmd_response response = {0};
 	struct dlb2_port_memory port_memory;
 	int ret, cq_alloc_depth;
@@ -355,6 +375,7 @@ dlb2_pf_ldb_port_create(struct dlb2_hw_dev *handle,
 		(void *)(pp_base + (rte_mem_page_size() * response.id));
 
 	dlb2_port[response.id][DLB2_LDB_PORT].cq_base = (void *)(port_base);
+	dlb2_port[response.id][DLB2_LDB_PORT].mmaped = true;
 	memset(&port_memory, 0, sizeof(port_memory));
 
 	dlb2_port[response.id][DLB2_LDB_PORT].mz = mz;
@@ -363,6 +384,11 @@ dlb2_pf_ldb_port_create(struct dlb2_hw_dev *handle,
 
 	cfg->response = response;
 
+	/* Store cq_base and pp_addr for secondary processes*/
+	port_data = &dlb2_dev->hw.rsrcs.ldb_ports[response.id].port_data;
+	port_data->pp_addr = dlb2_port[response.id][DLB2_LDB_PORT].pp_addr;
+	port_data->cq_base = (struct dlb2_dequeue_qe *)cq_base;
+
 	return 0;
 
 create_port_err:
@@ -380,6 +406,7 @@ dlb2_pf_dir_port_create(struct dlb2_hw_dev *handle,
 			enum dlb2_cq_poll_modes poll_mode)
 {
 	struct dlb2_dev *dlb2_dev = (struct dlb2_dev *)handle->pf_dev;
+	struct process_local_port_data *port_data;
 	struct dlb2_cmd_response response = {0};
 	struct dlb2_port_memory port_memory;
 	int ret;
@@ -431,6 +458,7 @@ dlb2_pf_dir_port_create(struct dlb2_hw_dev *handle,
 
 	dlb2_port[response.id][DLB2_DIR_PORT].cq_base =
 		(void *)(port_base);
+	dlb2_port[response.id][DLB2_DIR_PORT].mmaped = true;
 	memset(&port_memory, 0, sizeof(port_memory));
 
 	dlb2_port[response.id][DLB2_DIR_PORT].mz = mz;
@@ -439,6 +467,11 @@ dlb2_pf_dir_port_create(struct dlb2_hw_dev *handle,
 
 	cfg->response = response;
 
+	/* Store cq_base and pp_addr for secondary processes*/
+	port_data = &dlb2_dev->hw.rsrcs.dir_pq_pairs[response.id].port_data;
+	port_data->pp_addr = dlb2_port[response.id][DLB2_DIR_PORT].pp_addr;
+	port_data->cq_base = (struct dlb2_dequeue_qe *)cq_base;
+
 	return 0;
 
 create_port_err:
-- 
2.43.5

