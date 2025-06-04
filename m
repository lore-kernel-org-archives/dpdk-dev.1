Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26DDC5B549
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 06:32:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FA104014F;
	Fri,  6 Jun 2025 08:32:52 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 7C27142DF1
 for <dev@dpdk.org>; Wed,  4 Jun 2025 18:41:40 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5548Vu6J010362;
 Wed, 4 Jun 2025 16:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Dbqy7wq5ENE
 xfDD81wXUTEQoNGBFBy6unaJk07/IFGg=; b=QT4PER3nVNP8znCJa7qr6rxpIty
 OQi3fLLDqG1khMB7XDgtt8yxQIRnleWSiiY2wG0T9XM+9oSA4Qcf9SYWkN46Zufy
 IEzoGx8mSNGPQ4cZ2eoIEeDExueTxKTl0vvd3/mTPGUtFW1VQiH56AIWOyvBCKJx
 fmW+5q3haoOrngap9PqeC4adfLMxpHCVp8N0yMaKSylI8T5XsgGDMrgyNuqiRp7t
 5zqa89DXpqTxEqzs+EMUAB2LLdh4DL0t0o+Ih1tND35QIGZpomLaswtgbxgfXUTs
 kZQfILjFyEf+yAlW2vGsU+fxFuOxvc7gKv2/IgEurcY/ukOjH5rk7JQmolA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8ypq8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 16:41:39 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 554GfcCk028167; 
 Wed, 4 Jun 2025 16:41:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 4720pv666p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 16:41:38 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 554GfcYp028158;
 Wed, 4 Jun 2025 16:41:38 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 554GfbCQ028149
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Jun 2025 16:41:38 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id 6E327400AC; Wed,  4 Jun 2025 10:41:37 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH] app/compress-perf: support dictionary files
Date: Wed,  4 Jun 2025 10:41:34 -0600
Message-Id: <20250604164134.776009-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250530210956.1207580-1-svaze@qti.qualcomm.com>
References: <20250530210956.1207580-1-svaze@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEyNyBTYWx0ZWRfXzb6Ea+4ELSok
 hVYanlOuQ5yohqnmLA44kSrOEx+H2k/eQPZ6yQ2bE9iQfeSjgeSWOFLCyL9OX9b3Hm7hhWI7xdb
 R76I946aC2ug7VkKS9GGGOzPncm1avmuDRTLwAbp6vUToJXBYjO40lZRXcArCEylQLx0V1SLN6D
 eUfmZ4q8KZ3AEPSn6moXGZ8A1CYsXkRsWWYZKJI0ZwgJ9HQm2d8OUGA3+9Fc994qlH2SvHCTJyR
 phrV5aQG5+9K5JESQvUBfusUBFJmEod9K/YYRAdhkzi+EwGW2KylW2JKsdhIYq/cS+u7L4zTWo6
 O/nvGRqnCKF+Z+OTjMPovZZKSao0PBM9zB1Qh7h8pPXTMnFfJfUjzKD0Xi9cLoswKayR1lrRpl7
 01cJbcqjN764cJcc5cuU+E95HKZPN1BobHu28AQdPB931YioH3LMgIY21Zx2pQd9qKafxvNa
X-Proofpoint-ORIG-GUID: tIFVHVomf4lkIABtch_u7DltHfDwxLNg
X-Proofpoint-GUID: tIFVHVomf4lkIABtch_u7DltHfDwxLNg
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=68407743 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=6IFa9wvqVegA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=rmHwnBcX-epW8xLmar0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040127
X-Mailman-Approved-At: Fri, 06 Jun 2025 08:32:51 +0200
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

compress/zlib: support PDCP checksum

compress/zlib: support zlib dictionary

compressdev: add PDCP checksum

compressdev: support zlib dictionary

Adds support to provide predefined dictionaries to zlib. Handles setting
and getting of dictionaries using zlib apis. Also includes support to
read dictionary files

Adds support for passing in and validationg 3GPP PDCP spec defined
checksums as defined under the Uplink Data Compression(UDC) feature.
Changes also include functions that do inflate or deflate specific
checksum operations.

Introduces new members to compression api structures to allow setting
predefined dictionaries

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---

diff --git a/app/test-compress-perf/comp_perf_options.h b/app/test-compress-perf/comp_perf_options.h
index 828a730..4c34dcd 100644
--- a/app/test-compress-perf/comp_perf_options.h
+++ b/app/test-compress-perf/comp_perf_options.h
@@ -21,6 +21,7 @@ enum cleanup_st {
 	ST_TEST_DATA,
 	ST_COMPDEV,
 	ST_INPUT_DATA,
+	ST_DICTIONARY_DATA,
 	ST_MEMORY_ALLOC,
 	ST_DURING_TEST
 };
@@ -48,10 +49,13 @@ struct range_list {
 struct comp_test_data {
 	char driver_name[RTE_DEV_NAME_MAX_LEN];
 	char input_file[PATH_MAX];
+	char dictionary_file[PATH_MAX];
 	enum cperf_test_type test;
 
 	uint8_t *input_data;
 	size_t input_data_sz;
+	uint8_t *dictionary_data;
+	size_t dictionary_data_sz;
 	uint16_t nb_qps;
 	uint16_t seg_sz;
 	uint16_t out_seg_sz;
diff --git a/app/test-compress-perf/comp_perf_options_parse.c b/app/test-compress-perf/comp_perf_options_parse.c
index 6d8c370..37205ad 100644
--- a/app/test-compress-perf/comp_perf_options_parse.c
+++ b/app/test-compress-perf/comp_perf_options_parse.c
@@ -31,6 +31,7 @@
 #define CPERF_LEVEL		("compress-level")
 #define CPERF_WINDOW_SIZE	("window-sz")
 #define CPERF_EXTERNAL_MBUFS	("external-mbufs")
+#define CPERF_DICTIONARY	("dictionary")
 
 /* cyclecount-specific options */
 #define CPERF_CYCLECOUNT_DELAY_US ("cc-delay-us")
@@ -71,6 +72,7 @@ usage(char *progname)
 		"		keeping the data directly in mbuf area\n"
 		" --cc-delay-us N: delay between enqueue and dequeue operations in microseconds\n"
 		"		valid only for cyclecount perf test (default: 500 us)\n"
+		" --dictionary NAME: file with dictionary\n"
 		" -h: prints this help\n",
 		progname);
 }
@@ -610,6 +612,18 @@ parse_external_mbufs(struct comp_test_data *test_data,
 }
 
 static int
+parse_dictionary_file(struct comp_test_data *test_data, const char *arg)
+{
+	if (strlen(arg) > (sizeof(test_data->dictionary_file) - 1))
+		return -1;
+
+	strlcpy(test_data->dictionary_file, arg, sizeof(test_data->dictionary_file));
+
+	return 0;
+}
+
+
+static int
 parse_cyclecount_delay_us(struct comp_test_data *test_data,
 			const char *arg)
 {
@@ -647,6 +661,7 @@ static struct option lgopts[] = {
 	{ CPERF_LEVEL, required_argument, 0, 0 },
 	{ CPERF_WINDOW_SIZE, required_argument, 0, 0 },
 	{ CPERF_EXTERNAL_MBUFS, 0, 0, 0 },
+	{ CPERF_DICTIONARY, required_argument, 0, 0 },
 	{ CPERF_CYCLECOUNT_DELAY_US, required_argument, 0, 0 },
 	{ NULL, 0, 0, 0 }
 };
@@ -671,6 +686,7 @@ comp_perf_opts_parse_long(int opt_idx, struct comp_test_data *test_data)
 		{ CPERF_LEVEL,		parse_level },
 		{ CPERF_WINDOW_SIZE,	parse_window_sz },
 		{ CPERF_EXTERNAL_MBUFS,	parse_external_mbufs },
+		{ CPERF_DICTIONARY,	parse_dictionary_file },
 		{ CPERF_CYCLECOUNT_DELAY_US,	parse_cyclecount_delay_us },
 	};
 	unsigned int i;
diff --git a/app/test-compress-perf/comp_perf_test_common.c b/app/test-compress-perf/comp_perf_test_common.c
index 7848719..ebfe3ad 100644
--- a/app/test-compress-perf/comp_perf_test_common.c
+++ b/app/test-compress-perf/comp_perf_test_common.c
@@ -79,7 +79,7 @@ find_buf_size(uint32_t input_size)
 
 void
 comp_perf_free_memory(struct comp_test_data *test_data,
-		      struct cperf_mem_resources *mem)
+				struct cperf_mem_resources *mem)
 {
 	uint32_t i;
 
@@ -121,7 +121,7 @@ comp_perf_extbuf_free_cb(void *addr __rte_unused, void *opaque __rte_unused)
 
 static const struct rte_memzone *
 comp_perf_make_memzone(const char *name, struct cperf_mem_resources *mem,
-		       unsigned int number, size_t size)
+				 unsigned int number, size_t size)
 {
 	unsigned int socket_id = rte_socket_id();
 	char mz_name[RTE_MEMZONE_NAMESIZE];
@@ -293,7 +293,7 @@ comp_perf_allocate_memory(struct comp_test_data *test_data,
 	}
 
 	mem->total_bufs = DIV_CEIL(test_data->total_segs,
-				   test_data->max_sgl_segs);
+					test_data->max_sgl_segs);
 
 	snprintf(pool_name, sizeof(pool_name), "op_pool_%u_qp_%u",
 			mem->dev_id, mem->qp_id);
@@ -569,9 +569,9 @@ print_test_dynamics(const struct comp_test_data *test_data)
 				" input data) following parameters are"
 				" suggested:\n");
 			printf("	* Segment size: %d\n",
-			       MAX_SEG_SIZE);
+					 MAX_SEG_SIZE);
 			printf("	* Number of segments: %u\n",
-			       opt_total_segs);
+					 opt_total_segs);
 		}
 	} else if (buffer_info.total_buffs == 1) {
 		printf("\nInfo: there is only one op with %u segments -"
diff --git a/app/test-compress-perf/comp_perf_test_verify.c b/app/test-compress-perf/comp_perf_test_verify.c
index 09d97c5..cd4e3e4 100644
--- a/app/test-compress-perf/comp_perf_test_verify.c
+++ b/app/test-compress-perf/comp_perf_test_verify.c
@@ -64,6 +64,7 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 	int res = 0;
 	int allocated = 0;
 	uint32_t out_seg_sz;
+	uint8_t dict[DEFLATE_MAX_WINDOW_SIZE] = {0};
 
 	if (test_data == NULL || !test_data->burst_sz) {
 		RTE_LOG(ERR, USER1,
@@ -71,6 +72,22 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 		return -1;
 	}
 
+	uint16_t window_size = (1ULL << test_data->window_sz);
+
+	if (test_data->dictionary_data) {
+		if (test_data->dictionary_data_sz >= window_size) {
+			memcpy(dict,
+				test_data->dictionary_data
+				+ (test_data->dictionary_data_sz - window_size),
+				window_size);
+		} else if (test_data->dictionary_data_sz < window_size) {
+			memcpy(dict + (window_size - test_data->dictionary_data_sz),
+				test_data->dictionary_data,
+				test_data->dictionary_data_sz);
+		}
+	}
+
+
 	ops = rte_zmalloc_socket(NULL,
 		2 * mem->total_bufs * sizeof(struct rte_comp_op *),
 		0, rte_socket_id());
@@ -91,7 +108,9 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 				.level = test_data->level,
 				.window_size = test_data->window_sz,
 				.chksum = RTE_COMP_CHECKSUM_NONE,
-				.hash_algo = RTE_COMP_HASH_ALGO_NONE
+				.hash_algo = RTE_COMP_HASH_ALGO_NONE,
+				.dictionary = dict,
+				.dictionary_len = window_size
 			}
 		};
 		if (test_data->test_algo == RTE_COMP_ALGO_DEFLATE)
@@ -110,7 +129,9 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 				.algo = test_data->test_algo,
 				.chksum = RTE_COMP_CHECKSUM_NONE,
 				.window_size = test_data->window_sz,
-				.hash_algo = RTE_COMP_HASH_ALGO_NONE
+				.hash_algo = RTE_COMP_HASH_ALGO_NONE,
+				.dictionary = dict,
+				.dictionary_len = window_size
 			}
 		};
 		if (test_data->test_algo == RTE_COMP_ALGO_LZ4)
@@ -120,7 +141,7 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 		input_bufs = mem->comp_bufs;
 		output_bufs = mem->decomp_bufs;
 		out_seg_sz = (test_data->test_op & COMPRESS) ?
-			     test_data->seg_sz : test_data->out_seg_sz;
+				  test_data->seg_sz : test_data->out_seg_sz;
 	}
 
 	/* Create private xform */
@@ -146,7 +167,7 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 
 		while (remaining_ops > 0) {
 			uint16_t num_ops = RTE_MIN(remaining_ops,
-						   test_data->burst_sz);
+							test_data->burst_sz);
 			uint16_t ops_needed = num_ops - ops_unused;
 
 			/*
@@ -155,7 +176,7 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 			 */
 			if ((ops_unused > 0) && (num_enq > 0)) {
 				size_t nb_b_to_mov =
-				      ops_unused * sizeof(struct rte_comp_op *);
+						ops_unused * sizeof(struct rte_comp_op *);
 
 				memmove(ops, &ops[num_enq], nb_b_to_mov);
 			}
@@ -166,7 +187,7 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 						&ops[ops_unused],
 						ops_needed)) {
 				RTE_LOG(ERR, USER1,
-				      "Could not allocate enough operations\n");
+						"Could not allocate enough operations\n");
 				res = -1;
 				goto end;
 			}
@@ -194,8 +215,20 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 					rte_pktmbuf_pkt_len(input_bufs[buf_id]);
 				ops[op_id]->dst.offset = 0;
 				ops[op_id]->flush_flag = RTE_COMP_FLUSH_FINAL;
-				ops[op_id]->input_chksum = buf_id;
+				if ((xform.type == RTE_COMP_DECOMPRESS) &&
+					(xform.decompress.chksum
+						== RTE_COMP_CHECKSUM_3GPP_PDCP_UDC)) {
+					uint8_t *udc_header
+						= rte_pktmbuf_mtod(ops[op_id]->m_src, uint8_t *);
+					ops[op_id]->input_chksum = *udc_header & 0xf;
+					ops[op_id]->src.offset = 1;
+				} else {
+					ops[op_id]->input_chksum = buf_id;
+					ops[op_id]->src.offset = 0;
+				}
 				ops[op_id]->private_xform = priv_xform;
+
+
 			}
 
 			if (unlikely(test_data->perf_comp_force_stop))
@@ -219,9 +252,9 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 			total_enq_ops += num_enq;
 
 			num_deq = rte_compressdev_dequeue_burst(dev_id,
-							   mem->qp_id,
-							   deq_ops,
-							   test_data->burst_sz);
+								mem->qp_id,
+								deq_ops,
+								test_data->burst_sz);
 			total_deq_ops += num_deq;
 
 			for (i = 0; i < num_deq; i++) {
@@ -254,9 +287,9 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 
 				if (read_data_addr != output_data_ptr)
 					rte_memcpy(output_data_ptr,
-						   rte_pktmbuf_mtod(op->m_dst,
-								    uint8_t *),
-						   op->produced);
+							rte_pktmbuf_mtod(op->m_dst,
+									 uint8_t *),
+							op->produced);
 				output_data_ptr += op->produced;
 				output_size += op->produced;
 
@@ -284,7 +317,7 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 				}
 			}
 			rte_mempool_put_bulk(mem->op_pool,
-					     (void **)deq_ops, num_deq);
+						  (void **)deq_ops, num_deq);
 			allocated -= num_deq;
 		}
 
@@ -339,9 +372,9 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 
 				if (read_data_addr != output_data_ptr)
 					rte_memcpy(output_data_ptr,
-						   rte_pktmbuf_mtod(
+							rte_pktmbuf_mtod(
 							op->m_dst, uint8_t *),
-						   op->produced);
+							op->produced);
 				output_data_ptr += op->produced;
 				output_size += op->produced;
 
@@ -368,7 +401,7 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 				}
 			}
 			rte_mempool_put_bulk(mem->op_pool,
-					     (void **)deq_ops, num_deq);
+						  (void **)deq_ops, num_deq);
 			allocated -= num_deq;
 		}
 	}
@@ -382,7 +415,7 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 
 	if (test_data->perf_comp_force_stop) {
 		RTE_LOG(ERR, USER1,
-		      "lcore: %d Perf. test has been aborted by user\n",
+				"lcore: %d Perf. test has been aborted by user\n",
 			mem->lcore_id);
 		res = -1;
 	}
@@ -455,11 +488,11 @@ cperf_verify_test_runner(void *test_ctx)
 		if (rte_atomic_compare_exchange_strong_explicit(&display_once, &exp, 1,
 				rte_memory_order_relaxed, rte_memory_order_relaxed)) {
 			printf("%12s%6s%12s%17s\n",
-			    "lcore id", "Level", "Comp size", "Comp ratio [%]");
+				 "lcore id", "Level", "Comp size", "Comp ratio [%]");
 		}
 		printf("%12u%6u%12zu%17.2f\n",
-		       ctx->mem.lcore_id,
-		       test_data->level, ctx->comp_data_sz, ctx->ratio);
+				 ctx->mem.lcore_id,
+				 test_data->level, ctx->comp_data_sz, ctx->ratio);
 	}
 
 end:
diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c
index fa36612..12dfe64 100644
--- a/app/test-compress-perf/main.c
+++ b/app/test-compress-perf/main.c
@@ -73,14 +73,14 @@ comp_perf_check_capabilities(struct comp_test_data *test_data, uint8_t cdev_id)
 	case RTE_COMP_ALGO_DEFLATE:
 		/* Huffman encoding */
 		if (test_data->huffman_enc == RTE_COMP_HUFFMAN_FIXED &&
-		    (comp_flags & RTE_COMP_FF_HUFFMAN_FIXED) == 0) {
+			 (comp_flags & RTE_COMP_FF_HUFFMAN_FIXED) == 0) {
 			RTE_LOG(ERR, USER1,
 				"Compress device does not supported Fixed Huffman\n");
 			return -1;
 		}
 
 		if (test_data->huffman_enc == RTE_COMP_HUFFMAN_DYNAMIC &&
-		    (comp_flags & RTE_COMP_FF_HUFFMAN_DYNAMIC) == 0) {
+			 (comp_flags & RTE_COMP_FF_HUFFMAN_DYNAMIC) == 0) {
 			RTE_LOG(ERR, USER1,
 				"Compress device does not supported Dynamic Huffman\n");
 			return -1;
@@ -89,15 +89,15 @@ comp_perf_check_capabilities(struct comp_test_data *test_data, uint8_t cdev_id)
 	case RTE_COMP_ALGO_LZ4:
 		/* LZ4 flags */
 		if ((test_data->lz4_flags & RTE_COMP_LZ4_FLAG_BLOCK_CHECKSUM) &&
-		    (comp_flags & RTE_COMP_FF_LZ4_BLOCK_WITH_CHECKSUM) == 0) {
+			 (comp_flags & RTE_COMP_FF_LZ4_BLOCK_WITH_CHECKSUM) == 0) {
 			RTE_LOG(ERR, USER1,
 				"Compress device does not support LZ4 block with checksum\n");
 			return -1;
 		}
 
 		if ((test_data->lz4_flags &
-		     RTE_COMP_LZ4_FLAG_BLOCK_INDEPENDENCE) &&
-		    (comp_flags & RTE_COMP_FF_LZ4_BLOCK_INDEPENDENCE) == 0) {
+			  RTE_COMP_LZ4_FLAG_BLOCK_INDEPENDENCE) &&
+			 (comp_flags & RTE_COMP_FF_LZ4_BLOCK_INDEPENDENCE) == 0) {
 			RTE_LOG(ERR, USER1,
 				"Compress device does not support LZ4 independent blocks\n");
 			return -1;
@@ -154,7 +154,7 @@ comp_perf_initialize_compressdev(struct comp_test_data *test_data,
 			enabled_cdevs, RTE_COMPRESS_MAX_DEVS);
 	if (enabled_cdev_count == 0) {
 		RTE_LOG(ERR, USER1, "No compress devices type %s available,"
-				    " please check the list of specified devices in EAL section\n",
+					 " please check the list of specified devices in EAL section\n",
 				test_data->driver_name);
 		return -EINVAL;
 	}
@@ -234,7 +234,7 @@ comp_perf_initialize_compressdev(struct comp_test_data *test_data,
 					NUM_MAX_INFLIGHT_OPS, socket_id);
 			if (ret < 0) {
 				RTE_LOG(ERR, USER1,
-			      "Failed to setup queue pair %u on compressdev %u",
+					"Failed to setup queue pair %u on compressdev %u",
 					j, cdev_id);
 				return -EINVAL;
 			}
@@ -282,8 +282,8 @@ comp_perf_dump_input_data(struct comp_test_data *test_data)
 	}
 
 	if (!(test_data->test_op & COMPRESS) &&
-	    test_data->input_data_sz >
-	    (size_t) test_data->seg_sz * (size_t) test_data->max_sgl_segs) {
+		 test_data->input_data_sz >
+		 (size_t) test_data->seg_sz * (size_t) test_data->max_sgl_segs) {
 		RTE_LOG(ERR, USER1,
 			"Size of input must be less than total segments\n");
 		goto end;
@@ -335,6 +335,86 @@ comp_perf_dump_input_data(struct comp_test_data *test_data)
 	return ret;
 }
 
+static int
+comp_perf_dump_dictionary_data(struct comp_test_data *test_data)
+{
+	FILE *f = fopen(test_data->dictionary_file, "r");
+	int ret = -1;
+
+	if (f == NULL) {
+		RTE_LOG(ERR, USER1, "Dictionary file not specified\n");
+		test_data->dictionary_data_sz = 0;
+		test_data->dictionary_data = NULL;
+		ret = 0;
+		goto end;
+	}
+
+	if (fseek(f, 0, SEEK_END) != 0) {
+		RTE_LOG(ERR, USER1, "Size of input could not be calculated\n");
+		goto end;
+	}
+	size_t actual_file_sz = ftell(f);
+	/* If extended input data size has not been set,
+	 * input data size = file size
+	 */
+
+	if (test_data->dictionary_data_sz == 0)
+		test_data->dictionary_data_sz = actual_file_sz;
+
+	if (test_data->dictionary_data_sz <= 0 || actual_file_sz <= 0 ||
+			fseek(f, 0, SEEK_SET) != 0) {
+		RTE_LOG(ERR, USER1, "Size of input could not be calculated\n");
+		goto end;
+	}
+
+	test_data->dictionary_data = rte_zmalloc_socket(NULL,
+				test_data->dictionary_data_sz, 0, rte_socket_id());
+
+	if (test_data->dictionary_data == NULL) {
+		RTE_LOG(ERR, USER1, "Memory to hold the data from the dictionary "
+				"file could not be allocated\n");
+		goto end;
+	}
+
+	size_t remaining_data = test_data->dictionary_data_sz;
+	uint8_t *data = test_data->dictionary_data;
+
+	while (remaining_data > 0) {
+		size_t data_to_read = RTE_MIN(remaining_data, actual_file_sz);
+
+		if (fread(data, data_to_read, 1, f) != 1) {
+			RTE_LOG(ERR, USER1, "Input file could not be read\n");
+			goto end;
+		}
+		if (fseek(f, 0, SEEK_SET) != 0) {
+			RTE_LOG(ERR, USER1,
+				"Size of input could not be calculated\n");
+			goto end;
+		}
+		remaining_data -= data_to_read;
+		data += data_to_read;
+	}
+
+	printf("\n");
+	if (test_data->dictionary_data_sz > actual_file_sz)
+		RTE_LOG(INFO, USER1,
+		  "%zu bytes read from file %s, extending the file %.2f times\n",
+			test_data->dictionary_data_sz, test_data->dictionary_file,
+			(double)test_data->dictionary_data_sz/actual_file_sz);
+	else
+		RTE_LOG(INFO, USER1,
+			"%zu bytes read from file %s\n",
+			test_data->dictionary_data_sz, test_data->dictionary_file);
+
+	ret = 0;
+
+end:
+	if (f)
+		fclose(f);
+
+	return ret;
+}
+
 static void
 comp_perf_cleanup_on_signal(int signalNumber __rte_unused)
 {
@@ -407,6 +487,13 @@ main(int argc, char **argv)
 	}
 
 	test_data->cleanup = ST_INPUT_DATA;
+	if (comp_perf_dump_dictionary_data(test_data) < 0) {
+		ret = EXIT_FAILURE;
+		goto end;
+	}
+
+	test_data->cleanup = ST_DICTIONARY_DATA;
+
 
 	if (test_data->level_lst.inc != 0)
 		test_data->level = test_data->level_lst.min;
@@ -418,7 +505,7 @@ main(int argc, char **argv)
 	printf("Input data size = %zu\n", test_data->input_data_sz);
 	if (test_data->test == CPERF_TEST_TYPE_PMDCC)
 		printf("Cycle-count delay = %u [us]\n",
-		       test_data->cyclecount_delay);
+				 test_data->cyclecount_delay);
 
 	test_data->cleanup = ST_DURING_TEST;
 	total_nb_qps = nb_compressdevs * test_data->nb_qps;
@@ -496,12 +583,15 @@ main(int argc, char **argv)
 			i++;
 		}
 		/* fallthrough */
+	case ST_DICTIONARY_DATA:
+		rte_free(test_data->dictionary_data);
+		/* fallthrough */
 	case ST_INPUT_DATA:
 		rte_free(test_data->input_data);
 		/* fallthrough */
 	case ST_COMPDEV:
 		for (i = 0; i < nb_compressdevs &&
-		     i < RTE_COMPRESS_MAX_DEVS; i++) {
+			  i < RTE_COMPRESS_MAX_DEVS; i++) {
 			rte_compressdev_stop(enabled_cdevs[i]);
 			rte_compressdev_close(enabled_cdevs[i]);
 		}
diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_pmd.c
index 92e808e..63466bd 100644
--- a/drivers/compress/zlib/zlib_pmd.c
+++ b/drivers/compress/zlib/zlib_pmd.c
@@ -4,6 +4,7 @@
 
 #include <bus_vdev_driver.h>
 #include <rte_common.h>
+#include <rte_malloc.h>
 
 #include "zlib_pmd_private.h"
 
@@ -15,6 +16,119 @@
 		(data = rte_pktmbuf_mtod(mbuf, uint8_t *)),	\
 		(len = rte_pktmbuf_data_len(mbuf)) : 0)
 
+#define BOTTOM_NIBBLE_OF_BYTE 0xf
+#define TOP_NIBBLE_OF_BYTE 0xf0
+
+static void
+process_zlib_deflate_chksum(struct rte_comp_op *op,
+		z_stream *strm, enum rte_comp_checksum_type chksum)
+{
+	uint8_t *dictionary = NULL;
+	uint32_t dictionary_len = 0;
+	op->status = RTE_COMP_OP_STATUS_SUCCESS;
+
+	switch (chksum) {
+	case RTE_COMP_CHECKSUM_NONE:
+	case RTE_COMP_CHECKSUM_CRC32:
+	case RTE_COMP_CHECKSUM_ADLER32:
+	case RTE_COMP_CHECKSUM_CRC32_ADLER32:
+		ZLIB_PMD_ERR("Checksum type not supported");
+		op->status = RTE_COMP_OP_STATUS_INVALID_ARGS;
+		break;
+	case RTE_COMP_CHECKSUM_3GPP_PDCP_UDC:
+		dictionary = rte_zmalloc(NULL, DEFLATE_MAX_WINDOW_SIZE, 0);
+
+		if (!dictionary) {
+			ZLIB_PMD_ERR("Unable to fetch dictionary");
+			op->status = RTE_COMP_OP_STATUS_ERROR;
+			return;
+		}
+
+		if (deflateGetDictionary(strm, dictionary, &dictionary_len)) {
+			ZLIB_PMD_ERR("Unable to fetch dictionary");
+			op->status = RTE_COMP_OP_STATUS_CHECK_SUM_VALIDATION_FAILED;
+			rte_free(dictionary);
+			return;
+		}
+
+		uint32_t dictionary_start = (uint32_t)(*dictionary);
+		uint32_t dictionary_end = (uint32_t)(*(dictionary + dictionary_len - 4));
+		uint32_t sum = (dictionary_start & 0x0F0F0F0F)
+			+ (dictionary_start & (0xF0F0F0F0 >> 4))
+			+ (dictionary_end & 0x0F0F0F0F)
+			+ (dictionary_end & (0xF0F0F0F0 >> 4));
+		uint8_t *sum_bytes = (uint8_t *)&sum;
+
+		op->output_chksum = ~(sum_bytes[0] + sum_bytes[1] + sum_bytes[2] + sum_bytes[3])
+			 & BOTTOM_NIBBLE_OF_BYTE;
+
+		rte_free(dictionary);
+
+		break;
+	default:
+		ZLIB_PMD_ERR("Checksum not supported");
+		return;
+	}
+}
+
+static void
+process_zlib_inflate_chksum(struct rte_comp_op *op,
+		z_stream *strm,
+		enum rte_comp_checksum_type chksum)
+{
+	uint8_t *dictionary = NULL;
+	uint32_t dictionary_len = 0;
+	op->status = RTE_COMP_OP_STATUS_SUCCESS;
+
+	switch (chksum) {
+	case RTE_COMP_CHECKSUM_NONE:
+	case RTE_COMP_CHECKSUM_CRC32:
+	case RTE_COMP_CHECKSUM_ADLER32:
+	case RTE_COMP_CHECKSUM_CRC32_ADLER32:
+		ZLIB_PMD_ERR("Checksum type not supported");
+		op->status = RTE_COMP_OP_STATUS_INVALID_ARGS;
+		break;
+	case RTE_COMP_CHECKSUM_3GPP_PDCP_UDC:
+		dictionary = rte_zmalloc(NULL, DEFLATE_MAX_WINDOW_SIZE, 0);
+
+		if (!dictionary) {
+			ZLIB_PMD_ERR("Unable to fetch dictionary");
+			op->status = RTE_COMP_OP_STATUS_ERROR;
+			return;
+		}
+
+		if (inflateGetDictionary(strm, dictionary, &dictionary_len)) {
+			ZLIB_PMD_ERR("Unable to fetch dictionary");
+			op->status = RTE_COMP_OP_STATUS_CHECK_SUM_VALIDATION_FAILED;
+			rte_free(dictionary);
+			return;
+		}
+
+		uint32_t dictionary_start = (uint32_t)(*dictionary);
+		uint32_t dictionary_end = (uint32_t)(*(dictionary + dictionary_len - 4));
+		uint32_t sum = (dictionary_start & 0x0F0F0F0F)
+			+ (dictionary_start & (0xF0F0F0F0 >> 4))
+			+ (dictionary_end & 0x0F0F0F0F)
+			+ (dictionary_end & (0xF0F0F0F0 >> 4));
+		uint8_t *sum_bytes = (uint8_t *)&sum;
+
+		op->output_chksum = ~(sum_bytes[0] + sum_bytes[1] + sum_bytes[2] + sum_bytes[3])
+			 & BOTTOM_NIBBLE_OF_BYTE;
+
+		if (op->input_chksum != op->output_chksum) {
+			ZLIB_PMD_ERR("Checksum does not match");
+			op->status = RTE_COMP_OP_STATUS_CHECK_SUM_VALIDATION_FAILED;
+			rte_free(dictionary);
+			return;
+		}
+
+		break;
+	default:
+		ZLIB_PMD_ERR("Checksum not supported");
+		return;
+	}
+}
+
 static void
 process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 {
@@ -134,6 +248,8 @@ process_zlib_inflate(struct rte_comp_op *op, z_stream *strm)
 
 	do {
 		do {
+
+
 			ret = inflate(strm, flush);
 
 			switch (ret) {
@@ -203,10 +319,14 @@ process_zlib_op(struct zlib_qp *qp, struct rte_comp_op *op)
 			(op->dst.offset > rte_pktmbuf_data_len(op->m_dst))) {
 		op->status = RTE_COMP_OP_STATUS_INVALID_ARGS;
 		ZLIB_PMD_ERR("Invalid source or destination buffers or "
-			     "invalid Operation requested");
+				  "invalid Operation requested");
 	} else {
 		private_xform = (struct zlib_priv_xform *)op->private_xform;
 		stream = &private_xform->stream;
+		stream->chksum(op, &stream->strm, stream->chksum_type);
+		if (op->status != RTE_COMP_OP_STATUS_SUCCESS)
+			return -1;
+
 		stream->comp(op, &stream->strm);
 	}
 	/* whatever is out of op, put it into completion queue with
@@ -232,6 +352,7 @@ zlib_set_stream_parameters(const struct rte_comp_xform *xform,
 	case RTE_COMP_COMPRESS:
 		stream->comp = process_zlib_deflate;
 		stream->free = deflateEnd;
+		stream->chksum = process_zlib_deflate_chksum;
 		/** Compression window bits */
 		switch (xform->compress.algo) {
 		case RTE_COMP_ALGO_DEFLATE:
@@ -281,17 +402,30 @@ zlib_set_stream_parameters(const struct rte_comp_xform *xform,
 			ZLIB_PMD_ERR("Compression strategy not supported");
 			return -1;
 		}
+
+		/** Checksum used */
+		stream->chksum_type = xform->compress.chksum;
+
 		if (deflateInit2(strm, level,
 					Z_DEFLATED, wbits,
 					DEF_MEM_LEVEL, strategy) != Z_OK) {
 			ZLIB_PMD_ERR("Deflate init failed");
 			return -1;
 		}
+
+		if (xform->compress.dictionary) {
+			if (deflateSetDictionary(strm, xform->compress.dictionary,
+					xform->compress.dictionary_len)) {
+				ZLIB_PMD_ERR("Deflate set dictionary failed");
+				return -1;
+			}
+		}
 		break;
 
 	case RTE_COMP_DECOMPRESS:
 		stream->comp = process_zlib_inflate;
 		stream->free = inflateEnd;
+		stream->chksum = process_zlib_inflate_chksum;
 		/** window bits */
 		switch (xform->decompress.algo) {
 		case RTE_COMP_ALGO_DEFLATE:
@@ -302,10 +436,21 @@ zlib_set_stream_parameters(const struct rte_comp_xform *xform,
 			return -1;
 		}
 
+		/** Checksum used */
+		stream->chksum_type = xform->decompress.chksum;
+
 		if (inflateInit2(strm, wbits) != Z_OK) {
 			ZLIB_PMD_ERR("Inflate init failed");
 			return -1;
 		}
+
+		if (xform->decompress.dictionary) {
+			if (inflateSetDictionary(strm, xform->decompress.dictionary,
+					xform->decompress.dictionary_len)) {
+				ZLIB_PMD_ERR("inflate set dictionary failed");
+				return -1;
+			}
+		}
 		break;
 	default:
 		return -1;
diff --git a/drivers/compress/zlib/zlib_pmd_private.h b/drivers/compress/zlib/zlib_pmd_private.h
index 7f6a57c..e387e28 100644
--- a/drivers/compress/zlib/zlib_pmd_private.h
+++ b/drivers/compress/zlib/zlib_pmd_private.h
@@ -46,6 +46,10 @@ typedef void (*comp_func_t)(struct rte_comp_op *op, z_stream *strm);
 
 typedef int (*comp_free_t)(z_stream *strm);
 
+typedef void (*chksum_func_t)
+		(struct rte_comp_op *op, z_stream *strm, enum rte_comp_checksum_type chksum);
+
+
 /** ZLIB Stream structure */
 struct __rte_cache_aligned zlib_stream {
 	z_stream strm;
@@ -54,6 +58,10 @@ struct __rte_cache_aligned zlib_stream {
 	/**< Operation (compression/decompression) */
 	comp_free_t free;
 	/**< Free Operation (compression/decompression) */
+	chksum_func_t chksum;
+	/**< Checksum Operation (compression/decompression) */
+	enum rte_comp_checksum_type chksum_type;
+	/**< Type of checksum to generate on the uncompressed data */
 };
 
 /** ZLIB private xform structure */
diff --git a/lib/compressdev/rte_comp.h b/lib/compressdev/rte_comp.h
index d66a4b1..3b55983 100644
--- a/lib/compressdev/rte_comp.h
+++ b/lib/compressdev/rte_comp.h
@@ -100,6 +100,10 @@ enum rte_comp_op_status {
 	 * is not an error case. Output data up to op.produced can be used and
 	 * next op in the stream should continue on from op.consumed+1.
 	 */
+	RTE_COMP_OP_STATUS_CHECK_SUM_VALIDATION_FAILED,
+	/**< Checksum validation failed. Either calculated does checksum not match
+	 * the one provided or there was an error calculating the checksum
+	 */
 };
 
 /** Compression Algorithms */
@@ -165,6 +169,10 @@ enum rte_comp_checksum_type {
 	/**< Generates a xxHash-32 checksum, as used by LZ4.
 	 * https://github.com/Cyan4973/xxHash/blob/dev/doc/xxhash_spec.md
 	 */
+	RTE_COMP_CHECKSUM_3GPP_PDCP_UDC,
+	/**< Generates checksum as defined under Uplink Data Compression
+	 * checksum as defined in the 3GPP PDCP specification
+	 */
 };
 
 /** Compression Huffman Type - used by DEFLATE algorithm */
@@ -200,6 +208,11 @@ enum rte_comp_flush_flag {
 	 */
 };
 
+#define	DEFLATE_MAX_WINDOW_SIZE	(1ULL << 15)
+
+#define	DEFLATE_MIN_WINDOW_SIZE		(1ULL << 8)
+
+
 /** Compression transform types */
 enum rte_comp_xform_type {
 	RTE_COMP_COMPRESS,
@@ -304,6 +317,15 @@ struct rte_comp_compress_xform {
 	/**< Hash algorithm to be used with compress operation. Hash is always
 	 * done on plaintext.
 	 */
+	uint8_t *dictionary;
+	/**<
+	 * Pointer to memory containing dictionary to be used for inflate
+	 * and deflate operations
+	 */
+	uint16_t dictionary_len;
+	/**<
+	 * Length of dictionary to be used
+	 */
 };
 
 /**
@@ -327,6 +349,15 @@ struct rte_comp_decompress_xform {
 	/**< Hash algorithm to be used with decompress operation. Hash is always
 	 * done on plaintext.
 	 */
+	uint8_t *dictionary;
+	/**<
+	 * Pointer to memory containing dictionary to be used for inflate
+	 * and deflate operations
+	 */
+	uint16_t dictionary_len;
+	/**<
+	 * Length of dictionary to be used
+	 */
 };
 
 /**
