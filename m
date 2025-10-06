Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D25CCA470
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 20:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3CC5402E2;
	Mon,  6 Oct 2025 22:09:11 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 22C0D402D1
 for <dev@dpdk.org>; Mon,  6 Oct 2025 22:09:09 +0200 (CEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FBFfD023916;
 Mon, 6 Oct 2025 20:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BbDsi+p6e7k
 MXDAtvt+Q03/V8gHCr3QuH9dE4KyHjC4=; b=dVpZGwwymizvD3R2T/K9tLNAnar
 WexzYa9FrnsFLXuDGymQO3+eq/QCAYpU83WjAtL+Mh5uYT8L2EtAg2pOsoTre8SN
 TyIUIrV0Jwy7uCXA+rJ9Td3mmibqBIM7Igwlw6v44JBzDuEvnw/GZP/vUk9qO8YP
 ej4OTeUlD9dtyWg01E2+W9c7PX9r8CWqw2nFDxReUShlH4e+oziIKa6FyugzV1tX
 3XvzvKLWx7pjm1ftYnJFfcoWflCIP+ZCAeQoUyCmPscVyV/l1mbKMDcqF2wrUOna
 72zPYNOHPs5LfUfK9ZvVx97HExJDYG9Qc8t8wR3RAw9AFGVQC0Tt9EY0MFw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mg6a8rvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 20:09:08 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 596K98BD005145; 
 Mon, 6 Oct 2025 20:09:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 49jvnmkwxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 20:09:08 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 596K986U005138;
 Mon, 6 Oct 2025 20:09:08 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 596K97ND005128
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 20:09:08 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id 800CD4009E; Mon,  6 Oct 2025 14:09:07 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH v4 1/4] compressdev: support for dictionaries and PDCP checksum
Date: Mon,  6 Oct 2025 14:09:01 -0600
Message-Id: <20251006200904.2467957-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251003194901.3375364-1-svaze@qti.qualcomm.com>
References: <20251003194901.3375364-1-svaze@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=QtdTHFyd c=1 sm=1 tr=0 ts=68e421e4 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=ICaHq2TlwKOIBCp4uuMA:9
X-Proofpoint-ORIG-GUID: KDAXe8vpo4Gb-PDqaGduZfAflIw5xJ1B
X-Proofpoint-GUID: KDAXe8vpo4Gb-PDqaGduZfAflIw5xJ1B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMSBTYWx0ZWRfX6hpVj3oOgdYl
 CKoszhf9UsA/wweg13g23EiGnUEBHO0XZ2qnJk2xROFCxd9PGtYN+0LC5XRZNxd7cb+9YmN0dGr
 WTom3Joj/xXlHcqEv4SsSeZVNF+wCDgmLsBrXZwG8gz51jHGp783OHWpudugX31hUt/aGqNa/f5
 lCm5wizBBZaFq1MMqcKt6Np7dOlHPuhUdUoUCb2aN4Ip66qCelrfhH3l6lfqH8edM7N8yTvue7d
 leeeDgO1ZU8aVrMnK8Z1oPKFEI+LqlS4sLpLltP6z6Be7d5L6kkfYjsD3y8bqBzPByeZNn6iA58
 +oSVfeMOr3eyaM06rqRWI99ryP8rUSoOrZKDY/Ph7E8BnyXWJiKb8LTNskrwdTa9mmHe5R/1pNr
 4HH2D/S4iXUCP+sfbS8ZFyhJsymprw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060121
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
v4:
* Removed enum for max window size

 lib/compressdev/rte_comp.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/compressdev/rte_comp.h b/lib/compressdev/rte_comp.h
index 96d9b276dd..6384a388d4 100644
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
@@ -228,6 +236,18 @@ enum rte_comp_op_type {
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
@@ -321,6 +341,8 @@ struct rte_comp_decompress_xform {
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

