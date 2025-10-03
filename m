Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F71DCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 16:51:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81253402D9;
	Fri,  3 Oct 2025 18:51:46 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 243F240281
 for <dev@dpdk.org>; Fri,  3 Oct 2025 18:51:43 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593Ae3tx023326;
 Fri, 3 Oct 2025 16:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vdlB1HOZXHW
 /cKVzzKLFTOMQ0yFWoYFIFDWV/FwZ/F8=; b=UhOJs0MQdDImhvGYZ/CEWQqin5I
 d3t7uXnrZTV69zwVyN/HFV9fRocCfCaheOVnP4bzWjfHyMO8GV/CNri3idPXHlZg
 f7H/IXSRgII6bnsR/HVzNtQDwZy8qFWPbK0/u0jtc9vbzKKGtNp3qoeoNJrMmhpx
 gVBC47s3hz6EGW/x5Q+/U4KYayABA1LEPGcR3kXt2d347/58B9uRq/AZ0CJWTX0q
 YNErhmfI5i+laSGiyBronFXiAEOV1BuaHGoOXJrWkPgbuGg8gvNCcFOMqBzzU56a
 M7WOXSTtM4n5eamXg+G/kUoQ8oykaKAkTwxwzmnBbSbH0ZsMNG5U9/ZFwiw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a6be6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 16:51:42 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 593Gperi023503; 
 Fri, 3 Oct 2025 16:51:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 49gjtev7cu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 16:51:40 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 593Gpeex023495;
 Fri, 3 Oct 2025 16:51:40 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 593Gpen0023490
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 16:51:40 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id C5BE4400A3; Fri,  3 Oct 2025 10:51:39 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH v2 1/3] compressdev: support for dictionaries and PDCP checksum
Date: Fri,  3 Oct 2025 10:51:30 -0600
Message-Id: <20251003165132.3201643-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250924161918.2211290-1-svaze@qti.qualcomm.com>
References: <20250924161918.2211290-1-svaze@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68dfff1e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=ICaHq2TlwKOIBCp4uuMA:9
X-Proofpoint-GUID: spybECaa2yvwVM9wR3bAc8R9hOcN7igJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX5/K7eQ0Vsh31
 Id1EKzH90rSmSydQCiv1CK4giH/FWym2PJQpQf5PtZz9HT5+fGUpM+P51koEoq9LRJcHhUy/cHa
 2n3Jd+cf96JgJOovcOSqys5n8c1ZvweDnTe8CZ85cOmq24b8XdGLt0mg50G/RMLYbgwAu7C0zkE
 dvV8qPxabK8wncPP7G2C1gfaTGiZXhjujyZQJWivCqRKUDFaKaKEK5sZNHYxlYo47GXIXYWdPn1
 md8SJGeqICNegpzsuosad+imLsXiVAuue+i79LIwz8HVE4BFVPQlOzZ/ybI10AiLz13tW79Ja5D
 v2eN/HOvngSuyXWLeA5C3JN/ODJJIPN4WZZMJ4ZMdMUhyHQ10Aj3OrlzT5RfJK3tRRHCeqm6D4P
 PpJrLpGEvhAd0souQz04R5bhaUScgA==
X-Proofpoint-ORIG-GUID: spybECaa2yvwVM9wR3bAc8R9hOcN7igJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033
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
v2:
* Moved dictionary params to deflate params
* Added infalte params to union

 lib/compressdev/rte_comp.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/compressdev/rte_comp.h b/lib/compressdev/rte_comp.h
index 96d9b276dd..25835d589d 100644
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
@@ -201,6 +209,10 @@ enum rte_comp_flush_flag {
 	 */
 };
 
+#define	DEFLATE_MAX_WINDOW_SIZE	(1ULL << 15)
+
+#define	DEFLATE_MIN_WINDOW_SIZE		(1ULL << 8)
+
 /** Compression transform types */
 enum rte_comp_xform_type {
 	RTE_COMP_COMPRESS,
@@ -228,6 +240,18 @@ enum rte_comp_op_type {
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
@@ -321,6 +345,8 @@ struct rte_comp_decompress_xform {
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

