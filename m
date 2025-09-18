Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D01CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 21:08:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CBAD4065B;
	Thu, 18 Sep 2025 23:08:19 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 836CE402D0
 for <dev@dpdk.org>; Thu, 18 Sep 2025 23:08:18 +0200 (CEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IJ4Oe7018269
 for <dev@dpdk.org>; Thu, 18 Sep 2025 21:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Xi0I9WLpcUI3dM6yTAPx0fTitKG4HOeeCcj
 N6wG8h6A=; b=ZekgsqSV6bo7eXHVufRQr7odp52YwoZUfUu175qOvMULKNBYu3a
 eawbAMvOUBicgt4OSjG8lrJdPnbC1R2ZxaxF8DBWcWHIuh7lcoPpvNmn4iCy3AZK
 SgDov/lykSjvad0bCUdsGatyjugpjjO6XJXESkOz+Z++C1EvkypYuUN+eo+x8PwP
 wi7pxEdj+wAyiMTQg3FMozNKv2RA0fZyetamQOsYu0kgKczCZUf6ZOORsBr+Ce7s
 nQPbeEdsJUFtYGrx/6vyT/w/bo6uYczCLvT39r0UqVjfN7kHgwisZzYtHZ9jpMNi
 XLlhKpWuziUfawLkToFCx4an+ub2ugt9O2g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwg1u4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 18 Sep 2025 21:08:17 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IL8Gjt002016
 for <dev@dpdk.org>; Thu, 18 Sep 2025 21:08:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 496ymrgm0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 18 Sep 2025 21:08:16 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58IL8Gma002009
 for <dev@dpdk.org>; Thu, 18 Sep 2025 21:08:16 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 58IL8G33001989
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 21:08:16 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id D87C24016A; Thu, 18 Sep 2025 15:08:15 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: 
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH] app/compress-perf: support dictionary files
Date: Thu, 18 Sep 2025 15:08:06 -0600
Message-Id: <20250918210806.1709958-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cc74c1 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=IeAZipw4XQsdFnktVzgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXxUM9ogtzEalE
 Lq5n5C4TZ5dhhfddtEuBVdcp9BAbq1deow4rOk9DQecxvE2e3Te6oTTu1Mb9TsshHTn8VQEf0av
 qmY4bkTE62rTer1kaDscbW1UuNFAWrDRtwpFV8R1KJW685WSrF0YbDgQT5euHgtaXyJGDRA6EvU
 O1uB63cBmiDGj2AdCf0P6zq/zdD78HjfJnQCBAzuQ7xrgi3I/UJdi6rBXpAeTqdo40vhndw5UZf
 F64aSDYtXjP610pIakYIR+lOh+91uT8z/wmyCMDr3dRRe1fxs5y1P7gPXMctgIqj++mXeaDQnTr
 zwJ/8dHz2Fidp5nRLg142zy5ctByjvi701fHvHjK8Oo2LH9/6KgUSHQDFzKRGDT4MTzgHiMlZVS
 AjunTjyI
X-Proofpoint-GUID: tNDgZOH20nT1iRswmuAZiIVyAPtBfZEO
X-Proofpoint-ORIG-GUID: tNDgZOH20nT1iRswmuAZiIVyAPtBfZEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202
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

Adds support to pass in pre-defined dictionaries to zlib PMD.

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
Depends-on: patch-156722 ("compress/zlib: support for dictionary and PDCP checksum")
 app/test-compress-perf/comp_perf_options.h    |  4 +
 .../comp_perf_options_parse.c                 | 16 ++++
 .../comp_perf_test_verify.c                   | 37 +++++++-
 app/test-compress-perf/main.c                 | 90 +++++++++++++++++++
 4 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/app/test-compress-perf/comp_perf_options.h b/app/test-compress-perf/comp_perf_options.h
index 828a7309d8..4c34dcd8aa 100644
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
index 6d8c370fc2..37205ad806 100644
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
@@ -609,6 +611,18 @@ parse_external_mbufs(struct comp_test_data *test_data,
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
+
 static int
 parse_cyclecount_delay_us(struct comp_test_data *test_data,
 			const char *arg)
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
diff --git a/app/test-compress-perf/comp_perf_test_verify.c b/app/test-compress-perf/comp_perf_test_verify.c
index 09d97c5cf7..f1d02afa6e 100644
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
@@ -194,7 +215,17 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
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
 			}
 
diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c
index 70ce4316cc..693a7cc31b 100644
--- a/app/test-compress-perf/main.c
+++ b/app/test-compress-perf/main.c
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
@@ -496,6 +583,9 @@ main(int argc, char **argv)
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

