Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC7FC83F04
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 11:38:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1953840267;
	Thu,  3 Jul 2025 13:38:05 +0200 (CEST)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by mails.dpdk.org (Postfix) with ESMTP id 35F3440264
 for <dev@dpdk.org>; Thu,  3 Jul 2025 13:38:04 +0200 (CEST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5639Yu2q015512;
 Thu, 3 Jul 2025 11:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=d1wovr3anIqmWlKauYS5eCzDOEtDx
 BAZY0XZBt6IGiA=; b=QayhCnnVyCY0po0tJsnBN3kk9czN9vToHj+VJ/OgV2VRw
 oS7BfhsRwm57pPNBqaqvCoawZhh67xAKZAFd94rzK9XRh1DibQrYo5NN8XtbHLml
 NmglSMcgUD96UKf4omZAWeTBRJXdBHw8jf5TRO8Ggi/o69PkhO9Z2121wnUXSHIR
 co1Ftr56oIFx6XfpWQBkpdZRYhedVydjcCnIO0arV63ohwemHCK+3SJwp2AwKY0x
 AlJ8NmZZBDM27UFi6Iq8qNHJ2gMO1DElKzoDSTss4ufSSRFrZSN6NDXjNDUOoCbA
 xejC5r0A9CVFx6pHbiGoriIYkC2voAhN4XZunu4sg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766gvtd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Jul 2025 11:38:02 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 563ArHxm033615; Thu, 3 Jul 2025 11:38:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ucgug6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Jul 2025 11:38:01 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 563Bc13M017002;
 Thu, 3 Jul 2025 11:38:01 GMT
Received: from dhcp-10-48-119-207.wifi.oracle.com
 (dhcp-10-48-119-207.wifi.oracle.com [10.48.119.207])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 47j6ucgue9-1; Thu, 03 Jul 2025 11:38:00 +0000
From: madhuker.mythri@oracle.com
To: chas3@att.com
Cc: dev@dpdk.org, Madhuker Mythri <madhuker.mythri@oracle.com>
Subject: [PATCH] net/bonding: avoid RSS reta update in flow-isolation mode
Date: Thu,  3 Jul 2025 17:07:36 +0530
Message-Id: <20250703113736.6889-1-madhuker.mythri@oracle.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=851 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507030096
X-Proofpoint-GUID: Btg6lntx9TJSoagTIhsdFHosbfGVgI7H
X-Proofpoint-ORIG-GUID: Btg6lntx9TJSoagTIhsdFHosbfGVgI7H
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=68666b9a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=wFzsDpVAP8CWgpi1Ir0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA5NiBTYWx0ZWRfXwWGF7sJkPYHF
 sfBApchSm8b6TwJYaEFRMXqmgqJ8Ap5znrGkUNe2yJX2IJv6iIl8eNUSunrwAZRdZy98RgWLjkY
 HgIoRk61HJdymbHrmqC6iX1IOmrOGYTD1IlpRexHFs+jwjJZaT6QM2OnKV9/XyVC7c19yeTTqBx
 VZ+t8KTUeKEVtRCEWiCsOjwtcKt9kxq7ZEih7Gc1fYFsZExrkX5u/dK1bHXwzSTlc9fMLzCP80D
 L/4Hk4joobvlwbOLBaN39vEOKcfidI+xbKOK5m3SsgQGm7jdgnoztLD56QoCvABCg2LEjRz6rV8
 GGnFhiVtLwNrDXKb3iOlpOZTEmKVSvDctGji2e1hY6d+VQZ2Erl/ilNWapWzpUM2f45uttva/9+
 rJtKBZ21nbpCT2gSYoLsJUbRMsz2LNRGiGwln4ps30woG3bQBckVjnhJbM9Lnf6wdYQeG3vG
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

In bonding PMD, member_start() function checks whether RSS(mq_mode) is enabled
and then calling the RSS rte_eth_dev_rss_reta_update() API, which is returning
error in-case of device configured in flow isolation-mode. When the device
configured with flow isolation mode RSS reta update is not required and the API
was not supported. For example in-case of mlx5 PMD, RSS reta update API was not
supported, when the device is configured in flow isolatio-mode.

So, added check to verify if the device is configured in flow isolation-mode
then, do not call the rte_eth_dev_rss_reta_update() API.

Signed-off-by: Madhuker Mythri <madhuker.mythri@oracle.com>
---
 drivers/net/bonding/rte_eth_bond_pmd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index 83339bae3d..d312720869 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -1904,12 +1904,11 @@ member_start(struct rte_eth_dev *bonding_eth_dev,
 		}
 	}
 
-	/* If RSS is enabled for bonding, synchronize RETA */
-	if (bonding_eth_dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS) {
+	/* If flow-isolation is not enabled, then check whether RSS is enabled for
+	 * bonding, synchronize RETA */
+	if ((internals->flow_isolated_valid == 0) && 
+		(bonding_eth_dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS)) {
 		int i;
-		struct bond_dev_private *internals;
-
-		internals = bonding_eth_dev->data->dev_private;
 
 		for (i = 0; i < internals->member_count; i++) {
 			if (internals->members[i].port_id == member_port_id) {
-- 
2.39.5 (Apple Git-154)

