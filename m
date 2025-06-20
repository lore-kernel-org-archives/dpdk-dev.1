Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B969AC7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 10:42:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B022142EC2;
	Fri, 20 Jun 2025 12:42:44 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by mails.dpdk.org (Postfix) with ESMTP id 5E940400D7
 for <dev@dpdk.org>; Fri, 20 Jun 2025 12:42:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlSn011XT5UFO3ynpE5aEt7wiX9tYfQiGYfwrxVuA7aP8831iniihG8fYBst0JJEWVsZ/51bQNxykyGcmN8KArYDVVYji2ilFkIJ/LPWfFAkIX+/u1C4w/a2bDZXR2CF5Ypn2k4tG4P7LAw8DZ8bZEq0W8Llg6HtFrrdi2eDTpOhnGQOnEA9W+LTWT3/eDVs+Iq7/4XX0FA1UuyeYywy7+tKJGIvm3UhmCSE+Jf5FHqdtjJcQK9EV66GBsfM4Yxrz7nnsqQn+1Bf/FvNAlkOndr9wgbPODON2ISFv+n6FbKW1ofcWIkVvWqLtnzzZqALvub52j54DvCJWY98HTKRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRRvOmmZ3hoOebl8dFrN4cSwvLSzzaalGPq7fIv+T0I=;
 b=vN5XiJXIaDY1gAbXiSmbOZa2+0TCbAtv2q3Xi3rpH//y2zGNXHC2ClvWyrr9vHIi7mYageu5uPsZSXqvdEL8Ygsjalo1BbYqS1+7tQ9b2JiIVNP1y/LdN072JLdGDVQYksl+upGc1FU1Te9V/w9HY86Zyx26gxqOcx6rNDqW9wMhY5hg4FHBKzLlw/tND1rPm/8zLltJzC9DBxJUXOE3XinTFZI7+Nydvp5qOTrg8XnRC4mZHra+Yt7f8udbIsnRcYpir7NBfjIRh0QNVKWPRR8FGA5pQcQuevWuQPd/3u8C7XdTEDZn/t0ty32e9LTTQOLSr5eWOU4xKcwHNkwvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRRvOmmZ3hoOebl8dFrN4cSwvLSzzaalGPq7fIv+T0I=;
 b=FvIb6b8PB2+SkSV9KX21EMDhNUfHd1XGdR7PQ10ZvaUholaRgyl+3/dyFFyuO2cLXJBOwBv9Ig/CtlLW8KTWn09KtlrVEP7jtZtu3frLBbPNt3OhWBrpVLIweBWPLB+OoqAI9HvoEHs56jVyGtPPSNJzxOQxlay+1vXYrxjJhTUVYF4r7bdl+lb+aH05knJxySxiposJTYtUVz0CyTwwSSx/i30yNQBwil+T3wCNACHeP8yQn4YL8lWcB45z92VxnQLznVz7ZEMGhxH03wiK7NcKsh35yzFUzjEcnE7cUHC2c46+YjOhY9Xs9N2qaUk1Gf2C2FRUy9xmnQNDoO33jA==
Received: from MW4PR04CA0104.namprd04.prod.outlook.com (2603:10b6:303:83::19)
 by SJ5PPFEB07C8E34.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Fri, 20 Jun
 2025 10:42:39 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::80) by MW4PR04CA0104.outlook.office365.com
 (2603:10b6:303:83::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.30 via Frontend Transport; Fri,
 20 Jun 2025 10:42:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 10:42:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 20 Jun
 2025 03:42:27 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 20 Jun
 2025 03:42:25 -0700
From: Junfeng Guo <junfengg@nvidia.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
Subject: [PATCH 0/2] Support IPIP Tunnel in NT2HWS and HWS
Date: Fri, 20 Jun 2025 13:42:01 +0300
Message-ID: <20250620104203.261435-1-junfengg@nvidia.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SJ5PPFEB07C8E34:EE_
X-MS-Office365-Filtering-Correlation-Id: d4596aaa-c456-4cc2-9e75-08ddafe72d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5kCBIBzCfcXgkpsZKk/Pg+IV2+fl/lPSuREVcD9D7dkrmjDiUEwOC3dsF8go?=
 =?us-ascii?Q?Rsk5dK5NIq6PUA7KcQU9N+LGXPNVV4jR1XjsAfKOTfpGD0TtCRthXbYof9gV?=
 =?us-ascii?Q?CRQ57ZWf0XSG3I3X5SESvJgRR8IfSvhisP1Ag30D8qR20onyPCIEc6w5F25M?=
 =?us-ascii?Q?zkzmkV+3kbvc/nadN6fh8MTkuA6d1kL9A2xocDV39OUllCVXu8EvN1Cc315Q?=
 =?us-ascii?Q?BG1VGGNz0GW4bkTRocdTeHX2cE40B/pCpJSsdRu7W0E6jtTDwgERHqCwc/0B?=
 =?us-ascii?Q?Lpd0I9Ox6cwbpM1kaV+QYF0C1ToPfrEJ+ulWIq+s+i3PLqu1LxtPwYtdzsou?=
 =?us-ascii?Q?UuKq5ZjebZe29QW4x0vy4R0lmmdsu1tgasqiu+L/RBe+1yatTXbRZa9xk6oi?=
 =?us-ascii?Q?TxphLFDJvdTx7T64Amvj12HG+Mcry+YQDSEST1KzBrA+sBOpRCpZAl/Jo9sV?=
 =?us-ascii?Q?BMlKbVLjCOlhLGRvGl0wsXssgrdBtKPMWpcwO0yxAf8ObjjS9l2+z8xWlxha?=
 =?us-ascii?Q?CZipmRdJu/7+ZGIMQjc+JZSGOOxa2unaXh8gagFwV4pMBCmfXhOoASWWY3eM?=
 =?us-ascii?Q?F+NuzIdAOBZ02AXUHCD8MhPoBNo0bk7rzMzKHqlGT6iEHAdS5Y/xwKGF+GIN?=
 =?us-ascii?Q?MKwgdFiIi/um2ltHekDWbetXdLCPi4GsSJt2TlGd+ySSX8pwo04gMyli4OTZ?=
 =?us-ascii?Q?1hHUdivM8qG7oHm2+iL2tPgmcHr7xJYaYIlkITdNJosjRbcWoam5fKCjpxIi?=
 =?us-ascii?Q?DlePyeFsKaFRwrQ5Nvoa6QaG1LYwRu4tp9xp1L6bAOXNqBh6qJKrMXdSBOqE?=
 =?us-ascii?Q?7Xr4Sp6tTCF5Dfb1Jn/J2W1losH7jYAVznKniQWMppyHdJrXqjrw79i5PS17?=
 =?us-ascii?Q?cOQepdsZBhKtEpwpYkhVuxbzH7bY3e+xqzwwmiyOgbSs3zxUiay7bOFA2FDI?=
 =?us-ascii?Q?NycNnoHrBFOKkTM5OjB2ryMWHaGGwAljfjqm2/us3rst1JaAJOXGGWbR54Pe?=
 =?us-ascii?Q?5cpz7wPi2lLXSUlxcUvNAZlKdCsVqM2Mh9jPiNtT2M935Ixf5amopUsK7dTM?=
 =?us-ascii?Q?6MCUU/IfAhK2GhbFfExiF4iOrzKRymo9DSHvff5udYSlTyESmjFKJARzqzxu?=
 =?us-ascii?Q?gadtWib1cA6vzbgMRIIBvrdV2VfVTOIzxZo6qbWK4/hPPWG2ltdtK0vd8Zgc?=
 =?us-ascii?Q?prWqp5lxn6YJz3eyOpS2AhfoHZrm/y8GPMqdhfq801Q133p6UsjDrUI1GE6i?=
 =?us-ascii?Q?seoUpBtVMuVq4ReRZQmkQUNTRmBaddaZ/ESTLvVDTpKU6ciRWKYntmQ000hq?=
 =?us-ascii?Q?FUIIktJ34Gi91vfVjTctHKyryCfw5IkLXyjGwRV/OsMVyoj55QC7bDnuHppf?=
 =?us-ascii?Q?9Lgcbr30nv1KfEboCBFJmhLLZT8Wdd9kLExAWdsK8fi4zJTm+APS5OSgjON8?=
 =?us-ascii?Q?OqJkhtaWjC78oOR1TmTJVWB/uOf24+fa1V1dzTeqZkDLlPvIIVkLWTwSQMet?=
 =?us-ascii?Q?mOlRVuI9Vb+4+R9+owHVFYX43h0Hnue9vqEI?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 10:42:39.2477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4596aaa-c456-4cc2-9e75-08ddafe72d99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEB07C8E34
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

This patchset support IPIP Tunnel in NT2HWS and HWS, including the
following {IPv4 x IPv6} combinations:
 - IPv4 over IPv4
 - IPv4 over IPv6
 - IPv6 over IPv4
 - IPv6 over IPv6

This feature cover both basic IPIP and IPIP over VXLAN Tunnel types.

Junfeng Guo (2):
  net/mlx5/hws: recognize IPIP in definer layer
  net/mlx5: support IPIP flow for all combinations

 drivers/net/mlx5/hws/mlx5dr_definer.c | 10 ++++++++++
 drivers/net/mlx5/mlx5_flow.c          |  5 -----
 drivers/net/mlx5/mlx5_flow_hw.c       |  3 ++-
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.45.0

