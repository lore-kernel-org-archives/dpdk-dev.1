Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76665CA1013
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 20:32:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E8BD4064C;
	Thu, 18 Sep 2025 22:32:30 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id F2735402D0
 for <dev@dpdk.org>; Thu, 18 Sep 2025 22:32:28 +0200 (CEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIP2Yq027424;
 Thu, 18 Sep 2025 20:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=gV0VPBcjmG0OHdqUOHk+2O1VvBGbm2Sd0iI
 b8cTKeZ4=; b=RAen5ScamX/nN0czkKQAesybg7gtgZfr0tIJcs2sliR0syT7dzZ
 MaF19EfIg9SLDhFdZuV/hx2V+uo2K6i/d24aoxXULQ8uBRQz1vVzDLDrueqkj/1K
 N+9syu94ToqlJoXQlGedhPzdv8RhBgk8SsfHL2WE3wMt0a1PeO31uf3cqHkdLv2U
 z729cf5tr3RYv7KmXCW89L3dKFSohTY8LRBrtIRFiJpIFJno5I7lNLCnadM+TogV
 BpusdbC/IDk1imjZJwQfDeU4jgY+VoZdOebacfXGwx4jp1SStdgCHkxPqlk6yDp7
 MKqgkJhceNU8eAP7At3doDI7/lpomRYCcXw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt81eh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 20:32:27 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58IKWRCm024598; 
 Thu, 18 Sep 2025 20:32:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 497wy0qm67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 20:32:27 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58IKW4sv024241;
 Thu, 18 Sep 2025 20:32:27 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 58IKWQJ6024588
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 20:32:27 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id 85C9D4016A; Thu, 18 Sep 2025 14:32:26 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH] compress/zlib: support for dictionary and PDCP checksum
Date: Thu, 18 Sep 2025 14:32:10 -0600
Message-Id: <20250918203210.1689254-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: NgnF4Fiv347c_OonrJ5nmK2FnxqoK4yw
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cc6c5b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=BrkBEixOsbVaADiXYk8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX1ptgo6d+LW0g
 frQT7DBk+jPRjw8jBWG/msZUEZe0cVEcaBF0JDbhoHJFBBla+gPZeuKMUXw0QMc0EuCyp2l9NFe
 H0+uD3NdgfgERFW59rS7W61vVTHP6FurWnd+0VpifTuKFsr/RmSMPTvQdXuKSvF/TA21FbZCJmM
 HtFvGDP0Ky9NKZceulUiCBYjpztMl82LwEBTzob6yYE1tcZpvan2rPiN95dzzEMQ7mvaK63Qre5
 UdeJbq+7xOnEYKSYq+IU3BZm6CzdrNh6pZmoL3ifenogxhFqciHwlf6JgpcaZ14MAV5BsgJfZfr
 TRx/Q0907zdgT1O4LTUqTOQYkoimFsN0iuZCvp3cD1gTYn7MUCmlEMEGEzxyLphSzFhZGKD8+1k
 NZEm3G8z
X-Proofpoint-ORIG-GUID: NgnF4Fiv347c_OonrJ5nmK2FnxqoK4yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202
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

Adds support to provide predefined dictionaries to zlib. Handles setting
and getting of dictionaries using zlib apis. Also includes support to
read dictionary files

Adds support for passing in and validationg 3GPP PDCP spec defined
checksums as defined under the Uplink Data Compression(UDC) feature.
Changes also include functions that do inflate or deflate specfic
checksum operations.

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
 drivers/compress/zlib/zlib_pmd.c         | 173 +++++++++++++++++++++--
 drivers/compress/zlib/zlib_pmd_private.h |   8 ++
 lib/compressdev/rte_comp.h               |  31 ++++
 3 files changed, 203 insertions(+), 9 deletions(-)

diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_pmd.c
index 92e808e78c..1b1abd72e7 100644
--- a/drivers/compress/zlib/zlib_pmd.c
+++ b/drivers/compress/zlib/zlib_pmd.c
@@ -4,6 +4,7 @@
 
 #include <bus_vdev_driver.h>
 #include <rte_common.h>
+#include <rte_malloc.h>
 
 #include "zlib_pmd_private.h"
 
@@ -15,6 +16,120 @@
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
+		rte_free(dictionary);
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
@@ -27,6 +142,9 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 	case RTE_COMP_FLUSH_FINAL:
 		fin_flush = Z_FINISH;
 		break;
+	case RTE_COMP_FLUSH_SYNC:
+		fin_flush = Z_SYNC_FLUSH;
+		break;
 	default:
 		op->status = RTE_COMP_OP_STATUS_INVALID_ARGS;
 		ZLIB_PMD_ERR("Invalid flush value");
@@ -49,6 +167,9 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 
 	strm->avail_out = rte_pktmbuf_data_len(mbuf_dst) - op->dst.offset;
 
+	uLong total_in_at_start = strm->total_in;
+	uLong total_out_at_start = strm->total_out;
+
 	/* Set flush value to NO_FLUSH unless it is last mbuf */
 	flush = Z_NO_FLUSH;
 	/* Initialize status to SUCCESS */
@@ -56,8 +177,8 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 
 	do {
 		/* Set flush value to Z_FINISH for last block */
-		if ((op->src.length - strm->total_in) <= strm->avail_in) {
-			strm->avail_in = (op->src.length - strm->total_in);
+		if ((op->src.length - (strm->total_in - total_in_at_start)) <= strm->avail_in) {
+			strm->avail_in = (op->src.length - (strm->total_in - total_in_at_start));
 			flush = fin_flush;
 		}
 		do {
@@ -92,17 +213,18 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
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
@@ -127,6 +249,9 @@ process_zlib_inflate(struct rte_comp_op *op, z_stream *strm)
 
 	strm->avail_out = rte_pktmbuf_data_len(mbuf_dst) - op->dst.offset;
 
+	uLong total_in_at_start = strm->total_in;
+	uLong total_out_at_start = strm->total_out;
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
index fd8c4c55a4..99bfdc9a76 100644
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
index 96d9b276dd..169d3d960e 100644
--- a/lib/compressdev/rte_comp.h
+++ b/lib/compressdev/rte_comp.h
@@ -101,6 +101,10 @@ enum rte_comp_op_status {
 	 * is not an error case. Output data up to op.produced can be used and
 	 * next op in the stream should continue on from op.consumed+1.
 	 */
+	RTE_COMP_OP_STATUS_CHECK_SUM_VALIDATION_FAILED,
+	/**< Checksum validation failed. Either calculated does checksum not match
+	 * the one provided or there was an error calculating the checksum
+	 */
 };
 
 /** Compression Algorithms */
@@ -166,6 +170,10 @@ enum rte_comp_checksum_type {
 	/**< Generates a xxHash-32 checksum, as used by LZ4.
 	 * https://github.com/Cyan4973/xxHash/blob/dev/doc/xxhash_spec.md
 	 */
+	RTE_COMP_CHECKSUM_3GPP_PDCP_UDC,
+	/**< Generates checksum as defined under Uplink Data Compression
+	 * checksum as defined in the 3GPP PDCP specification
+	 */
 };
 
 /** Compression Huffman Type - used by DEFLATE algorithm */
@@ -201,6 +209,11 @@ enum rte_comp_flush_flag {
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
@@ -305,6 +318,15 @@ struct rte_comp_compress_xform {
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
@@ -328,6 +350,15 @@ struct rte_comp_decompress_xform {
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
-- 
2.31.1

