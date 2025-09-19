Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F0BCAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 21:03:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65474402CE;
	Fri, 19 Sep 2025 23:02:59 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id F00B440298
 for <dev@dpdk.org>; Fri, 19 Sep 2025 23:02:57 +0200 (CEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JF3D6r018262;
 Fri, 19 Sep 2025 21:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=9/niJ4MpNvgjoOA/6h8mHzDAT+//7TyYGwL
 0sSHVd3M=; b=Cd5AMvYd0rg9o0xT9ux8HFQYKRpLDyRCKDsX71E7uayWzs8mzD1
 /SB+wfb5+wXxIW9KoqyNJiH8XA6/vL9wxS9jB3ZP7feXwP3J/mrE1ts7CVFa2ckZ
 RKTaEM5P05qZidW+9mhb5iAg5v3tlDM+tnKU34C6SJuh76OuoSMSTGU/fo+VtPiI
 BL3VjyzNokf8KzTSN/sSPxLwH8okZUWt+T4cEctmqW646fTQWQvSbIsRqS3zDQu7
 KBKJCvyhYGdV/eOG5gQFZ/58uY3lpZwaA3Dcwp6jRibjSPF7htuVNrFKk6HPB49Z
 k5DkXirCeQH/5cV9VBjoRHjCLcvSaJBhuRA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwkswy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 21:02:56 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JL2uIB007130; 
 Fri, 19 Sep 2025 21:02:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 497fw2ckrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 21:02:56 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JL2t7v007118;
 Fri, 19 Sep 2025 21:02:56 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 58JL2tUc007115
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Sep 2025 21:02:55 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id 546B94016A; Fri, 19 Sep 2025 15:02:55 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH 1/3] compressdev: support for dictionaries and PDCP checksum
Date: Fri, 19 Sep 2025 15:02:51 -0600
Message-Id: <20250919210253.2664545-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68cdc501 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=v35SkfTKSYa7cEv86oYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXzovYtOFoFI1S
 CL4F9pCaxEK0W7fcFJ7lrqlodkHDdK5390HoLsfShvds9u9N9rjoBHRIhrtqPLYdVrwk3zycuvM
 zM4I905nkEIXmfpzgcAMkL0htiGwBs1o4B3s7GieivoEc55bi0yqHM7Wgpo5RIdHByoXRr6TU9k
 KMTzKFjpVZVjY4+vtjx9kBTJdWIGeNKyGmjbskbhzHGK63L70bSfabLNhhAb8xGjkuvCWD7EjuU
 GPYtBJg699SHC5mPU+H7KCE/EepDL86kIwQCO370UGni02mLj7SYnh/c5zlszEsJMLWs+iPWEyb
 N+gBEcNXgO47KK+01hz0e6R2dbADDwlD6Sp9edivR19dTmCacuieyswYQfEz8s3WX7Td42VlSA9
 dJhMf4d9
X-Proofpoint-GUID: mtoupLbqIEXxrh_cKvSvfIVuncFu0Phr
X-Proofpoint-ORIG-GUID: mtoupLbqIEXxrh_cKvSvfIVuncFu0Phr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
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

Adds definitions for PDCP checksums and apis to pass in
dictionaries

Change-Id: Idbfebdd4ee0203d78ece1759fae689afaea8d6e3
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

