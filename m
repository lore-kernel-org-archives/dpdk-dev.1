Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7748ACCF9E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 18:37:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87D7540151;
	Fri, 24 Oct 2025 20:37:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by mails.dpdk.org (Postfix) with ESMTP id 60BE14014F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 20:37:38 +0200 (CEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9L8w009675;
 Fri, 24 Oct 2025 18:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6cjD+CpxAatZ1slnpIzDSnkdmRuU8lVEDEF
 b2QGMO3U=; b=dAO3y+rIFRIC50byuYZqBJZ0juLIPsVHBe08VlufPxUUHB21LXP
 CzF3y9BCvUtpjh1153TBTVmV6Tz2YcFf8Cl15m47OjRnMck+45pcEHs/O3DqQNPO
 g3sskA/NnmlYhgZFMzu8NcuOtoPlCWX9g+sd01DDolwc2jRcNXIfLl9z8eKrla9G
 umJh2ldrYnmmoTZOs8hL8VfWe1d3v9+CCip/BGJGGqEjT9glXU12/E5/JiPH+ZMq
 3GebbTxrrj8+3umHwVzpbXNes5Mg4EJ9bl7yOz63H8yBIeVQoknA02T/akwML0sy
 llCzty/KboKLrMMYgKO7/QLQJjh+JVH0s3A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27jcuv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 18:37:37 +0000 (GMT)
Received: from pps.filterd (nasanppmta01.qualcomm.com [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OIbavr003733; 
 Fri, 24 Oct 2025 18:37:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 4a0adxcc3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 18:37:36 +0000
Received: from nasanppmta01.qualcomm.com (nasanppmta01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59OIbaNt003725;
 Fri, 24 Oct 2025 18:37:36 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA01.qualcomm.com (PPS) with ESMTPS id 59OIbZNw003722
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 18:37:36 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id 9852E4006F; Fri, 24 Oct 2025 12:37:35 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH 1/2] compressdev: fix coverity issue
Date: Fri, 24 Oct 2025 12:37:24 -0600
Message-Id: <20251024183724.1686730-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX4EtsToO6LT0I
 mjWXp/CJrSMd8ctVUtU6PoTPfNn+Xdl8CTjTRnRW1Cjy8NkJwFvvDz+Um7OOc+3O4uqPuUSztAu
 m6vGoBPzsYa9dyismqwGfaM2ORKX2vgRCpL4TBsbI6GVuiTTqIVK03mHsWmb+NX2tI1rjLGFWoB
 VTE0e6OossGU28QA7DoGEXoZuVPaZZB1i+BSetev7351xP9SYt8WU5aC78StNmCrQ/HEsk2NJZi
 5Fp770YxpeFeKmm6BwBwpXu+fZ+VU7U1uC34yTM7+Y1IfXPeFuIYe8FMbispHc7UCRs5Sg4Lg0s
 ZH6lmvOy+wVSSRWIBcGlCX/rxjEVeY8RIpLOMbGB2Y82e7eWEV0/amxO64q7IQ/dtYxJ/HPcaP/
 K8zU/IooSetWNIQvEB6YcnYVzgl2UA==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fbc771 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=NBG51ibPg0Pvp_jVd8UA:9
X-Proofpoint-GUID: sADAcAhLCTbJy7AAmToxJCfJ_Qvuuvzm
X-Proofpoint-ORIG-GUID: sADAcAhLCTbJy7AAmToxJCfJ_Qvuuvzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018
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

