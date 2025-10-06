Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD79ACAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 20:09:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D36D24065E;
	Mon,  6 Oct 2025 22:09:12 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id C3F61402D1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 22:09:10 +0200 (CEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596DxO1Z006173;
 Mon, 6 Oct 2025 20:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=M7l661yx3dz
 u9+mrX6NfxlFnGgtQ4xjoQSKYgxYFWas=; b=Q6ck+t/g9ph4twDMWzXh14q95AS
 sm0ELaS6nabagRMQzZc/3/qGosUHJ8kruWMOq/kmgU7MyDg3EEPfKgyuWS0wjy+J
 8mOQQBsLmSWVlM0nOdww52QOj/4J9EuM/J4QPtf5S08rsbqJYCRiQbCXKVdbO74u
 yAai40F9M82j2kHpsEIFGfB3rJ7uKEpF41CTKWm78YJCEM3IWbwuyFYi/tTGV0Uu
 NffCII+/S85CwZNZDGUlSwqa/JWzX4kva0dr4OMvtTle4M1RMXblD3HrOsuVpXKw
 gwJIn4PS3epPptXOXlqPbHomVDSLZDyRDq160ijZhdG8pwQOMQs4FJnnpEg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk6w395-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 20:09:09 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 596K98tN028195; 
 Mon, 6 Oct 2025 20:09:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 49kdetytwq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 20:09:08 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 596K98TO028183;
 Mon, 6 Oct 2025 20:09:08 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 596K98CA028166
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 20:09:08 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id E456F400E0; Mon,  6 Oct 2025 14:09:07 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH v4 2/4] compress/zlib: support for dictionaries and PDCP
 checksum
Date: Mon,  6 Oct 2025 14:09:02 -0600
Message-Id: <20251006200904.2467957-2-svaze@qti.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX5hNC6dtKugUN
 na2rFOcX7l25uWtFGQGpY8KULAt4PbHqZHgM/efmLRjC0usXJDzxuhoo3QCtameCUynffrzNoeI
 y9CQhF88nfbRuKShKXRk/iUT80+1YNk3jx6GM61JBiNotcuDJIy3CQMA3tIFQk0CztC/gJ3SLK6
 ERJqWRARXQepHV8y9Z+o+CuIkx0rVee6pxH73kj1mJewpkWRs08E/aR1Ds8X/Xtbi0tqhas1NZo
 2FcwtV072TnL3vBugiTcQwB6Ogf1s/9UfmsoQ5PCFKNvDyP8OJXc3BZttIqzLTufWaXi7Ww9lDN
 girry78syN9/yhFCdI3QjKgFOeuVkDxPpCr8iL2+3sgDpAhSaLKSvIuhqXWvlB7gJWuXZXIvL2g
 RPg20YysDdlerAjfFDA4yjsgh5wOAA==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e421e5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=m6COQzckJIiBeRjSn44A:9
X-Proofpoint-GUID: 6P-invokQ_Vmh54pGMsOYBOyVWuehnE7
X-Proofpoint-ORIG-GUID: 6P-invokQ_Vmh54pGMsOYBOyVWuehnE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017
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

Support to calculate PDCP checksums. Includes changes to
pass in dictionaries. Adds support for sync flush

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
v4:
* Moved all variables definitions to start of function
 drivers/compress/zlib/zlib_pmd.c         | 173 +++++++++++++++++++++--
 drivers/compress/zlib/zlib_pmd_private.h |   7 +
 2 files changed, 171 insertions(+), 9 deletions(-)

diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_pmd.c
index 92e808e78c..3a2485b54e 100644
--- a/drivers/compress/zlib/zlib_pmd.c
+++ b/drivers/compress/zlib/zlib_pmd.c
@@ -4,6 +4,7 @@
 
 #include <bus_vdev_driver.h>
 #include <rte_common.h>
+#include <stdlib.h>
 
 #include "zlib_pmd_private.h"
 
@@ -15,10 +16,123 @@
 		(data = rte_pktmbuf_mtod(mbuf, uint8_t *)),	\
 		(len = rte_pktmbuf_data_len(mbuf)) : 0)
 
+#define BOTTOM_NIBBLE_OF_BYTE 0xf
+#define TOP_NIBBLE_OF_BYTE 0xf0
+#define BOTTOM_NIBBLE_OF_BYTES_IN_DOUBLE_WORD 0x0f0f0f0f
+#define TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD 0xf0f0f0f0
+#define ZLIB_MAX_DICT_SIZE (1ULL << 15)
+
+static void
+process_zlib_deflate_chksum(struct rte_comp_op *op,
+		z_stream *strm, enum rte_comp_checksum_type chksum)
+{
+	uint32_t dictionary_len = 0;
+	uint8_t *dictionary = malloc(ZLIB_MAX_DICT_SIZE);
+	uint32_t dictionary_start, dictionary_end, sum;
+	uint8_t *sum_bytes = (uint8_t *)&sum;
+	op->status = RTE_COMP_OP_STATUS_SUCCESS;
+
+	switch (chksum) {
+	case RTE_COMP_CHECKSUM_3GPP_PDCP_UDC:
+
+		if (!dictionary) {
+			ZLIB_PMD_ERR("Unable to fetch dictionary");
+			op->status = RTE_COMP_OP_STATUS_ERROR;
+			return;
+		}
+
+		if (deflateGetDictionary(strm, dictionary, &dictionary_len)) {
+			ZLIB_PMD_ERR("Unable to fetch dictionary");
+			op->status = RTE_COMP_OP_STATUS_CHECKSUM_VALIDATION_FAILED;
+			free(dictionary);
+			return;
+		}
+
+		dictionary_start = (uint32_t)(*dictionary);
+		dictionary_end = (uint32_t)(*(dictionary + dictionary_len - 4));
+		sum = (dictionary_start & BOTTOM_NIBBLE_OF_BYTES_IN_DOUBLE_WORD)
+			+ (dictionary_start & (TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD >> 4))
+			+ (dictionary_end & BOTTOM_NIBBLE_OF_BYTES_IN_DOUBLE_WORD)
+			+ (dictionary_end & (TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD >> 4));
+
+		op->output_chksum = ~(sum_bytes[0] + sum_bytes[1] + sum_bytes[2] + sum_bytes[3])
+			 & BOTTOM_NIBBLE_OF_BYTE;
+		break;
+	case RTE_COMP_CHECKSUM_NONE:
+		break;
+	case RTE_COMP_CHECKSUM_CRC32:
+	case RTE_COMP_CHECKSUM_ADLER32:
+	case RTE_COMP_CHECKSUM_CRC32_ADLER32:
+	default:
+		ZLIB_PMD_ERR("Checksum not supported");
+		op->status = RTE_COMP_OP_STATUS_INVALID_ARGS;
+		free(dictionary);
+		return;
+	}
+	free(dictionary);
+}
+
+static void
+process_zlib_inflate_chksum(struct rte_comp_op *op,
+		z_stream *strm,
+		enum rte_comp_checksum_type chksum)
+{
+	uint32_t dictionary_len = 0;
+	uint8_t *dictionary = malloc(ZLIB_MAX_DICT_SIZE);
+	uint32_t dictionary_start, dictionary_end, sum;
+	uint8_t *sum_bytes = (uint8_t *)&sum;
+	op->status = RTE_COMP_OP_STATUS_SUCCESS;
+
+	switch (chksum) {
+	case RTE_COMP_CHECKSUM_3GPP_PDCP_UDC:
+		if (!dictionary) {
+			ZLIB_PMD_ERR("Unable to malloc dictionary");
+			op->status = RTE_COMP_OP_STATUS_ERROR;
+			return;
+		}
+
+		if (inflateGetDictionary(strm, dictionary, &dictionary_len)) {
+			ZLIB_PMD_ERR("Unable to fetch dictionary");
+			op->status = RTE_COMP_OP_STATUS_CHECKSUM_VALIDATION_FAILED;
+			free(dictionary);
+			return;
+		}
+
+		dictionary_start = (uint32_t)(*dictionary);
+		dictionary_end = (uint32_t)(*(dictionary + dictionary_len - 4));
+		sum = (dictionary_start & BOTTOM_NIBBLE_OF_BYTES_IN_DOUBLE_WORD)
+			+ (dictionary_start & (TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD >> 4))
+			+ (dictionary_end & BOTTOM_NIBBLE_OF_BYTES_IN_DOUBLE_WORD)
+			+ (dictionary_end & (TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD >> 4));
+
+		op->output_chksum = ~(sum_bytes[0] + sum_bytes[1] + sum_bytes[2] + sum_bytes[3])
+			 & BOTTOM_NIBBLE_OF_BYTE;
+
+		if (op->input_chksum != op->output_chksum) {
+			ZLIB_PMD_ERR("Checksum does not match");
+			op->status = RTE_COMP_OP_STATUS_CHECKSUM_VALIDATION_FAILED;
+			free(dictionary);
+			return;
+		}
+		break;
+	case RTE_COMP_CHECKSUM_NONE:
+		break;
+	case RTE_COMP_CHECKSUM_CRC32:
+	case RTE_COMP_CHECKSUM_ADLER32:
+	case RTE_COMP_CHECKSUM_CRC32_ADLER32:
+	default:
+		ZLIB_PMD_ERR("Checksum not supported");
+		op->status = RTE_COMP_OP_STATUS_INVALID_ARGS;
+		free(dictionary);
+		return;
+	}
+}
+
 static void
 process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 {
 	int ret, flush, fin_flush;
+	unsigned long total_in_at_start, total_out_at_start;
 	struct rte_mbuf *mbuf_src = op->m_src;
 	struct rte_mbuf *mbuf_dst = op->m_dst;
 
@@ -27,6 +141,9 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 	case RTE_COMP_FLUSH_FINAL:
 		fin_flush = Z_FINISH;
 		break;
+	case RTE_COMP_FLUSH_SYNC:
+		fin_flush = Z_SYNC_FLUSH;
+		break;
 	default:
 		op->status = RTE_COMP_OP_STATUS_INVALID_ARGS;
 		ZLIB_PMD_ERR("Invalid flush value");
@@ -49,6 +166,9 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 
 	strm->avail_out = rte_pktmbuf_data_len(mbuf_dst) - op->dst.offset;
 
+	total_in_at_start = strm->total_in;
+	total_out_at_start = strm->total_out;
+
 	/* Set flush value to NO_FLUSH unless it is last mbuf */
 	flush = Z_NO_FLUSH;
 	/* Initialize status to SUCCESS */
@@ -56,8 +176,8 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 
 	do {
 		/* Set flush value to Z_FINISH for last block */
-		if ((op->src.length - strm->total_in) <= strm->avail_in) {
-			strm->avail_in = (op->src.length - strm->total_in);
+		if ((op->src.length - (strm->total_in - total_in_at_start)) <= strm->avail_in) {
+			strm->avail_in = (op->src.length - (strm->total_in - total_in_at_start));
 			flush = fin_flush;
 		}
 		do {
@@ -92,23 +212,25 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 	/* Update op stats */
 	switch (op->status) {
 	case RTE_COMP_OP_STATUS_SUCCESS:
-		op->consumed += strm->total_in;
+		op->consumed += strm->total_in - total_in_at_start;
 	/* Fall-through */
 	case RTE_COMP_OP_STATUS_OUT_OF_SPACE_TERMINATED:
-		op->produced += strm->total_out;
+		op->produced += strm->total_out - total_out_at_start;
 		break;
 	default:
 		ZLIB_PMD_ERR("stats not updated for status:%d",
 				op->status);
 	}
 
-	deflateReset(strm);
+	if (op->flush_flag != RTE_COMP_FLUSH_SYNC)
+		deflateReset(strm);
 }
 
 static void
 process_zlib_inflate(struct rte_comp_op *op, z_stream *strm)
 {
 	int ret, flush;
+	unsigned long total_in_at_start, total_out_at_start;
 	struct rte_mbuf *mbuf_src = op->m_src;
 	struct rte_mbuf *mbuf_dst = op->m_dst;
 
@@ -127,6 +249,9 @@ process_zlib_inflate(struct rte_comp_op *op, z_stream *strm)
 
 	strm->avail_out = rte_pktmbuf_data_len(mbuf_dst) - op->dst.offset;
 
+	total_in_at_start = strm->total_in;
+	total_out_at_start = strm->total_out;
+
 	/** Ignoring flush value provided from application for decompression */
 	flush = Z_NO_FLUSH;
 	/* initialize status to SUCCESS */
@@ -178,17 +303,18 @@ process_zlib_inflate(struct rte_comp_op *op, z_stream *strm)
 	/* Update op stats */
 	switch (op->status) {
 	case RTE_COMP_OP_STATUS_SUCCESS:
-		op->consumed += strm->total_in;
+		op->consumed += strm->total_in - total_in_at_start;
 	/* Fall-through */
 	case RTE_COMP_OP_STATUS_OUT_OF_SPACE_TERMINATED:
-		op->produced += strm->total_out;
+		op->produced += strm->total_out - total_out_at_start;
 		break;
 	default:
 		ZLIB_PMD_ERR("stats not produced for status:%d",
 				op->status);
 	}
 
-	inflateReset(strm);
+	if (op->flush_flag != RTE_COMP_FLUSH_SYNC)
+		inflateReset(strm);
 }
 
 /** Process comp operation for mbuf */
@@ -203,10 +329,14 @@ process_zlib_op(struct zlib_qp *qp, struct rte_comp_op *op)
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
@@ -232,6 +362,7 @@ zlib_set_stream_parameters(const struct rte_comp_xform *xform,
 	case RTE_COMP_COMPRESS:
 		stream->comp = process_zlib_deflate;
 		stream->free = deflateEnd;
+		stream->chksum = process_zlib_deflate_chksum;
 		/** Compression window bits */
 		switch (xform->compress.algo) {
 		case RTE_COMP_ALGO_DEFLATE:
@@ -281,17 +412,30 @@ zlib_set_stream_parameters(const struct rte_comp_xform *xform,
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
+		if (xform->compress.deflate.dictionary) {
+			if (deflateSetDictionary(strm, xform->compress.deflate.dictionary,
+					xform->compress.deflate.dictionary_len)) {
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
@@ -302,10 +446,21 @@ zlib_set_stream_parameters(const struct rte_comp_xform *xform,
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
+		if (xform->decompress.inflate.dictionary) {
+			if (inflateSetDictionary(strm, xform->decompress.inflate.dictionary,
+					xform->decompress.inflate.dictionary_len)) {
+				ZLIB_PMD_ERR("inflate set dictionary failed");
+				return -1;
+			}
+		}
 		break;
 	default:
 		return -1;
diff --git a/drivers/compress/zlib/zlib_pmd_private.h b/drivers/compress/zlib/zlib_pmd_private.h
index fd8c4c55a4..f6bd948cc2 100644
--- a/drivers/compress/zlib/zlib_pmd_private.h
+++ b/drivers/compress/zlib/zlib_pmd_private.h
@@ -46,6 +46,9 @@ typedef void (*comp_func_t)(struct rte_comp_op *op, z_stream *strm);
 
 typedef int (*comp_free_t)(z_stream *strm);
 
+typedef void (*chksum_func_t)
+		(struct rte_comp_op *op, z_stream *strm, enum rte_comp_checksum_type chksum);
+
 /** ZLIB Stream structure */
 struct __rte_cache_aligned zlib_stream {
 	z_stream strm;
@@ -54,6 +57,10 @@ struct __rte_cache_aligned zlib_stream {
 	/**< Operation (compression/decompression) */
 	comp_free_t free;
 	/**< Free Operation (compression/decompression) */
+	chksum_func_t chksum;
+	/**< Checksum Operation (compression/decompression) */
+	enum rte_comp_checksum_type chksum_type;
+	/**< Type of checksum to generate on the uncompressed data */
 };
 
 /** ZLIB private xform structure */
-- 
2.31.1

