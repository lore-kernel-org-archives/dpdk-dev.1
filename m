Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DD7EC01CB
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 11:34:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 508E640268;
	Mon, 23 Mar 2026 12:34:14 +0100 (CET)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by mails.dpdk.org (Postfix) with ESMTP id 1E68F4025F;
 Mon, 23 Mar 2026 12:34:11 +0100 (CET)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62N10v6H1241674; Mon, 23 Mar 2026 11:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=+gZVSCuGh1Jv+Woyh9XIVVKykgRNo
 vHQ49QgM4FQg88=; b=LwlY93c/oLSD4s3XeBBNgVV6IjybfJs1keUfiv+FoUpBl
 79p4Wqhgok3ISpr6GH+liLUTJ2n1VDKx6frkQfi2mE8Zh5FL4f1tgVIhRQSc8pfA
 C2Zg6XoRO+C3PvMBSwVWeE9Hww4Bldb0nF8PQ6QxtXZAP9zv8k80q/f9pvTIXuFy
 7VPtni9flK1lh2BO2K0i8cajdY5JopPufkLjnOc1w4kXeMl8Q4GJDiflbuxZx7gn
 X2GghDBNhyA9O2/5mnQdUC3dDHe0DWVlsJ8RylWEgVDe4cVlI0pbsitquKcPTtJE
 oHLQyW7GvvngnULlWfxKR3h1qwdAaO11Kx6GRPncw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khf20yc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 11:34:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62N9QWwZ028971; Mon, 23 Mar 2026 11:34:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4d1hs8bxky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 11:34:10 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62NBY9oX010866;
 Mon, 23 Mar 2026 11:34:09 GMT
Received: from bansaiku-5cg5092xbr (dhcp-10-176-178-193.in.oracle.com
 [10.176.178.193])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4d1hs8bxk0-1; Mon, 23 Mar 2026 11:34:09 +0000
From: banoth.saikumar@oracle.com
To: viacheslavo@nvidia.com, bingz@nvidia.com
Cc: dev@dpdk.org, Banoth Saikumar <banoth.saikumar@oracle.com>, stable@dpdk.org
Subject: [PATCH] net/mlx5: fallback to verbs for Tx memory allocation if devx
 unsupported
Date: Mon, 23 Mar 2026 17:04:02 +0530
Message-ID: <20260323113403.1984-1-banoth.saikumar@oracle.com>
X-Mailer: git-send-email 2.51.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603230089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA5MCBTYWx0ZWRfX/qQzoTNOeaY2
 snpprSO/Q7BORtIURajAAUeIwlyxRzBleE3mdslecLyg+KdzvD1DWnxA2dyUsChbqirTTguQxyt
 DrXaJnXnh02Qh1Wfy3sApE5zguJRDwY/AHq6dnApyEUs8xeRG4KNUKa9fRTqbtRo/wrNFFegW+6
 NdtjwHNVBIDhGfES68970kbkLKJg2N+fg4Fvk0JI52uY/idQ8Pz380mb6d8/SGGB5CkzOrQt8It
 wHr3707Lb1zoHM3ey+/S4INrKCoCZGLOZaDoyyDXfpnEB639PkRkCwk66arz760PKp8qN5XVCF7
 hn+CZeDjRSbWkd8vpNXj7sXAFR9prMX6axiwpUbodlAVuRVZ72A3w58FEvgiy/4jvXn1C5oekAG
 92kcgHP6Satd9ERBBhFDisci4C9FmzIJ1P+C6GwzqTh6xRAX149Z65BXPHDXN6RpEb9ezv1YDsS
 KPOYkc+Ge5DGcZVndGw==
X-Authority-Analysis: v=2.4 cv=AIvfpCdw c=1 sm=1 tr=0 ts=69c12533 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=8rWy6zfcAAAA:8
 a=Rgv5PRHDQWjwTyRo_O4A:9 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: Xpn-VODszYjTbscdswaYxbnKzExnpDME
X-Proofpoint-GUID: Xpn-VODszYjTbscdswaYxbnKzExnpDME
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

From: Banoth Saikumar <banoth.saikumar@oracle.com>

Previously, the mlx5 PMD attempted to allocate consecutive Tx memory
using DevX without checking whether the NIC actually supported DevX.
This led to allocation failures on legacy or unsupported NICs.

This patch adds a fallback mechanism: if DevX is not available, the PMD
skips DevX-based allocation and allows the verbs path to handle memory
allocation and registration. This improves compatibility with older
NICs and ensures Tx queue setup proceeds correctly.

Fixes: bbfab2eb2528 ("net/mlx5: allocate and release unique
resources for Tx queues")
Cc: stable@dpdk.org

Signed-off-by: Banoth Saikumar <banoth.saikumar@oracle.com>
---
 drivers/net/mlx5/mlx5_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 6c6f228..c9ce3d4 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1161,7 +1161,7 @@ static int mlx5_dev_allocate_consec_tx_mem(struct rte_eth_dev *dev)
 	void *umem_buf = NULL;
 
 	/* Legacy per queue allocation, do nothing here. */
-	if (priv->sh->config.txq_mem_algn == 0)
+	if (priv->sh->config.txq_mem_algn == 0 || !priv->sh->cdev->config.devx)
 		return 0;
 	alignment = (size_t)1 << priv->sh->config.txq_mem_algn;
 	total_size = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;
-- 
1.8.3.1

