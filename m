Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F80C606A32F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dot4SZDE
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CDFD42E37;
	Tue,  3 Nov 2026 16:08:02 +0100 (CET)
Received: from mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
 by mails.dpdk.org (Postfix) with ESMTPS id 32C6242E24
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:08:01 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=U/4sORJdtN8oAWQciKRDU5nyp4UpztToF3QEmSfVFAE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793718480; v=1; x=1794323280;
 b=dot4SZDEFL7I+xu3CqnvHcLM3DKNtAw8hPL4IFRozYOOk6I4p84Gx5Az/Zpf1RSWFuBtv/qP
 Q67PGH543uuvsFRk4Vr2zn4YRtDna5VZ23RSJaWRVKDmy6cXT9acIFil86MQebB+WszSI/KczpT
 3vFF/nVDxuFA/oP3VRMZ/+ag=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id e905f569ea8a9933;
 Tue, 03 Nov 2026 15:08:00 +0000
X-Mizu-Trace-ID: e905f569ea8a9933
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 091/227] event/dlb2: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:50:49 +0800
Message-ID: <20261103145306.487255-92-chengwen.feng@linux.dev>
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
 drivers/event/dlb2/dlb2.c          |  8 ++++----
 drivers/event/dlb2/dlb2_priv.h     |  4 ++--
 drivers/event/dlb2/dlb2_selftest.c |  2 +-
 drivers/event/dlb2/dlb2_xstats.c   |  8 ++++----
 drivers/event/dlb2/pf/dlb2_pf.c    | 12 ++++++------
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 084875f1c8..b1e4963b95 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -332,14 +332,14 @@ set_producer_coremask(const char *key __rte_unused,
 static int
 set_numa_node(const char *key __rte_unused, const char *value, void *opaque)
 {
-	int *socket_id = opaque;
+	int *numa_id = opaque;
 	int ret;
 
-	ret = dlb2_string_to_int(socket_id, value);
+	ret = dlb2_string_to_int(numa_id, value);
 	if (ret < 0)
 		return ret;
 
-	if (*socket_id > RTE_MAX_NUMA_NODES)
+	if (*numa_id > RTE_MAX_NUMA_NODES)
 		return -EINVAL;
 	return 0;
 }
@@ -5224,7 +5224,7 @@ dlb2_parse_params(const char *params,
 		} else {
 			int ret = rte_kvargs_process(kvlist, NUMA_NODE_ARG,
 						     set_numa_node,
-						     &dlb2_args->socket_id);
+						     &dlb2_args->numa_id);
 			if (ret != 0) {
 				DLB2_LOG_ERR("%s: Error parsing numa node parameter",
 					     name);
diff --git a/drivers/event/dlb2/dlb2_priv.h b/drivers/event/dlb2/dlb2_priv.h
index 607b4d24d0..196c629e7d 100644
--- a/drivers/event/dlb2/dlb2_priv.h
+++ b/drivers/event/dlb2/dlb2_priv.h
@@ -196,7 +196,7 @@ struct dlb2_hw_resource_info {
 	/**> Max resources that can be provided */
 	struct dlb2_hw_rsrcs hw_rsrc_max;
 	int num_sched_domains;
-	uint32_t socket_id;
+	uint32_t numa_id;
 };
 
 enum dlb2_enqueue_type {
@@ -674,7 +674,7 @@ struct dlb2_cos_bw {
 };
 
 struct dlb2_devargs {
-	int socket_id;
+	int numa_id;
 	int max_num_events;
 	int num_dir_credits_override;
 	int dev_id;
diff --git a/drivers/event/dlb2/dlb2_selftest.c b/drivers/event/dlb2/dlb2_selftest.c
index 87d98700c9..bd608f08d1 100644
--- a/drivers/event/dlb2/dlb2_selftest.c
+++ b/drivers/event/dlb2/dlb2_selftest.c
@@ -1396,7 +1396,7 @@ do_selftest(void)
 						32 /*MBUF_CACHE_SIZE*/,
 						0,
 						512, /* use very small mbufs */
-						rte_socket_id());
+						rte_numa_id());
 		if (!eventdev_func_mempool) {
 			printf("ERROR creating mempool\n");
 			goto test_fail;
diff --git a/drivers/event/dlb2/dlb2_xstats.c b/drivers/event/dlb2/dlb2_xstats.c
index c037cfe786..3398c06bd0 100644
--- a/drivers/event/dlb2/dlb2_xstats.c
+++ b/drivers/event/dlb2/dlb2_xstats.c
@@ -586,9 +586,9 @@ dlb2_xstats_init(struct dlb2_eventdev *dlb2)
 		DLB2_MAX_NUM_QUEUES(dlb2->version) * RTE_DIM(qid_stats);
 	unsigned int i, port, qid, stat_id = 0;
 
-	dlb2->xstats = rte_zmalloc_socket(NULL,
+	dlb2->xstats = rte_zmalloc_numa(NULL,
 			sizeof(dlb2->xstats[0]) * count, 0,
-			dlb2->qm_instance.info.socket_id);
+			dlb2->qm_instance.info.numa_id);
 	if (dlb2->xstats == NULL)
 		return -ENOMEM;
 
@@ -1027,8 +1027,8 @@ dlb2_eventdev_dump(struct rte_eventdev *dev, FILE *f)
 	else
 		fprintf(f, "UNEXPECTED\n");
 
-	fprintf(f, "domain ID=%u, socket_id=%u, evdev=%p\n",
-		handle->domain_id, handle->info.socket_id, dlb2->event_dev);
+	fprintf(f, "domain ID=%u, numa_id=%u, evdev=%p\n",
+		handle->domain_id, handle->info.numa_id, dlb2->event_dev);
 
 	fprintf(f, "num dir ports=%u, num dir queues=%u\n",
 		dlb2->num_dir_ports, dlb2->num_dir_queues);
diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index aaa55bbe00..998df9ca0c 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -298,14 +298,14 @@ dlb2_alloc_coherent_aligned(const struct rte_memzone **mz, uintptr_t *phys,
 {
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	uint32_t core_id = rte_lcore_id();
-	unsigned int socket_id;
+	unsigned int numa_id;
 
 	snprintf(mz_name, sizeof(mz_name) - 1, "event_dlb2_pf_%lx",
 		 (unsigned long)rte_get_timer_cycles());
 	if (core_id == (unsigned int)LCORE_ID_ANY)
 		core_id = rte_get_main_lcore();
-	socket_id = rte_lcore_to_socket_id(core_id);
-	*mz = rte_memzone_reserve_aligned(mz_name, size, socket_id,
+	numa_id = rte_lcore_to_numa_id(core_id);
+	*mz = rte_memzone_reserve_aligned(mz_name, size, numa_id,
 					 RTE_MEMZONE_IOVA_CONTIG, align);
 	if (*mz == NULL) {
 		DLB2_LOG_LINE_DBG("Unable to allocate DMA memory of size %zu bytes - %s",
@@ -758,7 +758,7 @@ dlb2_eventdev_pci_init(struct rte_eventdev *eventdev)
 	int ret = 0;
 	struct rte_pci_device *pci_dev;
 	struct dlb2_devargs dlb2_args = {
-		.socket_id = rte_socket_id(),
+		.numa_id = rte_numa_id(),
 		.max_num_events = DLB2_MAX_NUM_LDB_CREDITS,
 		.producer_coremask = NULL,
 		.num_dir_credits_override = -1,
@@ -776,7 +776,7 @@ dlb2_eventdev_pci_init(struct rte_eventdev *eventdev)
 	int q;
 	const void *probe_args = NULL;
 
-	DLB2_LOG_LINE_DBG("Enter with dev_id=%d socket_id=%d",
+	DLB2_LOG_LINE_DBG("Enter with dev_id=%d numa_id=%d",
 		     eventdev->data->dev_id, eventdev->data->numa_id);
 
 	for (q = 0; q < DLB2_MAX_NUM_PORTS_ALL; q++)
@@ -787,7 +787,7 @@ dlb2_eventdev_pci_init(struct rte_eventdev *eventdev)
 	pci_dev = RTE_CLASS_TO_BUS_DEVICE(eventdev, *pci_dev);
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		dlb2 = dlb2_pmd_priv(eventdev); /* rte_zmalloc_socket mem */
+		dlb2 = dlb2_pmd_priv(eventdev); /* rte_zmalloc_numa mem */
 		dlb2->version = DLB2_HW_DEVICE_FROM_PCI_ID(pci_dev);
 		if (dlb2->version == DLB2_HW_V2_5)
 			dlb2_args.max_num_events = DLB2_MAX_NUM_CREDITS(DLB2_HW_V2_5);
-- 
2.55.0

