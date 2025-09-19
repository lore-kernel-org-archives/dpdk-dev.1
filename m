Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43019CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 20:48:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12A6A4042F;
	Fri, 19 Sep 2025 22:48:34 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 84C7E402B7
 for <dev@dpdk.org>; Fri, 19 Sep 2025 22:48:32 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JEN4Uw021478;
 Fri, 19 Sep 2025 20:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JWzkpRsMFnX
 /e1/9PV4B9DDB+nLFdP4vdDZroyXFsGg=; b=HcesoRqj+yoCdqpOv522L0PtDuY
 iYOnRB3X/lJm6R5XgZVQDcGixiQDvz1I0ndRKxvUdoSzUiM0lSD4mCcOPyR5XAtU
 0bwhMoVeEeGZ5D6oc+IbqD/JUW+FOAg/BAiu+tJyMpGl3+mmzzYQ8MUGP0UlFCZm
 cGQSIsiBamzhvgQZuynXwQo3c6Phr1QNhfP6uZjU7pZVo9uLyfduWi4X52EpuoA6
 IE3uaY6qljr397akYdTFEWo3dYx/i8Sa2sg4eQXC+FjhlkXW6S+r6c2apfxw3kaf
 1WAgOK6B+Bwjllf4bnCamAMj4k0J5P9g8+cjecaqeR+DIjAQlBeoP+Uce/A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5kuny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 20:48:31 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JKkbwO020209; 
 Fri, 19 Sep 2025 20:48:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 498uu4qu07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 20:48:30 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JKkPZj018799;
 Fri, 19 Sep 2025 20:48:30 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 58JKmTjZ027347
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 20:48:30 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id 74B414007E; Fri, 19 Sep 2025 14:48:29 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH v2 1/3] compressdev: support for dictionaries and PDCP checksum
Date: Fri, 19 Sep 2025 14:48:27 -0600
Message-Id: <20250919204827.2662199-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250919184821.2567839-1-svaze@qti.qualcomm.com>
References: <20250919184821.2567839-1-svaze@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: r289qxD6-irMyyqL4rBxsDNrtvVs3M0O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0PMH1hvnh5tQ
 XqfGYgFhu7fqrcsuDmarMpz/+U8hpnwXqTV9+eBudU9esPMQNmRNn/jZ1rHAn9ztUQKT9EvAwJK
 ScBfpZQeFuuqzp0ylIyTspMrw83+DgKSnql/MWG66defO5la9SUt8Z5WnNuV2PyNPsxujeX9+SS
 VWahopYBIX4R5Zf0XGafbnKHSft04HyN6aL023EVDmMsyl0Hf/TzqUMmkWH4g7xYVUyoL6J3jZs
 IPaAE0NeR6FAm0cMhM4U6LkM22luEz7h7xWHbs7pPRVMR/38aFjx8CrVRFFSK6jaJDvKFhiaqGa
 FXFssambT0Lz7J0zmnhPmZErGZ1FHfMSb0B2UdJavyoU7/Xbvwf6siGLGJOnJ6LngTS5wg8CrIa
 FfNJCaDL
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68cdc19f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=v35SkfTKSYa7cEv86oYA:9
X-Proofpoint-ORIG-GUID: r289qxD6-irMyyqL4rBxsDNrtvVs3M0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
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

Adds definitions for PDCP checksums and apis to pass in
dictionaries

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
 lib/compressdev/rte_comp.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

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

