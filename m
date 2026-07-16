Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4818C44512
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 14:56:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7FC5540270;
	Thu, 16 Jul 2026 16:56:17 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id C60C9400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 16:56:15 +0200 (CEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDJuLk2721923; Thu, 16 Jul 2026 14:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=zQmxEw8uIwGeUiS4bOLu5urSBP44PrJub0p
 wSBdzjYU=; b=FzbgK2Cr9fWLaxBU6IEx1XPQJF4GC4oRA+Ch0hjgeOGv0v2F7lV
 EWPNMfLKl9RL2KZj1KaH9H5zIRO9Apn7khRWZ+FVXh2hEuNM9/zlS13HcApXnZao
 BW7QqT6++uJPcKsVsOsoC7j0gF8wak5cM0PALgQ5d0mrU87HHk3QbayPPlxVUnAB
 nvsUzXueYvo5QujVq8apkZmh3o7Lonqv6YORqx5AzkOTa0fKAKEQx/OHYS5aFZJY
 uue0XBH/oH9GhhgOxqetGT4YC5DNDdWWsaVVgoSIsN1UhwUlWHz5r1Biy0JTTkIW
 Fo+rRQABQlDbvx8/AUvl/0wgPZobs27F4ZQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feehvcfgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:56:14 +0000 (GMT)
Received: from pps.filterd (nasanppmta04.qualcomm.com [127.0.0.1])
 by NASANPPMTA04.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GEs2mM030073; 
 Thu, 16 Jul 2026 14:56:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 4feja987g9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:56:13 +0000 (GMT)
Received: from nasanppmta04.qualcomm.com (nasanppmta04.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66GEuCeA002404;
 Thu, 16 Jul 2026 14:56:13 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA04.qualcomm.com (PPS) with ESMTPS id 66GEuCkO002321
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:56:12 +0000 (GMT)
Received: by tbs-5gnr-mt-30 (Postfix, from userid 467048)
 id 15457BB; Thu, 16 Jul 2026 08:56:12 -0600 (MDT)
From: Sana Kamboj <skamboj@qti.qualcomm.com>
To: kai.ji@intel.com
Cc: dev@dpdk.org, srizor@qti.qualcomm.com,
 Sana Kamboj <skamboj@qti.qualcomm.com>
Subject: [PATCH] crypto/ipsec_mb: fix out-of-place operation handling
Date: Thu, 16 Jul 2026 08:56:10 -0600
Message-ID: <20260716145610.1654914-1-skamboj@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=ZpDd7d7G c=1 sm=1 tr=0 ts=6a58f10e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=1xJUU9gEoM7YqYb0yesA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1MyBTYWx0ZWRfX1jzVXfSs5IPG
 gI+jZOpLhX8XATGIexWW6suU+1AzLb42PGJhbsIbWEKrEKR3ujAjBgH8ayobkfUrWCSvMITDf3F
 hLwkilsDXTEgoxKeOMZNXAz5um7tHoxhkLZRNoxFJC3Ss5yOmWqefEzHjGsUaWrz966llGoKVKe
 IQ1kXrTmW4qN1XTgKTEQfxShD1S4TxdWApiag5CJv7Hv/ZCTS+FvIvrfAywJu4W/U/tKL1t7bgR
 Iyy7TIlxCp21k4Y+yhFmoB6CqD39jcZQ3UzEe20EyrMHfkBMC3Ymw747Y0Bi7VIrhMp3ztkA2JS
 oVz2xi5D1oOjPUhHXDr7pQbXFC0fuRYoqfnzngMhtCvtAdLqptr6gxbCiup3ayDV5bukW83Zhtm
 TvtHyMd6IzQ++9RlXvJ4pX1p+skhNMfSprAKmqFNR93R2/14DqfjtlosKV/KatfF18Q+XNCuEfX
 TLq+ZTvAWlXCtGz63LA==
X-Proofpoint-GUID: PQmPCLdkOQImuld9HTn9q0jtGR-HTCbO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1MyBTYWx0ZWRfX5vqcqGGQrzKz
 OjkQUpk9DBk9Uc/M7SaXeh+4yGZk5wuYKE2+/vC5HYpFTKoyHCak7x/bS/hgD21kp4PYRPROv9Y
 bzxnaww4+efu6mLvv0VQyXFPwxOKAsI=
X-Proofpoint-ORIG-GUID: PQmPCLdkOQImuld9HTn9q0jtGR-HTCbO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160153
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

Fix incorrect buffer handling in out-of-place crypto operations.

For out-of-place scatter-gather sessions with NULL security, an
unnecessary memcpy() may dereference an invalid destination buffer and
cause a segmentation fault. Remove the redundant copy operation.

Also add the missing buffer copy for out-of-place non-scatter-gather
sessions, where the output data was not copied to the destination
buffer for the following transform combinations:

- NULL cipher with NULL authentication
- NULL cipher with authentication enabled
- Cipher with authentication enabled

These changes ensure correct out-of-place processing across the affected
transform combinations and prevent crashes in scatter-gather cases.

Cc: skamboj@qti.qualcomm.com

Signed-off-by: Sana Kamboj <skamboj@qti.qualcomm.com>
---
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index 4c5b6e70b5..aa3fb4c262 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -1824,12 +1824,6 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		job->msg_len_to_cipher_in_bytes = op->sym->cipher.data.length;
 	}
 
-	if (cipher_mode == IMB_CIPHER_NULL && oop) {
-		memcpy(job->dst + job->cipher_start_src_offset_in_bytes,
-			job->src + job->cipher_start_src_offset_in_bytes,
-			job->msg_len_to_cipher_in_bytes);
-	}
-
 	/* Set user data to be crypto operation data struct */
 	job->user_data = op;
 
@@ -1845,6 +1839,22 @@ set_mb_job_params(IMB_JOB *job, struct ipsec_mb_qp *qp,
 		else
 			return multi_sgl_job(job, op, oop,
 					m_offset, m_src, m_dst, mb_mgr);
+	} else if (oop) {
+		if (cipher_mode == IMB_CIPHER_NULL) {
+			memcpy(rte_pktmbuf_mtod(m_dst, uint8_t *),
+				rte_pktmbuf_mtod(m_src, uint8_t *),
+				job->msg_len_to_cipher_in_bytes +
+				job->cipher_start_src_offset_in_bytes);
+		} else if (cipher_mode == IMB_CIPHER_SNOW3G_UEA2_BITLEN ||
+				cipher_mode == IMB_CIPHER_KASUMI_UEA1_BITLEN) {
+			memcpy(rte_pktmbuf_mtod(m_dst, uint8_t *),
+				rte_pktmbuf_mtod(m_src, uint8_t *),
+				job->cipher_start_src_offset_in_bits >> 3);
+		} else {
+			memcpy(rte_pktmbuf_mtod(m_dst, uint8_t *),
+				rte_pktmbuf_mtod(m_src, uint8_t *),
+				job->cipher_start_src_offset_in_bytes);
+		}
 	}
 
 	return 0;
-- 
2.43.5

