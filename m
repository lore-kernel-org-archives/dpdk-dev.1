Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6441606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ErpjrW2I
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF2234332E;
	Tue,  3 Nov 2026 16:28:28 +0100 (CET)
Received: from mta0.migadu.com (out-193.mta0.migadu.com [91.218.175.193])
 by mails.dpdk.org (Postfix) with ESMTPS id 5AAAD4332A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:28:27 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=Ykbffa9I6j3tSgv3x4iM18TBqS/z4/hpoIfEb4ClYjY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719706; v=1; x=1794324506;
 b=ErpjrW2IcR6J5iqXmJ/eb9EgcKQKzlJ5jh+d+XiOE1GoxuHxYTSg39cvoUa4TCWcz1zFHVQ6
 SKO6L6qeO4N6BBOWdgjGqE0f82xcdXo2niw0o4UUM5CroHE+GrrlmQhAfXssOWOLW7adYnuwD8r
 3kgm3h5xibBGWaKXQ/Ad/y0A=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id ed6b3a60c79c264e;
 Tue, 03 Nov 2026 15:28:26 +0000
X-Mizu-Trace-ID: ed6b3a60c79c264e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 223/227] eal: deprecate legacy socket API aliases
Date: Tue,  3 Nov 2026 22:53:01 +0800
Message-ID: <20261103145306.487255-224-chengwen.feng@linux.dev>
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

Complete the socket to NUMA node terminology migration:

- Rename the numa_id fields of rte_memseg, rte_memseg_list,
  rte_memzone and rte_service_spec (were socket_id), keeping
  socket_id as a deprecated union alias, and switch the
  remaining in-tree users accordingly.
- Mark the legacy socket-named functions as deprecated:
  rte_socket_id(), rte_socket_count(), rte_socket_id_by_idx(),
  rte_lcore_to_socket_id(), the rte_malloc_socket() family,
  rte_malloc_heap_get_socket(), rte_malloc_get_socket_stats(),
  rte_malloc_heap_socket_is_external(), rte_eth_dev_socket_id(),
  rte_cryptodev_socket_id(), rte_compressdev_socket_id(),
  rte_event_dev_socket_id() and rte_rawdev_socket_id().
- Mark the SOCKET_ID_ANY macro as deprecated; use
  RTE_NUMA_ID_ANY instead.

Update the deprecation notices and the 26.11 release notes
accordingly.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/proc-info/main.c                          |  4 +--
 app/test/test_malloc.c                        |  4 +--
 app/test/test_memzone.c                       |  8 +++---
 doc/guides/rel_notes/deprecation.rst          | 27 +++++++++++++++----
 doc/guides/rel_notes/release_26_11.rst        |  9 +++++++
 drivers/common/qat/qat_qp.c                   |  4 +--
 drivers/common/zsda/zsda_qp.c                 |  2 +-
 drivers/crypto/bcmfs/bcmfs_qp.c               |  4 +--
 drivers/crypto/ccp/ccp_dev.c                  |  4 +--
 drivers/event/sw/sw_evdev.c                   |  2 +-
 drivers/net/failsafe/failsafe_intr.c          |  2 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     |  2 +-
 .../link_agx_100g/nt4ga_agx_link_100g.c       |  2 +-
 drivers/net/ntnic/ntnic_ethdev.c              |  6 ++---
 drivers/net/ring/rte_eth_ring.c               |  2 +-
 drivers/net/sfc/sfc_mae_counter.c             |  2 +-
 drivers/net/sfc/sfc_repr_proxy.c              |  2 +-
 drivers/net/softnic/rte_eth_softnic_thread.c  |  2 +-
 lib/compressdev/rte_compressdev.h             |  1 +
 lib/cryptodev/rte_cryptodev.h                 |  1 +
 lib/dispatcher/rte_dispatcher.c               |  2 +-
 lib/eal/common/eal_common_dynmem.c            |  2 +-
 lib/eal/common/eal_common_memory.c            | 10 +++----
 lib/eal/common/eal_common_memzone.c           |  4 +--
 lib/eal/common/malloc_heap.c                  | 12 ++++-----
 lib/eal/freebsd/eal.c                         |  2 +-
 lib/eal/include/rte_lcore.h                   |  5 ++++
 lib/eal/include/rte_malloc.h                  |  7 +++++
 lib/eal/include/rte_memory.h                  | 24 ++++++++++++++---
 lib/eal/include/rte_memzone.h                 | 10 ++++++-
 lib/eal/include/rte_service_component.h       | 12 +++++++--
 lib/eal/linux/eal.c                           |  2 +-
 lib/eal/linux/eal_memalloc.c                  |  6 ++---
 lib/eal/linux/eal_memory.c                    |  6 ++---
 lib/eal/windows/eal_memalloc.c                |  8 +++---
 lib/ethdev/ethdev_driver.c                    |  2 +-
 lib/ethdev/rte_ethdev.h                       |  1 +
 lib/eventdev/rte_event_crypto_adapter.c       |  2 +-
 lib/eventdev/rte_event_dma_adapter.c          |  2 +-
 lib/eventdev/rte_event_eth_rx_adapter.c       |  2 +-
 lib/eventdev/rte_event_eth_tx_adapter.c       |  2 +-
 lib/eventdev/rte_event_timer_adapter.c        |  2 +-
 lib/eventdev/rte_event_vector_adapter.c       |  2 +-
 lib/eventdev/rte_eventdev.h                   |  1 +
 lib/mempool/rte_mempool.c                     |  4 +--
 lib/rawdev/rte_rawdev.h                       |  1 +
 lib/ring/rte_ring.c                           |  4 +--
 lib/table/rte_swx_table_wm.c                  |  2 +-
 48 files changed, 152 insertions(+), 77 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index 8e8cc923ce..1fd06e866c 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -1587,7 +1587,7 @@ show_ring(char *name)
 				"\t  -- Single Producer Enqueue (%u)\n"
 				"\t  -- Single Consumer Dequeue (%u)\n",
 				ptr->name,
-				ptr->memzone->socket_id,
+				ptr->memzone->numa_id,
 				ptr->flags & RING_F_SP_ENQ,
 				ptr->flags & RING_F_SC_DEQ);
 			printf("  - size (%u) mask (0x%x) capacity (%u)\n",
@@ -1649,7 +1649,7 @@ show_mempool(char *name)
 				ptr->trailer_size,
 				ptr->private_data_size);
 			printf("  - memezone - socket %d\n",
-				ptr->mz->socket_id);
+				ptr->mz->numa_id);
 			printf("  - Count: avail (%u), in use (%u)\n",
 				rte_mempool_avail_count(ptr),
 				rte_mempool_in_use_count(ptr));
diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index ae6f8a979e..34ef99d787 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -962,7 +962,7 @@ check_socket_mem(const struct rte_memseg_list *msl, void *arg)
 	if (msl->external)
 		return 0;
 
-	return *numa_id == msl->socket_id;
+	return *numa_id == msl->numa_id;
 }
 
 /* Check if memory is available on a specific numa_id */
@@ -981,7 +981,7 @@ static int32_t
 addr_to_socket(void * addr)
 {
 	const struct rte_memseg *ms = rte_mem_virt2memseg(addr, NULL);
-	return ms == NULL ? -1 : ms->socket_id;
+	return ms == NULL ? -1 : ms->numa_id;
 
 }
 
diff --git a/app/test/test_memzone.c b/app/test/test_memzone.c
index b3e76b6e4f..1ebbf6286b 100644
--- a/app/test/test_memzone.c
+++ b/app/test/test_memzone.c
@@ -576,7 +576,7 @@ test_memzone_reserve_max_aligned(void)
 		const unsigned int align = 1 << ((rte_rand() % 8) + 5); /* from 128 up to 4k alignment */
 
 		/* memzone size may be between size and size - align */
-		minlen = find_max_block_free_size(align, numa_id);
+		minlen = find_max_block_free_size(align, socket);
 		maxlen = find_max_block_free_size(0, numa_id);
 
 		if (minlen == 0 || maxlen == 0) {
@@ -587,7 +587,7 @@ test_memzone_reserve_max_aligned(void)
 
 		mz = rte_memzone_reserve_aligned(
 				TEST_MEMZONE_NAME("max_zone_aligned"),
-				0, numa_id, 0, align);
+				0, socket, 0, align);
 		if (mz == NULL) {
 			printf("Failed to reserve a big chunk of memory - %s\n",
 					rte_strerror(rte_errno));
@@ -1053,9 +1053,9 @@ test_memzone_basic(void)
 					memzone3->iova, memzone3->len))
 		return -1;
 
-	printf("check numa_id ID\n");
+	printf("check socket ID\n");
 
-	/* memzone2 must be on numa_id id 0 and memzone3 on numa_id 1 */
+	/* memzone2 must be on socket id 0 and memzone3 on socket 1 */
 	if (memzone2->numa_id != 0)
 		return -1;
 	if (memzone3 != NULL && memzone3->numa_id != 1)
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 297ce8415c..c8226db555 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -16,16 +16,33 @@ Other API and ABI deprecation notices are to be posted below.
 Deprecation Notices
 -------------------
 
-* lib: The public structures use ``socket_id`` to refer to a NUMA node,
+* lib/eal: The public structures use ``socket_id`` to refer to a NUMA node,
   which conflates CPU sockets with NUMA memory nodes.
   The field is renamed to ``numa_id``, keeping ``socket_id``
   as a deprecated union alias.
-  The following structures are affected: ``rte_hash_parameters``,
-  ``rte_fbk_hash_params``, ``rte_member_parameters`` /
-  ``rte_member_setsum``, ``rte_mempool`` and ``rte_compressdev_config``
-  (more structures will follow in this release).
+  Affected structures include: ``rte_acl_param``, ``rte_bbdev_data``,
+  ``rte_bbdev_info``, ``rte_bbdev_queue_conf``, ``rte_compressdev_config``,
+  ``rte_cryptodev_config``, ``rte_event_timer_adapter_conf``,
+  ``rte_event_vector_adapter_conf``, ``rte_fbk_hash_params``,
+  ``rte_graph``, ``rte_graph_cluster_stats_param``, ``rte_graph_param``,
+  ``rte_gro_param``, ``rte_hash_parameters``, ``rte_ipsec_sad_conf``,
+  ``rte_member_parameters``, ``rte_member_setsum``, ``rte_memseg``,
+  ``rte_memseg_list``, ``rte_memzone``, ``rte_ml_dev_config``,
+  ``rte_mempool``, ``rte_rawdev``, ``rte_rawdev_info`` and
+  ``rte_service_spec``.
   Applications should switch to ``numa_id``.
 
+* eal/lib: The legacy socket-named functions
+  ``rte_socket_id()``, ``rte_socket_count()``, ``rte_socket_id_by_idx()``,
+  ``rte_lcore_to_socket_id()``, the ``rte_malloc_socket()`` family,
+  ``rte_malloc_heap_get_socket()``, ``rte_malloc_get_socket_stats()``,
+  ``rte_malloc_heap_socket_is_external()``, ``rte_eth_dev_socket_id()``,
+  ``rte_cryptodev_socket_id()``, ``rte_compressdev_socket_id()``,
+  ``rte_event_dev_socket_id()`` and ``rte_rawdev_socket_id()``
+  are deprecated aliases of their NUMA-named replacements,
+  and will be removed in a future release.
+  The ``SOCKET_ID_ANY`` macro is deprecated; use ``RTE_NUMA_ID_ANY``.
+
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 0298d7bb36..eed7b643c4 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -475,6 +475,15 @@ Removed Items
 API Changes
 -----------
 
+* eal/lib: The socket-based naming has been fully migrated to NUMA node
+  terminology. The legacy socket-named functions (``rte_socket_id()``,
+  ``rte_malloc_socket()`` family, ``rte_eth_dev_socket_id()`` and friends)
+  and the ``SOCKET_ID_ANY`` macro are deprecated aliases of the
+  NUMA-named APIs and will be removed in a future release.
+  The ``socket_id`` fields of public structures are deprecated union
+  aliases of ``numa_id``.
+
+
 .. This section should contain API changes. Sample format:
 
    * sample: Add a short 1-2 sentence description of the API change
diff --git a/drivers/common/qat/qat_qp.c b/drivers/common/qat/qat_qp.c
index 0d4d2dda52..d6029f392d 100644
--- a/drivers/common/qat/qat_qp.c
+++ b/drivers/common/qat/qat_qp.c
@@ -317,7 +317,7 @@ queue_dma_zone_reserve(const char *queue_name, uint32_t queue_size,
 	if (mz != 0) {
 		if (((size_t)queue_size <= mz->len) &&
 				((numa_id == RTE_NUMA_ID_ANY) ||
-					(numa_id == mz->socket_id))) {
+					(numa_id == mz->numa_id))) {
 			QAT_LOG(DEBUG, "re-use memzone already "
 					"allocated for %s", queue_name);
 			return mz;
@@ -327,7 +327,7 @@ queue_dma_zone_reserve(const char *queue_name, uint32_t queue_size,
 				"allocated %s, size %u, socket %d. "
 				"Requested size %u, socket %u",
 				queue_name, (uint32_t)mz->len,
-				mz->socket_id, queue_size, numa_id);
+				mz->numa_id, queue_size, numa_id);
 		return NULL;
 	}
 
diff --git a/drivers/common/zsda/zsda_qp.c b/drivers/common/zsda/zsda_qp.c
index 257898bed5..b2c89c3ca8 100644
--- a/drivers/common/zsda/zsda_qp.c
+++ b/drivers/common/zsda/zsda_qp.c
@@ -551,7 +551,7 @@ zsda_queue_dma_zone_reserve(const char *queue_name,
 	if (mz != 0) {
 		if (((size_t)queue_size <= mz->len) &&
 		    ((numa_id == (RTE_NUMA_ID_ANY & 0xffff)) ||
-		     (numa_id == (mz->socket_id & 0xffff)))) {
+		     (numa_id == (mz->numa_id & 0xffff)))) {
 			ZSDA_LOG(DEBUG,
 				 "re-use memzone already allocated for %s",
 				 queue_name);
diff --git a/drivers/crypto/bcmfs/bcmfs_qp.c b/drivers/crypto/bcmfs/bcmfs_qp.c
index feaaa81015..003dc201b6 100644
--- a/drivers/crypto/bcmfs/bcmfs_qp.c
+++ b/drivers/crypto/bcmfs/bcmfs_qp.c
@@ -71,7 +71,7 @@ queue_dma_zone_reserve(const char *queue_name, uint32_t queue_size,
 	if (mz != NULL) {
 		if (((size_t)queue_size <= mz->len) &&
 		    (numa_id == RTE_NUMA_ID_ANY ||
-		     numa_id == mz->socket_id)) {
+		     numa_id == mz->numa_id)) {
 			BCMFS_LOG(DEBUG, "re-use memzone already "
 					"allocated for %s", queue_name);
 			return mz;
@@ -81,7 +81,7 @@ queue_dma_zone_reserve(const char *queue_name, uint32_t queue_size,
 				"allocated %s, size %u, socket %d. "
 				"Requested size %u, socket %u",
 				queue_name, (uint32_t)mz->len,
-				mz->socket_id, queue_size, numa_id);
+				mz->numa_id, queue_size, numa_id);
 		return NULL;
 	}
 
diff --git a/drivers/crypto/ccp/ccp_dev.c b/drivers/crypto/ccp/ccp_dev.c
index defbb1e5a8..bb7c662808 100644
--- a/drivers/crypto/ccp/ccp_dev.c
+++ b/drivers/crypto/ccp/ccp_dev.c
@@ -93,7 +93,7 @@ ccp_queue_dma_zone_reserve(const char *queue_name,
 	if (mz != 0) {
 		if (((size_t)queue_size <= mz->len) &&
 		    ((numa_id == RTE_NUMA_ID_ANY) ||
-		     (numa_id == mz->socket_id))) {
+		     (numa_id == mz->numa_id))) {
 			CCP_LOG_INFO("re-use memzone already "
 				     "allocated for %s", queue_name);
 			return mz;
@@ -102,7 +102,7 @@ ccp_queue_dma_zone_reserve(const char *queue_name,
 			    "allocated %s, size %u, socket %d. "
 			    "Requested size %u, socket %u",
 			    queue_name, (uint32_t)mz->len,
-			    mz->socket_id, queue_size, numa_id);
+			    mz->numa_id, queue_size, numa_id);
 		return NULL;
 	}
 
diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index b2dc61142a..bccb0661b6 100644
--- a/drivers/event/sw/sw_evdev.c
+++ b/drivers/event/sw/sw_evdev.c
@@ -1116,7 +1116,7 @@ sw_probe(struct rte_vdev_device *vdev)
 	snprintf(service.name, sizeof(service.name), "%s_service", name);
 	snprintf(sw->service_name, sizeof(sw->service_name), "%s_service",
 			name);
-	service.socket_id = numa_id;
+	service.numa_id = numa_id;
 	service.callback = sw_sched_service_func;
 	service.callback_userdata = (void *)dev;
 
diff --git a/drivers/net/failsafe/failsafe_intr.c b/drivers/net/failsafe/failsafe_intr.c
index 68b7310b85..dd05b6d99b 100644
--- a/drivers/net/failsafe/failsafe_intr.c
+++ b/drivers/net/failsafe/failsafe_intr.c
@@ -134,7 +134,7 @@ fs_rx_event_proxy_service_install(struct fs_priv *priv)
 	memset(&service, 0, sizeof(struct rte_service_spec));
 	snprintf(service.name, sizeof(service.name), "%s_Rx_service",
 		 priv->data->name);
-	service.socket_id = priv->data->numa_node;
+	service.numa_id = priv->data->numa_node;
 	service.callback = fs_rx_event_proxy_routine;
 	service.callback_userdata = priv;
 
diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index b9b3738454..674775641d 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -721,7 +721,7 @@ static int nt4ga_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nth
 		struct rte_service_spec adapter_monitor_service = {
 			.name = "ntnic-adapter-monitor",
 			.callback = nt4ga_link_100g_mon,
-			.socket_id = RTE_NUMA_ID_ANY,
+			.numa_id = RTE_NUMA_ID_ANY,
 			.capabilities = RTE_SERVICE_CAP_MT_SAFE,
 			.callback_userdata = p_adapter_info,
 		};
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index c4e12b1c25..9eb8dba62c 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -1023,7 +1023,7 @@ int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_f
 		struct rte_service_spec adapter_monitor_service = {
 						.name = "ntnic-adapter_agx-monitor",
 						.callback = nt4ga_agx_link_100g_mon,
-						.socket_id = RTE_NUMA_ID_ANY,
+						.numa_id = RTE_NUMA_ID_ANY,
 						.capabilities = RTE_SERVICE_CAP_MT_SAFE,
 						.callback_userdata = p_adapter_info,
 		};
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 02c3be52e8..4b3c7b9c61 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2443,7 +2443,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		struct rte_service_spec flm_update_spec = {
 			.name = "ntnic-flm_update_service",
 			.callback = adapter_flm_update_service,
-			.socket_id = RTE_NUMA_ID_ANY,
+			.numa_id = RTE_NUMA_ID_ANY,
 			.capabilities = RTE_SERVICE_CAP_MT_SAFE,
 			.callback_userdata = p_drv
 		};
@@ -2460,7 +2460,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 	struct rte_service_spec stat_spec = {
 		.name = "ntnic-stat_collect_service",
 		.callback = adapter_stat_service,
-		.socket_id = RTE_NUMA_ID_ANY,
+		.numa_id = RTE_NUMA_ID_ANY,
 		.capabilities = RTE_SERVICE_CAP_MT_SAFE,
 		.callback_userdata = p_drv
 	};
@@ -2634,7 +2634,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		if (fpga_info->profile == FPGA_INFO_PROFILE_INLINE) {
 			struct rte_service_spec port_event_spec = {
 				.callback = port_event_service,
-				.socket_id = RTE_NUMA_ID_ANY,
+				.numa_id = RTE_NUMA_ID_ANY,
 				.capabilities = RTE_SERVICE_CAP_MT_SAFE,
 				.callback_userdata = internals
 			};
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index 9af86f4226..6da09ca3d7 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -520,7 +520,7 @@ int
 rte_eth_from_ring(struct rte_ring *r)
 {
 	return rte_eth_from_rings(r->name, &r, 1, &r, 1,
-			r->memzone ? r->memzone->socket_id : RTE_NUMA_ID_ANY);
+			r->memzone ? r->memzone->numa_id : RTE_NUMA_ID_ANY);
 }
 
 static int
diff --git a/drivers/net/sfc/sfc_mae_counter.c b/drivers/net/sfc/sfc_mae_counter.c
index fc500527bc..bb2291861c 100644
--- a/drivers/net/sfc/sfc_mae_counter.c
+++ b/drivers/net/sfc/sfc_mae_counter.c
@@ -589,7 +589,7 @@ sfc_mae_counter_service_register(struct sfc_adapter *sa,
 	/* Prepare service info */
 	memset(&service, 0, sizeof(service));
 	rte_strscpy(service.name, counter_service_name, sizeof(service.name));
-	service.socket_id = sa->numa_id;
+	service.numa_id = sa->numa_id;
 	service.callback = sfc_mae_counter_service_routine;
 	service.callback_userdata = sa;
 	sfc_mae_counter_registry_prepare(counter_registry, sa,
diff --git a/drivers/net/sfc/sfc_repr_proxy.c b/drivers/net/sfc/sfc_repr_proxy.c
index 3e9615911a..f1bac21e1f 100644
--- a/drivers/net/sfc/sfc_repr_proxy.c
+++ b/drivers/net/sfc/sfc_repr_proxy.c
@@ -916,7 +916,7 @@ sfc_repr_proxy_attach(struct sfc_adapter *sa)
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, sizeof(service.name),
 		 "net_sfc_%hu_repr_proxy", sfc_sa2shared(sa)->port_id);
-	service.socket_id = rte_lcore_to_numa_id(cid);
+	service.numa_id = rte_lcore_to_numa_id(cid);
 	service.callback = sfc_repr_proxy_routine;
 	service.callback_userdata = rp;
 
diff --git a/drivers/net/softnic/rte_eth_softnic_thread.c b/drivers/net/softnic/rte_eth_softnic_thread.c
index f45b63f481..e6b3ee69d8 100644
--- a/drivers/net/softnic/rte_eth_softnic_thread.c
+++ b/drivers/net/softnic/rte_eth_softnic_thread.c
@@ -137,7 +137,7 @@ thread_sc_service_up(struct pmd_internals *softnic, uint32_t thread_id)
 	service_params.callback = rte_pmd_softnic_run_internal;
 	service_params.callback_userdata = dev;
 	service_params.capabilities = 0;
-	service_params.socket_id = (int)softnic->params.cpu_id;
+	service_params.numa_id = (int)softnic->params.cpu_id;
 
 	/* service register */
 	status = rte_service_component_register(&service_params, &t->service_id);
diff --git a/lib/compressdev/rte_compressdev.h b/lib/compressdev/rte_compressdev.h
index e96d2b328a..9cec4e3245 100644
--- a/lib/compressdev/rte_compressdev.h
+++ b/lib/compressdev/rte_compressdev.h
@@ -194,6 +194,7 @@ rte_compressdev_numa_id(uint8_t dev_id);
  *   -1 if returned is the dev_id value is out of range.
  */
 int
+__rte_deprecated_msg("use the NUMA node API")
 rte_compressdev_socket_id(uint8_t dev_id);
 
 /** Compress device configuration structure */
diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.h
index a1afb7e927..514036661d 100644
--- a/lib/cryptodev/rte_cryptodev.h
+++ b/lib/cryptodev/rte_cryptodev.h
@@ -858,6 +858,7 @@ rte_cryptodev_numa_id(uint8_t dev_id);
  *   -1 if returned is the dev_id value is out of range.
  */
 int
+__rte_deprecated_msg("use the NUMA node API")
 rte_cryptodev_socket_id(uint8_t dev_id);
 
 /** Crypto device configuration structure */
diff --git a/lib/dispatcher/rte_dispatcher.c b/lib/dispatcher/rte_dispatcher.c
index 3f33a03de1..f90add0881 100644
--- a/lib/dispatcher/rte_dispatcher.c
+++ b/lib/dispatcher/rte_dispatcher.c
@@ -239,7 +239,7 @@ evd_service_register(struct rte_dispatcher *dispatcher)
 		.callback = evd_process,
 		.callback_userdata = dispatcher,
 		.capabilities = RTE_SERVICE_CAP_MT_SAFE,
-		.socket_id = dispatcher->numa_id
+		.numa_id = dispatcher->numa_id
 	};
 	int rc;
 
diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 56fa190280..912e9893f1 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -191,7 +191,7 @@ hugepage_count_walk(const struct rte_memseg_list *msl, void *arg)
 	if (msl->page_sz != hpi->hugepage_sz)
 		return 0;
 
-	hpi->num_pages[msl->socket_id] += msl->memseg_arr.len;
+	hpi->num_pages[msl->numa_id] += msl->memseg_arr.len;
 	return 0;
 }
 
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index cd22c254a1..b0dda5df43 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -214,7 +214,7 @@ eal_memseg_list_init_named(struct rte_memseg_list *msl, const char *name,
 	}
 
 	msl->page_sz = page_sz;
-	msl->socket_id = numa_id;
+	msl->numa_id = numa_id;
 	msl->base_va = NULL;
 	msl->heap = heap;
 
@@ -307,7 +307,7 @@ eal_memseg_list_populate(struct rte_memseg_list *msl, void *addr, int n_segs)
 			ms->iova = RTE_BAD_IOVA;
 		ms->addr = addr;
 		ms->hugepage_sz = page_sz;
-		ms->socket_id = 0;
+		ms->numa_id = 0;
 		ms->len = page_sz;
 
 		rte_fbarray_set_used(arr, i);
@@ -484,7 +484,7 @@ dump_memseg(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 			ms->iova,
 			ms->len,
 			ms->addr,
-			ms->socket_id,
+			ms->numa_id,
 			ms->hugepage_sz,
 			ms->nchannel,
 			ms->nrank,
@@ -1275,7 +1275,7 @@ handle_eal_memzone_info_request(const char *cmd __rte_unused,
 	rte_tel_data_add_dict_uint(d, "Length", mz->len);
 	snprintf(addr, ADDR_STR, "%p", mz->addr);
 	rte_tel_data_add_dict_string(d, "Address", addr);
-	rte_tel_data_add_dict_int(d, "Socket", mz->socket_id);
+	rte_tel_data_add_dict_int(d, "Socket", mz->numa_id);
 	rte_tel_data_add_dict_uint(d, "Flags", mz->flags);
 
 	/* go through each page occupied by this memzone */
@@ -1481,7 +1481,7 @@ handle_eal_memseg_info_request(const char *cmd __rte_unused,
 	ms_end_addr = ms_start_addr + ms->len;
 	ms_size = ms->len;
 	hugepage_size = ms->hugepage_sz;
-	ms_socket_id = ms->socket_id;
+	ms_socket_id = ms->numa_id;
 	ms_flags = ms->flags;
 
 	rte_mcfg_mem_read_unlock();
diff --git a/lib/eal/common/eal_common_memzone.c b/lib/eal/common/eal_common_memzone.c
index d325193b9d..a1132433b3 100644
--- a/lib/eal/common/eal_common_memzone.c
+++ b/lib/eal/common/eal_common_memzone.c
@@ -232,7 +232,7 @@ memzone_reserve_aligned_thread_unsafe(const char *name, size_t len,
 			elem->size - elem->pad - MALLOC_ELEM_OVERHEAD :
 			requested_len;
 	mz->hugepage_sz = elem->msl->page_sz;
-	mz->socket_id = elem->msl->socket_id;
+	mz->numa_id = elem->msl->numa_id;
 	mz->flags = 0;
 
 	return mz;
@@ -393,7 +393,7 @@ dump_memzone(const struct rte_memzone *mz, void *arg)
 			mz->name,
 			mz->len,
 			mz->addr,
-			mz->socket_id,
+			mz->numa_id,
 			mz->flags);
 
 	/* go through each page occupied by this memzone */
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index eb92ebc9b7..7863c1af9b 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -115,7 +115,7 @@ malloc_add_seg(const struct rte_memseg_list *msl,
 	if (msl->external)
 		return 0;
 
-	heap_idx = malloc_numa_to_heap_id(msl->socket_id);
+	heap_idx = malloc_numa_to_heap_id(msl->numa_id);
 	if (heap_idx < 0) {
 		EAL_LOG(ERR, "Memseg list has invalid NUMA node ID");
 		return -1;
@@ -136,7 +136,7 @@ malloc_add_seg(const struct rte_memseg_list *msl,
 	heap->total_size += len;
 
 	EAL_LOG(DEBUG, "Added %zuM to heap on NUMA node %i", len >> 20,
-			msl->socket_id);
+			msl->numa_id);
 	return 0;
 }
 
@@ -559,7 +559,7 @@ alloc_more_mem_on_socket(struct malloc_heap *heap, size_t size, int numa_id,
 	for (i = 0; i < RTE_MAX_MEMSEG_LISTS; i++) {
 		struct rte_memseg_list *msl = &mcfg->memsegs[i];
 
-		if (msl->socket_id != numa_id)
+		if (msl->numa_id != numa_id)
 			continue;
 
 		if (msl->base_va == NULL)
@@ -1031,7 +1031,7 @@ malloc_heap_free(struct malloc_elem *elem)
 	unmapped = true;
 
 	EAL_LOG(DEBUG, "Heap on NUMA node %d was shrunk by %zdMB",
-		msl->socket_id, aligned_len >> 20ULL);
+		msl->numa_id, aligned_len >> 20ULL);
 
 	rte_mcfg_mem_write_unlock();
 free_unlock:
@@ -1217,13 +1217,13 @@ malloc_heap_create_external_seg(void *va_addr, rte_iova_t iova_addrs[],
 		ms->len = page_sz;
 		ms->nchannel = rte_memory_get_nchannel();
 		ms->nrank = rte_memory_get_nrank();
-		ms->socket_id = numa_id;
+		ms->numa_id = numa_id;
 	}
 
 	/* set up the memseg list */
 	msl->base_va = va_addr;
 	msl->page_sz = page_sz;
-	msl->socket_id = numa_id;
+	msl->numa_id = numa_id;
 	msl->len = seg_len;
 	msl->version = 0;
 	msl->external = 1;
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index de4918f954..31622c441d 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -356,7 +356,7 @@ check_socket(const struct rte_memseg_list *msl, void *arg)
 	if (msl->external)
 		return 0;
 
-	if (msl->socket_id == *numa_id && msl->memseg_arr.count != 0)
+	if (msl->numa_id == *numa_id && msl->memseg_arr.count != 0)
 		return 1;
 
 	return 0;
diff --git a/lib/eal/include/rte_lcore.h b/lib/eal/include/rte_lcore.h
index 904d80fe28..ee30251be2 100644
--- a/lib/eal/include/rte_lcore.h
+++ b/lib/eal/include/rte_lcore.h
@@ -12,6 +12,7 @@
  */
 #include <stdio.h>
 
+#include <rte_common.h>
 #include <rte_compat.h>
 #include <rte_config.h>
 #include <rte_per_lcore.h>
@@ -135,6 +136,7 @@ unsigned int rte_numa_id(void);
  * @return
  *   the ID of current lcoreid's NUMA node
  */
+__rte_deprecated_msg("use the NUMA node API")
 unsigned int rte_socket_id(void);
 
 /**
@@ -159,6 +161,7 @@ rte_numa_count(void);
  *   the number of NUMA ID's as recognized by EAL
  */
 unsigned int
+__rte_deprecated_msg("use the NUMA node API")
 rte_socket_count(void);
 
 /**
@@ -192,6 +195,7 @@ rte_numa_id_by_idx(unsigned int idx);
  *   - -1 on error, with errno set to EINVAL
  */
 int
+__rte_deprecated_msg("use the NUMA node API")
 rte_socket_id_by_idx(unsigned int idx);
 
 /**
@@ -216,6 +220,7 @@ rte_lcore_to_numa_id(unsigned int lcore_id);
  *   the ID of lcoreid's NUMA node
  */
 unsigned int
+__rte_deprecated_msg("use the NUMA node API")
 rte_lcore_to_socket_id(unsigned int lcore_id);
 
 /**
diff --git a/lib/eal/include/rte_malloc.h b/lib/eal/include/rte_malloc.h
index 9d5d582e1a..bb4c08f859 100644
--- a/lib/eal/include/rte_malloc.h
+++ b/lib/eal/include/rte_malloc.h
@@ -233,6 +233,7 @@ rte_realloc_numa(void *ptr, size_t size, unsigned int align, int numa_id)
  *   - Otherwise, the pointer to the reallocated memory.
  */
 void *
+__rte_deprecated_msg("use the NUMA node API")
 rte_realloc_socket(void *ptr, size_t size, unsigned int align, int socket)
 	__rte_alloc_size(2) __rte_alloc_align(3)
 	__rte_malloc __rte_dealloc_free;
@@ -291,6 +292,7 @@ rte_malloc_numa(const char *type, size_t size, unsigned int align, int numa_id)
  *   - Otherwise, the pointer to the allocated object.
  */
 void *
+__rte_deprecated_msg("use the NUMA node API")
 rte_malloc_socket(const char *type, size_t size, unsigned int align, int socket)
 	__rte_alloc_size(2) __rte_alloc_align(3)
 	__rte_malloc __rte_dealloc_free;
@@ -353,6 +355,7 @@ rte_zmalloc_numa(const char *type, size_t size, unsigned int align, int numa_id)
  *   - Otherwise, the pointer to the allocated object.
  */
 void *
+__rte_deprecated_msg("use the NUMA node API")
 rte_zmalloc_socket(const char *type, size_t size, unsigned int align, int socket)
 	__rte_alloc_size(2) __rte_alloc_align(3)
 	__rte_malloc __rte_dealloc_free;
@@ -415,6 +418,7 @@ rte_calloc_numa(const char *type, size_t num, size_t size, unsigned int align, i
  *   - Otherwise, the pointer to the allocated object.
  */
 void *
+__rte_deprecated_msg("use the NUMA node API")
 rte_calloc_socket(const char *type, size_t num, size_t size, unsigned int align, int socket)
 	__rte_alloc_size(2, 3)	__rte_alloc_align(4)
 	__rte_malloc __rte_dealloc_free;
@@ -471,6 +475,7 @@ rte_malloc_get_numa_stats(int numa_id,
  *   Pointer to structure storing statistics on success
  */
 int
+__rte_deprecated_msg("use the NUMA node API")
 rte_malloc_get_socket_stats(int socket,
 		struct rte_malloc_numa_stats *socket_stats);
 
@@ -665,6 +670,7 @@ rte_malloc_heap_get_numa_id(const char *name);
  *     ENOENT - heap identified by the name ``name`` was not found
  */
 int
+__rte_deprecated_msg("use the NUMA node API")
 rte_malloc_heap_get_socket(const char *name);
 
 /**
@@ -695,6 +701,7 @@ rte_malloc_heap_numa_is_external(int numa_id);
  *   -1 if socket ID is invalid
  */
 int
+__rte_deprecated_msg("use the NUMA node API")
 rte_malloc_heap_socket_is_external(int socket_id);
 
 /**
diff --git a/lib/eal/include/rte_memory.h b/lib/eal/include/rte_memory.h
index 2633550524..ef47510b34 100644
--- a/lib/eal/include/rte_memory.h
+++ b/lib/eal/include/rte_memory.h
@@ -42,7 +42,7 @@ extern "C" {
 /**
  * Legacy alias of RTE_NUMA_ID_ANY.
  */
-#define SOCKET_ID_ANY RTE_NUMA_ID_ANY
+#define SOCKET_ID_ANY (RTE_DEPRECATED(SOCKET_ID_ANY) RTE_NUMA_ID_ANY)
 
 /** Prevent this segment from being freed back to the OS. */
 #define RTE_MEMSEG_FLAG_DO_NOT_FREE RTE_BIT32(0)
@@ -60,10 +60,18 @@ struct __rte_packed_begin rte_memseg {
 	};
 	size_t len;               /**< Length of the segment. */
 	uint64_t hugepage_sz;       /**< The pagesize of underlying memory */
-	int32_t socket_id;          /**< NUMA socket ID. */
+	union {
+		/** NUMA node ID. */
+		int32_t numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int32_t socket_id;
+	};
 	uint32_t nchannel;          /**< Number of channels. */
 	uint32_t nrank;             /**< Number of ranks. */
-	uint32_t flags;             /**< Memseg-specific flags */
+	uint32_t flags;             /**< Memseg-specific flag bits */
 } __rte_packed_end;
 
 /**
@@ -78,7 +86,15 @@ struct rte_memseg_list {
 		/**< Makes sure addr is always 64-bits */
 	};
 	uint64_t page_sz; /**< Page size for all memsegs in this list. */
-	int socket_id; /**< Socket ID for all memsegs in this list. */
+	union {
+		/** NUMA node ID for all memsegs in this list. */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	volatile uint32_t version; /**< version number for multiprocess sync. */
 	size_t len; /**< Length of memory area covered by this memseg list. */
 	unsigned int external; /**< 1 if this list points to external memory */
diff --git a/lib/eal/include/rte_memzone.h b/lib/eal/include/rte_memzone.h
index 125241c538..bcd71e525e 100644
--- a/lib/eal/include/rte_memzone.h
+++ b/lib/eal/include/rte_memzone.h
@@ -59,7 +59,15 @@ struct __rte_packed_begin rte_memzone {
 
 	uint64_t hugepage_sz;             /**< The page size of underlying memory */
 
-	int32_t socket_id;                /**< NUMA socket ID. */
+	union {
+		/** NUMA node ID. */
+		int32_t numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int32_t socket_id;
+	};
 
 	uint32_t flags;                   /**< Characteristics of this memzone. */
 } __rte_packed_end;
diff --git a/lib/eal/include/rte_service_component.h b/lib/eal/include/rte_service_component.h
index acdf45cf60..596717e64c 100644
--- a/lib/eal/include/rte_service_component.h
+++ b/lib/eal/include/rte_service_component.h
@@ -10,6 +10,7 @@
  * operate, and you wish to run the component using service cores
  */
 
+#include <rte_common.h>
 #include <rte_service.h>
 
 #ifdef __cplusplus
@@ -45,8 +46,15 @@ struct rte_service_spec {
 	 * the public header file for values of RTE_SERVICE_CAP_*
 	 */
 	uint32_t capabilities;
-	/** NUMA socket ID that this service is affinitized to */
-	int socket_id;
+	union {
+		/** NUMA node ID that this service is bound to */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 };
 
 /**
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 0d26c780f2..14dcdaed99 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -439,7 +439,7 @@ check_socket(const struct rte_memseg_list *msl, void *arg)
 	if (msl->external)
 		return 0;
 
-	return *numa_id == msl->socket_id;
+	return *numa_id == msl->numa_id;
 }
 
 static void
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index 6003f04bd7..3d2842b6ef 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -646,7 +646,7 @@ alloc_seg(struct rte_memseg *ms, void *addr, int numa_id,
 	ms->nchannel = rte_memory_get_nchannel();
 	ms->nrank = rte_memory_get_nrank();
 	ms->iova = iova;
-	ms->socket_id = numa_id;
+	ms->numa_id = numa_id;
 	ms->flags = dirty ? RTE_MEMSEG_FLAG_DIRTY : 0;
 
 	return 0;
@@ -779,7 +779,7 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 
 	if (msl->page_sz != wa->page_sz)
 		return 0;
-	if (msl->socket_id != wa->numa_id)
+	if (msl->numa_id != wa->numa_id)
 		return 0;
 
 	page_sz = (size_t)msl->page_sz;
@@ -1172,7 +1172,7 @@ sync_chunk(struct rte_memseg_list *primary_msl,
 
 		if (used) {
 			ret = alloc_seg(l_ms, p_ms->addr,
-					p_ms->socket_id, hi,
+					p_ms->numa_id, hi,
 					msl_idx, seg_idx);
 			if (ret < 0)
 				return -1;
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 601173c188..cce48208f9 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -712,7 +712,7 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 
 		if (msl->page_sz != page_sz)
 			continue;
-		if (msl->socket_id != numa_id)
+		if (msl->numa_id != numa_id)
 			continue;
 
 		/* leave space for a hole if array is not empty */
@@ -813,7 +813,7 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 		ms->hugepage_sz = page_sz;
 		ms->len = memseg_len;
 		ms->iova = hfile->physaddr;
-		ms->socket_id = hfile->numa_id;
+		ms->numa_id = hfile->numa_id;
 		ms->nchannel = rte_memory_get_nchannel();
 		ms->nrank = rte_memory_get_nrank();
 
@@ -1948,7 +1948,7 @@ memseg_secondary_init_dynmem(void)
 		}
 
 		EAL_LOG(DEBUG, "Attaching segment list: n_segs:%u numa_id:%d hugepage_sz:%" PRIu64,
-			msl->memseg_arr.len, msl->socket_id, msl->page_sz);
+			msl->memseg_arr.len, msl->numa_id, msl->page_sz);
 	}
 
 	return 0;
diff --git a/lib/eal/windows/eal_memalloc.c b/lib/eal/windows/eal_memalloc.c
index 2f956adc1a..a6ce85305d 100644
--- a/lib/eal/windows/eal_memalloc.c
+++ b/lib/eal/windows/eal_memalloc.c
@@ -46,7 +46,7 @@ alloc_seg(struct rte_memseg *ms, void *requested_addr, int numa_id,
 	if (ms->len > 0) {
 		/* If a segment is already allocated as needed, return it. */
 		if ((ms->addr == requested_addr) &&
-			(ms->socket_id == numa_id) &&
+			(ms->numa_id == numa_id) &&
 			(ms->hugepage_sz == hi->hugepage_sz)) {
 			return 0;
 		}
@@ -54,7 +54,7 @@ alloc_seg(struct rte_memseg *ms, void *requested_addr, int numa_id,
 		/* Bugcheck, should not happen. */
 		EAL_LOG(DEBUG, "Attempted to reallocate segment %p "
 			"(size %zu) on NUMA node %d", ms->addr,
-			ms->len, ms->socket_id);
+			ms->len, ms->numa_id);
 		return -1;
 	}
 
@@ -131,7 +131,7 @@ alloc_seg(struct rte_memseg *ms, void *requested_addr, int numa_id,
 	ms->nchannel = rte_memory_get_nchannel();
 	ms->nrank = rte_memory_get_nrank();
 	ms->iova = iova;
-	ms->socket_id = numa_id;
+	ms->numa_id = numa_id;
 
 	return 0;
 
@@ -187,7 +187,7 @@ alloc_seg_walk(const struct rte_memseg_list *msl, void *arg)
 
 	if (msl->page_sz != wa->page_sz)
 		return 0;
-	if (msl->socket_id != wa->numa_id)
+	if (msl->numa_id != wa->numa_id)
 		return 0;
 
 	page_sz = (size_t)msl->page_sz;
diff --git a/lib/ethdev/ethdev_driver.c b/lib/ethdev/ethdev_driver.c
index 92310c94be..da98f53fda 100644
--- a/lib/ethdev/ethdev_driver.c
+++ b/lib/ethdev/ethdev_driver.c
@@ -757,7 +757,7 @@ rte_eth_dma_zone_reserve(const struct rte_eth_dev *dev, const char *ring_name,
 
 	mz = rte_memzone_lookup(z_name);
 	if (mz) {
-		if ((numa_id != RTE_NUMA_ID_ANY && numa_id != mz->socket_id) ||
+		if ((numa_id != RTE_NUMA_ID_ANY && numa_id != mz->numa_id) ||
 				size > mz->len ||
 				((uintptr_t)mz->addr & (align - 1)) != 0) {
 			RTE_ETHDEV_LOG_LINE(ERR,
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index 83a4dfb337..ad9de5a662 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -2732,6 +2732,7 @@ int rte_eth_dev_numa_id(uint16_t port_id);
  *     - EINVAL is the port_id is invalid,
  *     - 0 is the socket could not be determined,
  */
+__rte_deprecated_msg("use the NUMA node API")
 int rte_eth_dev_socket_id(uint16_t port_id);
 
 /**
diff --git a/lib/eventdev/rte_event_crypto_adapter.c b/lib/eventdev/rte_event_crypto_adapter.c
index a8e29f2b32..081c407368 100644
--- a/lib/eventdev/rte_event_crypto_adapter.c
+++ b/lib/eventdev/rte_event_crypto_adapter.c
@@ -920,7 +920,7 @@ eca_init_service(struct event_crypto_adapter *adapter, uint8_t id)
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, CRYPTO_ADAPTER_NAME_LEN,
 		"rte_event_crypto_adapter_%d", id);
-	service.socket_id = adapter->numa_id;
+	service.numa_id = adapter->numa_id;
 	service.callback = eca_service_func;
 	service.callback_userdata = adapter;
 	/* Service function handles locking for queue add/del updates */
diff --git a/lib/eventdev/rte_event_dma_adapter.c b/lib/eventdev/rte_event_dma_adapter.c
index 1dc752141d..70480cbed6 100644
--- a/lib/eventdev/rte_event_dma_adapter.c
+++ b/lib/eventdev/rte_event_dma_adapter.c
@@ -867,7 +867,7 @@ edma_init_service(struct event_dma_adapter *adapter, uint8_t id)
 
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, DMA_ADAPTER_NAME_LEN, "rte_event_dma_adapter_%d", id);
-	service.socket_id = adapter->numa_id;
+	service.numa_id = adapter->numa_id;
 	service.callback = edma_service_func;
 	service.callback_userdata = adapter;
 
diff --git a/lib/eventdev/rte_event_eth_rx_adapter.c b/lib/eventdev/rte_event_eth_rx_adapter.c
index e87a6eca78..41e66ba2d6 100644
--- a/lib/eventdev/rte_event_eth_rx_adapter.c
+++ b/lib/eventdev/rte_event_eth_rx_adapter.c
@@ -1922,7 +1922,7 @@ rxa_init_service(struct event_eth_rx_adapter *rx_adapter, uint8_t id)
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, ETH_RX_ADAPTER_SERVICE_NAME_LEN,
 		"rte_event_eth_rx_adapter_%d", id);
-	service.socket_id = rx_adapter->numa_id;
+	service.numa_id = rx_adapter->numa_id;
 	service.callback = rxa_service_func;
 	service.callback_userdata = rx_adapter;
 	/* Service function handles locking for queue add/del updates */
diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c b/lib/eventdev/rte_event_eth_tx_adapter.c
index c57d6b868c..071bf7b9ac 100644
--- a/lib/eventdev/rte_event_eth_tx_adapter.c
+++ b/lib/eventdev/rte_event_eth_tx_adapter.c
@@ -456,7 +456,7 @@ txa_service_register(struct txa_service_data *txa)
 
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, TXA_SERVICE_NAME_LEN, "txa_%d", txa->id);
-	service.socket_id = txa->numa_id;
+	service.numa_id = txa->numa_id;
 	service.callback = txa_service_func;
 	service.callback_userdata = txa;
 	service.capabilities = RTE_SERVICE_CAP_MT_SAFE;
diff --git a/lib/eventdev/rte_event_timer_adapter.c b/lib/eventdev/rte_event_timer_adapter.c
index de33fd9f95..9b69bc690e 100644
--- a/lib/eventdev/rte_event_timer_adapter.c
+++ b/lib/eventdev/rte_event_timer_adapter.c
@@ -995,7 +995,7 @@ swtim_init(struct rte_event_timer_adapter *adapter)
 	memset(&service, 0, sizeof(service));
 	snprintf(service.name, RTE_SERVICE_NAME_MAX,
 		 "swtim_svc_%"PRIu8, adapter->data->id);
-	service.socket_id = adapter->data->numa_id;
+	service.numa_id = adapter->data->numa_id;
 	service.callback = swtim_service_func;
 	service.callback_userdata = adapter;
 	service.capabilities &= ~(RTE_SERVICE_CAP_MT_SAFE);
diff --git a/lib/eventdev/rte_event_vector_adapter.c b/lib/eventdev/rte_event_vector_adapter.c
index 6222f1c907..67d0d10603 100644
--- a/lib/eventdev/rte_event_vector_adapter.c
+++ b/lib/eventdev/rte_event_vector_adapter.c
@@ -662,7 +662,7 @@ sw_vector_adapter_service_init(struct sw_vector_adapter_data *sw)
 		snprintf(service.name, RTE_SERVICE_NAME_MAX, "%s", SW_VECTOR_ADAPTER_SERVICE_FMT);
 		service.callback = sw_vector_adapter_service_func;
 		service.callback_userdata = service_data;
-		service.socket_id = sw->adapter->data->numa_id;
+		service.numa_id = sw->adapter->data->numa_id;
 
 		ret = rte_service_component_register(&service, &service_data->service_id);
 		if (ret < 0) {
diff --git a/lib/eventdev/rte_eventdev.h b/lib/eventdev/rte_eventdev.h
index 1aaae6469b..4eefa8c14b 100644
--- a/lib/eventdev/rte_eventdev.h
+++ b/lib/eventdev/rte_eventdev.h
@@ -608,6 +608,7 @@ rte_event_dev_numa_id(uint8_t dev_id);
  *   correspond to any event device.
  */
 int
+__rte_deprecated_msg("use the NUMA node API")
 rte_event_dev_socket_id(uint8_t dev_id);
 
 /**
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 0e49cdfd1e..20e7590720 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -133,7 +133,7 @@ find_min_pagesz(const struct rte_memseg_list *msl, void *arg)
 	 * as a NUMA node ID argument, we must only look at native memory and
 	 * ignore any page sizes associated with external memory.
 	 */
-	valid = msl->socket_id == wa->numa_id;
+	valid = msl->numa_id == wa->numa_id;
 	valid |= wa->numa_id == RTE_NUMA_ID_ANY && msl->external == 0;
 
 	if (valid && msl->page_sz < wa->min)
@@ -1655,7 +1655,7 @@ mempool_info_cb(struct rte_mempool *mp, void *arg)
 	rte_tel_data_add_dict_uint(info->d, "mz_len", mz->len);
 	rte_tel_data_add_dict_uint(info->d, "mz_hugepage_sz",
 				  mz->hugepage_sz);
-	rte_tel_data_add_dict_int(info->d, "mz_numa_id", mz->socket_id);
+	rte_tel_data_add_dict_int(info->d, "mz_numa_id", mz->numa_id);
 	rte_tel_data_add_dict_uint(info->d, "mz_flags", mz->flags);
 }
 
diff --git a/lib/rawdev/rte_rawdev.h b/lib/rawdev/rte_rawdev.h
index 0ca7b5e111..a09732261c 100644
--- a/lib/rawdev/rte_rawdev.h
+++ b/lib/rawdev/rte_rawdev.h
@@ -73,6 +73,7 @@ rte_rawdev_numa_id(uint16_t dev_id);
  *   -(-EINVAL)  dev_id value is out of range.
  */
 int
+__rte_deprecated_msg("use the NUMA node API")
 rte_rawdev_socket_id(uint16_t dev_id);
 
 /**
diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
index c566592027..c113717341 100644
--- a/lib/ring/rte_ring.c
+++ b/lib/ring/rte_ring.c
@@ -605,7 +605,7 @@ ring_info_cb(struct rte_ring *r, void *arg)
 		return;
 
 	rte_tel_data_add_dict_string(d, "name", r->name);
-	rte_tel_data_add_dict_int(d, "numa_id", r->memzone->socket_id);
+	rte_tel_data_add_dict_int(d, "numa_id", r->memzone->numa_id);
 	rte_tel_data_add_dict_int(d, "flags", r->flags);
 	rte_tel_data_add_dict_string(d, "producer_type",
 		ring_prod_sync_type_to_name(r));
@@ -622,7 +622,7 @@ ring_info_cb(struct rte_ring *r, void *arg)
 	rte_tel_data_add_dict_string(d, "mz_name", mz->name);
 	rte_tel_data_add_dict_uint(d, "mz_len", mz->len);
 	rte_tel_data_add_dict_uint(d, "mz_hugepage_sz", mz->hugepage_sz);
-	rte_tel_data_add_dict_int(d, "mz_numa_id", mz->socket_id);
+	rte_tel_data_add_dict_int(d, "mz_numa_id", mz->numa_id);
 	rte_tel_data_add_dict_uint_hex(d, "mz_flags", mz->flags, 0);
 }
 
diff --git a/lib/table/rte_swx_table_wm.c b/lib/table/rte_swx_table_wm.c
index 4293e2fa6f..fbed791a55 100644
--- a/lib/table/rte_swx_table_wm.c
+++ b/lib/table/rte_swx_table_wm.c
@@ -308,7 +308,7 @@ acl_table_create(struct rte_swx_table_params *params,
 
 	/* ACL create. */
 	acl_params.name = name;
-	acl_params.socket_id = numa_node;
+	acl_params.numa_id = numa_node;
 	acl_params.rule_size = RTE_ACL_RULE_SZ(acl_cfg.num_fields);
 	acl_params.max_rule_num = n_entries;
 
-- 
2.55.0

