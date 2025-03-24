Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D946C3600C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Mar 2025 08:51:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 867F640655;
	Mon, 24 Mar 2025 09:51:02 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by mails.dpdk.org (Postfix) with ESMTP id 99EC5402DA
 for <dev@dpdk.org>; Mon, 24 Mar 2025 09:51:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pwokk3pdfREcChRNbYBwYnkvb3bSvQdVT5FVCSm0yGVDbEWjWth7VR0H8rnmoKJt4UnH6buirzl/tDluW7szfniQIVPHrp/LAX5SPnYSbwnvr3PgrcF9Ryd5KJVuGLBgsQBSPajrq/3GXeiW9nTs55sw1nbdvm6d0nyUAqZrX4sQsaMQT7FaTZ1+yDKBI45nMovdiAfCzc2AxxcXQ+Was/1c91zLHutsQRLksIHmCgE0YO5HHbfnns8f04uMOMmnfXQqWzp7Tkm6DyExLRuu/DZ+Z4nm7nnUfC/B8yNWxvNQix/z9vC6vyRhj0Hdc691FeFhlTINhGSk3Uhry7oBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22O/E0ULuWw74lU5KhjQULPaDbCf6SZbwAtTJYxG4JU=;
 b=YT6S9+8Ib++3kPALZ3+BjSMpasDbC7cmBXBWf6i5CoQIzRUoWuBKsXKTdDcdTRwyPlO/V4Z0/f1Jguz0ohOQmLQcFa/IkpK4Cltx5MxWW4HXUBPZuNi8p9J1K8uCaGhLFidCS3Vd3Mt5AJU7OVQERkyeOiyywUeM0JyKkQOcDKSYc6BmJbioKS4P9upE1BlLmpw+bvhPdkkgtPl4XS6rbCVhM61WdiaZf8pQmu0N7wvaEPvgPl6hI++Fn5D90YXVZQ01AAOT7PldxhIs/AlYkUXRa/ajf8lZrYJYYpZhlw/dQbLpNhrTRuvZvUPdgZEVvSM9WdPezYjkr/VYIqNBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22O/E0ULuWw74lU5KhjQULPaDbCf6SZbwAtTJYxG4JU=;
 b=Y/N4Q4EudWKmPQ+2iD6sojszU3ssjyWtrkKre/XbH/UxZNMmzq+uRQIzYZf6XrCYp9VicHUyQKKtCDLiBU+rO1AmFxbWuxkj56ZcAG9oRCf9tRSUMJZgXDbRqWCIScFCZGf1rD+eo8Pd1w9YQKhWcgoO9qqB9Tt3e75K5Dq/RKa2NQRj1/L38xs00wI1CQlMp4nMnAKWX3mtZ4BGZnJ7aIQVFk+9FOuNm+MWYPirTE1Qs46KL1ypkiUFEqAqj5TUQruodVXq1aTjSompsTjbsDS9SY84O++XnYG4Fc/+zmnLVSuoCfVD7ukSs7xIaopGPqUOGqbWWgFtHik8leSDYg==
Received: from CH0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:610:32::29)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:50:57 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::a5) by CH0PR07CA0024.outlook.office365.com
 (2603:10b6:610:32::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 08:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 08:50:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 01:50:42 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 01:50:39 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <mb@smartsharesystems.com>, <stephen@networkplumber.org>, 
 <haijie1@huawei.com>
Subject: [PATCH v2] app/testpmd: fix VLAN header parsing
Date: Mon, 24 Mar 2025 10:50:23 +0200
Message-ID: <20250324085023.23721-1-rasland@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250323122822.90407-1-rasland@nvidia.com>
References: <20250323122822.90407-1-rasland@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: d0309821-b9a1-40dd-beaf-08dd6ab0fe51
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4cJQedJRgwdARCeHm9R1eKxKWPznk2oaIhLZXo5waKHXp5K9RSrMrvRSjVYX?=
 =?us-ascii?Q?Pd9aIJ2L73QYd8tju01ZjEPk8ZzoC428k2PabeB7aqVtPEnkk8rWG0kAqn5s?=
 =?us-ascii?Q?YRL2MxIeZJR1xf6sf+LxcvLOvVil8Lwq9wh6Tt61gp2jjCjKuhp04uJ2X0gd?=
 =?us-ascii?Q?lHjuniTr8M8HUg2oAhlRy0Mfqpj5B9gOVWURiKgX+voksNQ6bO/KfsqvnOsN?=
 =?us-ascii?Q?3aHf6WN+FYmiXasi8WfpWwqTaFbJJvVs1DdU4OdWUOci7nOxhc6mCHpnTZY9?=
 =?us-ascii?Q?WL+w+mRjPNaYD1RtU08B2//nWxaBXureKcjAftsWmhc85t5Z5Q6oQrx04y9n?=
 =?us-ascii?Q?qiKYInQwoK4DAChielFOCyS3ZkCBt16lJ//N+KcDbKUTpuQfW+Y/ZIs7SvLC?=
 =?us-ascii?Q?OqOGZZnJS9c7uieTq39lqomPrI5LYlIAbb4bha3KFsYCGuUpqrEaff7xeaps?=
 =?us-ascii?Q?F7G7KGiv43xj8Vw7aqa2RkqO2YuBrUBHqXk2tlochZfTVEGqpVspagNEQLUG?=
 =?us-ascii?Q?GxAj/y34bUMyHmO00q+JWIkKn+02fOuJ1ToL3qqjUuZP+LOT/6ysRDAqIrnO?=
 =?us-ascii?Q?fs1ZrAXZ0iuGsLUKccb1X2FYXKO8L6Fh6J60CbQrCC4G+ForCorT2Y6p6X4r?=
 =?us-ascii?Q?vCWnF+nUP3TYHSAtzCAHd2+FumdUYKO7RlRF3rD1G3yn8nMzyBQE8qxTrjbz?=
 =?us-ascii?Q?SpxAC2TK2cx0RtlaGBht8fRp+gpXHkv4k0xT6Vd+fexOVw9l37lSQg5KHK5j?=
 =?us-ascii?Q?GPfEjtu09R62bZhCbkdyfTQ/e7inpYuxPWexdWD2LVanHX3gX4BMNR0HFN+5?=
 =?us-ascii?Q?ZqfqKCpd20WIJlX454TK53OB5p3DYVx20t9XEGCNB8c2pQHMDByvDhoGDHSU?=
 =?us-ascii?Q?hSUBLllaebuLHVw+BuA+GK7I41krG8Bz3PLhI3yMM+/roCpcF3FW4XFUH5n6?=
 =?us-ascii?Q?qFp9yhgN2TZxqkz2WCio7rgCfGbDgBO1gEATwFbJMdCKNHhpmguw2Q5e/I3y?=
 =?us-ascii?Q?F0tFVe2FS5TdB+xMimwuuz1a+sgW2TvIQSyvNzuVZyEZ/A8wE0rRAoBtOooM?=
 =?us-ascii?Q?+mFuako1zlDhOgxCHlTohWVMWCFd2880je+AFOfWgKmAVt6pQo3RYRQluWRw?=
 =?us-ascii?Q?E1hycvPhDjOm1uxwl383XJof5jb5tN531/I1t/6mGlUw7BDFI+/nrGCzZu94?=
 =?us-ascii?Q?j97EMmXImkXq4fdi4KvPsTI5gmi+NORuKh2lPdga9bGiibV3j1bTtVHzu9UD?=
 =?us-ascii?Q?7a61tew5G+VhAjj/v8aCyMeU0a1GdUCpjCxeWAfwiivvoOD7cHuax4TDNUXE?=
 =?us-ascii?Q?oUnDgQ0wfHlvTHdES+Zh6uZ8KnScDRHbike3sHk/6J2Tj5Eo2JQx9hNh1geg?=
 =?us-ascii?Q?cvlC70nEx6TtwSy8eL88JZ8WE7b/QBDT8wWN2fkRvf6GgO6sfaUXMOD+/70w?=
 =?us-ascii?Q?HrRlNa4+8EU2DS4UucF+2qmubT7MO+PafmdKFl2eiwKzbi8T5BMvl5HaQDoi?=
 =?us-ascii?Q?isT54kam4aqLbxI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:50:56.8474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0309821-b9a1-40dd-beaf-08dd6ab0fe51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
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

When processing VLAN or QinQ packets, an infinite loop occurred,
preventing the csum forward engine from proceeding and causing
testpmd to hang during shutdown attempts.

Updated the `get_ethertype_by_ptype` function to correctly parse
VLAN headers.

Fixes: 76730c7b9b5a ("app/testpmd: use packet type parsing API")
Cc: haijie1@huawei.com

Signed-off-by: Raslan Darawsheh <rasland@nvidia.com>
---
v2: update commit log
    fixed pointer handling to actually move the pointer
---
 app/test-pmd/csumonly.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index 5b906eaa53..7bd1040c72 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -486,10 +486,11 @@ get_ethertype_by_ptype(struct rte_ether_hdr *eth_hdr, uint32_t ptype)
 		return _htons(RTE_ETHER_TYPE_IPV6);
 	default:
 		ethertype = eth_hdr->ether_type;
-		while (eth_hdr->ether_type == _htons(RTE_ETHER_TYPE_VLAN) ||
-			eth_hdr->ether_type == _htons(RTE_ETHER_TYPE_QINQ)) {
-			vlan_hdr = (struct rte_vlan_hdr *)
-				((char *)eth_hdr + sizeof(*eth_hdr));
+		vlan_hdr = (struct rte_vlan_hdr *) RTE_PTR_ADD(eth_hdr,
+				 offsetof(struct rte_ether_hdr, ether_type));
+		while ((ethertype == _htons(RTE_ETHER_TYPE_VLAN) ||
+			ethertype == _htons(RTE_ETHER_TYPE_QINQ))) {
+			vlan_hdr++;
 			ethertype = vlan_hdr->eth_proto;
 		}
 		return ethertype;
-- 
2.39.5 (Apple Git-154)

