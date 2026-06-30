Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE3BC43327
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Jun 2026 10:23:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11CD14025E;
	Tue, 30 Jun 2026 12:23:53 +0200 (CEST)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by mails.dpdk.org (Postfix) with ESMTP id 86AED4021E;
 Tue, 30 Jun 2026 12:23:51 +0200 (CEST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U4NCfL3571820; Tue, 30 Jun 2026 10:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=6NKPm
 dc0lSbW07I2UaJ9SJTkWIYRwHt+S9EY3MFhmoU=; b=hXHS8nLCkeLOnfnAf8X4R
 D91C9OLRkhhmxtRQNzyRsDJGeCgYuWZWRMU1LxG3EZUbwTV4FJx1594LIRTGX0XA
 8JAYbsi9Teb+QKDx5Lc/r7+ct1EM+XUkMXwv+AvmbezkmRlaYSlrdGQPOch7KjdD
 ap/laYraowsVnhlXsDPIZ5whmT2eJFrmVC5Y3SyoDzICQwwjMMd9pOScrk3BEKau
 wJgtRHahIoZCO4WXTxCsqceQk5EgVmwTs5KgyCOENVPdq6QxHyd/pym09ADScDZq
 BKHMcSDZ23UnFy6f92bddMJ+5+O2G2licVOsry1wVr3u7iOvUoAuz9UMfeoz/Oko
 Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26kybrb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 10:23:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65UANYLV020506; Tue, 30 Jun 2026 10:23:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4f24yqgekg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 10:23:49 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65UANkYN022103;
 Tue, 30 Jun 2026 10:23:46 GMT
Received: from bansaiku-5cg5092xbr (dhcp-10-176-177-220.in.oracle.com
 [10.176.177.220])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4f24yqge9g-1; Tue, 30 Jun 2026 10:23:46 +0000 (GMT)
From: banoth.saikumar@oracle.com
To: dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com
Cc: dev@dpdk.org, stable@dpdk.org, Banoth Saikumar <banoth.saikumar@oracle.com>
Subject: [PATCH v2] net/mlx5: fallback to verbs for Tx memory allocation if
 devx unsupported
Date: Tue, 30 Jun 2026 15:53:11 +0530
Message-ID: <20260630102311.1050-1-banoth.saikumar@oracle.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <'20260323113403.1984-1-banoth.saikumar@oracle.com'>
References: <'20260323113403.1984-1-banoth.saikumar@oracle.com'>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606300094
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfX7WfbT56+6WaR
 C5Hte5c96xCeVOQSfMnr2olwFibGxVq0DE8OtGZulkUXX1vY//UPJMW/W4E6x/XiSoQ1GmJszCK
 zDlOoqJPCpGYjx3WqKU1RTWmEJWmLGZlIrd1bLWcNK1hcjpLtkO+
X-Proofpoint-ORIG-GUID: h03xX5U_qkQLigHpxNCnH6NJ4EtkIZ7N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfX/VLKKU6SV5Kn
 l3oCl0FQE5P0CSYqO10W8ZT9V0jSdK1sMhcbvMtPSA1oW6EjoXsz7QOgCmJbf/hQWPVJhqLHHmw
 UEIv9BXhfm2yn11Z7lXJU/gsEOvgkVmCY5DPDz9xeG7Gu1/OaAeX/w8JxgMCcVxg1ZwLVL+FLq3
 koDTB2f9DH4trYg4NaDqlPo8apCtOfBPUfjP9JAT1Bzft7dCDT1LFU3VP16erHqPAlYqnIUcKnF
 udE3rT5bfHAd7tiAXtzBnSeCl9f5GigpZ9FIRTh4e0kTdxZrmucMRTsnZD25oiq7Ne9uc5XukAb
 BL9EdgWOCG+gbS9QOQedxME5w1deOnQPkm/bVO0mNriiml99pkRiVTk4FbGg5jZ+xSDZSyENLgX
 oW7FXErBOVbLNgeJKrldrLGDLLXZRfOhdE6SUNACp/rjGHtcmRXdsbGkQfJnES8gnK3UTxbdkSI
 udtZxQvNxKGRk44VpcbT00zWItawo/ymSuckmq4o=
X-Proofpoint-GUID: h03xX5U_qkQLigHpxNCnH6NJ4EtkIZ7N
X-Authority-Analysis: v=2.4 cv=ROaD2Yi+ c=1 sm=1 tr=0 ts=6a439936 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=8rWy6zfcAAAA:8
 a=Rgv5PRHDQWjwTyRo_O4A:9 a=YjdVzJdQTyZRADMV7wFX:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13723
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
v2:
- Use mlx5_devx_obj_ops_en() instead of checking config.devx directly.

 drivers/net/mlx5/mlx5_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 6c6f228afd..721fa5e2c8 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1161,7 +1161,7 @@ static int mlx5_dev_allocate_consec_tx_mem(struct rte_eth_dev *dev)
 	void *umem_buf = NULL;
 
 	/* Legacy per queue allocation, do nothing here. */
-	if (priv->sh->config.txq_mem_algn == 0)
+	if (priv->sh->config.txq_mem_algn == 0 || !mlx5_devx_obj_ops_en(priv->sh))
 		return 0;
 	alignment = (size_t)1 << priv->sh->config.txq_mem_algn;
 	total_size = priv->consec_tx_mem.sq_total_size + priv->consec_tx_mem.cq_total_size;
-- 
2.47.3

