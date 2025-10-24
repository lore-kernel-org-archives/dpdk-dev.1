Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8A4CCD1BF
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 19:11:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 563DF40151;
	Fri, 24 Oct 2025 21:11:13 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by mails.dpdk.org (Postfix) with ESMTP id 7F5B44014F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 21:11:12 +0200 (CEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9PK5009075;
 Fri, 24 Oct 2025 19:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=qwlN4c003fkch/49X/p+VLYGaS5dAsSXLH8
 1eDjwrMk=; b=Ptcq8NJdTde9qgMOjjZGa5mCQQxFA3mAEYX+g2t23WIM4q3gvHj
 fRjT7UO43x82CGi48qeDDKxIUdSsmpPFDQHUfhFZdHNUaSADyYx+X826psWNkIhB
 6HnZUFEUJxO6seVQW491I60ngBmVmaMvgWy4vn6uFfQG0AxKEWTeQbgH9HW/+3/9
 u+4tewxTl0+w9meerqpmH/02uQgvZYRjdlviG2TAuZsMSh3vT0KtzlnvQKG7lahe
 y9SjHVpMXdVkQyD6BQU+LtdvabvHHdQX3bjgUbCjrIo3kGwgfx4gmFP/sZ39MTQR
 XgzyJL260rbfD5VC/dO1L0Qszs6Kro+J1XQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ym9j4nca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 19:11:11 +0000 (GMT)
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OJ8oBF027144; 
 Fri, 24 Oct 2025 19:11:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 49yufwhhmq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 19:11:11 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59OJ9cuE028408;
 Fri, 24 Oct 2025 19:11:10 GMT
Received: from tbs-5gnr-mt-30 (tbs-5gnr-mt-30.qualcomm.com [10.239.80.165])
 by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 59OJBAOb030980
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 19:11:10 +0000
Received: by tbs-5gnr-mt-30 (Postfix, from userid 2316195)
 id 22A314006F; Fri, 24 Oct 2025 13:11:10 -0600 (MDT)
From: Sameer Vaze <svaze@qti.qualcomm.com>
To: Sunila Sahu <ssahu@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashishg@marvell.com>
Cc: dev@dpdk.org, Sameer Vaze <svaze@qti.qualcomm.com>
Subject: [PATCH] compressdev: fix coverity issue
Date: Fri, 24 Oct 2025 13:11:08 -0600
Message-Id: <20251024191108.1728811-1-svaze@qti.qualcomm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=CLknnBrD c=1 sm=1 tr=0 ts=68fbcf4f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=NBG51ibPg0Pvp_jVd8UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDExMiBTYWx0ZWRfX29C1LPbaMrEB
 6VPlSoASOli3BFPFwKVuEIwrvHJvhUa0OugN10SFmC+Jns6elscXm91v3462sjH5wc15SiQjOuT
 +r/RYufH2tTiICKquUVfvm7piWxMmlWSOnkjJ1x2OUfkyJG4AM4n8H6n7PMjWtDqD+oRmO3gCA9
 E1xaD5oYfFsu5TEoAU2fv0cUHl8SgxNGXyr7qI4vatycl5RtvcssbQ6cNdt6HHiqVx5z4qe3U75
 J+Hv7TK2tD0ha7BGyNHCVc6RbVGZwVQhR+dyfenOMmm3nkxbOBaZtfYR8fXK8BAgYZOnXAxeESo
 olLveAfDu6Li8xZwcN6+bcElv1RmdF5C1cGmefNwNhi1D8epmxxmpj71nHv0cAGsL9D94nEn4M1
 HCLTxkL0Ldqx7+1SV1VO0eB/r4vBHQ==
X-Proofpoint-GUID: dnuD4Nd26F8O30vIeKC3UrMifk46cGK4
X-Proofpoint-ORIG-GUID: dnuD4Nd26F8O30vIeKC3UrMifk46cGK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230112
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

Coverity issue: 490941
Fixes: 72c6fcc18429 (compressdev: support dictionaries and PDCP
checksum)

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

