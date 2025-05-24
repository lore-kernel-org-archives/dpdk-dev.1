Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7E5C54E71
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 May 2025 09:13:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDA4140E2B;
	Sat, 24 May 2025 11:13:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 3863040E17
 for <dev@dpdk.org>; Sat, 24 May 2025 11:13:50 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54O9DUbd012629;
 Sat, 24 May 2025 02:13:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 RjE6FDOiXwqsgcvb4h+/LzREaR3PnXYoNhQTU9lGbs=; b=Xst7vKgnifPQWX1eF
 5mgHGIGSWQmb6cFaz60dehFsrl52yliaAEM2VQ1y0tMA5Wp9j7NdwMu9IORcQYNY
 dcoegjvLoxFyMzw2rfySIQUXKMoAQoNJw0MZDLyE4FX/I3Yr9z2k17amy2sbcgSX
 GCn9sQYIXTCLfp33BiAxAFRY/Vm6xCn3/364i8Z4wESinn7xCHQKNZuOLz4iAheI
 uDS7WwButEBOCfYAyGVShFq30qTWrkS7GTMaKqoWlkYuAaBgBWhtQW0ymSOtDB5r
 udv9o/eTF+nL7DFXEehRoVWfVGxKjpOJast6tGAP3zr1X3VwlRUsu5DoRXXUx5E3
 F2L/w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46u1pc0ma0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 May 2025 02:13:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 24 May 2025 02:13:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 24 May 2025 02:13:47 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 2BF583F707E;
 Sat, 24 May 2025 02:13:42 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Cheng Jiang <honest.jiang@foxmail.com>, "Chengwen
 Feng" <fengchengwen@huawei.com>
CC: <vattunuru@marvell.com>, <g.singh@nxp.com>, <sachin.saxena@nxp.com>,
 <hemant.agrawal@nxp.com>, <bruce.richardson@intel.com>,
 <kevin.laatz@intel.com>, <conor.walsh@intel.com>,
 <gmuthukrishn@marvell.com>, <vvelumuri@marvell.com>,
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, "Pavan
 Nikhilesh" <pbhagavatula@marvell.com>
Subject: [25.11 PATCH v3 3/5] app/dma-perf: add option to measure enq deq ops
Date: Sat, 24 May 2025 14:43:13 +0530
Message-ID: <20250524091316.10056-4-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524091316.10056-1-pbhagavatula@marvell.com>
References: <20250519185604.5584-1-pbhagavatula@marvell.com>
 <20250524091316.10056-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: d7upgl837DDLpyuBsYNnajY58zB-u_VW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI0MDA4MyBTYWx0ZWRfX1ZvS/S425S8i
 ts9uac721CVF/ROQYX3fpLPkRmDj4chm3bojGFLhawfqeSeodztZ1D4rGoT0U0E3AZVQBRfsoWf
 gA1/rRJugQRQ/duPOM6Agk7kbyknu31tTUYci0fXPgHavjJ1CUvdm5urc98or55jB1xkL0kInBq
 D7l68xMJ8HPjnZ3OMV6t93q3sZlmna7Yp1G+qywCkVYz9dt+S4dKzF3do7ZxYaWmxDS6qseBDDi
 ATfsacHQ9t1sUHfHyaCMuZbzMQqFnNjwi/jk77c3VA+e9tF9kVKRZPBCE7LbeYPV+qXyT0hlCx0
 1JipeqGmeYRRJx88jb2c7BlydDDaAsSD4IB7W7MnCEYMqbmGZ7PwMa9JlcBwjBvFw09dtGuJfAc
 R4s3UGOzBSAWq33UWbNgiCb35uj7of5XbmHY23WydRhSWCZciy2NjZ1zn94LOrYM6vfL59Nk
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=68318dcd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=SSXLivwrg0eM4BYXrbIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: d7upgl837DDLpyuBsYNnajY58zB-u_VW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-24_04,2025-05-22_01,2025-03-28_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

This patch adds a option to measure performanc of
enq/deq operations in the benchmark app.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 app/test-dma-perf/benchmark.c | 137 +++++++++++++++++++++++++++++++---
 app/test-dma-perf/config.ini  |   3 +
 app/test-dma-perf/main.c      |  13 +++-
 app/test-dma-perf/main.h      |   1 +
 doc/guides/tools/dmaperf.rst  |   5 ++
 5 files changed, 148 insertions(+), 11 deletions(-)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index 6d617ea200..4425fc97cf 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -54,6 +54,7 @@ struct lcore_params {
 	struct rte_mbuf **srcs;
 	struct rte_mbuf **dsts;
 	struct sge_info sge;
+	struct rte_dma_op **dma_ops;
 	volatile struct worker_info worker_info;
 };
 
@@ -198,6 +199,16 @@ configure_dmadev_queue(uint32_t dev_id, struct test_configure *cfg, uint8_t sges
 	if (vchan_data_populate(dev_id, &qconf, cfg, dev_num) != 0)
 		rte_exit(EXIT_FAILURE, "Error with vchan data populate.\n");
 
+	if (rte_dma_info_get(dev_id, &info) != 0)
+		rte_exit(EXIT_FAILURE, "Error with getting device info.\n");
+
+	if (cfg->use_ops && !(info.dev_capa & RTE_DMA_CAPA_OPS_ENQ_DEQ))
+		rte_exit(EXIT_FAILURE, "Error with device %s not support enq_deq ops.\n",
+			 info.dev_name);
+
+	if (cfg->use_ops)
+		dev_config.flags = RTE_DMA_CFG_FLAG_ENQ_DEQ;
+
 	if (rte_dma_configure(dev_id, &dev_config) != 0)
 		rte_exit(EXIT_FAILURE, "Error with dma configure.\n");
 
@@ -395,6 +406,61 @@ do_dma_sg_mem_copy(void *p)
 	return 0;
 }
 
+static inline int
+do_dma_enq_deq_mem_copy(void *p)
+{
+#define DEQ_SZ 64
+	struct lcore_params *para = (struct lcore_params *)p;
+	volatile struct worker_info *worker_info = &(para->worker_info);
+	struct rte_dma_op **dma_ops = para->dma_ops;
+	uint16_t kick_batch = para->kick_batch, sz;
+	uint16_t enq, deq, poll_cnt;
+	uint64_t tenq, tdeq;
+	const uint16_t dev_id = para->dev_id;
+	uint32_t nr_buf = para->nr_buf;
+	struct rte_dma_op *op[DEQ_SZ];
+	uint32_t i;
+
+	worker_info->stop_flag = false;
+	worker_info->ready_flag = true;
+
+	while (!worker_info->start_flag)
+		;
+
+	if (kick_batch > nr_buf)
+		kick_batch = nr_buf;
+
+	tenq = 0;
+	tdeq = 0;
+	while (1) {
+		for (i = 0; i < nr_buf; i += kick_batch) {
+			sz = RTE_MIN(nr_buf - i, kick_batch);
+			enq = rte_dma_enqueue_ops(dev_id, 0, &dma_ops[i], sz);
+			while (enq < sz) {
+				do {
+					deq = rte_dma_dequeue_ops(dev_id, 0, op, DEQ_SZ);
+					tdeq += deq;
+				} while (deq);
+				enq += rte_dma_enqueue_ops(dev_id, 0, &dma_ops[i + enq], sz - enq);
+				if (worker_info->stop_flag)
+					break;
+			}
+			tenq += enq;
+
+			worker_info->total_cpl += enq;
+		}
+
+		if (worker_info->stop_flag)
+			break;
+	}
+
+	poll_cnt = 0;
+	while ((tenq != tdeq) && (poll_cnt++ < POLL_MAX))
+		tdeq += rte_dma_dequeue_ops(dev_id, 0, op, DEQ_SZ);
+
+	return 0;
+}
+
 static inline int
 do_cpu_mem_copy(void *p)
 {
@@ -436,16 +502,17 @@ dummy_free_ext_buf(void *addr, void *opaque)
 }
 
 static int
-setup_memory_env(struct test_configure *cfg,
-			 struct rte_mbuf ***srcs, struct rte_mbuf ***dsts,
-			 struct rte_dma_sge **src_sges, struct rte_dma_sge **dst_sges)
+setup_memory_env(struct test_configure *cfg, struct rte_mbuf ***srcs, struct rte_mbuf ***dsts,
+		 struct rte_dma_sge **src_sges, struct rte_dma_sge **dst_sges,
+		 struct rte_dma_op ***dma_ops)
 {
 	unsigned int cur_buf_size = cfg->buf_size.cur;
 	unsigned int buf_size = cur_buf_size + RTE_PKTMBUF_HEADROOM;
-	unsigned int nr_sockets;
+	bool is_src_numa_incorrect, is_dst_numa_incorrect;
 	uint32_t nr_buf = cfg->nr_buf;
+	unsigned int nr_sockets;
+	uintptr_t ops;
 	uint32_t i;
-	bool is_src_numa_incorrect, is_dst_numa_incorrect;
 
 	nr_sockets = rte_socket_count();
 	is_src_numa_incorrect = (cfg->src_numa_node >= nr_sockets);
@@ -540,6 +607,34 @@ setup_memory_env(struct test_configure *cfg,
 			if (!((i+1) % nb_dst_sges))
 				(*dst_sges)[i].length += (cur_buf_size % nb_dst_sges);
 		}
+
+		if (cfg->use_ops) {
+
+			nr_buf /= RTE_MAX(nb_src_sges, nb_dst_sges);
+			*dma_ops = rte_zmalloc(NULL, nr_buf * (sizeof(struct rte_dma_op *)),
+					       RTE_CACHE_LINE_SIZE);
+			if (*dma_ops == NULL) {
+				printf("Error: dma_ops container malloc failed.\n");
+				return -1;
+			}
+
+			ops = (uintptr_t)rte_zmalloc(
+				NULL,
+				nr_buf * (sizeof(struct rte_dma_op) + ((nb_src_sges + nb_dst_sges) *
+								       sizeof(struct rte_dma_sge))),
+				RTE_CACHE_LINE_SIZE);
+			if (ops == 0) {
+				printf("Error: dma_ops malloc failed.\n");
+				return -1;
+			}
+
+			for (i = 0; i < nr_buf; i++)
+				(*dma_ops)[i] =
+					(struct rte_dma_op *)(ops +
+							      (i * (sizeof(struct rte_dma_op) +
+								    ((nb_src_sges + nb_dst_sges) *
+								     sizeof(struct rte_dma_sge)))));
+		}
 	}
 
 	return 0;
@@ -582,8 +677,12 @@ get_work_function(struct test_configure *cfg)
 	if (cfg->is_dma) {
 		if (!cfg->is_sg)
 			fn = do_dma_plain_mem_copy;
-		else
-			fn = do_dma_sg_mem_copy;
+		else {
+			if (cfg->use_ops)
+				fn = do_dma_enq_deq_mem_copy;
+			else
+				fn = do_dma_sg_mem_copy;
+		}
 	} else {
 		fn = do_cpu_mem_copy;
 	}
@@ -680,6 +779,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 	struct rte_dma_sge *src_sges = NULL, *dst_sges = NULL;
 	struct vchan_dev_config *vchan_dev = NULL;
 	struct lcore_dma_map_t *lcore_dma_map = NULL;
+	struct rte_dma_op **dma_ops = NULL;
 	unsigned int buf_size = cfg->buf_size.cur;
 	uint16_t kick_batch = cfg->kick_batch.cur;
 	uint16_t nb_workers = cfg->num_worker;
@@ -690,13 +790,13 @@ mem_copy_benchmark(struct test_configure *cfg)
 	float mops, mops_total;
 	float bandwidth, bandwidth_total;
 	uint32_t nr_sgsrc = 0, nr_sgdst = 0;
-	uint32_t nr_buf;
+	uint32_t nr_buf, nr_ops;
 	int ret = 0;
 
 	nr_buf = align_buffer_count(cfg, &nr_sgsrc, &nr_sgdst);
 	cfg->nr_buf = nr_buf;
 
-	if (setup_memory_env(cfg, &srcs, &dsts, &src_sges, &dst_sges) < 0)
+	if (setup_memory_env(cfg, &srcs, &dsts, &src_sges, &dst_sges, &dma_ops) < 0)
 		goto out;
 
 	if (cfg->is_dma)
@@ -751,6 +851,25 @@ mem_copy_benchmark(struct test_configure *cfg)
 				goto out;
 		}
 
+		if (cfg->is_sg && cfg->use_ops) {
+			nr_ops = nr_buf / RTE_MAX(cfg->nb_src_sges, cfg->nb_dst_sges);
+			lcores[i]->nr_buf = nr_ops / nb_workers;
+			lcores[i]->dma_ops = dma_ops + (nr_ops / nb_workers * i);
+			for (j = 0; j < (nr_ops / nb_workers); j++) {
+				for (k = 0; k < cfg->nb_src_sges; k++)
+					lcores[i]->dma_ops[j]->src_dst_seg[k] =
+						lcores[i]->sge.srcs[(j * cfg->nb_src_sges) + k];
+
+				for (k = 0; k < cfg->nb_dst_sges; k++)
+					lcores[i]->dma_ops[j]->src_dst_seg[k + cfg->nb_src_sges] =
+						lcores[i]->sge.dsts[(j * cfg->nb_dst_sges) + k];
+
+				lcores[i]->dma_ops[j]->nb_src = cfg->nb_src_sges;
+				lcores[i]->dma_ops[j]->nb_dst = cfg->nb_dst_sges;
+				lcores[i]->dma_ops[j]->vchan = 0;
+			}
+		}
+
 		rte_eal_remote_launch(get_work_function(cfg), (void *)(lcores[i]), lcore_id);
 	}
 
diff --git a/app/test-dma-perf/config.ini b/app/test-dma-perf/config.ini
index 61e49dbae5..fa59f6b140 100644
--- a/app/test-dma-perf/config.ini
+++ b/app/test-dma-perf/config.ini
@@ -52,6 +52,8 @@
 ;
 ; For DMA scatter-gather memory copy, the parameters need to be configured
 ; and they are valid only when type is DMA_MEM_COPY.
+;
+; To use Enqueue Dequeue operations, set ``use_enq_deq_ops=1`` in the configuration.
 
 ; To specify a configuration file, use the "--config" flag followed by the path to the file.
 
@@ -88,6 +90,7 @@ test_seconds=2
 lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
 lcore_dma1=lcore=11,dev=0000:00:04.2,dir=mem2mem
 eal_args=--in-memory --file-prefix=test
+use_enq_deq_ops=0
 
 [case3]
 skip=1
diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 0586b3e1d0..cb4aee878f 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -297,8 +297,8 @@ load_configs(const char *path)
 	char section_name[CFG_NAME_LEN];
 	const char *case_type;
 	const char *lcore_dma;
-	const char *mem_size_str, *buf_size_str, *ring_size_str, *kick_batch_str,
-		*src_sges_str, *dst_sges_str;
+	const char *mem_size_str, *buf_size_str, *ring_size_str, *kick_batch_str, *src_sges_str,
+		*dst_sges_str, *use_dma_ops;
 	const char *skip;
 	struct rte_kvargs *kvlist;
 	int args_nr, nb_vp;
@@ -349,6 +349,15 @@ load_configs(const char *path)
 			continue;
 		}
 
+		if (is_dma) {
+			use_dma_ops =
+				rte_cfgfile_get_entry(cfgfile, section_name, "use_enq_deq_ops");
+			if (use_dma_ops != NULL && (atoi(use_dma_ops) == 1))
+				test_case->use_ops = true;
+			else
+				test_case->use_ops = false;
+		}
+
 		test_case->is_dma = is_dma;
 		test_case->src_numa_node = (int)atoi(rte_cfgfile_get_entry(cfgfile,
 								section_name, "src_numa_node"));
diff --git a/app/test-dma-perf/main.h b/app/test-dma-perf/main.h
index 59eb648b3d..d6cc613250 100644
--- a/app/test-dma-perf/main.h
+++ b/app/test-dma-perf/main.h
@@ -58,6 +58,7 @@ struct test_configure {
 	uint16_t opcode;
 	bool is_dma;
 	bool is_sg;
+	bool use_ops;
 	struct lcore_dma_config dma_config[MAX_WORKER_NB];
 	struct test_configure_entry mem_size;
 	struct test_configure_entry buf_size;
diff --git a/doc/guides/tools/dmaperf.rst b/doc/guides/tools/dmaperf.rst
index b7ff41065f..7abbbf9260 100644
--- a/doc/guides/tools/dmaperf.rst
+++ b/doc/guides/tools/dmaperf.rst
@@ -69,6 +69,7 @@ along with the application to demonstrate all the parameters.
    lcore_dma1=lcore=11,dev=0000:00:04.2,dir=dev2mem,raddr=0x200000000,coreid=1,pfid=2,vfid=3
    lcore_dma2=lcore=12,dev=0000:00:04.3,dir=mem2dev,raddr=0x200000000,coreid=1,pfid=2,vfid=3
    eal_args=--in-memory --file-prefix=test
+   use_enq_deq_ops=0
 
 The configuration file is divided into multiple sections, each section represents a test case.
 The four mandatory variables ``mem_size``, ``buf_size``, ``dma_ring_size``, and ``kick_batch``
@@ -83,6 +84,7 @@ The variables for mem2dev and dev2mem copy are
 and can vary for each device.
 
 For scatter-gather copy test ``dma_src_sge``, ``dma_dst_sge`` must be configured.
+Enqueue and dequeue operations can be enabled by setting ``use_enq_deq_ops=1``.
 
 Each case can only have one variable change,
 and each change will generate a scenario, so each case can have multiple scenarios.
@@ -170,6 +172,9 @@ Configuration Parameters
 ``eal_args``
   Specifies the EAL arguments.
 
+  ``use_enq_deq_ops``
+  Specifies whether to use enqueue/dequeue operations.
+  ``0`` indicates to not use and ``1`` to use.
 
 Running the Application
 -----------------------
-- 
2.43.0

