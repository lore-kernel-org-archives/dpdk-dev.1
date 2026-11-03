Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C0606D82A
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZLAQrUgg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2BF44111C;
	Tue,  3 Nov 2026 15:54:46 +0100 (CET)
Received: from mta0.migadu.com (out-198.mta0.migadu.com [91.218.175.198])
 by mails.dpdk.org (Postfix) with ESMTPS id 717594111C
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:54:45 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=iSbMgt0i5U8QyzyjvohQe50oTqbiTd07xU2tNe/3Vjk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717685; v=1; x=1794322485;
 b=ZLAQrUgghupJSHeuzMh404uxs6LOtRnrBNK+KYncfxJTf096wzh7Ad6zZ6P9U7He4QqDSBHZ
 JWHi1CB6VtJmmx5yLmrJyKfT/1oPUmeT59Tz+hU1ojlLBFk7fRH0y2o+Xa5vKEGURAc1SIfTi8e
 Z3SIu5cYGnzzz/E1URicJIVg=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 3bac5411c15b6f91;
 Tue, 03 Nov 2026 14:54:45 +0000
X-Mizu-Trace-ID: 3bac5411c15b6f91
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 011/227] bbdev: rename device socket API to NUMA node API
Date: Tue,  3 Nov 2026 22:49:29 +0800
Message-ID: <20261103145306.487255-12-chengwen.feng@linux.dev>
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

Rename the numa_id fields of rte_bbdev_info, rte_bbdev_data and
rte_bbdev_queue_conf (were socket_id and socket), keeping the old
names as deprecated union aliases, and update in-tree users
accordingly.

Also rename socket_id parameters, trace arguments, internal
variables, log messages and comments to the NUMA node
terminology, and switch internal calls to rte_calloc_numa(),
rte_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-bbdev/test_bbdev.c                   | 12 +++----
 app/test-bbdev/test_bbdev_perf.c              |  6 ++--
 drivers/baseband/acc/rte_acc100_pmd.c         |  8 ++---
 drivers/baseband/acc/rte_vrb_pmd.c            |  8 ++---
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |  4 +--
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |  4 +--
 drivers/baseband/la12xx/bbdev_la12xx.c        |  2 +-
 drivers/baseband/null/bbdev_null.c            |  4 +--
 .../baseband/turbo_sw/bbdev_turbo_software.c  |  4 +--
 examples/bbdev_app/main.c                     |  4 +--
 lib/bbdev/bbdev_trace.h                       |  4 +--
 lib/bbdev/rte_bbdev.c                         | 26 +++++++-------
 lib/bbdev/rte_bbdev.h                         | 36 +++++++++++++++----
 lib/bbdev/rte_bbdev_op.h                      |  6 ++--
 lib/bbdev/rte_bbdev_pmd.h                     |  2 +-
 15 files changed, 77 insertions(+), 53 deletions(-)

diff --git a/app/test-bbdev/test_bbdev.c b/app/test-bbdev/test_bbdev.c
index 2422312f6b..1f4246a6fa 100644
--- a/app/test-bbdev/test_bbdev.c
+++ b/app/test-bbdev/test_bbdev.c
@@ -66,7 +66,7 @@ ut_setup(void)
 
 	/* Valid queue configuration */
 	ts_params->qconf.priority = 0;
-	ts_params->qconf.socket = SOCKET_ID_ANY;
+	ts_params->qconf.numa_id = RTE_NUMA_ID_ANY;
 	ts_params->qconf.deferred_start = 1;
 
 	num_queues = 1;
@@ -316,9 +316,9 @@ test_bbdev_configure_stop_queue(void)
 			"invalid return value from "
 			"rte_bbdev_queue_info_get function: %i", return_value);
 
-	TEST_ASSERT(qinfo.conf.socket == ts_params->qconf.socket,
+	TEST_ASSERT(qinfo.conf.numa_id == ts_params->qconf.numa_id,
 			"Failed test for rte_bbdev_queue_info_get: "
-			"invalid queue_size:%u", qinfo.conf.socket);
+			"invalid queue_size:%u", qinfo.conf.numa_id);
 
 	TEST_ASSERT(qinfo.conf.queue_size == ts_params->qconf.queue_size,
 			"Failed test for rte_bbdev_queue_info_get: "
@@ -426,13 +426,13 @@ test_bbdev_configure_invalid_queue_configure(void)
 			"Failed test for rte_bbdev_queue_configure: "
 			"NULL qconf structure ");
 
-	ts_params->qconf.socket = RTE_MAX_NUMA_NODES;
+	ts_params->qconf.numa_id = RTE_MAX_NUMA_NODES;
 	TEST_ASSERT_FAIL(rte_bbdev_queue_configure(dev_id, queue_id,
 			&ts_params->qconf),
 			"Failed test for rte_bbdev_queue_configure: "
 			"invalid socket number ");
 
-	ts_params->qconf.socket = SOCKET_ID_ANY;
+	ts_params->qconf.numa_id = RTE_NUMA_ID_ANY;
 	TEST_ASSERT_SUCCESS(rte_bbdev_queue_configure(dev_id, queue_id,
 			&ts_params->qconf),
 			"Failed test for rte_bbdev_queue_configure: "
@@ -1125,7 +1125,7 @@ test_bbdev_invalid_driver(void)
 			"NULL queue_release ");
 	dev2->dev_ops = dev1.dev_ops;
 
-	dev2->data->socket_id = SOCKET_ID_ANY;
+	dev2->data->numa_id = RTE_NUMA_ID_ANY;
 	TEST_ASSERT_SUCCESS(rte_bbdev_setup_queues(dev_id, 1,
 			SOCKET_ID_ANY), "Failed to configure bbdev %u", dev_id);
 
diff --git a/app/test-bbdev/test_bbdev_perf.c b/app/test-bbdev/test_bbdev_perf.c
index b75d8387bd..8e2a26905d 100644
--- a/app/test-bbdev/test_bbdev_perf.c
+++ b/app/test-bbdev/test_bbdev_perf.c
@@ -897,10 +897,10 @@ add_bbdev_dev(uint8_t dev_id, struct rte_bbdev_info *info,
 	nb_queues = RTE_MIN(nb_queues, (unsigned int) MAX_QUEUES);
 
 	/* setup device */
-	ret = rte_bbdev_setup_queues(dev_id, nb_queues, info->socket_id);
+	ret = rte_bbdev_setup_queues(dev_id, nb_queues, info->numa_id);
 	if (ret < 0) {
 		printf("rte_bbdev_setup_queues(%u, %u, %d) ret %i\n",
-				dev_id, nb_queues, info->socket_id, ret);
+				dev_id, nb_queues, info->numa_id, ret);
 		return TEST_FAILED;
 	}
 
@@ -915,7 +915,7 @@ add_bbdev_dev(uint8_t dev_id, struct rte_bbdev_info *info,
 	}
 
 	/* setup device queues */
-	qconf.socket = info->socket_id;
+	qconf.numa_id = info->numa_id;
 	qconf.queue_size = info->drv.default_queue_conf.queue_size;
 	qconf.priority = 0;
 	qconf.deferred_start = 0;
diff --git a/drivers/baseband/acc/rte_acc100_pmd.c b/drivers/baseband/acc/rte_acc100_pmd.c
index cbcacc7aa3..67b969fc71 100644
--- a/drivers/baseband/acc/rte_acc100_pmd.c
+++ b/drivers/baseband/acc/rte_acc100_pmd.c
@@ -413,7 +413,7 @@ allocate_info_ring(struct rte_bbdev *dev)
 	d->info_ring = rte_zmalloc_socket("Info Ring",
 		ACC_INFO_RING_NUM_ENTRIES *
 		sizeof(*d->info_ring), RTE_CACHE_LINE_SIZE,
-		dev->data->socket_id);
+		dev->data->numa_id);
 	if (d->info_ring == NULL) {
 		rte_bbdev_log(ERR,
 				"Failed to allocate Info Ring for %s:%u",
@@ -543,7 +543,7 @@ acc100_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
 	if (d->harq_layout == NULL)
 		d->harq_layout = rte_zmalloc_socket("HARQ Layout",
 			ACC_HARQ_LAYOUT * sizeof(*d->harq_layout),
-			RTE_CACHE_LINE_SIZE, dev->data->socket_id);
+			RTE_CACHE_LINE_SIZE, dev->data->numa_id);
 	if (d->harq_layout == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate harq_layout for %s:%u",
 				dev->device->driver->name,
@@ -978,7 +978,7 @@ acc100_dev_info_get(struct rte_bbdev *dev,
 	};
 
 	static struct rte_bbdev_queue_conf default_queue_conf;
-	default_queue_conf.socket = dev->data->socket_id;
+	default_queue_conf.numa_id = dev->data->numa_id;
 	default_queue_conf.queue_size = ACC_MAX_QUEUE_DEPTH;
 
 	dev_info->driver_name = dev->device->driver->name;
@@ -4058,7 +4058,7 @@ static int acc100_pci_probe(struct rte_pci_driver *pci_drv,
 	/* Fill HW specific part of device structure */
 	bbdev->device = &pci_dev->device;
 	bbdev->intr_handle = pci_dev->intr_handle;
-	bbdev->data->socket_id = pci_dev->device.numa_node;
+	bbdev->data->numa_id = pci_dev->device.numa_node;
 
 	/* Invoke ACC100 device initialization function */
 	acc100_bbdev_init(bbdev, pci_drv);
diff --git a/drivers/baseband/acc/rte_vrb_pmd.c b/drivers/baseband/acc/rte_vrb_pmd.c
index 1f85e33462..8d86694b80 100644
--- a/drivers/baseband/acc/rte_vrb_pmd.c
+++ b/drivers/baseband/acc/rte_vrb_pmd.c
@@ -513,7 +513,7 @@ allocate_info_ring(struct rte_bbdev *dev)
 
 	/* Allocate InfoRing */
 	d->info_ring = rte_zmalloc_socket("Info Ring", ACC_INFO_RING_NUM_ENTRIES *
-			sizeof(*d->info_ring), RTE_CACHE_LINE_SIZE, dev->data->socket_id);
+			sizeof(*d->info_ring), RTE_CACHE_LINE_SIZE, dev->data->numa_id);
 	if (d->info_ring == NULL) {
 		rte_bbdev_log(ERR,
 				"Failed to allocate Info Ring for %s:%u",
@@ -721,7 +721,7 @@ vrb_setup_queues(struct rte_bbdev *dev, uint16_t num_queues, int socket_id)
 	if (d->harq_layout == NULL)
 		d->harq_layout = rte_zmalloc_socket("HARQ Layout",
 				ACC_HARQ_LAYOUT * sizeof(*d->harq_layout),
-				RTE_CACHE_LINE_SIZE, dev->data->socket_id);
+				RTE_CACHE_LINE_SIZE, dev->data->numa_id);
 	if (d->harq_layout == NULL) {
 		rte_bbdev_log(ERR, "Failed to allocate harq_layout for %s:%u",
 				dev->device->driver->name,
@@ -1429,7 +1429,7 @@ vrb_dev_info_get(struct rte_bbdev *dev, struct rte_bbdev_driver_info *dev_info)
 	};
 
 	static struct rte_bbdev_queue_conf default_queue_conf;
-	default_queue_conf.socket = dev->data->socket_id;
+	default_queue_conf.numa_id = dev->data->numa_id;
 	default_queue_conf.queue_size = ACC_MAX_QUEUE_DEPTH;
 
 	dev_info->driver_name = dev->device->driver->name;
@@ -4436,7 +4436,7 @@ static int vrb_pci_probe(struct rte_pci_driver *pci_drv,
 	/* Fill HW specific part of device structure. */
 	bbdev->device = &pci_dev->device;
 	bbdev->intr_handle = pci_dev->intr_handle;
-	bbdev->data->socket_id = pci_dev->device.numa_node;
+	bbdev->data->numa_id = pci_dev->device.numa_node;
 
 	/* Invoke device initialization function. */
 	vrb_bbdev_init(bbdev, pci_drv);
diff --git a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
index e804be4cea..e14581cd48 100644
--- a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
+++ b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
@@ -589,7 +589,7 @@ fpga_5gnr_dev_info_get(struct rte_bbdev *dev, struct rte_bbdev_driver_info *dev_
 			FPGA_5GNR_FEC_HARQ_BUF_SIZE_REGS);
 
 	static struct rte_bbdev_queue_conf default_queue_conf;
-	default_queue_conf.socket = dev->data->socket_id;
+	default_queue_conf.numa_id = dev->data->numa_id;
 	default_queue_conf.queue_size = FPGA_5GNR_RING_MAX_SIZE;
 
 	dev_info->driver_name = dev->device->driver->name;
@@ -2949,7 +2949,7 @@ fpga_5gnr_fec_probe(struct rte_pci_driver *pci_drv,
 	/* Fill HW specific part of device structure */
 	bbdev->device = &pci_dev->device;
 	bbdev->intr_handle = pci_dev->intr_handle;
-	bbdev->data->socket_id = pci_dev->device.numa_node;
+	bbdev->data->numa_id = pci_dev->device.numa_node;
 
 	/* Invoke FPGA 5GNR FEC device initialization function */
 	fpga_5gnr_fec_init(bbdev, pci_drv);
diff --git a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
index cb3f29c10b..dc1394930f 100644
--- a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
+++ b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
@@ -631,7 +631,7 @@ fpga_dev_info_get(struct rte_bbdev *dev,
 	};
 
 	static struct rte_bbdev_queue_conf default_queue_conf;
-	default_queue_conf.socket = dev->data->socket_id;
+	default_queue_conf.numa_id = dev->data->numa_id;
 	default_queue_conf.queue_size = FPGA_RING_MAX_SIZE;
 
 
@@ -2372,7 +2372,7 @@ fpga_lte_fec_probe(struct rte_pci_driver *pci_drv,
 	/* Fill HW specific part of device structure */
 	bbdev->device = &pci_dev->device;
 	bbdev->intr_handle = pci_dev->intr_handle;
-	bbdev->data->socket_id = pci_dev->device.numa_node;
+	bbdev->data->numa_id = pci_dev->device.numa_node;
 
 	/* Invoke FEC FPGA device initialization function */
 	fpga_lte_fec_init(bbdev, pci_drv);
diff --git a/drivers/baseband/la12xx/bbdev_la12xx.c b/drivers/baseband/la12xx/bbdev_la12xx.c
index 1116dacc4b..6db9192d1d 100644
--- a/drivers/baseband/la12xx/bbdev_la12xx.c
+++ b/drivers/baseband/la12xx/bbdev_la12xx.c
@@ -1037,7 +1037,7 @@ la12xx_bbdev_create(struct rte_vdev_device *vdev,
 	}
 	bbdev->dev_ops = &pmd_ops;
 	bbdev->device = &vdev->device;
-	bbdev->data->socket_id = 0;
+	bbdev->data->numa_id = 0;
 	bbdev->intr_handle = NULL;
 
 	/* register rx/tx burst functions for data path */
diff --git a/drivers/baseband/null/bbdev_null.c b/drivers/baseband/null/bbdev_null.c
index d359bdcb5e..10d02da856 100644
--- a/drivers/baseband/null/bbdev_null.c
+++ b/drivers/baseband/null/bbdev_null.c
@@ -66,7 +66,7 @@ info_get(struct rte_bbdev *dev, struct rte_bbdev_driver_info *dev_info)
 		.queue_size = RTE_BBDEV_QUEUE_SIZE_LIMIT,
 	};
 
-	default_queue_conf.socket = dev->data->socket_id;
+	default_queue_conf.numa_id = dev->data->numa_id;
 
 	dev_info->driver_name = RTE_STR(DRIVER_NAME);
 	dev_info->max_num_queues = internals->max_nb_queues;
@@ -280,7 +280,7 @@ null_bbdev_create(struct rte_vdev_device *vdev,
 
 	bbdev->dev_ops = &pmd_ops;
 	bbdev->device = &vdev->device;
-	bbdev->data->socket_id = init_params->socket_id;
+	bbdev->data->numa_id = init_params->socket_id;
 	bbdev->intr_handle = NULL;
 
 	/* register rx/tx burst functions for data path */
diff --git a/drivers/baseband/turbo_sw/bbdev_turbo_software.c b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
index 9d5c505943..12d168666c 100644
--- a/drivers/baseband/turbo_sw/bbdev_turbo_software.c
+++ b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
@@ -244,7 +244,7 @@ info_get(struct rte_bbdev *dev, struct rte_bbdev_driver_info *dev_info)
 #else
 	dev_info->cpu_flag_reqs = NULL;
 #endif
-	default_queue_conf.socket = dev->data->socket_id;
+	default_queue_conf.numa_id = dev->data->numa_id;
 
 	dev_info->driver_name = RTE_STR(DRIVER_NAME);
 	dev_info->max_num_queues = internals->max_nb_queues;
@@ -1912,7 +1912,7 @@ turbo_sw_bbdev_create(struct rte_vdev_device *vdev,
 
 	bbdev->dev_ops = &pmd_ops;
 	bbdev->device = &vdev->device;
-	bbdev->data->socket_id = init_params->socket_id;
+	bbdev->data->numa_id = init_params->socket_id;
 	bbdev->intr_handle = NULL;
 
 	/* register rx/tx burst functions for data path */
diff --git a/examples/bbdev_app/main.c b/examples/bbdev_app/main.c
index 5ac70dab59..8c16d7c556 100644
--- a/examples/bbdev_app/main.c
+++ b/examples/bbdev_app/main.c
@@ -941,14 +941,14 @@ prepare_bbdev_device(unsigned int dev_id, struct rte_bbdev_info *info,
 	uint16_t enc_qs_nb = app_params->num_enc_cores;
 	uint16_t tot_qs = dec_qs_nb + enc_qs_nb;
 
-	ret = rte_bbdev_setup_queues(dev_id, tot_qs, info->socket_id);
+	ret = rte_bbdev_setup_queues(dev_id, tot_qs, info->numa_id);
 	if (ret < 0)
 		rte_exit(EXIT_FAILURE,
 				"ERROR(%d): BBDEV %u not configured properly\n",
 				ret, dev_id);
 
 	/* setup device DEC queues */
-	qconf.socket = info->socket_id;
+	qconf.numa_id = info->numa_id;
 	qconf.queue_size = info->drv.queue_size_lim;
 	qconf.op_type = RTE_BBDEV_OP_TURBO_DEC;
 
diff --git a/lib/bbdev/bbdev_trace.h b/lib/bbdev/bbdev_trace.h
index 0b640a4b3d..ca769fea46 100644
--- a/lib/bbdev/bbdev_trace.h
+++ b/lib/bbdev/bbdev_trace.h
@@ -21,10 +21,10 @@ extern "C" {
 
 RTE_TRACE_POINT(
 	rte_bbdev_trace_setup_queues,
-	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint16_t num_queues, int socket_id),
+	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint16_t num_queues, int numa_id),
 	rte_trace_point_emit_u8(dev_id);
 	rte_trace_point_emit_u16(num_queues);
-	rte_trace_point_emit_int(socket_id);
+	rte_trace_point_emit_int(numa_id);
 )
 RTE_TRACE_POINT(
 	rte_bbdev_trace_queue_configure,
diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
index ab570f2b0d..31ef9c6b4a 100644
--- a/lib/bbdev/rte_bbdev.c
+++ b/lib/bbdev/rte_bbdev.c
@@ -124,7 +124,7 @@ rte_bbdev_data_alloc(void)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		mz = rte_memzone_reserve(MZ_RTE_BBDEV_DATA,
 				RTE_BBDEV_MAX_DEVS * sizeof(*rte_bbdev_data),
-				rte_socket_id(), flags);
+				rte_numa_id(), flags);
 	} else
 		mz = rte_memzone_lookup(MZ_RTE_BBDEV_DATA);
 	if (mz == NULL) {
@@ -322,7 +322,7 @@ rte_bbdev_find_next(uint16_t dev_id)
 
 RTE_EXPORT_SYMBOL(rte_bbdev_setup_queues)
 int
-rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
+rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int numa_id)
 {
 	unsigned int i;
 	int ret;
@@ -332,7 +332,7 @@ rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
 
 	VALID_DEV_OPS_OR_RET_ERR(dev, dev_id);
 
-	rte_bbdev_trace_setup_queues(dev_id, num_queues, socket_id);
+	rte_bbdev_trace_setup_queues(dev_id, num_queues, numa_id);
 
 	if (dev->data->started) {
 		rte_bbdev_log(ERR,
@@ -379,13 +379,13 @@ rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
 	}
 
 	/* Allocate queue pointers */
-	dev->data->queues = rte_calloc_socket(DEV_NAME, num_queues,
+	dev->data->queues = rte_calloc_numa(DEV_NAME, num_queues,
 			sizeof(dev->data->queues[0]), RTE_CACHE_LINE_SIZE,
-				dev->data->socket_id);
+				dev->data->numa_id);
 	if (dev->data->queues == NULL) {
 		rte_bbdev_log(ERR,
-				"calloc of %u queues for device %u on socket %i failed",
-				num_queues, dev_id, dev->data->socket_id);
+				"calloc of %u queues for device %u on NUMA node %i failed",
+				num_queues, dev_id, dev->data->numa_id);
 		return -ENOMEM;
 	}
 
@@ -393,7 +393,7 @@ rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
 
 	/* Call optional device configuration */
 	if (dev->dev_ops->setup_queues) {
-		ret = dev->dev_ops->setup_queues(dev, num_queues, socket_id);
+		ret = dev->dev_ops->setup_queues(dev, num_queues, numa_id);
 		if (ret < 0) {
 			rte_bbdev_log(ERR,
 					"Device %u memory configuration failed",
@@ -854,7 +854,7 @@ rte_bbdev_info_get(uint16_t dev_id, struct rte_bbdev_info *dev_info)
 	dev_info->dev_name = dev->data->name;
 	dev_info->num_queues = dev->data->num_queues;
 	dev_info->device = dev->device;
-	dev_info->socket_id = dev->data->socket_id;
+	dev_info->numa_id = dev->data->numa_id;
 	dev_info->started = dev->data->started;
 
 	/* Copy data maintained by device driver layer */
@@ -955,7 +955,7 @@ RTE_EXPORT_SYMBOL(rte_bbdev_op_pool_create)
 struct rte_mempool *
 rte_bbdev_op_pool_create(const char *name, enum rte_bbdev_op_type type,
 		unsigned int num_elements, unsigned int cache_size,
-		int socket_id)
+		int numa_id)
 {
 	struct rte_bbdev_op_pool_private *priv;
 	struct rte_mempool *mp;
@@ -975,7 +975,7 @@ rte_bbdev_op_pool_create(const char *name, enum rte_bbdev_op_type type,
 
 	mp = rte_mempool_create(name, num_elements, get_bbdev_op_size(type),
 			cache_size, sizeof(struct rte_bbdev_op_pool_private),
-			NULL, NULL, bbdev_op_init, &type, socket_id, 0);
+			NULL, NULL, bbdev_op_init, &type, numa_id, 0);
 	if (mp == NULL) {
 		rte_bbdev_log(ERR,
 				"Failed to create op pool %s (num ops=%u, op size=%u) with error: %s",
@@ -989,8 +989,8 @@ rte_bbdev_op_pool_create(const char *name, enum rte_bbdev_op_type type,
 		return NULL;
 
 	rte_bbdev_log_debug(
-			"Op pool %s created for %u ops (type=%s, cache=%u, socket=%u, size=%u)",
-			name, num_elements, op_type_str, cache_size, socket_id,
+			"Op pool %s created for %u ops (type=%s, cache=%u, numa node=%u, size=%u)",
+			name, num_elements, op_type_str, cache_size, numa_id,
 			get_bbdev_op_size(type));
 
 	priv = (struct rte_bbdev_op_pool_private *)rte_mempool_get_priv(mp);
diff --git a/lib/bbdev/rte_bbdev.h b/lib/bbdev/rte_bbdev.h
index 9fcfbf4c69..4c55d174d7 100644
--- a/lib/bbdev/rte_bbdev.h
+++ b/lib/bbdev/rte_bbdev.h
@@ -101,8 +101,8 @@ rte_bbdev_find_next(uint16_t dev_id);
  *   The identifier of the device.
  * @param num_queues
  *   Number of queues to configure on device.
- * @param socket_id
- *   ID of a socket which will be used to allocate memory.
+ * @param numa_id
+ *   ID of a NUMA node which will be used to allocate memory.
  *
  * @return
  *   - 0 on success
@@ -112,7 +112,7 @@ rte_bbdev_find_next(uint16_t dev_id);
  *   - -ENOMEM if unable to allocate memory
  */
 int
-rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id);
+rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int numa_id);
 
 /**
  * Enable interrupts.
@@ -133,7 +133,15 @@ rte_bbdev_intr_enable(uint16_t dev_id);
 
 /** Device queue configuration structure */
 struct rte_bbdev_queue_conf {
-	int socket;  /**< NUMA socket used for memory allocation */
+	union {
+		/** NUMA node used for memory allocation */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket;
+	};
 	uint32_t queue_size;  /**< Size of queue */
 	uint8_t priority;  /**< Queue priority */
 	bool deferred_start; /**< Do not start queue when device is started. */
@@ -391,7 +399,15 @@ struct rte_bbdev_driver_info {
 
 /* Structure rte_bbdev_info 8< */
 struct rte_bbdev_info {
-	int socket_id;  /**< NUMA socket that device is on */
+	union {
+		/** NUMA node that device is on */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	const char *dev_name;  /**< Unique device name */
 	const struct rte_device *device; /**< Device Information */
 	uint16_t num_queues;  /**< Number of queues currently configured */
@@ -510,7 +526,15 @@ struct rte_bbdev_data {
 	uint16_t num_queues;  /**< Number of currently configured queues */
 	struct rte_bbdev_queue_data *queues;  /**< Queue structures */
 	uint16_t dev_id;  /**< Device ID */
-	int socket_id;  /**< NUMA socket that device is on */
+	union {
+		/** NUMA node that device is on */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	bool started;  /**< Device run-time state */
 	RTE_ATOMIC(uint16_t) process_cnt;  /** Counter of processes using the device */
 };
diff --git a/lib/bbdev/rte_bbdev_op.h b/lib/bbdev/rte_bbdev_op.h
index 02d157ada8..45e8ad6e9a 100644
--- a/lib/bbdev/rte_bbdev_op.h
+++ b/lib/bbdev/rte_bbdev_op.h
@@ -1046,8 +1046,8 @@ rte_bbdev_op_type_str(enum rte_bbdev_op_type op_type);
  * @param cache_size
  *   Number of elements to cache on an lcore, see rte_mempool_create() for
  *   further details about cache size.
- * @param socket_id
- *   Socket to allocate memory on.
+ * @param numa_id
+ *   NUMA node ID to allocate memory on.
  *
  * @return
  *   - Pointer to a mempool on success,
@@ -1056,7 +1056,7 @@ rte_bbdev_op_type_str(enum rte_bbdev_op_type op_type);
 struct rte_mempool *
 rte_bbdev_op_pool_create(const char *name, enum rte_bbdev_op_type type,
 		unsigned int num_elements, unsigned int cache_size,
-		int socket_id);
+		int numa_id);
 
 /**
  * Bulk allocate encode operations from a mempool with parameter defaults reset.
diff --git a/lib/bbdev/rte_bbdev_pmd.h b/lib/bbdev/rte_bbdev_pmd.h
index 4f14909e22..0fc94c86c5 100644
--- a/lib/bbdev/rte_bbdev_pmd.h
+++ b/lib/bbdev/rte_bbdev_pmd.h
@@ -76,7 +76,7 @@ rte_bbdev_get_named_dev(const char *name);
 
 /** @internal Function used to configure device memory. */
 typedef int (*rte_bbdev_setup_queues_t)(struct rte_bbdev *dev,
-		uint16_t num_queues, int socket_id);
+		uint16_t num_queues, int numa_id);
 
 /** @internal Function used to configure interrupts for a device. */
 typedef int (*rte_bbdev_intr_enable_t)(struct rte_bbdev *dev);
-- 
2.55.0

