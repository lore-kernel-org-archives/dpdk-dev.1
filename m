Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4402AE9E31B
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:05:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0733D4067B;
	Wed, 11 Feb 2026 16:04:52 +0100 (CET)
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com
 [67.231.157.127])
 by mails.dpdk.org (Postfix) with ESMTP id 7CF04402B0
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:16:08 +0100 (CET)
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
 by m0050096.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 619B5JuH625137; Mon, 9 Feb 2026 16:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=oqpG6XEHL1Hezjwp2u4MtBxZtVfUmWurDeX62wHgTR8=; b=Vv6wknaYnEDn
 2qpboAya38zvUQ1xGl0h9uEJ+g1UzzAuh57J1sJHVHfhKrveI0Bo6q/Fyet6n6ZL
 URUvrGvlLJ6uzEdmvF/TIIixVblQz/PP/SWW+ZW+q1SOKAuh8qGieUmSBJbjtHBk
 mbP81vFkQbS6L2gG9txPM2B6wSWilSr35tbSEWC3XQ9FdrJKLRl8qKkpSalACyGu
 12DTWieMkVb0OHsuNVLdZ3e0WfgVv8h3op8GQ6COH8uF0zF5V9Up8gBZvz5wyE5+
 YGjCpI0zUdPV2jloul8gthlXC+itPawsRZa4RBLbwSOOgvvtL9FgJeUtKLBJHWsn
 RnRM4CHs5A==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4c5xp9bpu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 16:16:07 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 619F61ho021476; Mon, 9 Feb 2026 11:16:06 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.41])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4c61m3fevj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 11:16:06 -0500
Received: from usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Feb 2026 08:16:06 -0800
Received: from lon-lph85swt.london.corp.akamai.com (172.27.164.43) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 id 15.2.2562.29 via Frontend Transport; Mon, 9 Feb 2026 08:16:06 -0800
Received: by lon-lph85swt.london.corp.akamai.com (Postfix, from userid 37336)
 id 7C38715634D9; Mon,  9 Feb 2026 16:16:05 +0000 (GMT)
From: Max Tottenham <mtottenh@akamai.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <mtottenh@akamai.com>, <johunt@akamai.com>
Subject: [PATCH v2 2/3] net/mlx5: fix vport metadata for auxiliary bus devices
Date: Mon, 9 Feb 2026 16:14:39 +0000
Message-ID: <20260209161440.1947052-3-mtottenh@akamai.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209161440.1947052-1-mtottenh@akamai.com>
References: <20260209161440.1947052-1-mtottenh@akamai.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=846
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEzNyBTYWx0ZWRfX0XkIyHxiKAVk
 oUIlVuTatDoyn1W1/cI74Wk7VvoDhCb3dsHeNSKZLVo3Bue2cBHOm23cbyT/F4kXdbVwSb/pTs/
 aggRoj972OgJmTmUfRTH7YVQvzpifUFG2pLktJVdLqMEyMFz3FSKbNzKZUwgyTztPVWIRAdZQcc
 XWmcuGI7m1GGRh7wVoSMOhQNTfrGsTHovWlKYLSpt+ZrtQxicMQTe0Rn/YYYQHf87bkbFBTV9YX
 GuvFlW32htjnSf0POMYWIYgW4OGDDcNflmzAC/eY2z0Ywl3vJqNliy3oZuBdBRG6TPpLpDZS5x0
 01LD9BwcgsZZhJKNBVAzysltZRrEiabgmfKdHaqg8sEvYiPd0CGtofuTZGJeobujalYB2aD++IV
 GvSYTUK3hs/zFGbjXbk+H2OvLBPNAHb+GmyY3eBPLL2A8X7xzs9Go3iglp9dQNIPTMcHh4r0K80
 7mYMUvZyCHLId2HnTQg==
X-Proofpoint-ORIG-GUID: UD76xbU8Kh9g2NMdFzLreqRtt7wuk7QS
X-Proofpoint-GUID: UD76xbU8Kh9g2NMdFzLreqRtt7wuk7QS
X-Authority-Analysis: v=2.4 cv=DeMaa/tW c=1 sm=1 tr=0 ts=698a0847 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=X7Ea-ya5AAAA:8 a=WURAd1XSAAAA:8
 a=hgkMnOTdYwRDr3TyGa0A:9 a=NsdkdtwoHwr4VYi03pWs:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090137
X-Mailman-Approved-At: Wed, 11 Feb 2026 16:04:47 +0100
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

Query switch info in auxiliary probe path to properly identify
SF representors. Without this, esw_mode stays 0 and vport
metadata is never initialized for hotplugged SFs.

Fixes: 919488fbfa ("net/mlx5: support Sub-Function")
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 7f73183bb1..ec96d11b26 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -2970,6 +2970,21 @@ mlx5_os_auxiliary_probe(struct mlx5_common_device *cdev,
 	}
 	spawn.ifindex = ret;
 	spawn.cdev = cdev;
+	/*
+	 * Query switch info for SF representors (like PCI probe does).
+	 * Without this, esw_mode stays 0 and vport metadata is never
+	 * initialized for hotplugged SFs.
+	 */
+	if (spawn.ifindex > 0) {
+		ret = mlx5_sysfs_switch_info(spawn.ifindex, &spawn.info);
+		if (ret) {
+			DRV_LOG(DEBUG, "No switch info for ifindex %d, assuming non-representor",
+				spawn.ifindex);
+			/* Not an error - device may not be a representor */
+			ret = 0;
+		}
+	}
+
 	/* Spawn device. */
 	eth_dev = mlx5_dev_spawn(dev, &spawn, &eth_da, mkvlist);
 	if (eth_dev == NULL)
-- 
2.52.0

