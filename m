Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF30D609DF
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 19:36:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D33E1402D0;
	Tue, 16 Dec 2025 20:36:23 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 2B3D64026D;
 Tue, 16 Dec 2025 20:36:22 +0100 (CET)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BGDhmPd3745801; Tue, 16 Dec 2025 19:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=qalSqcetPP1sX1Phh+fwLAKOsWJFHPu0NyY
 LP5EsxpM=; b=BwuIs8TXozF9opBwwYr+72i4PIaSXqhQVwIZHcPydDdK2gFv7Sl
 WIfHC+8qT4L6FSHrlYoD+rvllfRMHBKMABZwaHU76ftjo+9RkT/GWF2V/x1kI6iQ
 7yPDz4MvWW4V/BCmJvFIq4mIGoN1Papy1S6BktFRqM22wrdSGoAHbYBZMIIfYAUh
 qSCaASULiQFAL1RQIRBFBMi971NFj7jjs6PiR4wem1wsjqM4RvA3fpXu1oe6mLja
 lICk7BbgDva+PPUqSgldT75aiOZxcgrO+MoqAS+QcL1FdqucO6grt0stA8bfe5KK
 SRonMYWrAPE44EUMSxBg1KUbLGOYJThRC7g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b33xj2ep7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 19:36:21 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGJaK8G012403; 
 Tue, 16 Dec 2025 19:36:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 4b36dvp3h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 19:36:20 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BGJaJwq012397;
 Tue, 16 Dec 2025 19:36:19 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 5BGJaJHn012391
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 19:36:19 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id E5D7B4013C; Tue, 16 Dec 2025 12:36:18 -0700 (MST)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>, stable@dpdk.org
Subject: [PATCH v1] compress/zlib: fix UDC checksum logic
Date: Tue, 16 Dec 2025 12:36:16 -0700
Message-Id: <20251216193616.373430-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: sL0WVeKheGMwwDkHnDptrhPM06HHM8zk
X-Proofpoint-GUID: sL0WVeKheGMwwDkHnDptrhPM06HHM8zk
X-Authority-Analysis: v=2.4 cv=KtNAGGWN c=1 sm=1 tr=0 ts=6941b4b5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=8rWy6zfcAAAA:8 a=EUspDBNiAAAA:8
 a=3MbKbkNApmZOBSheXjMA:9 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE2OCBTYWx0ZWRfX6Lr04Fyh7TPY
 G0xHmCyaHJw3yzpz4qd5sKJmuNKjtSgyRBcumwAVpbMn7KRGX5lN3ULFKYgikBbVBytNANdFns0
 9KIRgVprXX40gaXV+VHM+dMLlt+Ko4eXB/NsfiXtANv3AyiUkSueRUoHjS7ZllIB7S0XbVlA2Qb
 vnvzA2T5Wt0P7zwrdrcK7dPRWAYrswHFAwZbEr9HVkUGEellQtRGPxLLFDbI1N1X0lsvqZeZyRx
 uWtqUql7wQhF3uJJUszTkOlGD0j7qL2YNJr2zyHkREC+WzEUujoz/C8FjWkjms/0YDeS8tefiUL
 fGU5WVfA0XjGte7nzxByJmyggh54trx253hgauEJVNgfbfuiLlkJ7uMETa4bWx2exlGwo19KlRm
 b6RRK+UEi3zN/+nKuWE9BwsTXYIQOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160168
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

Fixes bugs with casting and checksum calculation for
UDC checksum

Fixes: 0dc314debb22 ("compress/zlib: support dictionaries and PDCP checksum")
Cc: stable@dpdk.org

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
 drivers/compress/zlib/zlib_pmd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_pmd.c
index 1d7651dd7d..bb970912cb 100644
--- a/drivers/compress/zlib/zlib_pmd.c
+++ b/drivers/compress/zlib/zlib_pmd.c
@@ -48,12 +48,12 @@ process_zlib_deflate_chksum(struct rte_comp_op *op,
 			return;
 		}

-		dictionary_start = (uint32_t)(*dictionary);
-		dictionary_end = (uint32_t)(*(dictionary + dictionary_len - 4));
+		dictionary_start = *(uint32_t *)dictionary;
+		dictionary_end = *(uint32_t *)(dictionary + dictionary_len - 4);
 		sum = (dictionary_start & BOTTOM_NIBBLE_OF_BYTES_IN_DOUBLE_WORD)
-			+ (dictionary_start & (TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD >> 4))
+			+ ((dictionary_start & TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD) >> 4)
 			+ (dictionary_end & BOTTOM_NIBBLE_OF_BYTES_IN_DOUBLE_WORD)
-			+ (dictionary_end & (TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD >> 4));
+			+ ((dictionary_end & TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD) >> 4);

 		op->output_chksum = ~(sum_bytes[0] + sum_bytes[1] + sum_bytes[2] + sum_bytes[3])
 			 & BOTTOM_NIBBLE_OF_BYTE;
@@ -98,12 +98,12 @@ process_zlib_inflate_chksum(struct rte_comp_op *op,
 			return;
 		}

-		dictionary_start = (uint32_t)(*dictionary);
-		dictionary_end = (uint32_t)(*(dictionary + dictionary_len - 4));
+		dictionary_start = *(uint32_t *)dictionary;
+		dictionary_end = *(uint32_t *)(dictionary + dictionary_len - 4);
 		sum = (dictionary_start & BOTTOM_NIBBLE_OF_BYTES_IN_DOUBLE_WORD)
-			+ (dictionary_start & (TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD >> 4))
+			+ ((dictionary_start & TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD) >> 4)
 			+ (dictionary_end & BOTTOM_NIBBLE_OF_BYTES_IN_DOUBLE_WORD)
-			+ (dictionary_end & (TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD >> 4));
+			+ ((dictionary_end & TOP_NIBBLE_OF_BYTE_IN_DOUBLE_WORD) >> 4);

 		op->output_chksum = ~(sum_bytes[0] + sum_bytes[1] + sum_bytes[2] + sum_bytes[3])
 			 & BOTTOM_NIBBLE_OF_BYTE;
--
2.31.1

