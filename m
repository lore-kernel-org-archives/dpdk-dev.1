Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7A6C8303D
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 13:22:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1406E402CE;
	Fri,  4 Jul 2025 15:22:30 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by mails.dpdk.org (Postfix) with ESMTP id EB26240267
 for <dev@dpdk.org>; Fri,  4 Jul 2025 15:22:28 +0200 (CEST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5649YvW5018041;
 Fri, 4 Jul 2025 13:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=6dCIxXd+oJ7wXJGa76JQ5ReCRgvcK
 Gh3HRIZ9yR68HQ=; b=Lus1dxsNiUoeTP4g6Z4Gc4QLgBrikWrawqOkIbAMdVI1a
 liKeUAnxf38M9mtI9Om5A39WDY0AD2xxpg132xUHNWXoHqSLWnLHzadExBPtAUFI
 MHO6iMcMxEU5p8X0Rx9ewD6VusE6a4oY/BhadcnyZ2AQlwurv8zwMdAGpCVMmP4T
 Femsjf8JOtkb/BF8vNAUqs5eFz7Ux/ZlNnzjw/qcRlrPcJ8f9ag/Hj+6D9EE4y+y
 UWOgEtbpqJemt2PbZfbjEw+54OnrgX3ytiVnLGqgq5izOJJqWMDYXN8/ReZ2lwCD
 K2Qoz9KOEClXgb/8HhaAomQK50cczFif0opxN8qJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704jvx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Jul 2025 13:22:25 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 564CBfs0032568; Fri, 4 Jul 2025 13:22:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6un3y33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Jul 2025 13:22:24 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 564DMOGs005506;
 Fri, 4 Jul 2025 13:22:24 GMT
Received: from dhcp-10-48-115-21.wifi.oracle.com
 (dhcp-10-48-115-21.wifi.oracle.com [10.48.115.21])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 47j6un3xy9-1; Fri, 04 Jul 2025 13:22:23 +0000
From: madhuker.mythri@oracle.com
To: chas3@att.com
Cc: dev@dpdk.org, Madhuker Mythri <madhuker.mythri@oracle.com>,
 tomaszx.kulasek@intel.com
Subject: [PATCH] net/bonding: avoid RSS reta update in flow-isolation mode
Date: Fri,  4 Jul 2025 18:52:07 +0530
Message-Id: <20250704132207.5021-1-madhuker.mythri@oracle.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=941
 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507040101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwMiBTYWx0ZWRfX1DcvX2ZwyBjq
 i4VA+8dsYIcE/SYQdr3tO6YBPf7LKKNBPzG0CJ2s9phtDZx9XB3Jdh/4xn14bXZDHl6LjYvTYhn
 VvxkNVzBxEuvBnzf+gJk7geF4W/q7GqYvUNDnb4Dd0dCrrsM5O7Lo3BbVem8R31JrgDpI6Dy4Um
 hDIJDrvejATwXdHJ7IaXjv8HtHXV8z+Bi03yoUCiLckaw80f1wVXXQ71qYesuOsMwKzlH9aHSU3
 DUBc48gIHSY1SCi+Q1TRGp8EexYcv00Qz0I4llysCsFWB+W7V9blAwQgKca/Lv4K22rwoYl2usH
 tLbiMyEy84aDyjQ2ubZvoruVe9gp4HoSbZVYvivAywXTVcHPSCT6/WPNS8K+ywVytLXjBlpzbFU
 /ZHg14bZn6xczmNcqs++KIyTeaSL2ls6S68jhuN9WBKjJW0u0lciq8qu5mLOG7R8mj2Xv8bY
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6867d592 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=Mr-DseXuYG0Gcgx6uQYA:9
 cc=ntf awl=host:12057
X-Proofpoint-GUID: -pf6lQRYc4jt3UunNYw3Qe6CkSRRJI27
X-Proofpoint-ORIG-GUID: -pf6lQRYc4jt3UunNYw3Qe6CkSRRJI27
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

Fixes: 734ce47f71e0 ("bonding: support RSS dynamic configuration")
Cc: tomaszx.kulasek@intel.com

Signed-off-by: Madhuker Mythri <madhuker.mythri@oracle.com>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 83339bae3d..bcbb7cae7b 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -1904,12 +1904,13 @@ member_start(struct rte_eth_dev *bonding_eth_dev,
 		}
 	}
 
-	/* If RSS is enabled for bonding, synchronize RETA */
-	if (bonding_eth_dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS) {
+	/* 
+	 * If flow-isolation is not enabled, then check whether RSS is enabled for
+	 * bonding, synchronize RETA
+	 */
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

