Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77AAC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:39:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20CBA4029F;
	Wed, 26 Feb 2025 09:39:38 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by mails.dpdk.org (Postfix) with ESMTP id 495614027C
 for <dev@dpdk.org>; Wed, 26 Feb 2025 09:39:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ji5sawOENU21SdWevkwREZEYqxrYJDSTbjnyiHbD5ClXyRIAU7Ebodd0CXfQav+Zaod0zCZSiIO02TnHrZWZehHsA0on0GtjiCz9XmGFQ1eyzpvCRIU3nR4CseLMFfTbRz2n12WwBtcDkBKSR5rnY47ijImVqVckEfhTa/q2UN4IxKfVHDTpR3iyZSgHC1DYPLTMooAm3+wLCD3yEatyn5EOsEa/oj6C4ZnThMQ7ITgEEkTrm7opNW7zXsYB+JGnP3QCiqri8pdGYjTNd5nRLnPXVJ1AzROyZR5oKPts1Xf7FWgbVTOJN8+7ArFuw86BoFc95SFAxU2mOP6k9dEKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWLZi9yXaAlJ+HQngXa2akcOFXVJMRtB3jRfr2oMWyo=;
 b=qbqjhZsdPlIvXkuc/SmeD+swFJBgvuMl0gVEDQ6xM+8BFth6psb4A6fzpwbYXn5wA5DHMNxm11HY8IMN4vGp5LeIXcKOv2Yr3hkziX9OQaQkuif1OwoTa8+O+8cJqAtugLDf4Ny1B6PSRSJ+2jVJzxPs2UISsDY39kN5jnWOBtNXm1s30E4+9xRHevG8kFM5DqUWwnPzc4iN5YuyuT3uueAi1W5YStFWyV9mO4iOCfcakbHzkIipAqTB3WfQI+e2+omwh/TlxXM43wiR83SgRsJ0qrXNoOx539pr3rVHdEFmiWZ6ZGYEG688a3WVKU4nA0lKgtrPgHuMX457unynZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWLZi9yXaAlJ+HQngXa2akcOFXVJMRtB3jRfr2oMWyo=;
 b=pBRak9zMsNqCiwtdRpR3cleyH7nlwBdAvzMRFdXjpZOK1B83mWRmEjC38Fc4Q1E51h601+Gn5lNEUocFT35Dc1HCAKxfHLUOT2gqa0fKyZg/Ch0PHvKRNW3V//nUAvR2hHrVpirH07vE09vX4fnw9jdH4mT/NTJe+Q2q0Ho/Zqk5C/b0DgBjkh5yQbvg/SEPnvXuadsDezl5cGlS9VCsSs9cpOXbMlhMfPX54AyTFfMBRYnRMaQYbSbeeQw1aEiZQb+8SakfqzblAEgG41jXCNTDAC8uxiKPB55wRR7DBW+DPde0odJRWlsEekIKzbZVh79kl5VAORHPVPFOswjl7A==
Received: from PH8PR07CA0030.namprd07.prod.outlook.com (2603:10b6:510:2cf::16)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 08:39:32 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:510:2cf:cafe::e9) by PH8PR07CA0030.outlook.office365.com
 (2603:10b6:510:2cf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 08:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:39:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 00:39:15 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 00:39:13 -0800
From: Ophir Munk <ophirmu@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH V2 0/4] mlx5 unified fdb
Date: Wed, 26 Feb 2025 10:38:42 +0200
Message-ID: <20250226083846.4023622-1-ophirmu@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225120213.2968616-0-ophirmu@nvidia.com>
References: <20250225120213.2968616-0-ophirmu@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f96eed-27a6-48fb-55cb-08dd5641170b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HxpjMUhiD1OSSjD3/UFMqjfxhjFr3wlXwVglVB75cfFtYI8GGQEgtuwpidsK?=
 =?us-ascii?Q?vMja0Jv8hJMJDPDYuqL6VQX0EwJd6lBL4CxZWe0pLIYtcWAcesnyn08ybVjA?=
 =?us-ascii?Q?J9UeeyqBaab9pgc+Aa1mS78MCUMW5UI4RtbGFT5ASeIeViB/j97eh78ZbpXM?=
 =?us-ascii?Q?hzqeUrxhekVBRcyY457YlZgFGum7TF4NeKaCsLA8Q85Hg4G7ur41Q9kZSkes?=
 =?us-ascii?Q?E0Cjlh8Hy4O3mV8+l4jP6LLv2zlEDcfO0POvXFgMrCerI8ofY+9yKXVyKJEa?=
 =?us-ascii?Q?SgIDxgJnCqhdD6jxbNsM5JveemvebGItOZZzpfXBQprm5jAjxfbh7QJe/uc8?=
 =?us-ascii?Q?rW1RAX63MkS05QQ+IfHhunhXlAoJuTZMjzRSib0u3D1lIQukxh0/fJwt5m/X?=
 =?us-ascii?Q?Mky13gVqydimgt2J2lnIX9sZLVwG8aL4Vh191KKzMq60HPDXGmDCf8WP0MFC?=
 =?us-ascii?Q?myB/JwpwOA6WKAcnrE287ue1cK9+VxS7OnIQaZcgxW4k869Mt3YyBDcg6ij3?=
 =?us-ascii?Q?KJt0FhQApM0ExnBke5gxyQEvCWzYHhXaM3FYHNZ3WWLnLt0BSWEUAmrMveQi?=
 =?us-ascii?Q?UCrwWod/dKmjWcanp8e4TDweSa/rrj52uH3iEs9mId7xSjK0yAF3C4vbG4Et?=
 =?us-ascii?Q?4ovYT2vo7i9vN/56EZjDS1NfrRg5Plue/7rG3+9pGTc7XdAsjDSV55A70GBM?=
 =?us-ascii?Q?AKnXeCpNQVDXza5ejFvs5Ihpzurzfm2dUB8JCnuPQtQ7lzIRmgzaDKidbT9q?=
 =?us-ascii?Q?yEBLryffmj94OP20Oh5gmklBsFPX64H7dyoeZfdW3Ki2UDFDp+L1qUa748vl?=
 =?us-ascii?Q?R36PqUSFKvQeK1SwhwBpU88mJ+85k4aCYd8t8sFjy5hFTATJ7wwGsHyZ1dQI?=
 =?us-ascii?Q?IfcHgWk8O005nhNyA/RWAv841NYeIeodQHqjbabGWV5gDC458lG9kuX1jw1L?=
 =?us-ascii?Q?XnZt2K+9HhAJEYdr04rHdbzqrr7ETDTnZPz8ibsk9Hvsk6YrKB1pq4n9uA8a?=
 =?us-ascii?Q?vyW1GL1St/Kg3uMIFqOYryOOVhi+XAwuE8iMBvfunXhuWdXFe4eK+WVZVK0X?=
 =?us-ascii?Q?jFcT0EdX4nBcMWNkwxrCA9FLp09DN1qyLmhBcmTk4OfUcuiztH3okbes7uhA?=
 =?us-ascii?Q?ou2BaZg9WAQYbdwqx8Yl/SkWetr1L+AgJruq5eCqHda73Dz+3sxRFKqoEODh?=
 =?us-ascii?Q?ZWBxTUueyOu3gOYes0BJZ6YdKUqqtqgOuBfGCcCsZ1JyYhMVzi1wv0CdwbDR?=
 =?us-ascii?Q?b/jAApWGwlm3bynNPg8L3p3u1dXdNn+p739UfDmIIapATufZ+ot1VtoDnT4a?=
 =?us-ascii?Q?HZ05lvZfeQZVmKO4w/U3uO/cUi5jo8inrQQDTeQQP3KyZ+pNWGcbOVvBNZOC?=
 =?us-ascii?Q?niUN9XsiKBvcu74Cbtu5SEU6NQwzoH3JJbmeDOCcliFeytdVM0f0SSghlpHK?=
 =?us-ascii?Q?wLhv3IxKqI5uspq7VZJTPX2w2fskT4LmG/f7nJOKU/Ff0kCJUGmSryJ8AU7g?=
 =?us-ascii?Q?YTDBabYustyAFf0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:39:31.4709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f96eed-27a6-48fb-55cb-08dd5641170b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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

V1: initial version
V2: rebase + determine unified fdb based on FW capability

Bing Zhao (1):
  net/mlx5: remove unneeded FDB flag on representor action

Ophir Munk (3):
  common/mlx5: support FDB unified capability query
  net/mlx5: support FDB unified domain
  net/mlx5/hws: allow different types in miss validation

 drivers/common/mlx5/mlx5_devx_cmds.c |   3 +
 drivers/common/mlx5/mlx5_devx_cmds.h |   1 +
 drivers/net/mlx5/hws/mlx5dr_table.c  |  18 +-
 drivers/net/mlx5/linux/mlx5_os.c     |  11 +
 drivers/net/mlx5/mlx5.h              |   8 +
 drivers/net/mlx5/mlx5_flow_hw.c      | 521 ++++++++++++++++++++++++-----------
 drivers/net/mlx5/mlx5_flow_meter.c   |  16 +-
 drivers/net/mlx5/mlx5_flow_quota.c   |   9 +-
 drivers/net/mlx5/mlx5_hws_cnt.c      |   9 +-
 9 files changed, 429 insertions(+), 167 deletions(-)

-- 
2.8.4

