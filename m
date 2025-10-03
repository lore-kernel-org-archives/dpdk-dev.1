Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90793CCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 19:49:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CE4140670;
	Fri,  3 Oct 2025 21:49:08 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id B69364060B
 for <dev@dpdk.org>; Fri,  3 Oct 2025 21:49:05 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593A1gep022701;
 Fri, 3 Oct 2025 19:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=P6Wpgwuf6ok
 KK2hKv2s0fQqgbTef4SNmHmBiqOduFeQ=; b=Xf0aAjZos+PbjmBISk4WBwiVjqJ
 xzHFyTONkzLVPCUKos/SKRDI/aCPhgBK/de56RGJV6+382Mr9HSps8ralDMRfJb5
 89drboZPqXaHhd9p4OBo6mTCf5g8F8am5XImu0yVV1e+Kw2IdvYklKf/4BHsosf5
 aCvAC1yFtsUnN3ovKbNUMUisKqLEDbzb76leFZlP7lupG2O27Iem9wmLCVIdoVEK
 qUpIWPGkrzSWT+QkuiC9gW3zqfUb+JbWRk5u/9K+D+gYPaF89ooj87Mnzx+2kFRC
 IkDG0AYuAT2kXUHaq7NpQRv1vvwSQh62kc1rdbkk8Qok/6wYxvNim5FBDSQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59nc6gj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 19:49:04 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA04.qualcomm.com [127.0.0.1])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 593Jn3KB021006; 
 Fri, 3 Oct 2025 19:49:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 49hxy6hpjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 19:49:03 +0000
Received: from NASANPPMTA04.qualcomm.com (NASANPPMTA04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 593Jn3vA020993;
 Fri, 3 Oct 2025 19:49:03 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 593Jn3RF020976
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 19:49:03 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id DB46D4009E; Fri,  3 Oct 2025 13:49:02 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH v3 1/4] compressdev: support for dictionaries and PDCP checksum
Date: Fri,  3 Oct 2025 13:48:58 -0600
Message-Id: <20251003194901.3375364-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251003165132.3201643-1-svaze@qti.qualcomm.com>
References: <20251003165132.3201643-1-svaze@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: hl1iMjERy223Np9zn1Lx0X76WxUHNYIn
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68e028b0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=ICaHq2TlwKOIBCp4uuMA:9
X-Proofpoint-ORIG-GUID: hl1iMjERy223Np9zn1Lx0X76WxUHNYIn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfXw0ruZDApbRNB
 1YlPPSfYVZvrURA0JSODs4mCfbRPk8XFDHCMci+OungbOjZbveFR4jXEr5vq7Nm5Kf1Z6j+Acvy
 f4TWI+ll5zG/tMjF2RdoaLBd9T79v74GCS2gQ5OXvkxa3Z/P+K6fLPgtLJoka27bT+3TW+OoGMN
 njbliYhc27pGKVYjOUW5K6DM6FOdTBEX/JcCs70NZDl2+xihtQEQUrRizzS+6sGYMn6AGN74ch7
 9OylENYvKYbwKMG4pDM6T2UcPBqsPeuo0BxRmFx+z2NrelTfQL4ETGhNuASIqSLtsRoPki3cJAI
 lPVgZTcM7i8hQ0pERpDMJflU2iMQMJlyqS5nNJ2CDskz2cn7j0yq4dfrqQFcG/OJTKLteyh4G4Q
 KCzpylBovBb3wZvzDWABwPGhZYSr2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_06,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001
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
v3:
* Renamed checksum validation enum
* Added missed comments for window size enum

 lib/compressdev/rte_comp.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/compressdev/rte_comp.h b/lib/compressdev/rte_comp.h
index 96d9b276dd..c5ff708a4c 100644
--- a/lib/compressdev/rte_comp.h
+++ b/lib/compressdev/rte_comp.h
@@ -101,6 +101,10 @@ enum rte_comp_op_status {
 	 * is not an error case. Output data up to op.produced can be used and
 	 * next op in the stream should continue on from op.consumed+1.
 	 */
+	RTE_COMP_OP_STATUS_CHECKSUM_VALIDATION_FAILED,
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
+/** Max window size supported by deflate. Used when setting or getting pre
+ * defined dictionaries
+ */
+
 /** Compression transform types */
 enum rte_comp_xform_type {
 	RTE_COMP_COMPRESS,
@@ -228,6 +241,18 @@ enum rte_comp_op_type {
 struct rte_comp_deflate_params {
 	enum rte_comp_huffman huffman;
 	/**< Compression huffman encoding type */
+	uint8_t *dictionary;
+	/**< Pointer to memory containing dictionary to be used for deflate operations */
+	uint16_t dictionary_len;
+	/**< Length of dictionary to be used */
+};
+
+/** Parameters specific to the inflate algorithm */
+struct rte_comp_inflate_params {
+	uint8_t *dictionary;
+	/**< Pointer to memory containing dictionary to be used for inflate operations */
+	uint16_t dictionary_len;
+	/**< Length of dictionary to be used */
 };
 
 /**
@@ -321,6 +346,8 @@ struct rte_comp_decompress_xform {
 	 * setup of stream or private_xform should fail.
 	 */
 	union {
+		struct rte_comp_inflate_params inflate;
+		/**< Parameters specific to the deflate algorithm */
 		struct rte_comp_lz4_params lz4;
 		/**< Parameters specific to the LZ4 algorithm */
 	}; /**< Algorithm specific parameters */
-- 
2.31.1

