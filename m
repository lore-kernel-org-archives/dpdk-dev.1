Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB99C44501
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 08:31:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E00964026C;
	Wed, 21 Jan 2026 09:31:49 +0100 (CET)
Received: from mx1.wirefilter.com (mx1.wirefilter.com [82.147.223.86])
 by mails.dpdk.org (Postfix) with ESMTP id 863EA4013F;
 Tue, 20 Jan 2026 13:05:54 +0100 (CET)
Received: from egw.wirefilter.com (localhost.localdomain [127.0.0.1])
 by mx1.wirefilter.com (Proxmox) with ESMTP id 90561C14E6;
 Tue, 20 Jan 2026 15:05:53 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wirefilter.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=default; bh=VUj4R/U49v85DbhlH
 jOI4jRtclNhtBE2zm1WLtXURvA=; b=GqtfXBHJGpCinyzTNKZdP3AjORF+tyOkZ
 nmAwN0CVzvU1pCDO+9MheK60OK0KnaCuCnfQgCQIIGZx4UishwF0PpSGiwfsLouX
 fRE4TlOC3hts6xJebDEJz1KNDysfnzrhVxNjeWTlJGukcHvc//q9LB7RbUeAKrPO
 f5ZTw1rOFQrCGyaPhuGCJr0+8rNHdfIRGjoIttaYztM7rxUlwhthsi89eKy5Cj35
 vUltDXuo4c4vTQehcR8Na0k20aHpPZ07hWYXugyvS/3YzyPaymb5yjDR3RcvcixA
 Cs+hvyKVNJVaNe9XlBxcL/mEzanfQ0vqRL9pp0jYttZxqeWShVKlQ==
Date: Tue, 20 Jan 2026 15:05:53 +0300 (AST)
From: Mohand Alrasheed <mrasheed@wirefilter.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>
Cc: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, 
 Matan Azrad <matan@nvidia.com>, dev@dpdk.org, 
 Raslan Darawsheh <rasland@nvidia.com>, 
 Xiaoyu Min <jackmin@nvidia.com>, stable@dpdk.org
Message-ID: <24903824.20108042.1768910753339.JavaMail.zimbra@wirefilter.com>
In-Reply-To: <20260112172324.1523241-1-dsosnowski@nvidia.com>
References: <20260112172324.1523241-1-dsosnowski@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix HW flow counter query
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.1.1.3]
X-Mailer: Zimbra 10.1.13_GA_4837 (ZimbraModernWebClient - SAF26
 (Mac)/10.1.13_GA_4837)
Thread-Topic: net/mlx5: fix HW flow counter query
Thread-Index: NHITlmOg48gzxEWZiRDMdU+ynXpZmQ==
X-Mailman-Approved-At: Wed, 21 Jan 2026 09:31:48 +0100
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

Hi Dariusz and Xiaoyu,

Thank you both for identifying and fixing these issues.

I tested the patch locally. Based on my testing, the HW flow counter data is consistent and the issue I observed is resolved.

Best regards,
Mohand

-----Original Message-----
From: Dariusz <dsosnowski@nvidia.com>
To: Viacheslav <viacheslavo@nvidia.com>; Bing <bingz@nvidia.com>; Ori <orika@nvidia.com>; Suanming <suanmingm@nvidia.com>; Matan <matan@nvidia.com>
Cc: dev <dev@dpdk.org>; Raslan <rasland@nvidia.com>; Xiaoyu <jackmin@nvidia.com>; stable <stable@dpdk.org>; Mohand <mrasheed@wirefilter.com>
Date: Monday, 12 January 2026 11:56 PM +03
Subject: [PATCH] net/mlx5: fix HW flow counter query


From: Xiaoyu Min <jackmin@nvidia.com>

There are a couple of issues in the logic used by
counter service thread to refresh flow counter values
in HW Steering mode:

1. Flow counter offset in bulk is not taken into account
   correctly during query.
2. Number of WQEs used up during query is not tracked correctly.

Regarding the 1st issue, HW flow counters are queried by posting WQEs.
Each WQE queries 4 flow counters at once.
Flow counters are addressed by base ID (ASO object ID)
and offset (divided by 4).
During periodic counter refresh, mlx5 PMD fills whole queue with WQEs
and waits for query completion. This is repeated until all known
counters are refreshed.

The issue is that, between different iterations the base offset was not
adjusted. This lead to the same 64k counters (max achievable through
single queue) were being queried. Any flow counters above that limit
would get incorrect values.
This patch addresses that by adding proper offset calculation during
query loop.

Regarding the 2nd issue, tracking of how many counters were really
queried during single loop was incorrect.
In case when there weren't enough free WQEs in the queue,
fewer counters were queried than expected.
This mismatch was not taken into account, which in the resulted in some
counters not being queried.
This patch addresses that by adding proper reporting of the number
of queried counters to mlx5_aso_cnt_sq_enqueue_burst().

Fixes: 4d368e1da3a4 ("net/mlx5: support flow counter action for HWS")
Cc: stable@dpdk.org

Reported-by: Mohand Alrasheed <mrasheed@wirefilter.com>
Signed-off-by: Xiaoyu Min <jackmin@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 .mailmap                         |  1 +
 drivers/net/mlx5/mlx5_flow_aso.c | 44 +++++++++++++++++---------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2f089326ff..0f537306ba 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1108,6 +1108,7 @@ Mohamed Feroz Abdul Majeeth <mabdulmajeet@marvell.com>
 Mohammad Abdul Awal <mohammad.abdul.awal@intel.com>
 Mohammad Iqbal Ahmad <mahmad@marvell.com>
 Mohammed Gamal <mgamal@redhat.com>
+Mohand Alrasheed <mrasheed@wirefilter.com>
 Mohsin Kazmi <mohsin.kazmi14@gmail.com>
 Mohsin Mazhar Shaikh <mohsinmazhar_shaikh@trendmicro.com>
 Mohsin Shaikh <mohsinshaikh@niometrics.com>
diff --git a/drivers/net/mlx5/mlx5_flow_aso.c b/drivers/net/mlx5/mlx5_flow_aso.c
index feca8c3e89..5e2a81ef9c 100644
--- a/drivers/net/mlx5/mlx5_flow_aso.c
+++ b/drivers/net/mlx5/mlx5_flow_aso.c
@@ -1851,37 +1851,37 @@ mlx5_aso_cnt_queue_uninit(struct mlx5_dev_ctx_shared *sh)
 	sh->cnt_svc->aso_mng.sq_num = 0;
 }
 
-static uint16_t
+static uint32_t
+aso_hw_id(uint32_t base, uint32_t offset)
+{
+	return (base + offset) / 4;
+}
+
+static uint32_t
 mlx5_aso_cnt_sq_enqueue_burst(struct mlx5_hws_cnt_pool *cpool,
 		struct mlx5_dev_ctx_shared *sh,
 		struct mlx5_aso_sq *sq, uint32_t n,
-		uint32_t offset, uint32_t dcs_id_base)
+		uint32_t stats_mem_idx, uint32_t aso_id)
 {
 	volatile struct mlx5_aso_wqe *wqe;
 	uint16_t size = 1 << sq->log_desc_n;
 	uint16_t mask = size - 1;
 	uint16_t max;
-	uint32_t upper_offset = offset;
 	uint64_t addr;
-	uint32_t ctrl_gen_id = 0;
 	uint8_t opcmod = sh->cdev->config.hca_attr.flow_access_aso_opc_mod;
 	rte_be32_t lkey = rte_cpu_to_be_32(cpool->raw_mng->mr.lkey);
 	uint16_t aso_n = (uint16_t)(RTE_ALIGN_CEIL(n, 4) / 4);
-	uint32_t ccntid;
+	uint32_t bursted_cnts = 0;
 
 	max = RTE_MIN(size - (uint16_t)(sq->head - sq->tail), aso_n);
 	if (unlikely(!max))
 		return 0;
-	upper_offset += (max * 4);
 	/* Because only one burst at one time, we can use the same elt. */
 	sq->elts[0].burst_size = max;
-	ctrl_gen_id = dcs_id_base;
-	ctrl_gen_id /= 4;
 	do {
-		ccntid = upper_offset - max * 4;
 		wqe = &sq->sq_obj.aso_wqes[sq->head & mask];
 		rte_prefetch0(&sq->sq_obj.aso_wqes[(sq->head + 1) & mask]);
-		wqe->general_cseg.misc = rte_cpu_to_be_32(ctrl_gen_id);
+		wqe->general_cseg.misc = rte_cpu_to_be_32(aso_id);
 		wqe->general_cseg.flags = RTE_BE32(MLX5_COMP_ONLY_FIRST_ERR <<
 							 MLX5_COMP_MODE_OFFSET);
 		wqe->general_cseg.opcode = rte_cpu_to_be_32
@@ -1891,22 +1891,24 @@ mlx5_aso_cnt_sq_enqueue_burst(struct mlx5_hws_cnt_pool *cpool,
 						 (sq->pi <<
 						  WQE_CSEG_WQE_INDEX_OFFSET));
 		addr = (uint64_t)RTE_PTR_ADD(cpool->raw_mng->raw,
-				ccntid * sizeof(struct flow_counter_stats));
+				stats_mem_idx * sizeof(struct flow_counter_stats));
 		wqe->aso_cseg.va_h = rte_cpu_to_be_32((uint32_t)(addr >> 32));
 		wqe->aso_cseg.va_l_r = rte_cpu_to_be_32((uint32_t)addr | 1u);
 		wqe->aso_cseg.lkey = lkey;
 		sq->pi += 2; /* Each WQE contains 2 WQEBB's. */
 		sq->head++;
 		sq->next++;
-		ctrl_gen_id++;
+		aso_id++;
 		max--;
+		stats_mem_idx += 4;
 	} while (max);
 	wqe->general_cseg.flags = RTE_BE32(MLX5_COMP_ALWAYS <<
 							 MLX5_COMP_MODE_OFFSET);
 	mlx5_doorbell_ring(&sh->tx_uar.bf_db, *(volatile uint64_t *)wqe,
 			   sq->pi, &sq->sq_obj.db_rec[MLX5_SND_DBR],
 			   !sh->tx_uar.dbnc);
-	return sq->elts[0].burst_size;
+	bursted_cnts = RTE_MIN((uint32_t)(sq->elts[0].burst_size * 4), n);
+	return bursted_cnts;
 }
 
 static uint16_t
@@ -1949,7 +1951,7 @@ mlx5_aso_cnt_completion_handle(struct mlx5_aso_sq *sq)
 	return I;
 }
 
-static uint16_t
+static uint64_t
 mlx5_aso_cnt_query_one_dcs(struct mlx5_dev_ctx_shared *sh,
 			   struct mlx5_hws_cnt_pool *cpool,
 			   uint8_t dcs_idx, uint32_t num)
@@ -1958,7 +1960,7 @@ mlx5_aso_cnt_query_one_dcs(struct mlx5_dev_ctx_shared *sh,
 	uint64_t cnt_num = cpool->dcs_mng.dcs[dcs_idx].batch_sz;
 	uint64_t left;
 	uint32_t iidx = cpool->dcs_mng.dcs[dcs_idx].iidx;
-	uint32_t offset;
+	uint32_t bursted, dcs_offset = 0;
 	uint16_t mask;
 	uint16_t sq_idx;
 	uint64_t burst_sz = (uint64_t)(1 << MLX5_ASO_CNT_QUEUE_LOG_DESC) * 4 *
@@ -1978,12 +1980,12 @@ mlx5_aso_cnt_query_one_dcs(struct mlx5_dev_ctx_shared *sh,
 				continue;
 			}
 			n = RTE_MIN(left, qburst_sz);
-			offset = cnt_num - left;
-			offset += iidx;
-			mlx5_aso_cnt_sq_enqueue_burst(cpool, sh,
-					&sh->cnt_svc->aso_mng.sqs[sq_idx], n,
-					offset, dcs_id);
-			left -= n;
+			bursted = mlx5_aso_cnt_sq_enqueue_burst(cpool, sh,
+							&sh->cnt_svc->aso_mng.sqs[sq_idx], n,
+							iidx, aso_hw_id(dcs_id, dcs_offset));
+			left -= bursted;
+			dcs_offset += bursted;
+			iidx += bursted;
 		}
 		do {
 			for (sq_idx = 0; sq_idx < sh->cnt_svc->aso_mng.sq_num;
-- 
2.47.3



