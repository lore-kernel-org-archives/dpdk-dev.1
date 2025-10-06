Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D85CCA470
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 20:09:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E38734066E;
	Mon,  6 Oct 2025 22:09:13 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 2942A402E2
 for <dev@dpdk.org>; Mon,  6 Oct 2025 22:09:11 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FSELD005144
 for <dev@dpdk.org>; Mon, 6 Oct 2025 20:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pC+4Krh/FaJ
 1ZbzviPLEC4KqHGkRyB+8ONsCny3BE7s=; b=V+Bkp50kx3ii2Vf7Vy6L2Tpi4Zy
 LwrkGByQYkxBOJjPWYO+bFhdb6YMn7K8hVxLpFNb/KZ4VnJOfCkHMIu6sm+jEF99
 kZMbFz5dAA6w++RW4WngRYyhGKd9eI1vFigemdKa/VPaIG4hgFExVutvk0MpHgFn
 hNa1e8iuU5K4yBxCc6/KoUaPPmjAy6bs8VCSqYJf+rx4DUhPoff8IDGFJgVrsy2A
 AwNzofHewlwCepk9yJrzaqigjj1KGrjZ6/1rVOsKiFLtHS+pdxVgPp4H6sDbDRyD
 SIkoMhIQJ+Is5lqD6Nj7bmWjovb3jNLpS3xyCRW/CUrJKoyJKl/J3S87/tA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn58pb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 06 Oct 2025 20:09:10 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 596K82dX008441
 for <dev@dpdk.org>; Mon, 6 Oct 2025 20:09:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 49jvnmbp1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 06 Oct 2025 20:09:09 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 596K98Tc010172
 for <dev@dpdk.org>; Mon, 6 Oct 2025 20:09:09 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 596K982L010157
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 20:09:08 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id 665A24009E; Mon,  6 Oct 2025 14:09:08 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: 
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH v4 3/4] app/compress-perf: support for dictionaries and PDCP
 checksum
Date: Mon,  6 Oct 2025 14:09:03 -0600
Message-Id: <20251006200904.2467957-3-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251006200904.2467957-1-svaze@qti.qualcomm.com>
References: <20251003194901.3375364-1-svaze@qti.qualcomm.com>
 <20251006200904.2467957-1-svaze@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX7e/NFg5dMPD4
 7HhOXBF7ffNURzzj37f+3n6NFvH2WqApv6IRBHfZu0POm+Fis/CP90AWa9EjBgWJwNsv5uWoQIp
 U0r37dMrxOlOFT4g2GCdLb5sG1i0MB0nwph2lGELheuh9ldyr5ArVE4TtsCX8/D+lNozrUhxK9f
 9LPxUxEiUc3MzToaRDpOyv5PfTFcIhL1acZwLyXaQoEdhzdPyPtYy4o9c3xuhnB6tBmo0XhO1Yo
 WY3B5HmDAJvqgGSlZt0dT4R/GRA1dBTDiUZrsfEvGhEvH5bqP74gwxv/QXxh8LL3SyCPgo7Vsb3
 8j0xVWQg66eqLJ86+rnmkLpmMg2KOIMRiPZorMIZTxiuEJIVxA16FXQi2zQJArcGNtwo1CAe7+V
 oFWgpPoXK3iu3FSbtRM8UH4gT5qiYw==
X-Proofpoint-GUID: 409aLA5stiWLFwEPvkIefk4QwC1SBEbR
X-Proofpoint-ORIG-GUID: 409aLA5stiWLFwEPvkIefk4QwC1SBEbR
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e421e6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=fn7-FCLkNK9KKGPAsGMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001
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

Adds support to read and apply dictionaries

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
v4:
* Moved all new variable defintions to start of function
 app/test-compress-perf/comp_perf_options.h    |   5 +
 .../comp_perf_options_parse.c                 |  15 +++
 .../comp_perf_test_verify.c                   |  42 +++++++-
 app/test-compress-perf/main.c                 | 101 +++++++++++++++++-
 4 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/app/test-compress-perf/comp_perf_options.h b/app/test-compress-perf/comp_perf_options.h
index 828a7309d8..445f9db832 100644
--- a/app/test-compress-perf/comp_perf_options.h
+++ b/app/test-compress-perf/comp_perf_options.h
@@ -12,6 +12,7 @@
 #define EXPANSE_RATIO 1.1
 #define MAX_MBUF_DATA_SIZE (UINT16_MAX - RTE_PKTMBUF_HEADROOM)
 #define MAX_SEG_SIZE ((int)(MAX_MBUF_DATA_SIZE / EXPANSE_RATIO))
+#define MAX_DICT_SIZE (1ULL << 15)
 
 extern const char *comp_perf_test_type_strs[];
 
@@ -21,6 +22,7 @@ enum cleanup_st {
 	ST_TEST_DATA,
 	ST_COMPDEV,
 	ST_INPUT_DATA,
+	ST_DICTIONARY_DATA,
 	ST_MEMORY_ALLOC,
 	ST_DURING_TEST
 };
@@ -48,10 +50,13 @@ struct range_list {
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
index 6d8c370fc2..49197dc290 100644
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
@@ -609,6 +611,17 @@ parse_external_mbufs(struct comp_test_data *test_data,
 	return 0;
 }
 
+static int
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
 static int
 parse_cyclecount_delay_us(struct comp_test_data *test_data,
 			const char *arg)
@@ -647,6 +660,7 @@ static struct option lgopts[] = {
 	{ CPERF_LEVEL, required_argument, 0, 0 },
 	{ CPERF_WINDOW_SIZE, required_argument, 0, 0 },
 	{ CPERF_EXTERNAL_MBUFS, 0, 0, 0 },
+	{ CPERF_DICTIONARY, required_argument, 0, 0 },
 	{ CPERF_CYCLECOUNT_DELAY_US, required_argument, 0, 0 },
 	{ NULL, 0, 0, 0 }
 };
@@ -671,6 +685,7 @@ comp_perf_opts_parse_long(int opt_idx, struct comp_test_data *test_data)
 		{ CPERF_LEVEL,		parse_level },
 		{ CPERF_WINDOW_SIZE,	parse_window_sz },
 		{ CPERF_EXTERNAL_MBUFS,	parse_external_mbufs },
+		{ CPERF_DICTIONARY,	parse_dictionary_file },
 		{ CPERF_CYCLECOUNT_DELAY_US,	parse_cyclecount_delay_us },
 	};
 	unsigned int i;
diff --git a/app/test-compress-perf/comp_perf_test_verify.c b/app/test-compress-perf/comp_perf_test_verify.c
index 09d97c5cf7..66425d7e3c 100644
--- a/app/test-compress-perf/comp_perf_test_verify.c
+++ b/app/test-compress-perf/comp_perf_test_verify.c
@@ -64,6 +64,9 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 	int res = 0;
 	int allocated = 0;
 	uint32_t out_seg_sz;
+	uint8_t dict[MAX_DICT_SIZE] = {0};
+	uint16_t window_size = (1ULL << test_data->window_sz);
+	uint8_t *udc_header = NULL;
 
 	if (test_data == NULL || !test_data->burst_sz) {
 		RTE_LOG(ERR, USER1,
@@ -71,6 +74,20 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 		return -1;
 	}
 
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
@@ -91,12 +108,14 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 				.level = test_data->level,
 				.window_size = test_data->window_sz,
 				.chksum = RTE_COMP_CHECKSUM_NONE,
-				.hash_algo = RTE_COMP_HASH_ALGO_NONE
+				.hash_algo = RTE_COMP_HASH_ALGO_NONE,
 			}
 		};
-		if (test_data->test_algo == RTE_COMP_ALGO_DEFLATE)
+		if (test_data->test_algo == RTE_COMP_ALGO_DEFLATE) {
 			xform.compress.deflate.huffman = test_data->huffman_enc;
-		else if (test_data->test_algo == RTE_COMP_ALGO_LZ4)
+			xform.compress.deflate.dictionary = dict;
+			xform.compress.deflate.dictionary_len = window_size;
+		} else if (test_data->test_algo == RTE_COMP_ALGO_LZ4)
 			xform.compress.lz4.flags = test_data->lz4_flags;
 		output_data_ptr = ctx->mem.compressed_data;
 		output_data_sz = &ctx->comp_data_sz;
@@ -113,7 +132,10 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 				.hash_algo = RTE_COMP_HASH_ALGO_NONE
 			}
 		};
-		if (test_data->test_algo == RTE_COMP_ALGO_LZ4)
+		if (test_data->test_algo == RTE_COMP_ALGO_DEFLATE) {
+			xform.decompress.inflate.dictionary = dict;
+			xform.decompress.inflate.dictionary_len = window_size;
+		} else if (test_data->test_algo == RTE_COMP_ALGO_LZ4)
 			xform.decompress.lz4.flags = test_data->lz4_flags;
 		output_data_ptr = ctx->mem.decompressed_data;
 		output_data_sz = &ctx->decomp_data_sz;
@@ -194,7 +216,17 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 					rte_pktmbuf_pkt_len(input_bufs[buf_id]);
 				ops[op_id]->dst.offset = 0;
 				ops[op_id]->flush_flag = RTE_COMP_FLUSH_FINAL;
-				ops[op_id]->input_chksum = buf_id;
+				if ((xform.type == RTE_COMP_DECOMPRESS) &&
+					(xform.decompress.chksum
+						== RTE_COMP_CHECKSUM_3GPP_PDCP_UDC)) {
+					udc_header
+						= rte_pktmbuf_mtod(ops[op_id]->m_src, uint8_t *);
+					ops[op_id]->input_chksum = *udc_header & 0xf;
+					ops[op_id]->src.offset = 1;
+				} else {
+					ops[op_id]->input_chksum = buf_id;
+					ops[op_id]->src.offset = 0;
+				}
 				ops[op_id]->private_xform = priv_xform;
 			}
 
diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c
index 70ce4316cc..11b016069c 100644
--- a/app/test-compress-perf/main.c
+++ b/app/test-compress-perf/main.c
@@ -257,6 +257,8 @@ comp_perf_dump_input_data(struct comp_test_data *test_data)
 {
 	FILE *f = fopen(test_data->input_file, "r");
 	int ret = -1;
+	size_t actual_file_sz, remaining_data;
+	uint8_t *data = NULL;
 
 	if (f == NULL) {
 		RTE_LOG(ERR, USER1, "Input file could not be opened\n");
@@ -267,7 +269,7 @@ comp_perf_dump_input_data(struct comp_test_data *test_data)
 		RTE_LOG(ERR, USER1, "Size of input could not be calculated\n");
 		goto end;
 	}
-	size_t actual_file_sz = ftell(f);
+	actual_file_sz = ftell(f);
 	/* If extended input data size has not been set,
 	 * input data size = file size
 	 */
@@ -298,8 +300,8 @@ comp_perf_dump_input_data(struct comp_test_data *test_data)
 		goto end;
 	}
 
-	size_t remaining_data = test_data->input_data_sz;
-	uint8_t *data = test_data->input_data;
+	remaining_data = test_data->input_data_sz;
+	data = test_data->input_data;
 
 	while (remaining_data > 0) {
 		size_t data_to_read = RTE_MIN(remaining_data, actual_file_sz);
@@ -335,6 +337,89 @@ comp_perf_dump_input_data(struct comp_test_data *test_data)
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
+	if (test_data->dictionary_data)
+		rte_free(test_data->dictionary_data);
+
+	return ret;
+}
+
 static void
 comp_perf_cleanup_on_signal(int signalNumber __rte_unused)
 {
@@ -407,6 +492,13 @@ main(int argc, char **argv)
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
@@ -496,6 +588,9 @@ main(int argc, char **argv)
 			i++;
 		}
 		/* fallthrough */
+	case ST_DICTIONARY_DATA:
+		rte_free(test_data->dictionary_data);
+		/* fallthrough */
 	case ST_INPUT_DATA:
 		rte_free(test_data->input_data);
 		/* fallthrough */
-- 
2.31.1

