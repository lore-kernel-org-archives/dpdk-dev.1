Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B99DC7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 11:37:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A08F40156;
	Thu, 26 Jun 2025 13:37:10 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by mails.dpdk.org (Postfix) with ESMTP id 51EE6400D6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 13:37:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPxK9fpkaQRqYIYTxX5A/vhPfQgojVtr9JRwdqGY8H4QYUbGoCDzvrQVdiPxvy+VlTiwOzGmXo5vHQhvmb2hsuED4V8JIe1Td22sIbYdE/q6A5/lLNsmad8OiEtmAz7tIhLDRYwUiUGKvr3COEXnuBQ+vtrfFhobi4QjYkaxH4bhsVuTi4gBEwIpSkqw3IE/HjrEqS7+FBdBQURrGWKES2sT+P4JunA2b2CnuwttfIieT2hDwTKCC9qZBMyEuK69whggCSGxITbFTTQhn3Z8k8WByK7BSVH+aNsme5KAb1SeDXtXwyp5wiX5Y/VD5eVFyihIDBCFWR12W5qjU4wFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+1EMRGEQkxbACFhYqM7gXX7gxX8iYGwAbrmkA61d6I=;
 b=h9lMIYIWnyR09h1NgIA8DRL7aoPDscOuRgXMpmM8Hy2E9W9lAbDzR6Ky4Oy9SQs4c1rRdswrl8BBcrzIO6xljz7BJQVsi6bKW8gU89+OnSw4n5DmmAxocRWY2XUgjWdhcJcUTkAJXrM0AcsKVV49dViymbiJa7jWA8ESEvrzIYcH2q2TJlc4zgNL+CQG+yeK7kGo2lDJtGIyCscEOBWgL6DwjwrXXOqBUgx7RhADh2GvKCPJupdeSbU5qiGxQ8Mo8GPBytYNbAAdOD0D/tFrQO5kyMfUsMFx6pgr29a2/HEm+u2//m9eL0y02lEbezfY5h3XMa5lwR2Eu2q/p1Vv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=cgstowernetworks.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+1EMRGEQkxbACFhYqM7gXX7gxX8iYGwAbrmkA61d6I=;
 b=YfVBIEDxVYxhpPDPwVLdPTj2TY8EtavH88t36GgQRDm+u9tUlkXwo0/wM/0F6ly6fEsEQlxrglQIGuNsiTjsDr0Rl9X+NWoqha/WHKuq0S3p5cv/ZBfANCkPFSxL8seK4ouvwl3dYAQLFe1sbLPooZ+iv4y/t7i2ZMVIG7GHqPxvrBUy6be66K6mRJeZOY0uwoXXC4HWpyWJjIBrTTHd7oabPQ43j8Tn26i/Z3JVigLn9FWe0MUHdNSFfcjUP+WjJCVW8ft0NPxRtF8aRktEkkw0kwMeP8ZznfOZhaTvWhdh0RaSf9HKphLj8q+85pC9hdkS4YaoCcwt1bxwFnFvHA==
Received: from SJ0PR03CA0212.namprd03.prod.outlook.com (2603:10b6:a03:39f::7)
 by IA0PR12MB7673.namprd12.prod.outlook.com (2603:10b6:208:435::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 11:37:04 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::af) by SJ0PR03CA0212.outlook.office365.com
 (2603:10b6:a03:39f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 11:37:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:37:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Jun
 2025 04:36:48 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 26 Jun
 2025 04:36:47 -0700
Date: Thu, 26 Jun 2025 13:36:17 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Yogev Chaimovich <yogev@cgstowernetworks.com>
CC: Maayan Kashani <mkashani@nvidia.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Slava Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix transceiver warning when not exist
Message-ID: <20250626113617.fekttwech4w75jqt@ds-vm-debian.local>
References: <DU2PR09MB5486574FE72A43A09A323DCDD68E2@DU2PR09MB5486.eurprd09.prod.outlook.com>
 <20250520114904.6570827f@hermes.local>
 <PH7PR12MB701839586EA3DA18CB3E3D45B26CA@PH7PR12MB7018.namprd12.prod.outlook.com>
 <DU2PR09MB54860A76C9E7A1CFF4A00AF0D66BA@DU2PR09MB5486.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DU2PR09MB54860A76C9E7A1CFF4A00AF0D66BA@DU2PR09MB5486.eurprd09.prod.outlook.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA0PR12MB7673:EE_
X-MS-Office365-Filtering-Correlation-Id: bdec148e-ccc1-4ba7-8f43-08ddb4a5c63a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wk2WICf9TBgG8Vl/D5uPYIuZcU42PG33VTpD8AXFRZ8HZtP8MM/mzvPlTHaL?=
 =?us-ascii?Q?O83TeQe/wawGBkfA48VNfMr6pe2LH9iXS5+gyXDs66DSb5rnXsbvw7UO6ilw?=
 =?us-ascii?Q?/SD3/Zu7II4RaLnVXupWkMSt787chvmV/YC26kt6iVuOLD3800Nf4zvsHVMc?=
 =?us-ascii?Q?VLTQsLv1DT61Y5iFjmXgt6Ze+uEw7vNcdDxUTbGsTEzBWUM3by33w5mCSnz5?=
 =?us-ascii?Q?Y0Csq5ooxNj7yidM0e62KO+k8YVz4mYp+cFM4pJncvzgdCvtgoWIVAtq08TK?=
 =?us-ascii?Q?FOQ/y03/o8okyR3bGu046lW1LDvsGNUyY24PTzEVxMX15FHYHqJq73AZazNz?=
 =?us-ascii?Q?i8fcBD8MMyNz1fx1pBVqK4mPznGDUk826VlycffGm8W+LK9UOFnp0XolxhUI?=
 =?us-ascii?Q?ibSNbOr7HK8/xUc3JBPOlwqLpBIyZurbLuz1sX/4ciovhlQKJFOeVjSh7NUP?=
 =?us-ascii?Q?khOGODOLLV0ls+5g+BunjZhMe8RI3TbM/jMV/SjBTz3R4TfLhuLGtcaQAJ2C?=
 =?us-ascii?Q?MwqyVDccWi6bYMKhsgSUpqGVcmC/EYUFST0mBHWWlmLl0Z8a9Pgc7FIeWPL8?=
 =?us-ascii?Q?JWJyhu/StSjtfbUmD2yBOHfzn5QTU1OJxHjZ6qd52QQVRQZ+NQQAQfauwC39?=
 =?us-ascii?Q?19EeHR8lzcKK/jc5yHnGMjKVGTo5iWkRTFAPP8VBMvNgUq6UD1Kwij8LXPY5?=
 =?us-ascii?Q?LVcIq2R/AlMOum+u8PSWjbbuYD6O77EMRpFddOp2MDVFi4hz7UtPOrXbtkxq?=
 =?us-ascii?Q?tSgpdtMmXXjUIhF+klol7FnBKRSjT8dR1pPO9ijFrCbIPPiU9ajVOQIEgphT?=
 =?us-ascii?Q?P3a74vga8lG4l8Ku130xK4GzLa5Rhcq3gQoVBumjJF6I1c0n0zYHh/gWUcQA?=
 =?us-ascii?Q?MZiM08EbX1ZC9kUCfNcSFqSSHuV4h7FQx6Y2y4Hr8XC4/QC1dl7FsVhi7Hv7?=
 =?us-ascii?Q?RJ2qg5u/KonrFnqDsqDSZM/kLIENoORzFurMc7xG+tdBV0NrHhikk3iuJfoT?=
 =?us-ascii?Q?l2DCBcegsD7oPfkbRM7Mndl1sm7RjiqzmOEM7+5rJxeCyiV0KxanL9tQ1I8+?=
 =?us-ascii?Q?AeaxnlJViD0/aI+uYpJ7rdO4Gbu+IASGUss46o2rQSAkKqh+4mZbBBa6WDpu?=
 =?us-ascii?Q?o7bxf74KRNoxWrerXDMeqXW/aWTByQGJXskotvzLOdubE1NSoQdd8IvJIR/6?=
 =?us-ascii?Q?kHsPVwppxW4yN2q39epdr/V9B5UboHbbYRRm3BMeAUnRX7du0wF2U4Ga3pw6?=
 =?us-ascii?Q?nLzsG6lvUVAppNXcl2q7mYCMZ5o1+TcIEovqdDuy6O0DfGxquLA8n4oc+KJI?=
 =?us-ascii?Q?wBk5RpQvEG+504rLSKhhUwrAE/0IOCPBoU8vCj4Kg1KwOJ9zB44CGT/gtlQT?=
 =?us-ascii?Q?a1K9f8h/pEckp3SR34WGU63sMRH8WsVcKHFoE4xn2FkyvSmIgZ5/zj3SM3i2?=
 =?us-ascii?Q?44pv/tiECeiOflNGNYQjEmL+M8yfIwiLOU64zbAaE4udXjE8lW0BWH7V6tnP?=
 =?us-ascii?Q?1QFWYMcaASd8GlsEPSFOa63+H7NuQunwneM3?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:37:04.3619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdec148e-ccc1-4ba7-8f43-08ddb4a5c63a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7673
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

Hi Yogev,

On Mon, Jun 09, 2025 at 01:11:27PM +0000, Yogev Chaimovich wrote:
> Hi,
> Actually looks like we're going with another workaround, so I might not be needing my original patch.

Could you tell us what kind of workaround you applied?

Also, I'm not sure if this warning should be suppressed on EIO.
mlx5 PMD relies on the kernel driver to get the module info,
and from what I've seen for ETHTOOL_GMODULEINFO kernel can return EIO
also for cases other than transceiver not existing
(for example error on NIC register access).
So mlx5 PMD cannot discern between "no transceiver" and
"other I/O error".
For this reason I would keep the log and keep it at warn level.

> Also, I do not understand how my patch (not printing a log) makes a test fail - I couldn't find that test in DPDK to verify. I'm not that familiar though..
> 
> Yogev

*snip*

Best regards,
Dariusz Sosnowski
