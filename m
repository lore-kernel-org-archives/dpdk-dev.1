Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4597ECAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 17:34:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F5C94066E;
	Fri, 19 Sep 2025 19:34:21 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 1A3484042F
 for <dev@dpdk.org>; Fri, 19 Sep 2025 19:34:18 +0200 (CEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JE3UY1018272;
 Fri, 19 Sep 2025 17:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wWaMTyTCaat
 JBlaa9eLXcoMTbNdZDBxheWdRtWewg54=; b=dygRAT0Cms83+l2mQG9zcQ2+5Te
 32WCgbODyUrEOO16BBH177zfVEnTzrt8my3d+KLOAdd2uRcRpS6/rAzaW6yoHUfL
 /m4OrwVJxssjh1VD7VzIYXg4HUX+LUoE4OaFMWE8atpr32TGoM7G7O6NMusRLDHc
 DCcSZG0dN/oX50Fb+bIaF8koraKaoddG8n6InDvvcUZXk0zM3MFPZK8k/iOlh7L7
 h4Fc+DzdaG+0wYYFBD3o55ml9AGWesEMfhwq3yi85omddD5JUuRkYLPA7EUdUdEV
 giRHTjeGGbmbd1b7NSwQUTtUEGz3tGZfBmOZgM0XSM6gADGhf8vkl1EaegA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwk81a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 17:34:18 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA01.qualcomm.com [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JHYHUg009308; 
 Fri, 19 Sep 2025 17:34:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 497wy16x9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 17:34:17 +0000
Received: from NASANPPMTA01.qualcomm.com (NASANPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JHYHrZ009288;
 Fri, 19 Sep 2025 17:34:17 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 58JHYGXt009282
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 17:34:17 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id 8119B4016A; Fri, 19 Sep 2025 11:34:16 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH 2/3] compress/zlib: support for dictionaries and PDCP checksum
Date: Fri, 19 Sep 2025 11:34:14 -0600
Message-Id: <20250919173415.2462642-2-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250919173415.2462642-1-svaze@qti.qualcomm.com>
References: <20250919173415.2462642-1-svaze@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cd941a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=OVecn4WgEKDgdfIVBRYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyC3y2TffjF+q
 fl3TUOjbOXh7xfMV2C/hBqt44WIzfT5Y4QGCxt/pSXz+9G/VAqc7JYnLABF1Rdo80Tf+eKoQTvo
 WGfl4l/bttT0/IOz2WsYLr9QE5hmJDdhV7VqXh4Qnw/XaD3cXkxDat4i2yZ0BY/zYEVZncbBDTs
 oKlyTpNuD8QUeQNUx4H4LR/7o21ySBPwVFFyAJX6aINDsklvP0JmfHG06ZxzZNsbKHRilBQ8dNZ
 rLCHKAOcPOFSjjqqNO7XWNRGG3rE2n96QtGMYQKGDsoqvtzcgLPTNRgRI2pOqCJDCSg8OvpWIaj
 E/a3LZAzLxSWZTOPp4hoG0qGtiPEU9vnB0oKg7xsUyWC8YRLztEit137F2Yl77aFEvSQYyCc5wa
 B0f8zZoK
X-Proofpoint-GUID: 7yyr7G2kSLGSRYKhANCR4lxEZoBufZ4y
X-Proofpoint-ORIG-GUID: 7yyr7G2kSLGSRYKhANCR4lxEZoBufZ4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
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

Support to calculate PDCP checksums. Includes changes to
pass in dictionaries. Adds support for sync flush

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
 drivers/compress/zlib/zlib_pmd.c         | 171 +++++++++++++++++++++--
 drivers/compress/zlib/zlib_pmd_private.h |   8 ++
 2 files changed, 170 insertions(+), 9 deletions(-)

diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_pmd.c
index 92e808e78c..65f3999428 100644
--- a/drivers/compress/zlib/zlib_pmd.c
+++ b/drivers/compress/zlib/zlib_pmd.c
@@ -4,6 +4,7 @@
 
 #include <bus_vdev_driver.h>
 #include <rte_common.h>
+#include <rte_malloc.h>
 
 #include "zlib_pmd_private.h"
 
@@ -15,6 +16,118 @@
 		(data = rte_pktmbuf_mtod(mbuf, uint8_t *)),	\
 		(len = rte_pktmbuf_data_len(mbuf)) : 0)
 
+#define BOTTOM_NIBBLE_OF_BYTE 0xf
+#define TOP_NIBBLE_OF_BYTE 0xf0
+
+static void
+process_zlib_deflate_chksum(struct rte_comp_op *op,
+		z_stream *strm, enum rte_comp_checksum_type chksum)
+{
+	uint32_t dictionary_len = 0;
+	op->status = RTE_COMP_OP_STATUS_SUCCESS;
+
+	switch (chksum) {
+	case RTE_COMP_CHECKSUM_3GPP_PDCP_UDC:
+		{
+		uint8_t *dictionary = malloc(DEFLATE_MAX_WINDOW_SIZE);
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
+	}
+	case RTE_COMP_CHECKSUM_NONE:
+	case RTE_COMP_CHECKSUM_CRC32:
+	case RTE_COMP_CHECKSUM_ADLER32:
+	case RTE_COMP_CHECKSUM_CRC32_ADLER32:
+	default:
+		ZLIB_PMD_ERR("Checksum not supported");
+		op->status = RTE_COMP_OP_STATUS_INVALID_ARGS;
+		return;
+	}
+}
+
+static void
+process_zlib_inflate_chksum(struct rte_comp_op *op,
+		z_stream *strm,
+		enum rte_comp_checksum_type chksum)
+{
+	uint32_t dictionary_len = 0;
+	op->status = RTE_COMP_OP_STATUS_SUCCESS;
+
+	switch (chksum) {
+	case RTE_COMP_CHECKSUM_3GPP_PDCP_UDC:
+		{
+		uint8_t *dictionary = malloc(DEFLATE_MAX_WINDOW_SIZE);
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
+		}
+	case RTE_COMP_CHECKSUM_NONE:
+	case RTE_COMP_CHECKSUM_CRC32:
+	case RTE_COMP_CHECKSUM_ADLER32:
+	case RTE_COMP_CHECKSUM_CRC32_ADLER32:
+	default:
+		ZLIB_PMD_ERR("Checksum not supported");
+		op->status = RTE_COMP_OP_STATUS_INVALID_ARGS;
+		return;
+	}
+}
+
 static void
 process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 {
@@ -27,6 +140,9 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 	case RTE_COMP_FLUSH_FINAL:
 		fin_flush = Z_FINISH;
 		break;
+	case RTE_COMP_FLUSH_SYNC:
+		fin_flush = Z_SYNC_FLUSH;
+		break;
 	default:
 		op->status = RTE_COMP_OP_STATUS_INVALID_ARGS;
 		ZLIB_PMD_ERR("Invalid flush value");
@@ -49,6 +165,9 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 
 	strm->avail_out = rte_pktmbuf_data_len(mbuf_dst) - op->dst.offset;
 
+	uLong total_in_at_start = strm->total_in;
+	uLong total_out_at_start = strm->total_out;
+
 	/* Set flush value to NO_FLUSH unless it is last mbuf */
 	flush = Z_NO_FLUSH;
 	/* Initialize status to SUCCESS */
@@ -56,8 +175,8 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
 
 	do {
 		/* Set flush value to Z_FINISH for last block */
-		if ((op->src.length - strm->total_in) <= strm->avail_in) {
-			strm->avail_in = (op->src.length - strm->total_in);
+		if ((op->src.length - (strm->total_in - total_in_at_start)) <= strm->avail_in) {
+			strm->avail_in = (op->src.length - (strm->total_in - total_in_at_start));
 			flush = fin_flush;
 		}
 		do {
@@ -92,17 +211,18 @@ process_zlib_deflate(struct rte_comp_op *op, z_stream *strm)
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
@@ -127,6 +247,9 @@ process_zlib_inflate(struct rte_comp_op *op, z_stream *strm)
 
 	strm->avail_out = rte_pktmbuf_data_len(mbuf_dst) - op->dst.offset;
 
+	uLong total_in_at_start = strm->total_in;
+	uLong total_out_at_start = strm->total_out;
+
 	/** Ignoring flush value provided from application for decompression */
 	flush = Z_NO_FLUSH;
 	/* initialize status to SUCCESS */
@@ -178,17 +301,18 @@ process_zlib_inflate(struct rte_comp_op *op, z_stream *strm)
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
@@ -203,10 +327,14 @@ process_zlib_op(struct zlib_qp *qp, struct rte_comp_op *op)
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
@@ -232,6 +360,7 @@ zlib_set_stream_parameters(const struct rte_comp_xform *xform,
 	case RTE_COMP_COMPRESS:
 		stream->comp = process_zlib_deflate;
 		stream->free = deflateEnd;
+		stream->chksum = process_zlib_deflate_chksum;
 		/** Compression window bits */
 		switch (xform->compress.algo) {
 		case RTE_COMP_ALGO_DEFLATE:
@@ -281,17 +410,30 @@ zlib_set_stream_parameters(const struct rte_comp_xform *xform,
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
@@ -302,10 +444,21 @@ zlib_set_stream_parameters(const struct rte_comp_xform *xform,
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
-- 
2.31.1

