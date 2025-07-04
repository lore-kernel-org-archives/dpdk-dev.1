Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE4FC83F03
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 13:50:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A16940298;
	Fri,  4 Jul 2025 15:50:46 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by mails.dpdk.org (Postfix) with ESMTP id 8341440267
 for <dev@dpdk.org>; Fri,  4 Jul 2025 15:50:44 +0200 (CEST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5649YskX000349;
 Fri, 4 Jul 2025 13:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=HFTYg66v5LWaXvsa5CTWxba2zssWh
 Zfw9kwk4pWYj44=; b=A8UlpD9SyIOMzA6w+PA/HjZvkxMVRiE6iU2MdNoDF9eeE
 yb+aiouxhsJyijM1gaF7IjLiQFOJHWvwYLQdj4O4czPQ71elUUWefBzUakvWK7wK
 ZkZR0IvyYOtl8wpFhmUqlslAWNiiDclTwWxaNu1sLpeeKaq+kezhdCLIr4aNJU8t
 aEfH4OzbSZerH4RD0Phuqn401R05oH/nP93cYV5f3zvvdtBn/FhhKLD2lCGptcA3
 /K8jhtdG/RQ0J7AhyRFzJCTt8Tt0sz0jWwhPKSBDfpnzyF6hknxEasmVp9XURRvM
 WLIz4eWVPSuRcos8I7yt42rCuNVEelPpg+S95rUwQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80wasnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Jul 2025 13:50:42 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 564CY46V018761; Fri, 4 Jul 2025 13:50:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6uduadb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Jul 2025 13:50:41 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 564DoetY024637;
 Fri, 4 Jul 2025 13:50:40 GMT
Received: from dhcp-10-48-118-103.wifi.oracle.com
 (dhcp-10-48-118-103.wifi.oracle.com [10.48.118.103])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 47j6uduaav-1; Fri, 04 Jul 2025 13:50:40 +0000
From: madhuker.mythri@oracle.com
To: chas3@att.com
Cc: dev@dpdk.org, Madhuker Mythri <madhuker.mythri@oracle.com>,
 tomaszx.kulasek@intel.com
Subject: [PATCH] net/bonding: avoid RSS reta update in flow-isolation mode
Date: Fri,  4 Jul 2025 19:20:31 +0530
Message-Id: <20250704135031.5306-1-madhuker.mythri@oracle.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_05,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0
 mlxlogscore=941 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507040105
X-Proofpoint-GUID: bV70gRkG-Ncc7plm4zMWJk3mZVt2RnSm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDEwNSBTYWx0ZWRfX5RMMfk6i2hls
 jeYTWeq7Q+QrntkffwtAYxUfPkhoy3mbqMR9MNy2jVfq+pgZywjVv+xmZGIKzDvm0p1Wju2yYGv
 2s0q1MsBu8RpYYhhxHQ8IkmkiHwjomLkkvXqFGwen81Gbed3NYfU4ocau7awRjTXQ/fFGlrjv1I
 bpo4FFk03akeslwxi0mYtXksZKxusF5OB/K1z78sT4uYiS5JUYH3QWvClGm/6Rn6485zzHkL+ZI
 scSVBm8fyJh28IbRK5ZC5c4ID86rQmUUz75Vns//ncArbuMHPHcWIy+lSFYODFcUKLYrC0xO/57
 h+M1lRFjzcEotElSE7mLK+Ct9Afh/e5s8pCmXDqXvRPPKb+Xh/1iJ0Ydb2OBNc8Gc+aGTs+uiPA
 mr+v3tP0je/NilFzeSrWG9mAR6eAvM83x4+LatCgrpTYoF3R7CrKHtY1vsoOaf+1tV1v3u1c
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=6867dc32 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=Mr-DseXuYG0Gcgx6uQYA:9
X-Proofpoint-ORIG-GUID: bV70gRkG-Ncc7plm4zMWJk3mZVt2RnSm
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
index 83339bae3d..4906701a95 100644
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

