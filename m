Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5EC10987A2
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 16:01:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C002A402BB;
	Fri, 20 Mar 2026 17:01:07 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013004.outbound.protection.outlook.com
 [40.93.201.4]) by mails.dpdk.org (Postfix) with ESMTP id 3BEF8402B2;
 Fri, 20 Mar 2026 17:01:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDXcnTc28CKp7G1WT2o6+UqjP78odb+XIffGtrUPc/AlKHXAN6u7JTOcv8BUpTb/E9LXvcdcMPC+vY4RMDdfcgDWr/FKV+CrgwtzaogwQb0rji5ct1eRwKknY0bGa7FNUKEyeTTP809Pdi/QILbmQizHJBqe9HXpBkcoGlr3JwfVOObDDAqzs0h2YSGlugX3AewgnXJIrcOfuhKWYo6yavzaKlWhCaR93OUgXx384xH0ZVqx2SynaUyJSrFZT43IGKf1jsqXEnjhMtXrkHmqAqDI4GhoRAw5dDJomZPOj/2wK2vk2ISffb5qVDpv52Sx7DQJ56Rw7mnz/Lhaw0wL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcALoOSFrNk76qSNA6MyZ3PmP2IpH2GIyaPezx05R5s=;
 b=pOnUEwRykZxELGHsyFT+xHVk9f0wJ7YBHArrXq8NbGNf7cbyNdOLwN59xoFXKPqfRtfvTh+yqd4OWCXQL1QsY918d4OLO0fI7Xby4Ji2i3D48FhwKRxs4dfbdRHxc8aaKNjioWPNgvomN9N6fyWh9FD1ZcCHE9+JRHP1z4FFSQUPn3bKS7vtQRWB83IvbHPZbXH/7BzCRDbp2TqenfOFkY3ih9tNBgf1GHdBAIYIgUZIJ0bTi3D4a5Z56wGmugP8IQZY35fQG+IC9sR6DBN4wjRLlhTG3V7/OVmnGWBN5/NQH7xUSxSYdqSEFYQikQQP7HCyLE+tqX6iu/jO2In7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcALoOSFrNk76qSNA6MyZ3PmP2IpH2GIyaPezx05R5s=;
 b=Od4EJe2oX7RnfMuQ5Ff4PDZxI53Uy4Bx+pQ2q6inqHLra82WtEjtBBrSi1mEee2DFuQpD6wZl64msRRWqPsdWevuETXtRh4KHnFHuoepU9riH6TX6rlmL2vuutsbRPZz/mWiY6rVT8JhPFBUOA7R2qk+BsK1+Be+H5XFEk3uWuEYmgeSnxO5svEcHS+qHZf88/56O+UBI/jtmalYDjt0BMSZCAdj/fKmYlVUnn88vnDU94rOAUqzyXDBgOCHIhn+uHA+YD/+4neL6FGyW8FfzxX+NNtKAvEsmpgb4nfnMAH9y73Z9q5Do3ueD+a9Loic7/u0tFPwFxwpgIh3YSwyPQ==
Received: from SJ0PR13CA0140.namprd13.prod.outlook.com (2603:10b6:a03:2c6::25)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 16:00:58 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::97) by SJ0PR13CA0140.outlook.office365.com
 (2603:10b6:a03:2c6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Fri,
 20 Mar 2026 16:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 16:00:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 09:00:25 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 20 Mar
 2026 09:00:23 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Alexander Kozyrev
 <akozyrev@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix VLAN strip info for CQE compression
Date: Fri, 20 Mar 2026 17:00:01 +0100
Message-ID: <20260320160001.787223-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: a98e165a-02c0-4529-6175-08de8699dfe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: vY9eKjpfbBf8j/tW+8w6vaUSql+r7U6NWqWDqxo4mmQ9SJw9eh2+wvh+N6ofQGcPbASosyVHYdx/ACT+TunzOAvov6zWQhllLfssxgFQl2g6ghVUZ8LnLbfif3eOm3npheXl6H8ZyLU3PkhUJkVsmuJPLPSb67HLMPIXdZvbTHauxpDZB8iZebHJuEdMN0MKbym9WvljbNCRr7TL3fN28WocbcR6YhZa7IVWMJY0nfQj5Iheao4wP2YRoWCBo4I77Dj6EToC7ESIa0gu3rrPZXJKQiXJK/sMm4SUTrLhx6BfigGVOY+UjLgOHnKZFFt2JmQ4ECREnga3pCFbo4aTi6enpYmNZtE9ly4QDcDC33CMlzqQpGf02hsNSGrGv3AwymgajhjkEuk5KfF9o/0VNs+1+ix+zGvLcT9Mj/mdjFPAo1Z76MZ2QbYTGingnFg1OLxW0tPXva81L6jmZzkH9s6rB+AkIrRnXGvjGlEIjaT3i33Gz3/tWOVCcwx1lcx6vxN78Lk4HO5ibIISo6mgc+QSKGqu/lPQ5P8lvguyePZoWgtdGm/b3BDueHV7GkMgxMzpa7E/0RyM8Q1v/AHBT9VWRHydHTFdSdVyEeNufKhvdlyG/E4QkfrLi8IKczHKJO5nhABRmHAutoT7TOfSziuawRtlgZBsJO4nNKmzkPIIkq/tqf07x710oevLZFmPikXcYrYwQU6iV7AieJjB+SfJ4hfXF3H+uHiaAhmQDGhS17ntrY1oG2MlP3YOKwOKU0RwYEVEZPmSZOWcVFMjSA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zb4oxXkNWvGkVFI3ZhFbx0FmYyDybLk6089DiabXaZBzAyQJaWOuYOCONUUFY2dbnSKrPCJrg3/qTHOU66bl+kFptL07u1tZKrbb1zlQRXZm8yLzuSmLmccCXsh42EHgRjPTEx/A6N2tHi3uHHwpqlMBwjoRYxRLUHpZq3R8tmbw9C0KfYm1gPdOwgSZXYa0PohvRphBxzYHuVlGtqfyCBlnT55BPn/78nVYBRt9+Y10DZWp4mIL/jgFP0CbXK1lpA1wX5A1CcA21/10QcleAyQ9Yh2/kwVtX8s5Iz7o/GcwmLDm4mCpbwIpYJ4p0HGh5047LB78/n6/27fi0GLnYeaiOkrQDbsxXHKVXm+p69wLiB7xIamr3/7kRo7qSl2orkA5hRl3d+1083ATQXK82wwSieQufKgfh49ZpcpkjVCDRe6OhOMk9cAnSD9odZbS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:00:57.6424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a98e165a-02c0-4529-6175-08de8699dfe3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
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

When L3/L4 mini CQE format is used with CQE compression
(rxq_cqe_comp_en set to 4 in lower 3 bits),
each mini CQE reports packet header info for relevant packet.
One bit in that header info is dedicated to CVLAN info,
used to determine whether CVLAN is present in the received packet.
This info is used to determine VLAN stripping info
when relevant offload is enabled.

Before this patch, users might have seen incorrectly set/unset
RTE_MBUF_F_RX_VLAN and RTE_MBUF_F_RX_VLAN_STRIPPED flags because:

- Struct for mlx5 mini CQE incorrectly defined the location
  of packet header info byte - it was swapped with neighboring
  reserved byte.
- CVLAN bit was checked incorrectly because of cast to uint16_t
  and big endian change. It should be checked as uint8_t.

This patch addresses the above.

Fixes: 54c2d46b160f ("net/mlx5: support flow tag and packet header miniCQEs")
Cc: akozyrev@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/mlx5_prm.h | 2 +-
 drivers/net/mlx5/mlx5_rx.c     | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index ba33336e58..11b14e4f9d 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -5516,8 +5516,8 @@ struct mlx5_mini_cqe8 {
 				uint16_t checksum;
 				uint16_t flow_tag_high;
 				struct {
-					uint8_t reserved;
 					uint8_t hdr_type;
+					uint8_t reserved;
 				};
 			};
 			uint16_t stride_idx;
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index bc0470e6af..da871fd18a 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -1000,8 +1000,7 @@ rxq_cq_to_mbuf(struct mlx5_rxq_data *rxq, struct rte_mbuf *pkt,
 			vlan_strip = cqe->hdr_type_etc &
 				     RTE_BE16(MLX5_CQE_VLAN_STRIPPED);
 		else
-			vlan_strip = mcqe->hdr_type &
-				     RTE_BE16(MLX5_CQE_VLAN_STRIPPED);
+			vlan_strip = mcqe->hdr_type & MLX5_CQE_VLAN_STRIPPED;
 		if (vlan_strip) {
 			pkt->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
 			pkt->vlan_tci = rte_be_to_cpu_16(cqe->vlan_info);
-- 
2.47.3

