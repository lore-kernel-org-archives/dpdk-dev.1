Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6DECCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 18:47:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 883BE40151;
	Fri, 24 Oct 2025 20:47:32 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id C0B6E4014F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 20:47:30 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9KMo020691;
 Fri, 24 Oct 2025 18:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6cjD+CpxAatZ1slnpIzDSnkdmRuU8lVEDEF
 b2QGMO3U=; b=WPTIAk421wkUyKLBeI9RQ5Ftn/ePl09tl7bZZzmNJq+/DjfbfYo
 aZrDqvqZiVULsIZNEPy/eE1if4D4zKESCJsjwzA/ZwwPbkoLMdi8LAmu13LzHzTA
 /7Bv51PV/VWukzv3Z7aWRdN8w1UWXTbXSM+ieJ6Akf9GzFTuJIe59ysZTLl2ULtM
 bctK/OnOe46lYXxXFImfpnsBtnE05e7a7vqm3kLBTGrM/NHSma0YTj+P4ogBMPZ0
 pjVZqubF+YcB7wn6nMd+4nMiaeZ9ecaaWHLEIYaHxdB1VuLfhID0h6Y7ubcSe92p
 0cxhM/h8hT3CD12bRYXlBGDslCNZCeuq4Lg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pw6tm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 18:47:29 +0000 (GMT)
Received: from pps.filterd (nasanppmta01.qualcomm.com [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OIlSBO019741; 
 Fri, 24 Oct 2025 18:47:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a0adxcfsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 18:47:28 +0000
Received: from nasanppmta01.qualcomm.com (nasanppmta01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59OIj5S0015578;
 Fri, 24 Oct 2025 18:47:28 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 59OIlSw6019730
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 18:47:28 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id E2AB24006F; Fri, 24 Oct 2025 12:47:27 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH] compressdev: fix coverity issue
Date: Fri, 24 Oct 2025 12:47:24 -0600
Message-Id: <20251024184724.1698235-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX6bvoyrfCsDB8
 ZNkraMeFRf87/9+HXsPXzbIXS/GkOboG7HsK5aMQa8z4evlGvFEySE4T2TE3DvLytSCFQooNcc9
 f1ep179AB82ag9VfPkL5jm56no0upFlBVg8Qzc39M7iNtibDy+0qLDq7nspYFHQjGKj5x1lqCJ3
 CNn60wv/kWt5TmVRjMsoIa9YF3qBSOtw878mLZtpgUYNwrxRE/qsIlqQPN8bL+YoIAkpyqG9B7g
 /1vIa2+WQzKttiwDza8WGz8iy86wZqOXbSz7M1WsPFP5tCEZLZp7VfMYjx3F4xnEGr0RWdK0rlL
 MxNIGqJJRpW19eMCZ9Eo1JM9PrnBd7eiyBH28IpZBnHD1V70bZoNBxh1uP9yWlGmn6mYAnII263
 5GILXPyhdb/I5uPxf7IOySpCoUlOWw==
X-Proofpoint-GUID: utdHxlpFW3MHYueDsC8Vd8Zi7_7ob0Lx
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fbc9c1 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=NBG51ibPg0Pvp_jVd8UA:9
X-Proofpoint-ORIG-GUID: utdHxlpFW3MHYueDsC8Vd8Zi7_7ob0Lx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000
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

Adds missing free before end of function

Signed-off-by: Sameer Vaze <svaze@qti.qualcomm.com>
---
 drivers/compress/zlib/zlib_pmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_pmd.c
index 3a2485b54e..1d7651dd7d 100644
--- a/drivers/compress/zlib/zlib_pmd.c
+++ b/drivers/compress/zlib/zlib_pmd.c
@@ -126,6 +126,7 @@ process_zlib_inflate_chksum(struct rte_comp_op *op,
 		free(dictionary);
 		return;
 	}
+	free(dictionary);
 }
 
 static void
-- 
2.31.1

