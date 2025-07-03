Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7E4C77B7C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 11:59:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B44940267;
	Thu,  3 Jul 2025 13:59:15 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by mails.dpdk.org (Postfix) with ESMTP id EAC4740264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 13:59:13 +0200 (CEST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5639Z09O008258;
 Thu, 3 Jul 2025 11:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=SzaEWqxBy5y5iOh6UIUq9u5xP6tjS
 po0I0sKyVAZ0b4=; b=OlHbev0zVzSQ7I3ROQM59y6h0wqZPLLqPsR7HG774bn58
 evZl/4uw/PxPZ/kSTtFab5LMGue5BW2DayEZVook5pexvgOdJOSJuPktAHznsrjD
 x26tqZcLWvU7YKucakpxaeo0bWL/ucoll2o0w3RJcKZO9fyFk/2tQd/5lmV7KDGG
 KoxSIkNnJ7CyagOpmF4dDBXnb7GPZOOVYidOSCw67vg7B2oTT+5x13SEMvL3JjuB
 Fq2TVa9flI+jIWCgyPIYGf3KZXLUJzirrxR8RHqFjyTPgCCwY6IM94+i3mW3BMEc
 PR2RcYRFBKkChwwOkXNoIs3HazrZiirsdBMFdAmMw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum803vc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Jul 2025 11:59:11 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 563Bp2Ev019295; Thu, 3 Jul 2025 11:59:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47jy1haes9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Jul 2025 11:59:10 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 563BxA2E016093;
 Thu, 3 Jul 2025 11:59:10 GMT
Received: from dhcp-10-48-119-207.wifi.oracle.com
 (dhcp-10-48-119-207.wifi.oracle.com [10.48.119.207])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 47jy1haeqj-1; Thu, 03 Jul 2025 11:59:09 +0000
From: madhuker.mythri@oracle.com
To: chas3@att.com
Cc: dev@dpdk.org, Madhuker Mythri <madhuker.mythri@oracle.com>
Subject: [PATCH] net/bonding: avoid RSS reta update in flow-isolation mode
Date: Thu,  3 Jul 2025 17:29:03 +0530
Message-Id: <20250703115903.7157-1-madhuker.mythri@oracle.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=851 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507030099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA5OSBTYWx0ZWRfX1SVEXStxyfIo
 NbdbZlef2CrlYOICDVMi1ZiBBQpPVC7pxX5SyWUC+YLy722AJY2ssW4Jq1pDckg2H60y4lrT8hJ
 0GgoLCEP7jorEJRjsMaerbVEFZIdojK+UHr8XehHXGKWWM0SfcPBoN1pdH23rN0qdGBWTbaTFHg
 28q/atvXBssJl8ttUAGsLQPId860B7kCk3OS8N7YeGQ9Hc7Ihp9Gog4tGsY5mD+F3RkJEkcbhaQ
 rkJJ3l5YPshqQ04CaF4cSan7Djf+Pbn7Vp/pLpBkawOLkP4cMQqCZGhatjZLp+bS4ZaPbChdI9h
 qVgbDYa41aqbAYAsi6DBhqzkGcaTEOwHAwtLnr2oW0PGLY0RP0VJzW800Lop19GLgF7swcdiZIa
 9OMKO6O/9OxH2E+qvEXJA1eR4S1scTEURPU9ypEKprtwTeVc8vpDeN98RgXte7Wxom0VQ63W
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=6866708f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=wFzsDpVAP8CWgpi1Ir0A:9 cc=ntf
 awl=host:12058
X-Proofpoint-ORIG-GUID: TA1une7TOMWOCfkKytnzYsDtInsAoKeA
X-Proofpoint-GUID: TA1une7TOMWOCfkKytnzYsDtInsAoKeA
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

From: Madhuker Mythri <madhuker.mythri@oracle.com>

In bonding PMD, member_start() function checks whether RSS(mq_mode) is
enabled and then calling the RSS rte_eth_dev_rss_reta_update() API, which
is returning error in-case of device configured in flow isolation-mode.
When the device configured with flow isolation mode RSS reta update is not
required and the API was not supported. For example in-case of mlx5 PMD,
RSS reta update API was not supported, when the device is configured in
flow isolation-mode.

So, added check to verify if the device is configured in flow-isolation
mode, then do not call the rte_eth_dev_rss_reta_update() API.

Signed-off-by: Madhuker Mythri <madhuker.mythri@oracle.com>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 83339bae3d..b8fecb85d2 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -1904,12 +1904,11 @@ member_start(struct rte_eth_dev *bonding_eth_dev,
 		}
 	}
 
-	/* If RSS is enabled for bonding, synchronize RETA */
-	if (bonding_eth_dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS) {
+	/* If flow-isolation is not enabled, then check whether RSS is enabled for
+	 * bonding, synchronize RETA */
+	if (internals->flow_isolated_valid == 0 &&
+		(bonding_eth_dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS)) {
 		int i;
-		struct bond_dev_private *internals;
-
-		internals = bonding_eth_dev->data->dev_private;
 
 		for (i = 0; i < internals->member_count; i++) {
 			if (internals->members[i].port_id == member_port_id) {
-- 
2.39.5 (Apple Git-154)

