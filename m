Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20130C28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 12:28:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D390C4064A;
	Sun, 23 Mar 2025 13:28:56 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
 by mails.dpdk.org (Postfix) with ESMTP id 9092340648
 for <dev@dpdk.org>; Sun, 23 Mar 2025 13:28:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBzxFGuxhorEPoWfll4CDVUkNUKUQiK0mKEfBXaBFcmLY8laDNVC6zbQzPdLqZc3Wq1KehvogZaPLGX5de9xn/Vhsb4p4G7rwlKR9zu88HpR1khnjsR5DCxEshiqVCbxNEYqbPleLIDeF5anepKGgIfTzr1fwj+QfK056rldRCY+Ys3Eu/3H94uoFPLXq88HS+rYNomSilya1WjfdveMCavuCafTenGpiphhz7tOpc3wZeu19jJu+B+MaaksqlgVoaxHa+/LQ4yfCjrfg6pQg7gP+2q7IGun0KOHX+1IS9xnUUgrF1UM9eYNyNAxxdUGpwlltVr/Jf87aNmWO4UVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/GbPNbcMpX6pmpCAqp4fs5Xj1NPpkhAVwp94QsdWdA=;
 b=ZNp+N7c0nquoA/VJ7laZOwzybq60pj9llgQxr9DLZz3czN8mvk4AiyZlPtIbc42qIM8VCPF1dkACBJz08CNO+c0KTwCjc1vVAKSjngJ7KOgKyJ7MOY7Yp/ERVBT2bReSPWUhlzFlltAGG7VqJmZ/mgJtoXsKDpHPpJArofC1Eh/b70CnZ+pBElJfvsxNLTyWU5JnnYuSeXNmkIzP+9kMTeBsaOzKT0uq9qustnLQgED6cugomksOd5uhQftwgXMDlP+n4DdSlINPskVBENU0cg840bmFn7/ZVS8b549v8Lqi3gV9XNN9UiJE6tpKruvtE2w27ZCeJQAgVpB0HVa8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/GbPNbcMpX6pmpCAqp4fs5Xj1NPpkhAVwp94QsdWdA=;
 b=QdfoZtN0WiqqGfrL8NeRPP0rC+YyOrRpxg2Pcl3SN/FXAy1VOhKYYmcAema2HtSr745a7dvKVABK6YgjVPcTe3/HCb5WlKaw3q5GDV/g6/t0U+8/lW6JwXS+MSeYR6vNL6u1M4/4rUvtzU/blR7YctTa4KyCJZeLjZjuOOxGutsWYut+2v/md28XmwtcK7QbgraTWABhurcXlFo367XBER4ZdOdhgAE1T8C0fww2aW1aiCLA/GUUf5Wx9HXKN4Bw+QbTVMnn5Ol5Ne8GIRjl00p4gqHc7QidYVUQdjj9bMZ8oVgs0cj/0GG2T8D4LOsV76UoPwN7ySDwl1X/D0oJ4Q==
Received: from BN9PR03CA0564.namprd03.prod.outlook.com (2603:10b6:408:138::29)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 12:28:51 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::c) by BN9PR03CA0564.outlook.office365.com
 (2603:10b6:408:138::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.40 via Frontend Transport; Sun,
 23 Mar 2025 12:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 23 Mar 2025 12:28:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 23 Mar
 2025 05:28:39 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 23 Mar
 2025 05:28:37 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <haijie1@huawei.com>
Subject: [PATCH] app/testpmd: fix VLAN header parsing
Date: Sun, 23 Mar 2025 14:28:22 +0200
Message-ID: <20250323122822.90407-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: a449a045-baec-4a4b-ec50-08dd6a0644e2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yq/CNH5LsyBZhOB/mvjukOzTfp43yJemgxJD8fmO8RzfrZBAIDYDWUjgTdmX?=
 =?us-ascii?Q?Zhkq10cZXUc+XjsQ3dxxg091jIC6/EsOoluki50Un5bl855pbX8c8EagjEYo?=
 =?us-ascii?Q?E7cm0beKCAz/s0c0+I2ifUeQUTGDuqe0EKZAnLGgF3kBgA2Gbb9Pc7p2mdtH?=
 =?us-ascii?Q?tjlxvX5wXow4IL4Y4GyG8fZGCXmcQlubd8G0vr7tT2Lq6fatVAEnes1Q8f41?=
 =?us-ascii?Q?Hgf1s/GYkuMpBvcY3rIE9bDZxHEUR0r9YhIw7mD/g6rrl05rJn0cwZpDPZeU?=
 =?us-ascii?Q?d2133fQNC1PF/dpeetkrTHEMT1nu44DAvXL25fRZi9xdfW7lrbfsdTB1HrRQ?=
 =?us-ascii?Q?wUnGDzqerSzDudZ1Sz6lbBGwKGkR3yza9TlsfJR87ezfHDafES49QqHv71yV?=
 =?us-ascii?Q?cTgVaKIEaS3xhz1rx2JKocM7O1bpwDi57cgCCdbFN+9TMcjPFBsNuJmTgOyC?=
 =?us-ascii?Q?4zdLHk/t9qWZGtXrTjQzgJQv5HXqHT0Gg/kkjyp9v1XQozZOo+Ol8reZUzAS?=
 =?us-ascii?Q?6kMbN99C1qZShrSTZjEaak3cQQpqCRyMooESUVMbSEbx9fgnsm/AV99fuqc8?=
 =?us-ascii?Q?Jmsqs3/AGuq+4eNgnXZ9LQ2pJexCqFEdXAh3yki88dYn7NBpaLjJ8SOM1TeC?=
 =?us-ascii?Q?SeQZeZ+Z/B2L6G1kqcx4cyTLR42dhMaF8PSLhab6aiLU0nFbh+4nsuWr/a3n?=
 =?us-ascii?Q?0trljAn10J0kobsxI9iVLu8WmR0+ydrY6ApYzPeZ61UcmNZn0XOL1kHaxUsy?=
 =?us-ascii?Q?0FT1wmP1I/Cig4AFiBMckd0eZFj9HQnnAoV7Z5X27F8eSbGy7EfEV4dXZHEI?=
 =?us-ascii?Q?p6K/UO9fauy3ggqAJ3gqmRQxEB6Zxh7HI3CVCyH7FTKGN+W584xtT3XQ4/ZL?=
 =?us-ascii?Q?qaZJEoYS/Ytr+JXbVt/e2lu14oMOOi03ecXV1snSDNPAfk7QXsGTy7aNXamo?=
 =?us-ascii?Q?8x6f5JX0R/dJx4ZGHNgQn8Khlqlwo9klQVDcnGUcmdzdB1/QuEnx1X4bnzEf?=
 =?us-ascii?Q?25ajCP7NzdeQsY5si0MW4WG2Bc2UR9iyboyK7kRgZoro3s95aYdmJQTXT8H4?=
 =?us-ascii?Q?CpwCE74cRjcxPEzO8FYikwR0FlPAtxyXDjcR7+hpDSXYQyWedeSPwql+fzqo?=
 =?us-ascii?Q?ioDU0LJ2FMSqNFtpB+LqK1stVO7a5tD8KDhnWRcNyOCngTDzBhiJQQVe8MYV?=
 =?us-ascii?Q?nJWjAv42X+0uA2s6KqTdqpRuCQRgBtn17ae1AlTy02U/FOXPN9hGNKjluLM/?=
 =?us-ascii?Q?dFwDO0Kvkx4ttLhgN0uk7sszq9o4nmgXD449Ls3Wnr36wNIVPHYyzITXqZ7z?=
 =?us-ascii?Q?554OdveHjnWPbAiFOOH0xxtuOJhOv9F7Ex31sWlkw2n6QV5OYIlZ8Kch48U1?=
 =?us-ascii?Q?1elOAGB6fcZCIwuHG4jtO+AOK6S1tntgeUz+UwkP0l5u5Bt4Ze3uGifCw2In?=
 =?us-ascii?Q?ACNKL7LU0pmRPYVCDl/kTDUc3kADIqS3osZ0prI2pQbLJ+eGWB4UE0gCVr2a?=
 =?us-ascii?Q?WhgrIVyJ9FPyMFU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 12:28:51.2673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a449a045-baec-4a4b-ec50-08dd6a0644e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
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

Updated the `get_ethertype_by_ptype` function to correctly parse VLAN
headers.

Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
Cc: haijie1@huawei.com

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
 app/test-pmd/csumonly.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index 5b906eaa53..302cc4cc66 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -468,6 +468,7 @@ get_ethertype_by_ptype(struct rte_ether_hdr *eth_hdr, uint32_t ptype)
 {
 	struct rte_vlan_hdr *vlan_hdr;
 	uint16_t ethertype;
+	uint32_t i = 0;
 
 	switch (ptype) {
 	case RTE_PTYPE_L3_IPV4:
@@ -486,10 +487,11 @@ get_ethertype_by_ptype(struct rte_ether_hdr *eth_hdr, uint32_t ptype)
 		return _htons(RTE_ETHER_TYPE_IPV6);
 	default:
 		ethertype = eth_hdr->ether_type;
-		while (eth_hdr->ether_type == _htons(RTE_ETHER_TYPE_VLAN) ||
-			eth_hdr->ether_type == _htons(RTE_ETHER_TYPE_QINQ)) {
+		while (ethertype == _htons(RTE_ETHER_TYPE_VLAN) ||
+			ethertype == _htons(RTE_ETHER_TYPE_QINQ)) {
 			vlan_hdr = (struct rte_vlan_hdr *)
-				((char *)eth_hdr + sizeof(*eth_hdr));
+				((char *)eth_hdr + sizeof(*eth_hdr) +
+				(i * sizeof(struct rte_vlan_hdr)));
 			ethertype = vlan_hdr->eth_proto;
 		}
 		return ethertype;
-- 
2.39.5 (Apple Git-154)

