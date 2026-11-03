Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A0606B24D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qago8FBn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75A1C42EA7;
	Tue,  3 Nov 2026 16:14:27 +0100 (CET)
Received: from mta0.migadu.com (out-67.mta0.migadu.com [91.218.175.67])
 by mails.dpdk.org (Postfix) with ESMTPS id 64B4B42E88
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:14:26 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=sRYlvLUDNXv3uin7zP7+UFXXd5Oi+WyeSdAhu61BIaM=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718865; v=1; x=1794323665;
 b=qago8FBnM/YwuFL5Pl+m0N2zz1nq1Fv9UV0UHn7ZLuRBqjMtOw/ft9x0hhmwi/YViXdI5ONn
 xrjhmw/b6+EOvb6oL3h6lemFDkVStR1oXnoTQID5N1Bmg2juVHn6sNQRJZJKdUBhRXErRwHmefW
 mp7gmGOwemvhxlbUvRrG0shI=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 432bd7dd19567d87;
 Tue, 03 Nov 2026 15:14:25 +0000
X-Mizu-Trace-ID: 432bd7dd19567d87
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 136/227] net/ntnic: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:51:34 +0800
Message-ID: <20261103145306.487255-137-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, internal structure fields, variables
and comments to the NUMA node terminology, and switch calls to
the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  4 ++--
 .../link_mgmt/link_100g/nt4ga_link_100g.c     |  2 +-
 .../link_agx_100g/nt4ga_agx_link_100g.c       |  2 +-
 .../flow_api/profile_inline/flm_age_queue.c   |  2 +-
 .../flow_api/profile_inline/flm_evt_queue.c   |  2 +-
 .../flow_api/profile_inline/flm_lrn_queue.c   |  2 +-
 drivers/net/ntnic/ntnic_ethdev.c              | 24 +++++++++----------
 drivers/net/ntnic/ntutil/nt_util.c            |  4 ++--
 8 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index ef8ad29aa1..d009f0e6a0 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -180,7 +180,7 @@ static int dbs_numa_node(const nthw_dbs_t *p_nthw_dbs)
 /* Allocate a zeroed queue object and bind it to its DBS module */
 static struct nthw_virt_queue *dbs_alloc_virt_queue(nthw_dbs_t *p_nthw_dbs)
 {
-	struct nthw_virt_queue *vq = rte_zmalloc_socket("ntnic_vq",
+	struct nthw_virt_queue *vq = rte_zmalloc_numa("ntnic_vq",
 			sizeof(struct nthw_virt_queue), RTE_CACHE_LINE_SIZE,
 			dbs_numa_node(p_nthw_dbs));
 
@@ -202,7 +202,7 @@ static int dbs_copy_packet_buffers(struct nthw_virt_queue *vq,
 	if (n == 0)
 		return -1;	/* don't allocate memory with size of 0 bytes */
 
-	vq->p_virtual_addr = rte_zmalloc_socket("ntnic_vq_bufs", size, RTE_CACHE_LINE_SIZE,
+	vq->p_virtual_addr = rte_zmalloc_numa("ntnic_vq_bufs", size, RTE_CACHE_LINE_SIZE,
 			dbs_numa_node(vq->mp_nthw_dbs));
 
 	if (vq->p_virtual_addr == NULL)
diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index 0f36c30e5f..b9b3738454 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -721,7 +721,7 @@ static int nt4ga_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nth
 		struct rte_service_spec adapter_monitor_service = {
 			.name = "ntnic-adapter-monitor",
 			.callback = nt4ga_link_100g_mon,
-			.socket_id = SOCKET_ID_ANY,
+			.socket_id = RTE_NUMA_ID_ANY,
 			.capabilities = RTE_SERVICE_CAP_MT_SAFE,
 			.callback_userdata = p_adapter_info,
 		};
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index f0c07c80ad..c4e12b1c25 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -1023,7 +1023,7 @@ int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_f
 		struct rte_service_spec adapter_monitor_service = {
 						.name = "ntnic-adapter_agx-monitor",
 						.callback = nt4ga_agx_link_100g_mon,
-						.socket_id = SOCKET_ID_ANY,
+						.socket_id = RTE_NUMA_ID_ANY,
 						.capabilities = RTE_SERVICE_CAP_MT_SAFE,
 						.callback_userdata = p_adapter_info,
 		};
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c
index b9c93a293c..ac1f8b0005 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_age_queue.c
@@ -95,7 +95,7 @@ struct rte_ring *nthw_flm_age_queue_create(uint8_t port, uint16_t caller_id, uns
 	q = rte_ring_create_elem(name,
 			FLM_AGE_ELEM_SIZE,
 			count,
-			SOCKET_ID_ANY,
+			RTE_NUMA_ID_ANY,
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 
 	if (q == NULL) {
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
index e2f3b31ad0..869680173e 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_evt_queue.c
@@ -179,7 +179,7 @@ static struct rte_ring *flm_evt_queue_create(uint8_t port, uint8_t caller)
 	q = rte_ring_create_elem(name,
 			elem_size,
 			queue_size,
-			SOCKET_ID_ANY,
+			RTE_NUMA_ID_ANY,
 			RING_F_SP_ENQ | RING_F_SC_DEQ);
 
 	if (q == NULL) {
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
index cb4504a6e0..98c7825fb1 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flm_lrn_queue.c
@@ -21,7 +21,7 @@ void *nthw_flm_lrn_queue_create(void)
 	struct rte_ring *q = rte_ring_create_elem("RFQ",
 		ELEM_SIZE,
 		QUEUE_SIZE,
-		SOCKET_ID_ANY,
+		RTE_NUMA_ID_ANY,
 		RING_F_MP_HTS_ENQ | RING_F_SC_DEQ);
 	RTE_ASSERT(q != NULL);
 	return q;
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index e0d84705f5..02c3be52e8 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -789,7 +789,7 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 	uint64_t tot_alloc_size = 0x100000 + (uint64_t)buf_size * (uint64_t)num_descr;
 
 	void *virt =
-		rte_malloc_socket("VirtQDescr", tot_alloc_size,
+		rte_malloc_numa("VirtQDescr", tot_alloc_size,
 			nthw_util_align_size(tot_alloc_size),
 			eth_dev->data->numa_node);
 
@@ -820,7 +820,7 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 
 		/* Just allocate 1MB to hold all combined descr rings */
 		size = 0x100000;
-		void *virt = rte_malloc_socket("VirtQDescr", size, 4096, eth_dev->data->numa_node);
+		void *virt = rte_malloc_numa("VirtQDescr", size, 4096, eth_dev->data->numa_node);
 
 		if (!virt)
 			return -1;
@@ -843,7 +843,7 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 
 		size = num_descr * sizeof(struct nthw_memory_descriptor);
 		hwq->pkt_buffers =
-			rte_zmalloc_socket("rx_pkt_buffers", size, 64, eth_dev->data->numa_node);
+			rte_zmalloc_numa("rx_pkt_buffers", size, 64, eth_dev->data->numa_node);
 
 		if (!hwq->pkt_buffers) {
 			NT_LOG(ERR, NTNIC,
@@ -856,7 +856,7 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 
 		size = buf_size * num_descr;
 		void *virt_addr =
-			rte_malloc_socket("pkt_buffer_pkts", size, 4096, eth_dev->data->numa_node);
+			rte_malloc_numa("pkt_buffer_pkts", size, 4096, eth_dev->data->numa_node);
 
 		if (!virt_addr) {
 			NT_LOG(ERR, NTNIC,
@@ -916,7 +916,7 @@ static int allocate_hw_virtio_queues(struct rte_eth_dev *eth_dev, int vf_num, st
 
 	size = num_descr * sizeof(struct nthw_memory_descriptor);
 	hwq->pkt_buffers =
-		rte_zmalloc_socket("rx_pkt_buffers", size, 64, eth_dev->data->numa_node);
+		rte_zmalloc_numa("rx_pkt_buffers", size, 64, eth_dev->data->numa_node);
 
 	if (!hwq->pkt_buffers) {
 		NT_LOG(ERR, NTNIC,
@@ -1028,7 +1028,7 @@ static int allocate_queue(int num)
 static int eth_rx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 	uint16_t rx_queue_id,
 	uint16_t nb_rx_desc __rte_unused,
-	unsigned int socket_id __rte_unused,
+	unsigned int numa_id __rte_unused,
 	const struct rte_eth_rxconf *rx_conf,
 	struct rte_mempool *mb_pool)
 {
@@ -1107,7 +1107,7 @@ static int eth_rx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 static int eth_tx_scg_queue_setup(struct rte_eth_dev *eth_dev,
 	uint16_t tx_queue_id,
 	uint16_t nb_tx_desc __rte_unused,
-	unsigned int socket_id __rte_unused,
+	unsigned int numa_id __rte_unused,
 	const struct rte_eth_txconf *tx_conf)
 {
 	const struct port_ops *port_ops = nthw_get_port_ops();
@@ -2323,7 +2323,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 
 
 	/* alloc */
-	p_drv = rte_zmalloc_socket(pci_dev->name, sizeof(struct drv_s), RTE_CACHE_LINE_SIZE,
+	p_drv = rte_zmalloc_numa(pci_dev->name, sizeof(struct drv_s), RTE_CACHE_LINE_SIZE,
 			pci_dev->device.numa_node);
 
 	if (!p_drv) {
@@ -2443,7 +2443,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		struct rte_service_spec flm_update_spec = {
 			.name = "ntnic-flm_update_service",
 			.callback = adapter_flm_update_service,
-			.socket_id = SOCKET_ID_ANY,
+			.socket_id = RTE_NUMA_ID_ANY,
 			.capabilities = RTE_SERVICE_CAP_MT_SAFE,
 			.callback_userdata = p_drv
 		};
@@ -2460,7 +2460,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 	struct rte_service_spec stat_spec = {
 		.name = "ntnic-stat_collect_service",
 		.callback = adapter_stat_service,
-		.socket_id = SOCKET_ID_ANY,
+		.socket_id = RTE_NUMA_ID_ANY,
 		.capabilities = RTE_SERVICE_CAP_MT_SAFE,
 		.callback_userdata = p_drv
 	};
@@ -2494,7 +2494,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		NT_LOG_DBGX(DBG, NTNIC, "%s: interface #%d: %s: '%s'", p_port_id_str,
 			n_intf_no, (pci_dev->name[0] ? pci_dev->name : "NA"), name);
 
-		internals = rte_zmalloc_socket(name, sizeof(struct pmd_internals),
+		internals = rte_zmalloc_numa(name, sizeof(struct pmd_internals),
 				RTE_CACHE_LINE_SIZE, pci_dev->device.numa_node);
 
 		if (!internals) {
@@ -2634,7 +2634,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		if (fpga_info->profile == FPGA_INFO_PROFILE_INLINE) {
 			struct rte_service_spec port_event_spec = {
 				.callback = port_event_service,
-				.socket_id = SOCKET_ID_ANY,
+				.socket_id = RTE_NUMA_ID_ANY,
 				.capabilities = RTE_SERVICE_CAP_MT_SAFE,
 				.callback_userdata = internals
 			};
diff --git a/drivers/net/ntnic/ntutil/nt_util.c b/drivers/net/ntnic/ntutil/nt_util.c
index 8014b218b5..450c35c00c 100644
--- a/drivers/net/ntnic/ntutil/nt_util.c
+++ b/drivers/net/ntnic/ntutil/nt_util.c
@@ -56,11 +56,11 @@ struct nt_dma_s *nthw_dma_alloc(uint64_t size, uint64_t align, int numa)
 		return NULL;
 	}
 
-	void *addr = rte_malloc_socket(NULL, size, align, numa);
+	void *addr = rte_malloc_numa(NULL, size, align, numa);
 
 	if (!addr) {
 		rte_free(vfio_addr);
-		NT_LOG(ERR, GENERAL, "VFIO rte_malloc_socket failed");
+		NT_LOG(ERR, GENERAL, "VFIO rte_malloc_numa failed");
 		return NULL;
 	}
 
-- 
2.55.0

