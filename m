Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A26CE7B08
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 13:08:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6447040DFD;
	Fri, 14 Nov 2025 14:08:19 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
 by mails.dpdk.org (Postfix) with ESMTP id 247F240151;
 Fri, 14 Nov 2025 14:08:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLHFVXL/5VcquIMhunYpLeOgk0HT8T7jMroOt3OVW13N6ychjTaikEEVdl4Nka9sVpIKGQtMQKxrbp8QZuY43nl+Xlwm1Am9HG/9zWTR4f+U21U3TwfLyRDcZxstRb3rii2FXfFiJiHFVM5RLAj4Ipe5k4ZbvaMnqvh4rENtHULfWV708HS8JwEddexN6gt5wNqrmnFVcuGnxNLBfIYJJHYVeAwk57E0dKSavnauY86H/6lrDd4NDNO5C8JtMOUL44krUK+FjYT+42lMpv2auntgFFlgTBuHEygGJcMMoD21bxfPS0LXNpK9t9KIzPvgW8oEdxHEUrUUVAOYu5aBrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRoDorI7gW89n4Pmh6PSglr6jqU6k0hMeEe01M/bFZo=;
 b=UIXZM7kS9CMKe4jrrhDsZDrjU9qTEG10J84t8ALISPtnzjc0/wecnw+I4W/JHAyriQlg5z3LchszSi0xUJUscXVgcJMkAO1YER0RzGmAuwh8lQuY2grdJG9fDfKOAkhjeLo686mqsjI4Tadpgf6R05T0IqEr4IJm/vk19YRdY8PhacsNKHUe6Pkg2gHFMtP55dUYmCgf+sS0mcI4iBklioCDXOIrN2eAleNyHK2OaM8hVHM7icgoQMC20rX4ETe7Oz5xIYiCFbMTDQtHnt2xMDIOxD+9Y/1/TkvkEOR/FiUlXEUN17DBCEZIpWxxlylvc/9mNISsZaksC9ysOArmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRoDorI7gW89n4Pmh6PSglr6jqU6k0hMeEe01M/bFZo=;
 b=RwhI+Qn/Bkpt4pi3iFEaPEbfXcJsCjkVtAqJvSnUK8afyRE8CRJ8RDC58ugwM6HEV02QvKEYRkcevwhrmzT5dTDYO4ztPCw0QS2osFGXJdMtE1UxVjIDpuh/uMy/J9khFWieqy/BnHN3OHXFY/ns5HgPQraUM+YzrpoWixgjGRaO7MKxPmZPs5nzxlw844pZJ/UdsnjUqTv4Jq51jamQ/FwTbMTNd74JLKp8R04A6vbIssnAGbF61rP2Nsi+QpN8tIaq/RkmK7825McmTdrCh5vWyFTwkMWheP/QFfr+ZcbHhSw4ZAqa4YvOQl6d71coW7KUdoMhPgPNFGJYCaK+6w==
Received: from CH0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:610:b1::21)
 by BN3PR12MB9595.namprd12.prod.outlook.com (2603:10b6:408:2cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Fri, 14 Nov
 2025 13:08:13 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::63) by CH0PR13CA0016.outlook.office365.com
 (2603:10b6:610:b1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.8 via Frontend Transport; Fri,
 14 Nov 2025 13:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 13:08:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 05:08:00 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 05:07:59 -0800
Date: Fri, 14 Nov 2025 14:07:56 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Alexander Kozyrev
 <akozyrev@nvidia.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/mlx5: fix spurious CPU wakeups caused by invalid
 CQE
Message-ID: <20251114130756.kzr7bgvdg2saw2rx@ds-vm-debian.local>
References: <20251015133957.4094235-1-sivaprasad.tummala@amd.com>
 <20251111034057.3177641-1-sivaprasad.tummala@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251111034057.3177641-1-sivaprasad.tummala@amd.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|BN3PR12MB9595:EE_
X-MS-Office365-Filtering-Correlation-Id: f10ae2d2-2e58-4719-da0c-08de237ede22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8OlZhcm9hd1x2wKbyov5APuzQfuyUHIn+PTB31Xr4/5ATkYplm0dCBT7wlWF?=
 =?us-ascii?Q?NoKrn7u++4ehbkdF0sFqzGr07FKrBCf6waz9psZ/g7VGRACzJVI308F6MBCr?=
 =?us-ascii?Q?8eiWKl54R3UZLgHiv5rGOusSx1fxLPg41CKwyw5ZQ7RGCwIm0oNIX1q3YeBo?=
 =?us-ascii?Q?VdZSJbolxANESKEuagj42B8jbDBEVhPI0bbJfyEe+Z3wV4oQBtHAUPv4Jmiw?=
 =?us-ascii?Q?92H3cET/YFHbClWx8qeqEvDA75jKbGHVxkIO85PZw89CG0h61cZ1x7kLFMYD?=
 =?us-ascii?Q?DMIOV5UFEGvsSIgSQr1HtLXvU2l6yeNCL/WQRzk5PQOi+SiZ3AzIf/DsldcU?=
 =?us-ascii?Q?N0DxlNueLNJD/J4yhtEGmuVEAZoGAG/m+S17tlW+JgntCOHwubbPvEKJkTcp?=
 =?us-ascii?Q?eMN8OxNa/2LsriNEHp6x4qZu5Sb+oz/Mt3RPnigUEraHrPg+9rmVoeaFsZz3?=
 =?us-ascii?Q?zcY5G6JKX01GKsU0YnRnIBChdIZWVMZ8VYGDD/ecVAEZ5yo3gwW2xDxkIEBr?=
 =?us-ascii?Q?bwYWwNg2uhqqZyDENljsAntcFVktxD3XweeuAhRj2TKDvKYUhUoUTg9RLS1A?=
 =?us-ascii?Q?VNQ7LcJH7PJZFbnLP7qNhgoKyF2C54Ifg9UUTJqq/lGkm6l/d8/OrhPq+2ia?=
 =?us-ascii?Q?So78wDQSeOEXnuma9/yi6Dq/2oZopciFGgFmRyp7ImiwTmezYAeNDm8ytg3b?=
 =?us-ascii?Q?+H4wyFXinCXln67CPGQAJQQ6VaVEbbuSz725ErEeXL9tyqtMZxU2JpzKHeSY?=
 =?us-ascii?Q?428fPNp4lXK67MJJ5+8YjiTwho2+5jFycSZgLEDIli8RLEq+YeQ+JOVk0WoO?=
 =?us-ascii?Q?P/u94WQH0RfWmPnPrA5QHWMwf11fyeXSSYobyZvI6NCtLixUiBVALNKuACif?=
 =?us-ascii?Q?f+jIF8OnN5GERWGpJCEAyjF4g+XQ1ptJjp1vJixTJbMgw8wHaRxdY6iC+WyY?=
 =?us-ascii?Q?qeXT/QUABqGSOmEssGHQx9ZeNN1Yb4g0pQb0hI33Ss1WIV6uTNq79Bt627jA?=
 =?us-ascii?Q?Uz9kpF3+kgcMErScxoQy7M6f9sRUf7AndqwQYVtPABnZ43k8a03HecO9GTAG?=
 =?us-ascii?Q?Qz3fV1glE141EMNq4dHfvHhG1JRLxl3dRxJENkTXxEs727PQLqp0jlVTvxxA?=
 =?us-ascii?Q?+loZqX0Es9AWmejZAn7D0Djx5u9mO+OUqR6d5kLlIEfjVf0rryeDjCr3C5FQ?=
 =?us-ascii?Q?0S4x6ccPAz0F5cZY+oVpIpu5q0RcYJDHdd9P/CHDmQyXCsL7A+C6Rb/gWgSO?=
 =?us-ascii?Q?uX2cGmTa4eKP+YmnuvXtVYrTwpKYY5zQLom37rv4k9LCaSnyFlt9LHQcrDVF?=
 =?us-ascii?Q?ivGGMPqxq7UYF6mMi+5VX9hMAjncn0w40eu15VSErK97Ycp8IcPlSI6MnnIZ?=
 =?us-ascii?Q?gyH8e6yO6lGbebq9En2BhfiXSd6QuMwU0YKVHAiUS8a+cd7aqefWLi+6olAg?=
 =?us-ascii?Q?z18xOzFUiRXwmVr6CAduxTNQRz+wzyhFUOjYShTd8mFZ0JcW7SD9BfREn4N2?=
 =?us-ascii?Q?tnKEQ41SJjjEPZsdG9T67juo8okOQjw6R05x/qNFbkjo6KBg0SrW3veQb0D8?=
 =?us-ascii?Q?TwFuZADj7TSYBuq7WEI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 13:08:13.1279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f10ae2d2-2e58-4719-da0c-08de237ede22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9595
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

On Tue, Nov 11, 2025 at 03:40:57AM +0000, Sivaprasad Tummala wrote:
> Previously, the PMD used a common monitor callback to determine
> CQE ownership for power-aware polling. However, when a CQE contained
> an invalid opcode(MLX5_CQE_INVALID), ownership bit was not reliable.
> As a result, the monitor condition could falsely indicate CQE
> availability and cause the CPU to wake up unnecessarily during
> low traffic periods.
> 
> This resulted in spurious wakeups in monitor-wait mode and reduced
> the expected power savings, as cores exited the sleep state even
> when no valid CQEs were available.
> 
> This patch introduces a dedicated callback that skips invalid CQEs
> and optimizes power efficiency by preventing false wakeups caused
> by hardware-owned or invalid entries.
> 
> Fixes: a8f0df6bf98d ("net/mlx5: support power monitoring")
> Cc: akozyrev@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Thank you for the contribution.

Best regards,
Dariusz Sosnowski
